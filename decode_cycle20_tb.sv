module decode_cycle20_tb;

    // Entradas
    reg clk;
    reg rst;
    reg RegWriteW;
    reg [4:0] RDW;
    reg [33:0] InstrD;
    reg [23:0] PCD;
    reg [23:0] PCPlus4D;
    reg [23:0] ResultW;

    // Salidas
    wire RegWriteE;
    wire ALUSrcE;
    wire MemWriteE;
    wire ResultSrcE;
    wire BranchE;
    wire [2:0] ALUControlE;
    wire [23:0] RD1_E;
    wire [23:0] RD2_E;
    wire [23:0] Imm_Ext_E;
    wire [4:0] RS1_E;
    wire [4:0] RS2_E;
    wire [4:0] RD_E;
    wire [23:0] PCE;
    wire [23:0] PCPlus4E;

    // Instancia del DUT (Device Under Test)
    decode_cycle uut (
        .clk(clk),
        .rst(rst),
        .RegWriteW(RegWriteW),
        .RDW(RDW),
        .InstrD(InstrD),
        .PCD(PCD),
        .PCPlus4D(PCPlus4D),
        .ResultW(ResultW),
        .RegWriteE(RegWriteE),
        .ALUSrcE(ALUSrcE),
        .MemWriteE(MemWriteE),
        .ResultSrcE(ResultSrcE),
        .BranchE(BranchE),
        .ALUControlE(ALUControlE),
        .RD1_E(RD1_E),
        .RD2_E(RD2_E),
        .Imm_Ext_E(Imm_Ext_E),
        .RS1_E(RS1_E),
        .RS2_E(RS2_E),
        .RD_E(RD_E),
        .PCE(PCE),
        .PCPlus4E(PCPlus4E)
    );

    // Generar el reloj
    always #5 clk = ~clk;

    initial begin
        // Inicialización
        clk = 0;
        rst = 1;
        RegWriteW = 0;
        RDW = 5'b00000;
        InstrD = 34'b0;
        PCD = 24'b0;
        PCPlus4D = 24'b0;
        ResultW = 24'b0;

        // Reset del sistema
        #10 rst = 0; // Desactivar reset
        #10 rst = 1; // Activar sistema

        // Caso 1: Instrucción tipo ALU (por ejemplo, suma)
        InstrD = 34'b0010000100010000010000100000000001; // Supongamos que esta instrucción es una suma
        PCD = 24'h000004; 
        PCPlus4D = 24'h000008;
        ResultW = 24'h000001; // Resultado que se escribirá en el register file
        RDW = 5'b00001;       // Registro destino 1
        RegWriteW = 1'b1;     // Habilitar escritura en registro
        #10;  // Esperar un ciclo

        // Caso 2: Instrucción de memoria (carga)
        InstrD = 34'b0001001100010101010000000000000100; // Supongamos que esta es una instrucción de carga
        PCD = 24'h00000C; 
        PCPlus4D = 24'h000010;
        ResultW = 24'h000002; // Otro resultado
        RDW = 5'b00010;       // Registro destino 2
        RegWriteW = 1'b1;     // Habilitar escritura en registro
        #10;  // Esperar un ciclo

        // Caso 3: Instrucción de rama (salto condicional)
        InstrD = 34'b0110001100001110000000000000000110; // Instrucción de salto condicional
        PCD = 24'h000014; 
        PCPlus4D = 24'h000018;
        ResultW = 24'h000003; // Resultado de un cálculo previo
        RDW = 5'b00011;       // Registro destino 3
        RegWriteW = 1'b1;     // Habilitar escritura en registro
        #10;  // Esperar un ciclo

        // Caso 4: Instrucción de inmediato
        InstrD = 34'b1001000100001000000000000011111111; // Inmediato tipo
        PCD = 24'h000020; 
        PCPlus4D = 24'h000024;
        ResultW = 24'h000004; // Otro resultado de inmediato
        RDW = 5'b00100;       // Registro destino 4
        RegWriteW = 1'b1;     // Habilitar escritura en registro
        #10;  // Esperar un ciclo

        // Finalizar la simulación
        $finish;
    end

    // Monitor para observar las señales
    initial begin
        $monitor("Time=%0t, InstrD=%b, RegWriteE=%b, ALUSrcE=%b, MemWriteE=%b, ResultSrcE=%b, BranchE=%b, ALUControlE=%b, RD1_E=%h, RD2_E=%h, Imm_Ext_E=%h, RS1_E=%b, RS2_E=%b, RD_E=%b, PCE=%h, PCPlus4E=%h", 
                  $time, InstrD, RegWriteE, ALUSrcE, MemWriteE, ResultSrcE, BranchE, ALUControlE, RD1_E, RD2_E, Imm_Ext_E, RS1_E, RS2_E, RD_E, PCE, PCPlus4E);
    end

endmodule
