module Main_Decoder_20_tb;


    // Entradas
    reg [1:0] tipo;   // Tipo de instrucción
    reg [1:0] op;     // Operación específica
    reg Inm;          // Bit de inmediato

    // Salidas
    wire RegWrite;
    wire [1:0] ImmSrc;
    wire ALUSrc;
    wire MemWrite;
    wire ResultSrc;
    wire Branch;
    wire [1:0] ALUOp;
    wire [1:0] RGB;

    // Instancia del Main_Decoder
    Main_Decoder uut (
        .tipo(tipo),
        .op(op),
        .Inm(Inm),
        .RegWrite(RegWrite),
        .ImmSrc(ImmSrc),
        .ALUSrc(ALUSrc),
        .MemWrite(MemWrite),
        .ResultSrc(ResultSrc),
        .Branch(Branch),
        .ALUOp(ALUOp),
        .RGB(RGB)
    );

    // Estímulos de prueba
    initial begin
        $display("=== Testbench para Main_Decoder especializado en imagen ===");

        // Prueba 1: Instrucción aritmética (ADD)
        tipo = 2'b00; op = 2'b00; Inm = 1'b0;
        #10;
        $display("Tipo=Aritmetica, Op=ADD, Inm=0: RegWrite=%b, ALUSrc=%b, ALUOp=%b, Branch=%b, MemWrite=%b, ResultSrc=%b, RGB=%b",
                 RegWrite, ALUSrc, ALUOp, Branch, MemWrite, ResultSrc, RGB);

        // Prueba 2: Instrucción de lectura (LDR) con color rojo
        tipo = 2'b01; op = 2'b01; Inm = 1'b1;
        #10;
        $display("Tipo=Lectura, Op=LDR, Inm=1, Color=Red: RegWrite=%b, ALUSrc=%b, ALUOp=%b, Branch=%b, MemWrite=%b, ResultSrc=%b, RGB=%b",
                 RegWrite, ALUSrc, ALUOp, Branch, MemWrite, ResultSrc, RGB);

        // Prueba 3: Instrucción de lectura (LDG) con color verde
        tipo = 2'b01; op = 2'b10; Inm = 1'b0;
        #10;
        $display("Tipo=Lectura, Op=LDG, Inm=0, Color=Green: RegWrite=%b, ALUSrc=%b, ALUOp=%b, Branch=%b, MemWrite=%b, ResultSrc=%b, RGB=%b",
                 RegWrite, ALUSrc, ALUOp, Branch, MemWrite, ResultSrc, RGB);

        // Prueba 4: Instrucción de lectura (LDB) con color azul
        tipo = 2'b01; op = 2'b11; Inm = 1'b1;
        #10;
        $display("Tipo=Lectura, Op=LDB, Inm=1, Color=Blue: RegWrite=%b, ALUSrc=%b, ALUOp=%b, Branch=%b, MemWrite=%b, ResultSrc=%b, RGB=%b",
                 RegWrite, ALUSrc, ALUOp, Branch, MemWrite, ResultSrc, RGB);

        // Prueba 5: Instrucción de control de flujo (BEQ)
        tipo = 2'b10; op = 2'b11; Inm = 1'b0;
        #10;
        $display("Tipo=Flujo, Op=BEQ: RegWrite=%b, ALUSrc=%b, ALUOp=%b, Branch=%b, MemWrite=%b, ResultSrc=%b, RGB=%b",
                 RegWrite, ALUSrc, ALUOp, Branch, MemWrite, ResultSrc, RGB);

        // Prueba 6: Instrucción de escritura (STR) con color rojo
        tipo = 2'b11; op = 2'b01; Inm = 1'b0;
        #10;
        $display("Tipo=Escritura, Op=STR, Color=Red: RegWrite=%b, ALUSrc=%b, ALUOp=%b, Branch=%b, MemWrite=%b, ResultSrc=%b, RGB=%b",
                 RegWrite, ALUSrc, ALUOp, Branch, MemWrite, ResultSrc, RGB);

        // Prueba 7: Instrucción de escritura (STG) con color verde
        tipo = 2'b11; op = 2'b10; Inm = 1'b1;
        #10;
        $display("Tipo=Escritura, Op=STG, Color=Green: RegWrite=%b, ALUSrc=%b, ALUOp=%b, Branch=%b, MemWrite=%b, ResultSrc=%b, RGB=%b",
                 RegWrite, ALUSrc, ALUOp, Branch, MemWrite, ResultSrc, RGB);

        // Prueba 8: Instrucción de escritura (STB) con color azul
        tipo = 2'b11; op = 2'b11; Inm = 1'b0;
        #10;
        $display("Tipo=Escritura, Op=STB, Color=Blue: RegWrite=%b, ALUSrc=%b, ALUOp=%b, Branch=%b, MemWrite=%b, ResultSrc=%b, RGB=%b",
                 RegWrite, ALUSrc, ALUOp, Branch, MemWrite, ResultSrc, RGB);
					  
		  // Prueba 9: RET
        tipo = 2'b11; op = 2'b00; Inm = 1'b0;
        #10;
        $display("Tipo=Escritura, Op=STB, Color=Blue: RegWrite=%b, ALUSrc=%b, ALUOp=%b, Branch=%b, MemWrite=%b, ResultSrc=%b, RGB=%b",
                 RegWrite, ALUSrc, ALUOp, Branch, MemWrite, ResultSrc, RGB);

        // Finalizar simulación
        $finish;
    end

endmodule

