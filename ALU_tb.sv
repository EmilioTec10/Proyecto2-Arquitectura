module ALU_tb;

    // Inputs
    reg [20:0] A, B;
    reg [1:0] ALUControl;

    // Outputs
    wire [20:0] Result;
    wire Carry, OverFlow, Zero, Negative;

    // Instantiate the ALU module
    ALU alu_uut (
        .A(A),
        .B(B),
        .ALUControl(ALUControl),
        .Result(Result),
        .Carry(Carry),
        .OverFlow(OverFlow),
        .Zero(Zero),
        .Negative(Negative)
    );

    // Testbench process
    initial begin
        // Initialize inputs
        A = 0;
        B = 0;
        ALUControl = 2'b00;
        #10;

        // Test case 1: A = 10, B = 5, ALUControl = 00 (Addition)
        A = 21'd10;
        B = 21'd5;
        ALUControl = 2'b00;
        #10;
        $display("Addition: A = %d, B = %d, Result = %d, Carry = %b, OverFlow = %b, Zero = %b, Negative = %b", A, B, Result, Carry, OverFlow, Zero, Negative);

        // Test case 2: A = 15, B = 5, ALUControl = 01 (Subtraction)
        A = 21'd15;
        B = 21'd5;
        ALUControl = 2'b01;
        #10;
        $display("Subtraction: A = %d, B = %d, Result = %d, Carry = %b, OverFlow = %b, Zero = %b, Negative = %b", A, B, Result, Carry, OverFlow, Zero, Negative);

        // Test case 3: A = 3, B = 4, ALUControl = 10 (Multiplication)
        A = 21'd3;
        B = 21'd4;
        ALUControl = 2'b10;
        #10;
        $display("Multiplication: A = %d, B = %d, Result = %d, Carry = %b, OverFlow = %b, Zero = %b, Negative = %b", A, B, Result, Carry, OverFlow, Zero, Negative);

        // Test case 4: A = 20, B = 4, ALUControl = 11 (Division)
        A = 21'd20;
        B = 21'd4;
        ALUControl = 2'b11;
        #10;
        $display("Division: A = %d, B = %d, Result = %d, Carry = %b, OverFlow = %b, Zero = %b, Negative = %b", A, B, Result, Carry, OverFlow, Zero, Negative);

        // Test case 5: A = -10, B = 10, ALUControl = 00 (Addition with negative number)
        A = -21'd10;
        B = 21'd10;
        ALUControl = 2'b00;
        #10;
        $display("Addition with negative: A = %d, B = %d, Result = %d, Carry = %b, OverFlow = %b, Zero = %b, Negative = %b", A, B, Result, Carry, OverFlow, Zero, Negative);

        // Test case 6: A = 0, B = 0, ALUControl = 00 (Zero result)
        A = 21'd0;
        B = 21'd0;
        ALUControl = 2'b00;
        #10;
        $display("Zero result: A = %d, B = %d, Result = %d, Carry = %b, OverFlow = %b, Zero = %b, Negative = %b", A, B, Result, Carry, OverFlow, Zero, Negative);
		  
		  
        // Test case 7: A = 524288, B = 524288, ALUControl = 00 (Overflow case)
        A = 21'd524288;  // Máximo positivo que no causa desbordamiento
        B = 21'd524288;  // Se espera que la suma cause desbordamiento
        ALUControl = 2'b00;
        #10;
        $display("Overflow case: A = %d, B = %d, Result = %d, Carry = %b, OverFlow = %b, Zero = %b, Negative = %b", A, B, Result, Carry, OverFlow, Zero, Negative);
			
        // End of test
        $stop;
    end

endmodule
