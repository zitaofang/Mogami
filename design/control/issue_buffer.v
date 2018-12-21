`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/12/19 18:25:04
// Design Name: 
// Module Name: issue_buffer
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

// Compare the tag against the CDB bus
module issue_buffer_comparator(
    input [3:0] bus_en,
    input [6 * 4 - 1:0] bus_tag,
    input [64 * 4 - 1:0] bus_data,
    input [5:0] entry_tag,
    output match,
    output [63:0] refill_data
    );
    wire [3:0] tag_match;
    generate
        genvar i;
        for (i = 0; i < 4; i = i + 1)
        begin: tag_comp
            assign tag_match[i] = ~|(entry_tag ^ bus_tag[6 * (i + 1) - 1: 6 * i]);
        end
        
        for (i = 0; i < 4; i = i + 1)
        begin: refill_sel
            control_buf #(.WIDTH(4)) refill_ctl (
                .in(bus_data[64 * (i + 1) - 1: 64 * i]),
                .out(refill_data),
                .control(tag_match[i] & bus_en[i])
            );
        end
    endgenerate
    
    assign match = |(tag_match & bus_en);
endmodule

// One entry of the issue buffer
module issue_buffer_entry(
    input clk,
    input kill,
    
    // uops input
    input new_uop,
    input [3:0] op_flag,
    input [63:0] src1,
    input src1_p,
    input [63:0] src2,
    input src2_p,
    
    // Inter-FU bus - receiver
    input [3:0] bus_en,
    input [6 * 4 - 1:0] bus_tag,
    input [64 * 4 - 1:0] bus_data,
    
    // output
    output valid,
    output ready,
    output [63:0] fu_op_flag,
    output [63:0] fu_op1,
    output [63:0] fu_op2,
    
    // Issue selected - clear this entry
    input issue,
    
    // NMI
    output nmi
    );
    // The register group of one uop
    reg valid_reg;
    reg [3:0] op_flag_reg;
    reg [63:0] src1_reg;
    reg src1_p_reg;
    reg [63:0] src2_reg;
    reg src2_p_reg;
    
    // The NMI bit: 1 if there's a hardware failure
    reg nmi_bit;
    // The ready bit: ready to issue
    reg ready_bit;
    
    // The comparator against the bus value
    wire src1_match;
    wire [63:0] src1_refill;
    issue_buffer_comparator src1_comp(
        .bus_en(bus_en),
        .bus_tag(bus_tag),
        .bus_data(bus_data),
        .entry_tag(src1_reg[5:0]),
        .match(src1_match),
        .refill_data(src1_refill)
    );
    wire src2_match;
    wire [63:0] src2_refill;
    issue_buffer_comparator src2_comp(
        .bus_en(bus_en),
        .bus_tag(bus_tag),
        .bus_data(bus_data),
        .entry_tag(src2_reg[5:0]),
        .match(src2_match),
        .refill_data(src2_refill)
    );
    
    always @ (posedge clk) begin
        if (kill) begin
            // If kill signal is received, clear all the register without asking anything
            {valid_reg, op_flag_reg, src1_reg, src1_p_reg, src2_reg, src2_p_reg} <= 135'b0;
            nmi_bit <= 1'b0;
            ready_bit <= 1'b0;
        end
        else if (new_uop) begin
            // When the new instruction is in, put it in
            {valid_reg, op_flag_reg, src1_reg, src1_p_reg, src2_reg, src2_p_reg} <= {1'b1, op_flag, src1, src1_p, src2, src2_p};
            // Check if there is already a uop; if there is, NMI
            nmi_bit <= valid_reg;
            // Assign ready bit: if both operands present, it is ready
            ready_bit <= src1_p & src2_p;
        end
        else if (issue) begin
            // If the instruction is issued but there is no new instruction refilled to this slot,
            // clear all the content
            {valid_reg, op_flag_reg, src1_reg, src1_p_reg, src2_reg, src2_p_reg} <= 135'b0;
            // Also, check if this entry is not ready; NMI if it is
            nmi_bit <= ~ready_bit;
        end
        else if (bus_en) begin
            // If the bus has something in...
            if (valid_reg) begin
                // compare it with the tag if it is not present
                if (~src1_p_reg & src1_match) begin
                    src1_p_reg = 1'b1;
                    src1_reg <= src1_refill;
                end
                if (~src2_p_reg & src2_match) begin
                    src2_p_reg = 1'b1;
                    src2_reg <= src2_refill;
                end
                // Then, set the ready bit (use blocking here to avoid repetition of code)
                ready_bit = src1_p_reg & src2_p_reg;
                // Hardware error cannot be detected here, so clear the bit
                nmi_bit <= 1'b0;
            end
        end
    end
endmodule

// The buffer that provides the next location to fill in and the next uop to issue
// such that the uop in the buffer that came in first can always be chosen
module issue_order_buffer(
    input clk,
    input kill,
    
    input fu_busy,
    input [3:0] ready_bit,
    output [3:0] issue_sel,
    
    input new_uop,
    output [3:0] assign_bit
    );
    // The array of buffer entry index (in one-hot), in the order that they are put in
    reg [3:0] order_array [3:0];
    // The next available slot in the array, in one-hot format
    reg [3:0] uop_next_slot;

    // The available entries in the buffer
    wire [3:0] available_entries = order_array[0] & order_array[1] & order_array[2] & order_array[3];

    integer i;
    initial begin
        for (i = 0; i < 4; i = i + 1)
            order_array[i] <= 4'b0;
        uop_next_slot <= 4'b0;
    end

    // Calculate the output index
    wire [3:0] ready_order_array;
    generate
        genvar j;
        for (j = 0; j < 4; j = j + 1)
        begin: ready_order_assign
            assign ready_order_array[j] = |(order_array[j] & ready_bit);
        end
    endgenerate
    // Construct a mux to extract the data
    wire [3:0] issue_mux_l1 [1:0];
    assign issue_mux_l1[1] = ready_order_array[2] ? order_array[2] : order_array[3];
    assign issue_mux_l1[0] = ready_order_array[0] ? order_array[0] : order_array[1];
    wire [3:0] issue_mux_l0 = (ready_order_array[1] | ready_order_array[0]) ? issue_mux_l1[0] : issue_mux_l1[1];
    // Pull ready bits to 0 if the FU is busy
    assign issue_sel = issue_mux_l0 & {4{~fu_busy}} & ready_bit;
    
    // After issuing, shift the array content after the issued instruction
    // We create control bits for them here
    wire [3:0] array_shift_ctl;
    set_high_bits shift_ctl_set(
        .in(ready_order_array),
        .out(array_shift_ctl)
    );
    
    // Determine the new entry for assignment
    clear_high_bits assign_entry_set(
        .in(~available_entries),
        .out(assign_bit)
    );
    
    // Helper wire for update
    wire uop_issued = |ready_bit & ~fu_busy;
    wire [4:0] uop_next_shift_in = {~&uop_next_slot, uop_next_slot};
    always @ (posedge clk) begin
        // If killed, clear the order array, reset uop_next_slot
        if (kill) begin
            for (i = 0; i < 4; i = i + 1) begin
                order_array[i] <= 4'b0;
            end
            uop_next_slot <= 4'b1;
        end else begin
            // First, update uop_next_slot
            if (uop_issued)
                if (new_uop)
                    uop_next_slot <= uop_next_slot; // No change if a new uop filled in
                else
                    uop_next_slot <= uop_next_shift_in[4:1]; // Otherwise, shift one bit to the right; set the highest bit if the table is full
            else
                if (new_uop)
                    uop_next_slot <= {uop_next_slot[2:0], 1'b0}; // Shift left if a new uop is filled in
                else
                    uop_next_slot <= uop_next_slot; // Otherwise, no change
            
            // Update the table
            for (i = 0; i < 4; i = i + 1) begin
                // If the corresponding location is the next location to insert a new instruction,
                // take the new instruction
                if (uop_next_slot[i] & new_uop)
                    order_array[i] <= assign_bit;
                // Otherwise, shift the registers toward the lowest bit if a shift is needed 
                else if (array_shift_ctl[i] & uop_issued)
                    if (i != 3)
                        order_array[i] <= order_array[i + 1];
                    else
                        order_array[i] <= 4'b0;
                // Otherwise, do nothing
                else
                    order_array[i] <= order_array[i];
            end
        end
    end
endmodule

// The buffer holding four uops to be issued
module issue_buffer(
    input clk,
    input kill,
    // instruction input
    input new_uop,
    input [3:0] op_flag,
    input [63:0] src1,
    input src1_p,
    input [63:0] src2,
    input src2_p,
    output full, // 1 if full; the fetching and decoding should stop if any reservation station reports that it's full
    // CDB bus receiver
    input [3:0] bus_en,
    input [6 * 4 - 1:0] bus_tag,
    input [64 * 4 - 1:0] bus_data,
    // FU ports
    input fu_busy,
    output [3:0] fu_op_flag,
    output [63:0] fu_op1,
    output [63:0] fu_op2,
    output issue, // Set 1 if an instruction is issued
    // NMI port
    output nmi
    );
    // Issue selection wire
    wire [3:0] issue_sel;
    // New ops assignment selection
    wire [3:0] assign_bit;
    
    // Entry valid bits wire
    wire [3:0] valid_bits;
    // Ready bits wire
    wire [3:0] ready_bits;
    // NMI bits wire
    wire [3:0] nmi_bits;
    
    // If all entry is full, send full signal
    assign full = &valid_bits;
    // NMI checking
    assign nmi = |nmi_bits;
    
    // The order buffer
    issue_order_buffer order_buf(
        .clk(clk),
        .kill(kill),
        
        .fu_busy(fu_busy),
        .ready_bit(ready_bits),
        .issue_sel(issue_sel),
        
        .new_uop(new_uop),
        .assign_bit(assign_bit)
    );
    
    // Four entries of the buffer
    generate 
        genvar i;
        for (i = 0; i < 4; i = i + 1)
        begin: entry_gen
            // Issuing wires, controlled by a tri-state buffer
            wire [3:0] entry_op_flag;
            wire [63:0] entry_op1;
            wire [63:0] entry_op2;
            
            issue_buffer_entry entry(
                .clk(clk),
                .kill(kill),
                
                // uops input
                .new_uop(assign_bit),
                .op_flag(op_flag),
                .src1(src1),
                .src1_p(src1_p),
                .src2(src2),
                .src2_p(src2_p),
                
                // CDB receiver
                .bus_en(bus_en),
                .bus_tag(bus_tag),
                .bus_data(bus_data),
                
                // output
                .valid(valid_bits[i]),
                .ready(ready_bits[i]),
                .fu_op1(entry_op1),
                .fu_op2(entry_op2),
                .fu_op_flag(entry_op_flag),
                
                // Issue selected - clear this entry
                .issue(issue_sel[i]),
                
                // NMI
                .nmi(nmi_bits[i])
            );
            
            // Issue operands selection
            control_buf #(.WIDTH(4)) op_flag_tri (
                .in(fu_op_flag),
                .out(entry_op_flag),
                .control(issue_sel[i])
            );
            control_buf op1_tri (
                .in(fu_op1),
                .out(entry_op1),
                .control(issue_sel[i])
            );
            control_buf op2_tri (
                .in(fu_op2),
                .out(entry_op2),
                .control(issue_sel[i])
            );
        end
    endgenerate
endmodule