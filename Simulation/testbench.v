`timescale 1ns / 1ps

module tb_carry_save_adder_16bit;

    // 1. Declare signals to connect to the inputs and outputs of the DUT (Device Under Test)
    reg [15:0] a;
    reg [15:0] b;
    reg [15:0] c;
    
    wire [17:0] final_sum;

    // 2. Variable to hold the expected result for self-checking
    reg [17:0] expected_sum;

    // 3. Instantiate the Carry Save Adder module
    carry_save_adder_16bit dut (
        .a(a), 
        .b(b), 
        .c(c), 
        .final_sum(final_sum)
    );

    // 4. Test Stimulus Block
    initial begin
        // Print a header for the simulation console output
        $display("Time\t a\t\t b\t\t c\t\t |\t final_sum\t expected\t Match?");
        $display("-------------------------------------------------------------------------------------------------");
        
        // Use $monitor to automatically print values whenever any signal changes
        $monitor("%0t\t %d\t %d\t %d\t |\t %d\t\t %d\t\t %s", 
                 $time, a, b, c, final_sum, expected_sum, (final_sum == expected_sum) ? "YES" : "ERROR");

        // Test Case 1: All Zeros
        a = 16'd0; b = 16'd0; c = 16'd0; 
        expected_sum = a + b + c; 
        #10; // Wait 10 time units

        // Test Case 2: Small numbers
        a = 16'd10; b = 16'd20; c = 16'd30; 
        expected_sum = a + b + c; 
        #10;

        // Test Case 3: Medium numbers (Causes multiple internal carries)
        a = 16'd1500; b = 16'd2500; c = 16'd3500; 
        expected_sum = a + b + c; 
        #10;

        // Test Case 4: Alternating bit patterns
        a = 16'hAAAA; b = 16'h5555; c = 16'h1111; 
        expected_sum = a + b + c; 
        #10;

        // Test Case 5: Maximum possible 16-bit values (Tests the 18-bit overflow capacity)
        a = 16'hFFFF; b = 16'hFFFF; c = 16'hFFFF; // 65535 + 65535 + 65535
        expected_sum = a + b + c; 
        #10;
        
        // Test Case 6: Random stimulus
        a = $random; b = $random; c = $random; 
        expected_sum = a + b + c; 
        #10;
        
        // Test Case 7: Another random stimulus
        a = $random; b = $random; c = $random; 
        expected_sum = a + b + c; 
        #10;

        // Finish simulation
        $display("-------------------------------------------------------------------------------------------------");
        $display("Simulation Complete.");
        $finish;
    end
    
endmodule
