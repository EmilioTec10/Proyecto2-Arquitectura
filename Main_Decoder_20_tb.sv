module Main_Decoder_20_tb;

    // Declaración de señales de prueba
    logic [1:0] tipo;   // Tipo de instrucción
    logic [1:0] op;     // Operación específica
    logic Inm;          // Bit de inmediato
	 
    logic RegWrite;    // Habilitar escritura en registros
    logic [1:0] ImmSrc;// Fuente del inmediato
    logic ALUSrc;      // Selección entre registro o inmediato en la ALU
    logic MemWrite;    // Habilitar escritura en memoria
    logic ResultSrc;   // Selección del resultado (ALU o memoria)
    logic Branch;      // Indicar si es una instrucción de salto condicional
    logic [1:0] ALUOp;  // Señal de control para la ALU

    // Instancia del decodificador
    Main_Decoder_20 uut (
        .tipo(tipo),       // Tipo de instrucción
        .op(op),           // Operación específica
        .Inm(Inm),         // Bit de inmediato
        .RegWrite(RegWrite),    // Habilitar escritura en registros
        .ImmSrc(ImmSrc),        // Fuente del inmediato
        .ALUSrc(ALUSrc),        // Selección entre registro o inmediato en la ALU
        .MemWrite(MemWrite),    // Habilitar escritura en memoria
        .ResultSrc(ResultSrc),  // Selección del resultado (ALU o memoria)
        .Branch(Branch),        // Indicar si es una instrucción de salto condicional
        .ALUOp(ALUOp)           // Señal de control para la ALU
    );
	 
    // Procedimiento inicial
    initial begin
        // Imprimir título
        $display("Comenzando pruebas para Main Decoder...");
        $display("Formato: tipo=%b, op=%b, Inm=%b -> RegWrite=%b, ImmSrc=%b, ALUSrc=%b, MemWrite=%b, ResultSrc=%b, Branch=%b, ALUOp=%b", 
                 tipo, op, Inm, RegWrite, ImmSrc, ALUSrc, MemWrite, ResultSrc, Branch, ALUOp);

        // Test 1: Instrucciones Aritméticas (tipo = 00)
        $display("Probando instrucciones aritméticas (tipo 00)...");
        tipo = 2'b00;

        // ADD (00)
        op = 2'b00; Inm = 0;
        #10;  
        $display("ADD (00): tipo=%b, op=%b, Inm=%b -> RegWrite=%b, ImmSrc=%b, ALUSrc=%b, MemWrite=%b, ResultSrc=%b, Branch=%b, ALUOp=%b", 
                 tipo, op, Inm, RegWrite, ImmSrc, ALUSrc, MemWrite, ResultSrc, Branch, ALUOp);

        // SUB (01)
        op = 2'b01; Inm = 0;
        #10;
        $display("SUB (01): tipo=%b, op=%b, Inm=%b -> RegWrite=%b, ImmSrc=%b, ALUSrc=%b, MemWrite=%b, ResultSrc=%b, Branch=%b, ALUOp=%b", 
                 tipo, op, Inm, RegWrite, ImmSrc, ALUSrc, MemWrite, ResultSrc, Branch, ALUOp);

        // MULT (10)
        op = 2'b10; Inm = 0;
        #10;
        $display("MULT (10): tipo=%b, op=%b, Inm=%b -> RegWrite=%b, ImmSrc=%b, ALUSrc=%b, MemWrite=%b, ResultSrc=%b, Branch=%b, ALUOp=%b", 
                 tipo, op, Inm, RegWrite, ImmSrc, ALUSrc, MemWrite, ResultSrc, Branch, ALUOp);

        // DIV (11)
        op = 2'b11; Inm = 0;
        #10;
        $display("DIV (11): tipo=%b, op=%b, Inm=%b -> RegWrite=%b, ImmSrc=%b, ALUSrc=%b, MemWrite=%b, ResultSrc=%b, Branch=%b, ALUOp=%b", 
                 tipo, op, Inm, RegWrite, ImmSrc, ALUSrc, MemWrite, ResultSrc, Branch, ALUOp);

        // Test 2: Instrucciones de Transferencia de Datos (tipo = 01)
        $display("Probando instrucciones de transferencia de datos (tipo 01)...");
        tipo = 2'b01;

        // MOV (00)
        op = 2'b00; Inm = 0;
        #10;
        $display("MOV (00): tipo=%b, op=%b, Inm=%b -> RegWrite=%b, ImmSrc=%b, ALUSrc=%b, MemWrite=%b, ResultSrc=%b, Branch=%b, ALUOp=%b", 
                 tipo, op, Inm, RegWrite, ImmSrc, ALUSrc, MemWrite, ResultSrc, Branch, ALUOp);

        // LDR (01)
        op = 2'b01; Inm = 0;
        #10;
        $display("LDR (01): tipo=%b, op=%b, Inm=%b -> RegWrite=%b, ImmSrc=%b, ALUSrc=%b, MemWrite=%b, ResultSrc=%b, Branch=%b, ALUOp=%b", 
                 tipo, op, Inm, RegWrite, ImmSrc, ALUSrc, MemWrite, ResultSrc, Branch, ALUOp);

        // STR (10)
        op = 2'b10; Inm = 0;
        #10;
        $display("STR (10): tipo=%b, op=%b, Inm=%b -> RegWrite=%b, ImmSrc=%b, ALUSrc=%b, MemWrite=%b, ResultSrc=%b, Branch=%b, ALUOp=%b", 
                 tipo, op, Inm, RegWrite, ImmSrc, ALUSrc, MemWrite, ResultSrc, Branch, ALUOp);

        // Test 3: Instrucciones de Control de Flujo (tipo = 10)
        $display("Probando instrucciones de control de flujo (tipo 10)...");
        tipo = 2'b10;

        // Branch (00)
        op = 2'b00; Inm = 0;
        #10;
        $display("Branch (00): tipo=%b, op=%b, Inm=%b -> RegWrite=%b, ImmSrc=%b, ALUSrc=%b, MemWrite=%b, ResultSrc=%b, Branch=%b, ALUOp=%b", 
                 tipo, op, Inm, RegWrite, ImmSrc, ALUSrc, MemWrite, ResultSrc, Branch, ALUOp);

        // Branch_link (01)
        op = 2'b01; Inm = 0;
        #10;
        $display("Branch_link (01): tipo=%b, op=%b, Inm=%b -> RegWrite=%b, ImmSrc=%b, ALUSrc=%b, MemWrite=%b, ResultSrc=%b, Branch=%b, ALUOp=%b", 
                 tipo, op, Inm, RegWrite, ImmSrc, ALUSrc, MemWrite, ResultSrc, Branch, ALUOp);

        // CMP (10)
        op = 2'b10; Inm = 0;
        #10;
        $display("CMP (10): tipo=%b, op=%b, Inm=%b -> RegWrite=%b, ImmSrc=%b, ALUSrc=%b, MemWrite=%b, ResultSrc=%b, Branch=%b, ALUOp=%b", 
                 tipo, op, Inm, RegWrite, ImmSrc, ALUSrc, MemWrite, ResultSrc, Branch, ALUOp);

        // BEQ (11)
        op = 2'b11; Inm = 0;
        #10;
        $display("BEQ (11): tipo=%b, op=%b, Inm=%b -> RegWrite=%b, ImmSrc=%b, ALUSrc=%b, MemWrite=%b, ResultSrc=%b, Branch=%b, ALUOp=%b", 
                 tipo, op, Inm, RegWrite, ImmSrc, ALUSrc, MemWrite, ResultSrc, Branch, ALUOp);

        // Test de instrucciones con Inmediato activado
        $display("Probando instrucciones con inmediato activado...");
        
        // ADD con inmediato
        tipo = 2'b00; op = 2'b00; Inm = 1;
        #10;
        $display("ADD con inmediato (00): tipo=%b, op=%b, Inm=%b -> RegWrite=%b, ImmSrc=%b, ALUSrc=%b, MemWrite=%b, ResultSrc=%b, Branch=%b, ALUOp=%b", 
                 tipo, op, Inm, RegWrite, ImmSrc, ALUSrc, MemWrite, ResultSrc, Branch, ALUOp);

        // SUB con inmediato
        tipo = 2'b00; op = 2'b01; Inm = 1;
        #10;
        $display("SUB con inmediato (01): tipo=%b, op=%b, Inm=%b -> RegWrite=%b, ImmSrc=%b, ALUSrc=%b, MemWrite=%b, ResultSrc=%b, Branch=%b, ALUOp=%b", 
                 tipo, op, Inm, RegWrite, ImmSrc, ALUSrc, MemWrite, ResultSrc, Branch, ALUOp);
        
        $display("Fin de las pruebas.");
        $finish;
    end
endmodule

