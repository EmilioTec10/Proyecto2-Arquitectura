module ALU_Decoder(
    input [1:0] ALUOp,   // Control general de la operación
    input [1:0] op,      // Operación específica (2 bits)
    output reg [2:0] ALUControl // Señales de control para la ALU
);

    always @(*) begin
        case(ALUOp)
				2'b10:begin
					case (op)
						 2'b00: ALUControl = 3'b000; // Suma
						 2'b01: ALUControl = 3'b001; // Resta
						 2'b10: ALUControl = 3'b010; // Multiplicación
						 2'b11: ALUControl = 3'b011; // División
						 default: ALUControl = 3'b000; // Valor por defecto, podría ser NOP
					endcase
					end
					
				2'b01:begin
					ALUControl = 3'b000;
		
					end
					
				2'b00:begin
					ALUControl = 3'b000;
					end
			endcase	
        
    end

endmodule
