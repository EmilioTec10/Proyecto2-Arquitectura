module Control_Unit_Top_20_tb;

    // Entradas de la unidad de control
    reg [1:0] tipo;   // Tipo de instrucción
    reg [1:0] op;     // Operación específica
    reg Inm;          // Bit de inmediato

    // Salidas de la unidad de control
    wire RegWrite;    // Habilitar escritura en registros
    wire [1:0] ImmSrc;// Fuente del inmediato
    wire ALUSrc;      // Selección entre registro o inmediato en la ALU
    wire MemWrite;    // Habilitar escritura en memoria
    wire ResultSrc;   // Selección del resultado (ALU/memoria)
    wire Branch;      // Indicar si es una instrucción de salto condicional
    wire [2:0] ALUControl; // Señales de control para la ALU

    // Instancia de la unidad de control bajo prueba (DUT)
    Control_Unit_Top_20 uut (
        .tipo(tipo),
        .op(op),
        .Inm(Inm),
        .RegWrite(RegWrite),
        .ImmSrc(ImmSrc),
        .ALUSrc(ALUSrc),
        .MemWrite(MemWrite),
        .ResultSrc(ResultSrc),
        .Branch(Branch),
        .ALUControl(ALUControl)
    );

    // Procedimiento inicial
    initial begin
        // Título del testbench
        $display("Probando Control_Unit_Top_20...");
        $display("Tipo  | Op  | Inm -> RegWrite | ImmSrc | ALUSrc | MemWrite | ResultSrc | Branch | ALUControl");

        // Test 1: Instrucción Aritmética (tipo = 00, ADD, Inmediato = 0)
        tipo = 2'b00; op = 2'b00; Inm = 1'b0; // ADD
        #10;
        $display("%b    | %b  |  %b ->    %b       |   %b    |   %b    |    %b     |     %b     |   %b   |   %b", 
                 tipo, op, Inm, RegWrite, ImmSrc, ALUSrc, MemWrite, ResultSrc, Branch, ALUControl);

        // Test 2: Instrucción Aritmética (tipo = 00, SUB, Inmediato = 1)
        tipo = 2'b00; op = 2'b01; Inm = 1'b1; // SUB con inmediato
        #10;
        $display("%b    | %b  |  %b ->    %b       |   %b    |   %b    |    %b     |     %b     |   %b   |   %b", 
                 tipo, op, Inm, RegWrite, ImmSrc, ALUSrc, MemWrite, ResultSrc, Branch, ALUControl);

        // Test 3: Instrucción de Transferencia de Datos (tipo = 01, LDR)
        tipo = 2'b01; op = 2'b01; Inm = 1'b0; // LDR (load)
        #10;
        $display("%b    | %b  |  %b ->    %b       |   %b    |   %b    |    %b     |     %b     |   %b   |   %b", 
                 tipo, op, Inm, RegWrite, ImmSrc, ALUSrc, MemWrite, ResultSrc, Branch, ALUControl);

        // Test 4: Instrucción de Transferencia de Datos (tipo = 01, STR)
        tipo = 2'b01; op = 2'b10; Inm = 1'b0; // STR (store)
        #10;
        $display("%b    | %b  |  %b ->    %b       |   %b    |   %b    |    %b     |     %b     |   %b   |   %b", 
                 tipo, op, Inm, RegWrite, ImmSrc, ALUSrc, MemWrite, ResultSrc, Branch, ALUControl);

        // Test 5: Instrucción de Control de Flujo (tipo = 10, Branch)
        tipo = 2'b10; op = 2'b00; Inm = 1'b0; // Branch
        #10;
        $display("%b    | %b  |  %b ->    %b       |   %b    |   %b    |    %b     |     %b     |   %b   |   %b", 
                 tipo, op, Inm, RegWrite, ImmSrc, ALUSrc, MemWrite, ResultSrc, Branch, ALUControl);

        // Test 6: Instrucción de Control de Flujo (tipo = 10, CMP)
        tipo = 2'b10; op = 2'b10; Inm = 1'b0; // CMP
        #10;
        $display("%b    | %b  |  %b ->    %b       |   %b    |   %b    |    %b     |     %b     |   %b   |   %b", 
                 tipo, op, Inm, RegWrite, ImmSrc, ALUSrc, MemWrite, ResultSrc, Branch, ALUControl);

        // Finalizar la simulación
        $display("Pruebas completadas.");
        $finish;
    end

endmodule
