module Main_Decoder(
    input [1:0] tipo,   // Tipo de instrucción
    input [1:0] op,     // Operación específica
    input Inm,          // Bit de inmediato
	 
    output reg RegWrite,    // Habilitar escritura en registros
    output reg [1:0] ImmSrc,// Fuente del inmediato
    output reg ALUSrc,      // Selección entre registro o inmediato en la ALU
    output reg MemWrite,    // Habilitar escritura en memoria
    output reg ResultSrc,   // Selección del resultado (ALU o memoria)
    output reg Branch,      // Indicar si es una instrucción de salto condicional
    output reg [1:0] ALUOp  // Señal de control para activar la ALU
);

    always @(*) begin
        // Valores por defecto
        RegWrite   = 0;
        ImmSrc     = 2'b00;
        ALUSrc     = 0;
        MemWrite   = 0;
        ResultSrc  = 0;
        Branch     = 0;
        ALUOp      = 2'b00; // La ALU no se activa por defecto

        // Decodificación según el tipo de instrucción
        case (tipo)
            2'b00: begin  // Instrucciones Aritméticas
                RegWrite = 1; // Se escriben resultados en registros
                ALUSrc = Inm; // Usamos inmediato si el bit Inm está activado
                ALUOp = 2'b10; // Activamos la ALU para operaciones aritméticas
            end

            2'b01: begin  // Instrucciones de Transferencia de Datos
                ALUSrc = Inm; // Usamos inmediato si está activado
                case (op)
                    2'b00: begin // MOV
                        RegWrite = 1; // Escribimos en registro
                        ResultSrc = 0; // El resultado proviene de la ALU
                        ALUOp = 2'b00; // No activamos la ALU para MOV
                    end
                    2'b01: begin // LDR (load)
                        RegWrite = 1; // Escribimos en registro
                        ResultSrc = 1; // El resultado proviene de memoria
                        ALUOp = 2'b00; // No activamos la ALU para LDR
                    end
                    2'b10: begin // STR (store)
                        MemWrite = 1; // Escribimos en memoria
                        RegWrite = 0; // No escribimos en registros
                        ALUOp = 2'b00; // No activamos la ALU para STR
                    end
                endcase
            end

            2'b10: begin  // Instrucciones de Control de Flujo
                case (op)
                    2'b00: Branch = 1; // Branch
                    2'b01: Branch = 1; // Branch_link
                    2'b10: begin // CMP
                        ALUOp = 2'b01; // Activamos la ALU para comparación
                        RegWrite = 0; // No se escribe en registros
                    end
                    2'b11: Branch = 1; // BEQ (Branch if equal)
                endcase
            end
        endcase
    end

endmodule
