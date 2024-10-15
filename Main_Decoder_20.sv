module Main_Decoder_20(
    input [1:0] tipo,   // Tipo de instrucción
    input [1:0] op,     // Operación específica
    input Inm,          // Bit de inmediato
	 
    output RegWrite,    // Habilitar escritura en registros
    output [1:0] ImmSrc,// Fuente del inmediato
    output ALUSrc,      // Selección entre registro o inmediato en la ALU
    output MemWrite,    // Habilitar escritura en memoria
    output ResultSrc,   // Selección del resultado (ALU o memoria)
    output Branch,      // Indicar si es una instrucción de salto condicional
    output [1:0] ALUOp  // Señal de control para la ALU
);

    // RegWrite: se activa para instrucciones de tipo R (00) y tipo I (01)
    assign RegWrite = (tipo == 2'b00 || tipo == 2'b01) ? 1'b1 : 1'b0;

    // ImmSrc: depende de si es tipo I o tipo S
    assign ImmSrc = (tipo == 2'b10) ? 2'b01 :  // Tipo S (memoria)
                    (tipo == 2'b01) ? 2'b01 :  // Tipo I (inmediato)
                                     2'b00;    // Otros

    // ALUSrc: se activa para instrucciones que usan inmediatos (tipo I y tipo S)
    assign ALUSrc = (tipo == 2'b01 || tipo == 2'b10) ? 1'b1 : 1'b0;

    // MemWrite: solo se activa para instrucciones de tipo S (store)
    assign MemWrite = (tipo == 2'b10) ? 1'b1 : 1'b0;

    // ResultSrc: selecciona la memoria como fuente del resultado (para LOAD)
    assign ResultSrc = (tipo == 2'b01 && op == 2'b00) ? 1'b1 : 1'b0;  // Para instrucciones de carga (tipo I con `op == 00`)

    // Branch: se activa para instrucciones de tipo B (branch)
    assign Branch = (tipo == 2'b11) ? 1'b1 : 1'b0;

    // ALUOp: se define en base al tipo de operación (ADD, SUB, etc.)
    assign ALUOp = (tipo == 2'b00) ? 2'b10 :  // Tipo R (operaciones como ADD/SUB)
                   (tipo == 2'b11) ? 2'b01 :  // Tipo B (branch)
                                     2'b00;   // Otros (ORI, etc.)

endmodule
