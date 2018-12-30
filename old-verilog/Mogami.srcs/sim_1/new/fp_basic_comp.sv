`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/13/2018 16:08:07 PM
// Design Name: FPU Basic Component Test Suite
// Module Name: (Multiple modules)
// Project Name: Mogami 
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

// PASSED
// The test case against carry-save booth recoder
module booth_test_cs();
    logic [15:0] c;
    logic [15:0] s;
    logic [7:0] sign;
    logic [7:0] m_2;
    logic [7:0] m_1;
    logic [7:0] m_0;
    cs2sd_16bit conversion_module(.*);
    
    // We start by testing carry-save conversion.
    class carry_save;
        rand bit [15:0] cs_a;
        rand bit [15:0] cs_b;
        constraint fuck {
            cs_b[0] == 1'b0;
            cs_a[15] == 1'b0;
        }
        function integer expected_value();
            return cs_a + cs_b;
        endfunction
    endclass
    
    logic [15:0] pos;
    logic [15:0] neg;
    logic [15:0] res;
    generate
        genvar i;
        for (i = 0; i < 8; i++)
        begin:pos_neg_connect
            assign pos[2 * i] = m_1[i] & ~sign[i];
            assign pos[2 * i + 1] = m_2[i] & ~sign[i];
            assign neg[2 * i] = m_1[i] & sign[i];
            assign neg[2 * i + 1] = m_2[i] & sign[i];
        end
    endgenerate
    assign res = pos - neg;
    
    logic [3:0] counter;
    logic [15:0] expected;
    bit halt;
    carry_save value;
    initial begin
        $write("Carry-save testing begin\n");
        counter <= 0;
        expected <= 0;
        halt <= 0;
        value = new();
    end
    
    bit clk;
    always #1 clk <= ~clk;
    always @ (posedge clk) begin
        if (!halt) begin
            value.randomize();
            s <= value.cs_a;
            c <= value.cs_b;
            expected <= value.expected_value();
            counter <= counter + 1;
        end 
    end
    
    always @ (negedge clk) begin
        if (!halt) begin
            if (res != expected)
                $write("Test failed for c=%x, s=%x, expected %x, got %x\n", c, s, expected, res);
            else
                $write("Case %x passed (value: %x)\n", counter, res);
            if (counter == 15)
                halt <= 1;
        end
    end
endmodule

// PASSED
// The test case against 2's completement booth recoder
module booth_test_tc();
    logic [23:0] in;
    logic [11:0] sign;
    logic [11:0] m_2;
    logic [11:0] m_1;
    logic [11:0] m_0;
    tc2sd_24bit conversion_module(.*);
    
    class twos_complement;
        rand bit [23:0] in;
    endclass
    
    logic [23:0] pos;
    logic [23:0] neg;
    logic [23:0] res;
    generate
        genvar i;
        for (i = 0; i < 12; i++)
        begin:pos_neg_connect
            assign pos[2 * i] = m_1[i] & ~sign[i];
            assign pos[2 * i + 1] = m_2[i] & ~sign[i];
            assign neg[2 * i] = m_1[i] & sign[i];
            assign neg[2 * i + 1] = m_2[i] & sign[i];
        end
    endgenerate
    assign res = pos - neg;
    
    logic [3:0] counter;
    bit halt;
    twos_complement value;
    initial begin
        $write("Carry-save testing begin\n");
        counter <= 0;
        halt <= 0;
        value = new();
    end
    
    bit clk;
    always #1 clk <= ~clk;
    always @ (posedge clk) begin
        if (!halt) begin
            value.randomize();
            in <= value.in;
            counter <= counter + 1;
        end 
    end
    
    always @ (negedge clk) begin
        if (!halt) begin
            if (res != in)
                $write("Test failed: expected %x, got %x, MSB sign %d\n", in, res, sign[11]);
            else
                $write("Case %x passed (value: %x), MSB sign %d\n", counter, res, sign[11]);
            if (counter == 15)
                halt <= 1;
        end
    end
endmodule

// A standard squaring module for comparison
// THIS IS FOR TESTING ONLY: NOT FOR SYNTHESIS.
module standard_squaring(
    input [15:0] in,
    output [15:0] out
);
    wire [31:0] pp_gen [0:15];
    wire [16:0] tmp [0:16];
    assign tmp[0] = 32'b0;
    assign out = tmp[16][16:1] + 16'b10;
    generate
        genvar i, j;
        for (i = 0; i < 16; i = i + 1)
        begin: sample
            assign pp_gen[i][31:16 + i] = {(16 - i){1'b0}};
            assign pp_gen[i][15 + i: i] = {16{in[i]}} & in;
            if (i != 0)
                assign pp_gen[i][i - 1:0] = {i{1'b0}};
        end
        for (i = 0; i < 16; i = i + 1)
        begin: outer
            assign tmp[i + 1] = tmp[i] + pp_gen[i][31:15];
        end
    endgenerate
endmodule

// The unit using the method in the paper, but with naive sum
// Based on
// Schulte, Michael J., and Earl E. Swartzlander. "Truncated multiplication with correction constant [for DSP]."
//     In VLSI Signal Processing, VI, 1993.,[Workshop on], pp. 388-396. IEEE, 1993.
module suqaring_naive_sum(
    input [15:0] in,
    output [15:0] out
);
    // Don't forget to change the wire width when switching version!
    wire [19:0] pp [0:11];
    wire [19:0] tmp [0:12];
    assign tmp[0] = 21'b0;
    assign out = tmp[12][19:4]/* + {15'b0, tmp[12][4]}*/;
    
    // k = 6 version
    /*
    assign pp[0] = {1'b0, {15{in[15]}} & in[14:0], 5'b0};
    assign pp[1] = {1'b0, in[15], 1'b0, {14{in[14]}} & in[13:0], 4'b0};
    assign pp[2] = {3'b0, in[14], 1'b0, {13{in[13]}} & in[12:0], 3'b0};
    assign pp[3] = {5'b0, in[13], 1'b0, {12{in[12]}} & in[11:0], 2'b0};
    assign pp[4] = {7'b0, in[12], 1'b0, {11{in[11]}} & in[10:0], 1'b0};
    assign pp[5] = {9'b0, in[11], 1'b0, {10{in[10]}} & in[9:0]};
    assign pp[6] = {11'b0, in[10], 1'b0, {8{in[9]}} & in[8:1]};
    assign pp[7] = {13'b0, in[9], 1'b0, {6{in[8]}} & in[7:2]};
    assign pp[8] = {15'b0, in[8], 1'b0, {4{in[7]}} & in[6:3]};
    
    assign pp[9] = {17'b0, in[7], 1'b0, {2{in[6]}} & in[5:4]};
    assign pp[10] = {19'b0, in[6], 1'b0};
    assign pp[11] = 21'd5;
    */
    
    assign pp[0] = {1'b0, {15{in[15]}} & in[14:0], 4'b0};
    assign pp[1] = {1'b0, in[15], 1'b0, {14{in[14]}} & in[13:0], 3'b0};
    assign pp[2] = {3'b0, in[14], 1'b0, {13{in[13]}} & in[12:0], 2'b0};
    assign pp[3] = {5'b0, in[13], 1'b0, {12{in[12]}} & in[11:0], 1'b0};
    assign pp[4] = {7'b0, in[12], 1'b0, {11{in[11]}} & in[10:0]};
    assign pp[5] = {9'b0, in[11], 1'b0, {9{in[10]}} & in[9:1]};
    assign pp[6] = {11'b0, in[10], 1'b0, {7{in[9]}} & in[8:2]};
    assign pp[7] = {13'b0, in[9], 1'b0, {5{in[8]}} & in[7:3]};
    assign pp[8] = {15'b0, in[8], 1'b0, {3{in[7]}} & in[6:4]};
    
    assign pp[9] = {17'b0, in[7], 1'b0, in[6] & in[5]};
    assign pp[10] = {19'b0, in[6]};
    assign pp[11] = 20'h6;
    
    generate
        genvar i;
        for (i = 0; i < 12; i = i + 1)
        begin: test
            assign tmp[i + 1] = tmp[i] + pp[i];
        end
    endgenerate
endmodule 

module squaring_test();
    logic [15:0] in;
    logic [15:0] out;
    logic [15:0] out_c;
    square_16b target_object(.*);
    logic [15:0] standard_out;
    logic [15:0] naive_sum;
    standard_squaring standard(.in(in), .out(standard_out));
    suqaring_naive_sum naive(.in(in), .out(naive_sum));
   
    class square;
        rand bit [15:0] in;
        function integer expected_value();
            return in * in;
        endfunction
    endclass
    
    logic [15:0] res;
    logic [31:0] expected_tmp;
    logic [15:0] expected;
    assign res = out + out_c;
    assign expected = expected_tmp[31:16];
    
    logic [3:0] counter;
    bit halt;
    square value;
    initial begin
        $write("Carry-save testing begin\n");
        counter <= 0;
        halt <= 0;
        value = new();
    end
    
    bit clk;
    always #1 clk <= ~clk;
    always @ (posedge clk) begin
        if (!halt) begin
            value.randomize();
            in <= value.in;
            counter <= counter + 1;
            expected_tmp <= value.expected_value();
        end 
    end
    
    always @ (negedge clk) begin
        if (!halt) begin
            if (/*res*/naive_sum != expected)
                $write("Test failed for %x: expected %x, got %x\n", in, expected, /*res*/naive_sum);
            else
                $write("Case %x passed (value: %x)\n", counter, /*res*/naive_sum);
            if (counter == 15)
                halt <= 1;
        end
    end
endmodule