module ALU (input [23:0] A, 
			  input [23:0]B, 
			  input [1:0] ALUControl,
			  output [23:0]Result,
			  output OverFlow,
			  output Carry,
			  output Zero,
			  output Negative);

    wire Cout;
    wire [23:0]Sum;

    assign Sum = (ALUControl[0] == 1'b0) ? A + B :
                                          (A + ((~B)+1)) ;
    assign {Cout,Result} = (ALUControl == 2'b00) ? Sum :
                           (ALUControl == 2'b01) ? Sum :
                           (ALUControl == 2'b10) ? A * B :
                           (ALUControl == 2'b11) ? A / B :
									{22{1'b0}};
									
    assign OverFlow = ((A[23] == B[23]) && (Result[23] != A[23])) && (~ALUControl[1]);
    assign Carry = (ALUControl[0] == 1'b0) ? Cout : (~Cout);
    assign Zero = &(~Result);
    assign Negative = Result[23];


endmodule 