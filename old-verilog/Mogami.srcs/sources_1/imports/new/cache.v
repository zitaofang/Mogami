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
// Description: A 64 KiB, 8-way cache with write back+write allocate+LRU policy. Block size is 32B.
// 
// Dependencies: 
// 
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: We also put the virtual memory parts here. The page size is 16KB. 
// The canonical address space is 48-bit. The device we are targetting has only 2GB memory,
// so 36b physical address is supported here. (Anyway, it is not a datacenter chip) 
//////////////////////////////////////////////////////////////////////////////////

`define PPN 22
`define VPN 34
`define PI 12 // Page index
`define INST_LRU_ADDR 3 // means there are 2 ** 3 entries

// All macros below should not be modified to some values: they are associated to the value above
`define INST_LRU_SIZE (2 ** `INST_LRU_ADDR)

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

// The TLB. 
// Note: If it is a page fault, give a refill_ready signal and clear it.
module tlb_new(
    // Standard control signal for memory component
    input clk,
    input enable,
    output busy, // Just an alias for miss
    output ready,
    
    input [`VPN - 1:0] in_pn,
    output [`PPN - 1:0] out_pn,
    
    // Communicate with hardware walker
    output miss,
    output [`VPN - 1:0] vpn,
    input [`PPN - 1:0] ppn,
    input refill_ready
);
    // LRU: replace it with a code.
    // 8-entry should be sufficient. 
    reg [`PPN + `VPN - 1:0] lru [0:`INST_LRU_SIZE - 1];
    // replace pointer
    reg [`INST_LRU_ADDR - 1:0] release_pointer;
    // The status register
    reg miss_reg;
    // The PPN the walker is checking
    reg [`VPN - 1:0] request_pn_reg;
    
    // Comparator
    wire [`INST_LRU_SIZE - 1:0] neq_out;
    wire [`INST_LRU_ADDR - 1:0] comp_index;
    genvar i, j;
    generate
        for (i = 0; i < `INST_LRU_SIZE; i = i + 1)
        begin: comp
            assign neq_out[i] = |(lru[i][71:24] ^ in_pn[63:12]);
        end
        // If exist, retrive the data; if there are multiple matching entries (which implies hardware malfunction),
        // choose the first one, and (if I have time) raise a NMI.
        wire [`INST_LRU_SIZE - 1:0] en_int [0:`INST_LRU_ADDR];
        assign en_int[0] = neq_out;
        for (i = 0; i < `INST_LRU_ADDR; i = i + 1)
        begin: comp_res_encode
            wire [2 ** (2 - i) - 1:0] or_op;
            for (j = 0; j < 2 ** (2 - i); j = j + 1)
            begin: comp_encode_inner
                assign or_op[j] = en_int[i][2 * j + 1];
                assign en_int[i + 1][j] = en_int[i][2 * j] | en_int[i][2 * j + 1];
            end
            assign comp_index[i] = |or_op;
        end
    endgenerate
    wire entry_exist = en_int[`INST_LRU_ADDR][0];
    
    // When the refill comes in, the reading data port should takes the value from the refill port
    // directly instead of waiting the memory to update.
    assign out_pn = refill_ready ? ppn : lru[comp_index][`PPN - 1:0];
    // Set ready bit: It is set for one cycle when refill comes in, or the request (if enabled) is completed without walker
    assign ready = (miss_reg & refill_ready) | (enable & entry_exist);
    // Miss signal for page walker
    assign miss = miss_reg;
    assign busy = miss_reg;
    
    // Adding one to release pointer, and take it when update is needed.
    wire [`INST_LRU_ADDR - 1:0] next_release;
    // TODO fill in the canonic adder
    
    // initialize the memory
    integer index;
    initial begin
        release_pointer <=`INST_LRU_ADDR'b0;
        request_pn_reg <= `VPN'b0;
        miss_reg <= 1'b0;
        for (index= 0; index < 8; index = index + 1) lru[index] <= {(`PPN + `VPN){1'b0}};
    end
    
    // The updating block
    always @ (posedge clk) begin
        if (miss_reg) begin // The module is waiting for data refill and update
            if (refill_ready) begin // refill comes in
                // Change the status back
                miss_reg <= 1'b0;
                // Save the data to the register
                lru[release_pointer] <= {request_pn_reg, ppn};
                // Update the release pointer
                release_pointer <= next_release;
                // clear request PPN
                request_pn_reg <= `VPN'b0;
            end // If nothing comes in, do nothing
        end else if(enable) begin // The module can process new request, and there is one
            if (!entry_exist) begin // The request require refill data
                // Update the miss reg and send signal to walker.
                miss_reg <= 1'b1;
                // Save the request VPN.
                request_pn_reg <= ppn;
            end else if(~|(comp_index ^ release_pointer)) begin // The request can be processed here, and the release pointer is pointing to the current entry
                // Update the release pointer
                release_pointer <= next_release;
            end
        end
    end
endmodule

// Page walker
module page_walker(
    // Standard control signal for memory component
    input clk,
    input enable,
    output busy, // Just an alias for miss
    output ready,
    
    input [`VPN - 1:0] vpn,
    output [`PPN - 1:0] ppn,
    
    output page_fault,
    output protection_fault,
    
    // uop issue
    // For this case, we hard-wired one register in the file for walker. 
    output [63:0] imm_op,
    output [31:0] uop
);
    // We have a two-level page table, so there should be two access to the memory.
    
endmodule