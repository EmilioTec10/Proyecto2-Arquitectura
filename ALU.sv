module ALU (input [20:0] A, 
			  input [20:0]B, 
			  input [1:0] ALUControl,
			  output [20:0]Result,
			  output OverFlow,
			  output Carry,
			  output Zero,
			  output Negative);

    wire Cout;
    wire [20:0]Sum;

    assign Sum = (ALUControl[0] == 1'b0) ? A + B :
                                          (A + ((~B)+1)) ;
    assign {Cout,Result} = (ALUControl == 2'b00) ? Sum :
                           (ALUControl == 2'b01) ? Sum :
                           (ALUControl == 2'b10) ? A * B :
                           (ALUControl == 2'b11) ? A / B :
									{22{1'b0}};
									
    assign OverFlow = ((A[20] == B[20]) && (Result[20] != A[20])) && (~ALUControl[1]);
    assign Carry = (ALUControl[0] == 1'b0) ? Cout : (~Cout);
    assign Zero = &(~Result);
    assign Negative = Result[20];


endmodule 