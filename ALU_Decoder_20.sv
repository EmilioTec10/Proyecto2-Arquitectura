module ALU_Decoder_20(
    input [1:0] ALUOp,   // Control general de la operación
    input [3:0] op,      // Operación específica (4 bits)
    output reg [2:0] ALUControl // Señales de control para la ALU
);

    always @(*) begin
        if (ALUOp == 2'b00) begin // Estamos en una operación aritmética
            case (op)
                4'b0000: ALUControl = 3'b000; // Suma
                4'b0001: ALUControl = 3'b001; // Resta
                4'b0010: ALUControl = 3'b010; // Multiplicación
                4'b0011: ALUControl = 3'b011; // División
                default: ALUControl = 3'b000; // Valor por defecto, podría ser NOP
            endcase
        end else begin
            ALUControl = 3'b000; // Valor por defecto cuando no hay operación aritmética
        end
    end

endmodule
