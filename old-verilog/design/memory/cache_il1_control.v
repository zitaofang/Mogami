`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/12/12 23:52:18
// Design Name: 
// Module Name: cache_il1_control
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments: Note that the access to the LRU and valid table must be done
// within the cycle the addresses come in to prevent discrepency.
//////////////////////////////////////////////////////////////////////////////////

module valid_table_il1(
    input clk,
    input [7:0] read_set_index, // Connected to the CPU-side controller: read valid bit for a set
    input reset, // Connected to the CPU-side controller: invalidate the whole cache (by fence.i)
    output [3:0] valid_bits, // Connected to the CPU-side controller: the valid bits. Not registered.
    input write_en, // Connected to the L2-side controller: indicate if the refill data is coming in to update the table
    input [7:0] write_set_index, // Connected to the L2-side controller: specify the valid bit to update
    input [3:0] valid_mask, // Connected to the L2-side controller: the way to be set valid (will be or-ed with the content)
    output [3:0] refill_valid_bits, // Connected to the L2-side controller: the valid bit for refill controller to select. Not registered.
    output nmi // External port: NMI raised for hardware error
    );
    reg [3:0] valid_table [0:255];
    
    assign valid_bits = valid_table[read_set_index];
    assign refill_valid_bits = valid_table[write_set_index];
    
    // After the refill_valid bits is sent to L2-side, the controller will calculate the valid mask
    // and sent back one cycle later. Therefore, we add an register here to delay the write back.
    reg [7:0] write_set_index_reg;
    reg [3:0] refill_valid_bits_reg;
    reg write_en_reg;
    initial begin
        write_set_index_reg <= 8'b0;
        refill_valid_bits_reg <= 8'b0;
        write_en_reg <= 1'b0;
    end
    always @ (posedge clk) begin
        if (reset | nmi) begin
            write_set_index_reg <= 8'b0;
            refill_valid_bits_reg <= 4'b0;
            write_en_reg <= 1'b0;
        end else begin
            write_set_index_reg <= write_set_index;
            refill_valid_bits_reg <= refill_valid_bits;
            write_en_reg <= write_en;
        end
    end
    
    // If valid_mask have more than one hot bit, report an error
    wire [1:0] tmp0 = {&valid_mask[3:2], &valid_mask[1:0]};
    wire [1:0] tmp1 = {|valid_mask[3:2], |valid_mask[1:0]};
    assign nmi = |tmp0 | &tmp1;
    
    integer i;
    // Initialize the memory
    initial
        for (i = 0; i < 256; i = i + 1)
            valid_table[i] <= 4'b0;
    // Update the valid table
    always @ (posedge clk)
        if (reset) // Reset the whole instruction cache synchronously
            for (i = 0; i < 256; i = i + 1)
                valid_table[i] <= 4'b0;
        else if (write_en_reg & ~nmi)
            valid_table[write_set_index_reg] <= refill_valid_bits_reg | valid_mask;
endmodule

// A pseudo-LRU table, one-hot encoding
module lru_table_il1(
    input clk, 
    input write_en, // external port: enable LRU update for refill
    input has_invalid, // Connected to valid table (indirectly): If there is invalid ways in the set being refilled, no need to update
    input [7:0] refill_set_index, // Connected to L2-side controller: the set index where data is refilled
    output [3:0] lru_way, // Connected to L2-side controller: the way where data should be refilled if there's no invalid slot otherwise the controller give addr to update
    input [3:0] way_selected, // Connected to L2-side controller: the way where data is refilled, when L2-side found a invalid slot
    input [7:0] read_set_index, // Connected to CPU-side controller: the current address being read by the CPU 
    input [3:0] read_way, // Connected to CPU-side controller: the current way being read by the CPU (WARNING: 2-CYCLE DELAY!)
    input stalled // External port (but also or-ed with missed): stop updating 
    );
    reg [3:0] lru_table [0:255];
    
    // Since the read_way can be determined only after the data is pulled out, 
    // I have to add two levels of register for read_set_index and stalled.
    reg [7:0] read_set_index_reg0;
    reg [7:0] read_set_index_reg1;
    reg [7:0] stalled_reg0;
    reg [7:0] stalled_reg1;
    always @ (posedge clk) begin
        read_set_index_reg0 <= read_set_index;
        read_set_index_reg1 <= read_set_index_reg0;
        stalled_reg0 <= stalled;
        stalled_reg1 <= stalled_reg0;
    end
    
    // Compare the reading address and update
    // Note: we don't care if the CPU is stalled since the way whose LRU entry is being updated
    // will be used immediately after the CPU resumes
    wire [3:0] read_lru = lru_table[read_set_index_reg1];
    wire [3:0] updated_read_lru = {read_lru[2:0], read_lru[3]};
    wire read_lru_sel = |(read_lru ^ read_way);
    always @ (posedge clk)
        if (~stalled_reg1)
            lru_table[read_set_index_reg1] <= read_lru_sel ? read_lru : updated_read_lru;
        
    // Compare the refill address and update
    wire [3:0] refill_lru = lru_table[refill_set_index];
    wire updated_refill_lru = {refill_lru[2:0], refill_lru[3]};
    wire refill_lru_sel = |(refill_lru ^ way_selected);
    assign lru_way = refill_lru;
    always @ (posedge clk)
        if (write_en & ~has_invalid)
            lru_table[refill_set_index] <= refill_lru_sel ? refill_lru : updated_refill_lru;
endmodule

module il1_cpu_side(
    // External
    input clk,
    input [47:0] addr,
    output [31:0] inst0,
    output [31:0] inst1,
    output [31:0] inst2,
    output [31:0] inst3,
    output miss, // This port will only give a pulse if there is a miss; there should be a FF to keep it
    // Internal, to IP Core
    input [179:0] ram_d0,
    input [179:0] ram_d1,
    input [179:0] ram_d2,
    input [179:0] ram_d3,
    output [7:0] read_set_index, // Also to other RTL components besides the IP
    // Internal, to other RTL components
    input [3:0] valid_bits,
    output [3:0] read_way
    );
    // Parse the address
    wire [3:0] block_offset; // Not used, should be always 0, and the PC should check this
    wire [7:0] set_index;
    wire [35:0] tag;
    assign {tag, set_index, block_offset} = addr;
    // Contact the valid table and LRU to obtain valid bits and to update the LRU
    assign read_set_index = set_index;
    reg [3:0] valid_bit_reg0;
    reg [3:0] valid_bit_reg1;
    // Store the block offset and tag
    reg [35:0] tag_reg0;
    reg [35:0] tag_reg1;
    always @ (posedge clk) begin
        valid_bit_reg0 <= valid_bits;
        valid_bit_reg1 <= valid_bit_reg0;
        tag_reg0 <= tag;
        tag_reg1 <= tag_reg0;
    end
    // Compare the tag and check invalid
    wire [143:0] packed_tag = {ram_d0[163:128], ram_d1[163:128], ram_d2[163:128], ram_d3[163:128]};
    wire [3:0] hit_way;
    assign read_way = hit_way;
    generate
        genvar i;
        for (i = 0; i < 4; i = i + 1)
        begin: compare_loop
            wire [35:0] current_tag = packed_tag[36 * (i + 1) - 1:36 * i];
            wire low_tag_comp = |(tag_reg1[31:0] ^ current_tag[31:0]);
            wire high_tag_comp = |(tag_reg1[35:32] ^ current_tag[35:32]) | ~valid_bit_reg1[i];
            assign hit_way[i] = ~(low_tag_comp | high_tag_comp);
        end
    endgenerate
    // encode and select, assuming only one way matched
    wire [127:0] hit_data0 = hit_way[1] ? ram_d1[127:0] : ram_d0[127:0];
    wire [127:0] hit_data1 = hit_way[3] ? ram_d3[127:0] : ram_d2[127:0];
    wire [127:0] hit_data = (hit_way[3] | hit_way[2]) ? hit_data1 : hit_data0;
    assign {inst0, inst1, inst2, inst3} = hit_data;
    assign miss = ~|hit_way;
endmodule

module il1_l2_side(
    // External ports
    input clk,
    input refill_in,
    input [47:0] refill_addr,
    input [127:0] refill_data,
    // Internal ports, to IP Core
    output [7:0] refill_set_index, // Also connected to the LRU table and valid table: the set index the refill is going to
    output [3:0] way_selected, // Also connected to the valid and LRU table: the way selected to be refilled. Registered.
    output [179:0] write_data,
    // Internal ports, to other RTL component
    input [3:0] valid_bits, // Connected to the valid table: the valid bits that indicates the available slot to refill in
    input [3:0] lru_way // Connected to the LRU table: the set that should be evicted if the set is full; its value is invalid if there is invalid slot
    );
    // Parse the address
    wire [3:0] block_offset; // Not used, should be always 0, and the refill controller should check this
    wire [7:0] set_index;
    wire [35:0] tag;
    assign {tag, set_index, block_offset} = refill_addr;
    assign refill_set_index = set_index;
    
    // Prepare the data
    assign write_data[127:0] = refill_data;
    assign write_data[163:128] = tag;
    assign write_data[179:164] = 16'b0;
    
    wire eviction_needed = &valid_bits;
    
    // Find available slot if there is invalid way (the way with a lower index is preferred)
    // I don't know how to name this...but it should be easy to understand
    // Just clearing the upper bit if the lower bit is set
    wire [3:0] sel_tmp0 = {valid_bits[3] & ~ valid_bits[2], valid_bits[2], valid_bits[1] & ~ valid_bits[0], valid_bits[0]};
    wire [1:0] sel_tmp1 = {|valid_bits[3:2], |valid_bits[1:0]};
    wire [3:0] invalid_slot = {sel_tmp0[3:2] & (sel_tmp1[1] & ~sel_tmp1[0]), sel_tmp0[1:0] & (sel_tmp1[0])};
    
    // Register way_selected as it cannot be read and written to the valid table in one cycle.
    reg [3:0] way_selected_reg;
    initial
        way_selected_reg <= 4'b0;
    always @ (posedge clk)
        way_selected_reg <= eviction_needed ? lru_way : invalid_slot;
    assign way_selected = way_selected_reg;
endmodule

// This module assumes that the delay between the clk posedge and the data input is small.
module controller_il1(
    input clk,
    input refill_in,
    input fence_i,
    input stalled,
    input [47:0] pc_addr,
    input [127:0] refill_data,
    input [47:0] refill_addr,
    output [31:0] inst_0,
    output [31:0] inst_1,
    output [31:0] inst_2,
    output [31:0] inst_3,
    output miss,
    output hardware_error // Which will raise an NMI
    );
    // This wire is connected to the valid table. Once the valid bits are read in the same cycle the read address gets in,
    // one copy of it is delivered back to the CPU-side controller, and another copy is or-ed and sent to the LRU.
    wire [3:0] valid_bits;
    // The valid bit for refill.
    wire [3:0] refill_valid_bits;
    // The way selected to be refilled by the L2-side controller
    wire [3:0] way_selected;
    // The set index to be refilled by the L2-side controller
    wire [7:0] refill_set_index;
    // LRU entry provided by the LRU table. It is sent to the L2-side controller if it report an entry must be evicted.
    wire [3:0] lru_way;
    // The way currently being read by the CPU
    wire [3:0] read_way;
    // Internal ports
    wire [179:0] ram_d0;
    wire [179:0] ram_d1;
    wire [179:0] ram_d2;
    wire [179:0] ram_d3;
    wire [179:0] write_ram;
    wire [7:0] read_set_index;
    
    wire has_invalid = ~|valid_bits;

    lru_table_il1(
        .clk(clk), 
        .write_en(refill_in), // external port: enable LRU update for refill
        .has_invalid(has_invalid), // Connected to valid table (indirectly): If there is invalid ways in the set being refilled, no need to update
        .refill_set_index(refill_set_index), // Connected to L2-side controller: the set index where data is refilled
        .lru_way(lru_way), // Connected to L2-side controller: the way where data should be refilled if there's no invalid slot otherwise the controller give addr to update
        .way_selected(way_selected), // Connected to L2-side controller: the way where data is refilled, when L2-side found a invalid slot
        .read_set_index(read_set_index), // Connected to CPU-side controller: the current address being read by the CPU 
        .read_way(read_way), // Connected to CPU-side controller: the current way being read by the CPU
        .stalled(stalled | miss) // External port (but also or-ed with missed): stop updating 
    );
    valid_table_il1(
        .clk(clk),
        .read_set_index(read_set_index), // Connected to the CPU-side controller: read valid bit for a set
        .reset(fence_i), // Connected to the CPU-side controller: invalidate the whole cache (by fence.i)
        .valid_bits(valid_bits), // Connected to the CPU-side controller: the valid bits
        .write_en(refill_in), // Connected to the L2-side controller: indicate if the refill data is coming in to update the table
        .write_set_index(refill_set_index), // Connected to the L2-side controller: specify the valid bit to update
        .valid_mask(way_selected), // Connected to the L2-side controller: the way to be set valid (will be or-ed with the content)
        .refill_valid_bits(refill_valid_bits) // Connected to the L2-side controller: the valid bit for refill controller to select
    );
    il1_cpu_side(
        // External
        .clk(clk),
        .addr(pc_addr),
        .inst0(inst_0),
        .inst1(inst_1),
        .inst2(inst_2),
        .inst3(inst_3),
        .miss(miss), // This port will only give a pulse if there is a miss; there should be a FF to keep it
        // Internal, to IP Core
        .ram_d0(ram_d0),
        .ram_d1(ram_d1),
        .ram_d2(ram_d2),
        .ram_d3(ram_d3),
        .read_set_index(read_set_index), // Also to other RTL components besides the IP
        // Internal, to other RTL components
        .valid_bits(valid_bits),
        .read_way(read_way)
    );
    il1_l2_side(
        // External ports
        .clk(clk),
        .refill_in(refill_in),
        .refill_addr(refill_addr),
        .refill_data(refill_data),
        // Internal ports, to IP Core
        .refill_set_index(refill_set_index), // Also connected to the LRU table and valid table: the set index the refill is going to
        .way_selected(way_selected), // Also connected to the valid and LRU table: the way selected to be refilled
        .write_data(write_ram),
        // Internal ports, to other RTL component
        .valid_bits(refill_valid_bits), // Connected to the valid table: the valid bits that indicates the available slot to refill in
        .lru_way(lru_way) // Connected to the LRU table: the set that should be evicted if the set is full; its value is invalid if there is invalid slot
    );
    cache_il1 cache_ram (
        .clk(clk),
        .ram_d0(ram_d0),
        .ram_d1(ram_d1),
        .ram_d2(ram_d2),
        .ram_d3(ram_d3),
        .ram_en(has_invalid ? way_selected : lru_way),
        .ram_wd(write_ram),
        .read_addr(read_set_index),
        .write_addr(refill_set_index)
    );
endmodule
