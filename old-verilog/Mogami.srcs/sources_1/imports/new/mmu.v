`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/05/22 22:37:23
// Design Name: 
// Module Name: mmu
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
`define page_offset 12
`define virtual_space 48
`define level0_pt_bit 12
`define level1_pt_bit 12
`define level2_pt_bit 12

module mmu(
    input [63:0] vaddr,
    output [63:0] paddr
    );
    
endmodule

module tlb(
    input clk,
    input enable,
    input refill_ready,
    input [`virtual_space - `page_offset - 1:0] vpn,
    input [`virtual_space - `page_offset - 1:0] refill_ppn,
    output [`virtual_space - `page_offset - 1:0] ppn,
    output state
);
    reg tlb_state; // if 0, ready for lookup; if 1, waiting for refills
    assign state = tlb_state;
    
    // TODO Replace this with block RAM
    reg [`virtual_space - `page_offset - 1:0] vpn_table [0:31];
    reg [`virtual_space - `page_offset - 1:0] ppn_table [0:31];
    
    // The entry to be evicted
    reg [4:0] evict;
    
    // Comparator module
    wire [31:0] equal_res;
    generate
        genvar i;
        for (i = 0; i < 32; i = i +1)
        begin: comparator
            assign equal_res[i] = ~|(vpn_table[i] ^ vpn);
        end
    endgenerate
    
    // Encode the address
    // If we have more space, we can check this
    wire [4:0] hit_addr;
    wire miss;
    sbs #(.OUT_BIT(5)) (
        .in(equal_res),
        .out(hit_addr),
        .indeterminate(miss)
    );
    assign ppn = ppn_table[hit_addr];
    
    // Update the pseudo-LRU register
    wire [4:0] new_evict;
    canonic_adder #(.A_BIT(5)) (
        .a(hit_addr),
        .b(|(hit_addr ^ evict)),
        .res(new_evict)
    );
    
    always @ (posedge clk) begin
        if (enable) begin
            if (tlb_state) begin
            // If tlb is waiting for refills, refills it
                if (refill_ready) begin
                    vpn_table[evict] <= vpn;
                    ppn_table[evict] <= ppn;
                    tlb_state <= 1'b0;
                end
            end else begin
            // Otherwise, update the miss status and pseudo-LRU entry
                tlb_state <= miss;
                evict <= new_evict;
            end
        end
    end
endmodule

// WARNING: When stall, vaddr MUST NOT CHANGE!
module translation (
    input clk,
    
    input enable,
    input [`virtual_space - 1:0] vaddr,
    output [`virtual_space - 1:0] paddr,
    
    // These address should go to the memory access queue as read
    output [`virtual_space - 1:0] pt_addr0,
    output pt0_enable,
    output [`virtual_space - 1:0] pt_addr1,
    output pt1_enable,
    output [`virtual_space - 1:0] pt_addr2,
    output pt2_enable,
    input [1:0] return_addr,
    input [63:0] table_data,
    
    output state,
    
    input [`virtual_space - 1:0] table_base
);

    // first, check with the tlb
    wire refill_ready;
    wire [`virtual_space - `page_offset - 1:0] refill_ppn;
    wire [`virtual_space - `page_offset - 1:0] hit_ppn;
    wire miss;
    tlb(
        .clk(clk),
        .enable(enable),
        .refill_ready(refill_ready),
        .vpn(vaddr[`virtual_space - 1:`page_offset]),
        .refill_ppn(refill_ppn),
        .ppn(hit_ppn),
        .state(miss)
    );
    
    // If miss, calculate the first level (concurrent with the tlb lookup)
    // Note: "miss" is driven by a register and to be treated as stage valid bit
    wire [`virtual_space - 1:0] new_pt_level0;
    adder_lookahead(
        .a(table_base),
        .b({{(`virtual_space - `level0_pt_bit){1'b0}}, vaddr[`virtual_space - 1:`virtual_space - `level0_pt_bit]}),
        .cin(1'b0),
        .r(new_pt_level0),
        .cout(),
        .sign_cin()
    );
    reg [`virtual_space - 1:0] pt_level0;
    always @ (posedge clk) begin
        if (enable)
            pt_level0 <= new_pt_level0;
    end
    assign pt_addr0 = pt_level0;
    
    // Confirm that the next level address arrives
    wire pt0_res_ready = ~|(2'b00 ^ return_addr);
    
    // walk second level
    reg pt1_valid;
    wire [`virtual_space - 1:0] new_pt_level1;
    adder_lookahead(
        .a(pt_level0),
        .b({{(`virtual_space - `level0_pt_bit - `level1_pt_bit){1'b0}},
            table_data[`virtual_space - `level0_pt_bit - 1:`virtual_space - `level0_pt_bit - `level1_pt_bit]}),
        .cin(1'b0),
        .r(new_pt_level1),
        .cout(),
        .sign_cin()
    );
    reg [`virtual_space - 1:0] pt_level1;
    always @ (posedge clk) begin
        if (miss & pt0_res_ready)
            pt_level1 <= new_pt_level1;
        pt1_valid <= miss;
    end
    assign pt_addr1 = pt_level1;
    
    // Confirm that the next level address arrives
    wire pt1_res_ready = ~|(2'b01 ^ return_addr);
    
    // walk third level
    reg pt2_valid;
    wire [`virtual_space - 1:0] new_pt_level2;
    adder_lookahead(
        .a(pt_level1),
        .b({{(`virtual_space - `level0_pt_bit - `level1_pt_bit){1'b0}},
            table_data[`virtual_space - `level0_pt_bit - `level1_pt_bit - 1:`virtual_space - `level0_pt_bit]}),
        .cin(1'b0),
        .r(new_pt_level2),
        .cout(),
        .sign_cin()
    );
    
    // output paddr and update the tlb
    
    
endmodule