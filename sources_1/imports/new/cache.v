`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/03/19 17:45:07
// Design Name: 
// Module Name: cache
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: A 32 KiB, 4-way cache with write back+write allocate+LRU policy. Block size is 32B.
// 
// Dependencies: 
// 
// Revision: 
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module cmos_512 (
    input [511:0] in,
    output [511:0] out,
    input control
);
    genvar i;
    generate
        for (i = 0; i < 512; i = i + 1)
        begin: cmos_gen
            bufif1 (out[i], in[i], control);
        end
    endgenerate
endmodule

// The LRU module -- any cache address must go through this
module LRU(
    input clk,
    input enable,
    input miss,
    input refilled,
    input [7:0] set_index,
    input [1:0] hit_block,
    output [9:0] target_address
    );
    reg [1:0] lru_table [0:255];
    assign target_address[9:2] = set_index;
    assign target_address[1:0] = miss ? lru_table[set_index] : hit_block;
    
    always @ (posedge clk) begin
        // When hit and current LRU pointing to the accessing block, or the refill come in...
        if ((~miss & (hit_block == lru_table[set_index])) | refilled)
            if (enable)
                lru_table[set_index] <= lru_table[set_index] + 1;
    end
endmodule

// WARNING: addr must be stable between miss is set and refilled is set
// WARNING: refilled should only last for one cycle
module cache_controller(
    input clk,
    input enable,
    input refilled,
    input write_en,
    input [63:0] addr,
    output miss,
    output [9:0] target_address
);
    reg [63:0] cache_info [0:1023];
    wire [50:0] tag = addr[63:13];
    wire [7:0] set_index = addr[12:5];
    wire [4:0] block_offset = addr[4:0];
    
    wire [9:0] set_address [0:3];
    wire [3:0] tag_compare;
    // compare the tag
    assign set_address[0] = {set_index, 2'h0};
    assign tag_compare[0] = (tag == cache_info[set_address[0]][50:0]) & cache_info[set_address[0]][63];
    assign set_address[1] = {set_index, 2'h1};
    assign tag_compare[1] = (tag == cache_info[set_address[1]][50:0]) & cache_info[set_address[1]][63];
    assign set_address[2] = {set_index, 2'h2};
    assign tag_compare[2] = (tag == cache_info[set_address[2]][50:0]) & cache_info[set_address[2]][63];
    assign set_address[3] = {set_index, 2'h3};
    assign tag_compare[3] = (tag == cache_info[set_address[3]][50:0]) & cache_info[set_address[3]][63];
    // encode the tag
    wire[1:0] hit_block;
    assign hit_block[0] = tag_compare[3] & tag_compare[1];
    assign hit_block[1] = tag_compare[3] & tag_compare[2];
    
    assign miss = ~|tag_compare;
    LRU lru(.clk(clk), .enable(enable), .miss(miss), .refilled(refilled), .set_index(set_index),
        .hit_block(hit_block));
    assign target_address = lru.target_address;
    
    always @ (posedge clk) begin
        if (enable & refilled) begin
            cache_info[target_address][63] <= 1;
            cache_info[target_address][62] <= write_en;
            cache_info[target_address][50:0] <= tag;
        end else if (write_en)
            cache_info[target_address][62] <= 1;
    end
endmodule

module cache(
    input enable, // Only affects the miss output
    input clk,
    input [63:0] addr,
    input [63:0] write_data,
    input refilled,
    input write_finish,
    input write_en,
    inout [511:0] mem_block,
    output [63:0] read_data,
    output miss,
    output write_mem
    );
    reg [511:0] cache_data [0:1023];
    reg [63:0] cache_info [0:1023]; // 52: valid bit; 51: dirty bit
    reg [1:0] lru_table [0:255];
    reg [511:0] write_buf;
    reg writing_mem;
    
    localparam SET_VALID_BIT = 64'h0010000000000000;
    localparam SET_DIRTY_BIT = 64'h0008000000000000;
    
    // Tag compare logic
    wire [3:0] tag_compare;
    assign tag_compare[0] = (cache_info[{addr[12:5], 2'b00}] == addr[63:13]) | cache_info[{addr[12:5], 2'b00}][52];
    assign tag_compare[1] = (cache_info[{addr[12:5], 2'b01}] == addr[63:13]) | cache_info[{addr[12:5], 2'b01}][52];
    assign tag_compare[2] = (cache_info[{addr[12:5], 2'b10}] == addr[63:13]) | cache_info[{addr[12:5], 2'b10}][52];
    assign tag_compare[3] = (cache_info[{addr[12:5], 2'b11}] == addr[63:13]) | cache_info[{addr[12:5], 2'b11}][52];
    wire hit;
    assign hit = |tag_compare;
    wire [9:0] hit_address;
    wire [9:0] victim_address;
    assign hit_address[0] = tag_compare[3] & tag_compare[1];
    assign hit_address[1] = tag_compare[3] & tag_compare[2];
    assign hit_address[9:2] = addr[12:5];
    assign victim_address[1:0] = lru_table[addr[12:5]];
    assign victim_address[9:2] = addr[12:5];
    
    wire [511:0] write_wire;
    wire [511:0] clear_mask;
    demux #(3, 64) (write_wire, addr[4:2], write_data);
    demux #(3, 64) (clear_mask, addr[4:2], 64'hFFFFFFFFFFFFFFFF);
    
    assign write_mem = writing_mem;
    cmos_512(write_buf, mem_block, writing_mem);
    
    wire [63:0] target_addr; // The address of the block being manipulated
    assign target_addr = hit ? hit_address : victim_address;
    
    wire [511:0] write_base_data; // The data that will be overrided if write_en is on
    wire [511:0] write_block_data; // The actual block data written into the cache
    assign write_base_data = refilled ? mem_block : cache_data[target_addr];
    assign write_block_data = write_en ? ((write_base_data & clear_mask) | write_wire) : write_base_data;
    
    wire [63:0] new_info;  // The new cache_info value to be written after dirty bit is set
    assign new_info = refilled ? {13'b10, addr[63:13]} : cache_info[target_addr];
    
    
    wire [63:0] read_data_sel [0:7];
    genvar sel_gen;
    generate
        for (sel_gen = 0; sel_gen < 8; sel_gen = sel_gen + 1)
        begin: read_sel_gen
            assign read_data_sel[sel_gen] = cache_data[target_addr][sel_gen * 64 + 63:sel_gen * 64];
        end
    endgenerate
    
    assign read_data = read_data_sel[addr[4:2]];
    assign miss = ~hit & enable;
    
    always @ (posedge clk)
    begin
        if (write_finish)
            writing_mem <= 0;
        if (miss & !refilled) begin // A miss, put the victim to the buf
            write_buf <= cache_data[target_addr];
            writing_mem <= cache_info[target_addr][51];
        end else begin // A hit or coming in refill data
            // cache_data can be modified even if it is invalid
            // since nobody is aceesssing it before fetch is completed
            cache_data[target_addr] <= write_block_data;
            // Dirty bit cannot be set until actual write since it may affect the writing_mem register
            cache_info[target_addr] <= write_en ? (new_info | SET_DIRTY_BIT) : new_info;
            // Increase the LRU pointer (only if it is enabled)
            // TODO fix the timing
            if (enable)
                lru_table[addr[12:5]] <= lru_table[addr[12:5]] + 1;
        end
    end
    
endmodule

module data_memory_entry(
    input [63:0] address,
    input lock, // For atomic operations
    input reserve, // For lr
    input [63:0] data_in,
    input [1:0] data_size,
    input write,
    output [63:0] data_out,
    
    input clk,
    input enable,
    output busy,
    output res_ready,
    
    output exception,
    output [3:0] cause
);

endmodule

module instruction_memory_entry(
    input [63:0] pc_address,
    output [63:0] inst,
    
    input clk,
    output busy,
    output res_ready,
    
    input fence_i_update,
    
    output exception,
    output [3:0] cause
);

endmodule