module ALU (
    input [17:0] A, 
    input [17:0] B, 
    input [1:0] ALUControl,
    output [17:0] Result,
    output OverFlow,
    output Carry,
    output Zero,
    output Negative
);

    wire Cout;
    wire [17:0] Sum;

    assign Sum = (ALUControl[0] == 1'b0) ? A + B :
                                          (A + ((~B) + 1));
    assign {Cout, Result} = (ALUControl == 2'b00) ? Sum :
                            (ALUControl == 2'b01) ? Sum :
                            (ALUControl == 2'b10) ? A * B :
                            (ALUControl == 2'b11) ? A / B :
                            {18{1'b0}};
                            
    // Ajuste para la detección de OverFlow en suma y resta
    assign OverFlow = ((ALUControl == 2'b00) && (A[17] == B[17]) && (Result[17] != A[17])) ||
                      ((ALUControl == 2'b01) && (A[17] != B[17]) && (Result[17] != A[17]));

    assign Carry = (ALUControl[0] == 1'b0) ? Cout : (~Cout);
    assign Zero = (Result == 18'b0);
    assign Negative = Result[17];

endmodule
