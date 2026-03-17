`timescale 1ns/1ps
// 1-bit Full Adder Module
module full_adder(
    input a, 
    input b, 
    input cin,
    output sum, 
    output cout
);
    assign sum = a ^ b ^ cin;
    assign cout = (a & b) | (b & cin) | (cin & a);
endmodule

// 16-bit Carry Save Adder Top Module
module carry_save_adder_16bit(
    input [15:0] a,
    input [15:0] b,
    input [15:0] c,
    output [17:0] final_sum  // 18 bits to accommodate the maximum possible sum of three 16-bit numbers
);
    // Internal wires to hold the intermediate sum and carry vectors
    wire [15:0] save_sum;
    wire [15:0] save_carry;

    // Stage 1: Carry Save Adder Array
    // This stage computes the sum and carry bits independently for each bit position.
    // There is no carry-ripple here, making it exceptionally fast ($O(1)$ delay).
    genvar i;
    generate
        for (i = 0; i < 16; i = i + 1) begin : csa_stage
            full_adder fa (
                .a(a[i]),
                .b(b[i]),
                .cin(c[i]),
                .sum(save_sum[i]),
                .cout(save_carry[i])
            );
        end
    endgenerate

    // Stage 2: Carry Propagate Adder (CPA)
    // To get the final sum, we add the intermediate 'save_sum' and the 'save_carry'.
    // The 'save_carry' vector must be shifted left by 1 bit because carry bits 
    // represent the next significant positional weight.
    
    // We pad with 0s to ensure no overflow is lost during the final addition.
    assign final_sum = {2'b00, save_sum} + {1'b0, save_carry, 1'b0};

endmodule
