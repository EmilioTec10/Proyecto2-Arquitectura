module Control_Unit_Top_20(
    input [1:0] tipo,   // Tipo de instrucción
    input [1:0] op,     // Operación específica
    input Inm,          // Bit de inmediato
	 
    output RegWrite,    // Habilitar escritura en registros
    output [1:0] ImmSrc,  // Fuente del inmediato
    output ALUSrc,      // Selección entre registro o inmediato en la ALU
    output MemWrite,    // Habilitar escritura en memoria
    output ResultSrc,   // Selección del resultado (ALU/memoria)
    output Branch,      // Indicar si es una instrucción de salto condicional
    output [2:0] ALUControl  // Control para la ALU
);

    // Señal interna para ALUOp, que determinará la operación de la ALU
    wire [1:0] ALUOp;

    // Instancia del decodificador principal
    Main_Decoder_20 Main_Decoder(
        .tipo(tipo),
        .op(op),
        .Inm(Inm),
		  
        .RegWrite(RegWrite),
        .ImmSrc(ImmSrc),
        .MemWrite(MemWrite),
        .ResultSrc(ResultSrc),
        .Branch(Branch),
        .ALUSrc(ALUSrc),
        .ALUOp(ALUOp)
    );

    // Instancia del decodificador de la ALU
    ALU_Decoder_20 ALU_Decoder(
        .ALUOp(ALUOp),
        .op(op),
		  
        .ALUControl(ALUControl)
    );

endmodule
