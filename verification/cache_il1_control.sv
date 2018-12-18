`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/12/15 11:57:19
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
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

task test_equal(input integer expected, input integer got, input string name);
    if (expected != got)
        $write("%s test failed: expected %x, got %x\n", name, expected, got);
endtask

module cache_il1_valid_table_test();
    typedef struct {
        bit [7:0] read_set_index;
        bit reset;
        bit write_en;
        bit [7:0] write_set_index;
        bit [3:0] valid_mask;
    } simulant;
    typedef struct {
        bit [3:0] valid_bits;
        bit [3:0] refill_valid_bits;
        bit nmi;
    } response;
    typedef struct {
        simulant s;
        response r;
        string description;
    } test_case;
    
    // Build test cases (only work under functional test)
    // Note that the result will be tested one cycle after the corresponding simulant is given
    test_case functional_cases [12] = '{
        //  r_si  rst   w_en   w_si  v_mask     valid_b  r_valid_b nmi 
        '{'{8'b0, 1'b0, 1'b1, 8'b0, 4'b1000}, '{4'b0000, 4'b0000, 1'b0}, "request a write to address 0"},
        '{'{8'b0, 1'b0, 1'b1, 8'b1, 4'b0100}, '{4'b0000, 4'b0000, 1'b0}, "write 0100 to address 0, and request to write address 1"},
        '{'{8'b0, 1'b0, 1'b0, 8'b0, 4'b0001}, '{4'b0100, 4'b0100, 1'b0}, "Reading address 0 should give 0100 now; write 0001 to address 1"},
        '{'{8'b1, 1'b0, 1'b0, 8'b0, 4'b0001}, '{4'b0001, 4'b0100, 1'b0}, "read address 0 for refill, and pass a valid mask without enabling writing"},
                                                                    // Also verify if address 1 is 0001
        '{'{8'b0, 1'b0, 1'b1, 8'b0, 4'b0000}, '{4'b0100, 4'b0100, 1'b0}, "request write addr 0; addr 0 shouldn't be changed"},
        '{'{8'b0, 1'b0, 1'b0, 8'b0, 4'b1000}, '{4'b0100, 4'b0100, 1'b0}, "write 1000"},
        '{'{8'b0, 1'b1, 1'b1, 8'b10, 4'b0000}, '{4'b1100, 4'b0000, 1'b0}, "read addr 0 should give 1100; now, reset, while attempting to write to addr 2"},
        '{'{8'b0, 1'b0, 1'b0, 8'b10, 4'b0010}, '{4'b0000, 4'b0000, 1'b0}, "All bit should be cleared, and refill request should be cancelled; write 0010"},
                                                                    // Also read addr 1 to check if it is also cleared
        '{'{8'b10, 1'b0, 1'b1, 8'b11, 4'b0010}, '{4'b0000, 4'b0000, 1'b0}, "Check if addr 2 is 0000; now, write addr 3"},
        '{'{8'b0, 1'b0, 1'b1, 8'b0, 4'b1111}, '{4'b0000, 4'b0000, 1'b1}, "Write an ill-formed data: 1111. It should raise a NMI. Also request to write to addr 0"},
        '{'{8'b0, 1'b0, 1'b0, 8'b0, 4'b0001}, '{4'b0000, 4'b0000, 1'b0}, "Pipeline should be cleared, and write shouldn't be done despite attempt to write 0001 to addr 0"},
        '{'{8'b0, 1'b0, 1'b0, 8'b11, 4'b0000}, '{4'b0000, 4'b0000, 1'b0}, "Check if addr 0 and 3 is not modified"}
    };
    
    bit [7:0] read_set_index;
    bit reset;
    bit write_en;
    bit [7:0] write_set_index;
    bit [3:0] valid_mask;
    
    bit [3:0] valid_bits;
    bit [3:0] refill_valid_bits;
    bit nmi;
    
    logic [3:0] counter;
    bit halt;
    initial begin
        $write("Valid table testing begin\n");
        counter <= 0;
        halt <= 0;
    end
    
    // op buffer
    response op_buffer;
    bit [3:0] counter_buf;
    bit halt_buf;
    initial
        halt_buf <= 4'b1111; // Marked as invalid (-1)
    
    bit clk;
    always #2.5 clk <= ~clk;
    always @ (posedge clk) begin
        // Read the output
        if (counter_buf != 4'b1111 & ~halt_buf) begin // Check if there is any result in the buf
            $write("Test case: %s\n", functional_cases[counter_buf].description);
            test_equal(op_buffer.valid_bits, valid_bits, "valid_bits");
            test_equal(op_buffer.refill_valid_bits, refill_valid_bits, "refill_valid_bits");
            test_equal(op_buffer.nmi, nmi, "nmi");
            $write("===========\n");
        end
        
        // Load the input
        if (!halt) begin
            op_buffer <= functional_cases[counter].r;
            
            read_set_index <= functional_cases[counter].s.read_set_index;
            reset <= functional_cases[counter].s.reset;
            write_en <= functional_cases[counter].s.write_en;
            write_set_index <= functional_cases[counter].s.write_set_index;
            valid_mask <= functional_cases[counter].s.valid_mask;
            counter <= counter + 1;
            // Lock if done
            if (counter == 11) // The counter value is updated after this condition is evaluated, so it must be (length - 1)
                halt <= 1'b1;
        end
        
        // Update the counter buffer
        counter_buf <= counter;
        halt_buf <= halt;
    end
    
    // The target
    valid_table_il1 target_object(.*, .clk(clk));
endmodule

module cache_il1_lru_table_test();
    typedef struct {
        bit write_en;
        bit has_invalid;
        bit [7:0] refill_set_index;
        bit [3:0] way_selected;
        bit [7:0] read_set_index;
        bit [3:0] read_way;
        bit stalled;
    } simulant;
    typedef struct {
        bit [3:0] lru_way;
    } response;
    typedef struct {
        simulant s;
        response r;
        string description;
    } test_case;
    
    // Build test cases (only work under functional test)
    // Note that the result will be tested one cycle after the corresponding simulant is given
    /*test_case functional_cases [12] = '{
        //  w_en  has_i r_si  w_sel  v_mask     valid_b  r_valid_b nmi 
        '{'{8'b0, 1'b0, 1'b1, 8'b0, 4'b1000}, '{4'b0000, 4'b0000, 1'b0}, "read and refill to way 0, with invalid slot"},
        '{'{8'b0, 1'b0, 1'b1, 8'b1, 4'b0100}, '{4'b0000, 4'b0000, 1'b0}, "read way 3, refill way 0, with invalid slot"},
        '{'{8'b0, 1'b0, 1'b0, 8'b0, 4'b0001}, '{4'b0100, 4'b0100, 1'b0}, "read 1, refill 3, with invalid slot"},
        '{'{8'b1, 1'b0, 1'b0, 8'b0, 4'b0001}, '{4'b0001, 4'b0100, 1'b0}, "read 4, refill 4, with invalid slot"},
        '{'{8'b0, 1'b0, 1'b1, 8'b0, 4'b0000}, '{4'b0100, 4'b0100, 1'b0}, "read 0, refill 2, with invalid slot"},
        '{'{8'b0, 1'b0, 1'b0, 8'b0, 4'b1000}, '{4'b0100, 4'b0100, 1'b0}, "read 0, no refill, but still set way to 3"},
        '{'{8'b0, 1'b1, 1'b1, 8'b10, 4'b0000}, '{4'b1100, 4'b0000, 1'b0}, "read 2, no valid slot (but set to refill 0)"},
        '{'{8'b0, 1'b0, 1'b0, 8'b10, 4'b0010}, '{4'b0000, 4'b0000, 1'b0}, "read and refill two different address"},
    };*/
    
    bit write_en;
    bit has_invalid;
    bit [7:0] refill_set_index;
    bit [3:0] way_selected;
    bit [7:0] read_set_index;
    bit [3:0] read_way;
    bit stalled;
    
    bit [3:0] lru_way;
    
    logic [3:0] counter;
    bit halt;
    initial begin
        $write("Valid table testing begin\n");
        counter <= 0;
        halt <= 0;
    end
    
    // op buffer
    response op_buffer;
    bit [3:0] counter_buf;
    bit halt_buf;
    initial
        halt_buf <= 4'b1111; // Marked as invalid (-1)
    
    bit clk;
    always #2.5 clk <= ~clk;
    always @ (posedge clk) begin
        // Read the output
        if (counter_buf != 4'b1111 & ~halt_buf) begin // Check if there is any result in the buf
            $write("Test case: %s\n", functional_cases[counter_buf].description);
            test_equal(op_buffer.valid_bits, valid_bits, "valid_bits");
            test_equal(op_buffer.refill_valid_bits, refill_valid_bits, "refill_valid_bits");
            test_equal(op_buffer.nmi, nmi, "nmi");
            $write("===========\n");
        end
        
        // Load the input
        if (!halt) begin
            op_buffer <= functional_cases[counter].r;
            
            read_set_index <= functional_cases[counter].s.read_set_index;
            reset <= functional_cases[counter].s.reset;
            write_en <= functional_cases[counter].s.write_en;
            write_set_index <= functional_cases[counter].s.write_set_index;
            valid_mask <= functional_cases[counter].s.valid_mask;
            counter <= counter + 1;
            // Lock if done
            if (counter == 11) // The counter value is updated after this condition is evaluated, so it must be (length - 1)
                halt <= 1'b1;
        end
        
        // Update the counter buffer
        counter_buf <= counter;
        halt_buf <= halt;
    end
    
    // The target
    valid_table_il1 target_object(.*, .clk(clk));
endmodule