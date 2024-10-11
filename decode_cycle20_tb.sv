module decode_cycle20_tb; 




	 logic clk, rst, RegWriteW;
    logic [4:0] RDW;
    logic [19:0] InstrD; // Instrucción de 20 bits
    logic [21:0] PCD, PCPlus4D; // PC ajustado a 22 bits
    logic [21:0] ResultW;
    
    logic RegWriteE, ALUSrcE, MemWriteE, ResultSrcE, BranchE;
    logic [2:0] ALUControlE;
    logic [21:0] RD1_E, RD2_E, Imm_Ext_E;
    logic [4:0] RS1_E, RS2_E, RD_E;
    logic [21:0] PCE, PCPlus4E;

	 
	 
	 
	 
	 
	 
	 
	 
	 decode_cycle_20 uut(
    .clk(clk), 
	 .rst(rst), 
	 .RegWriteW(RegWriteW),
    .RDW(RDW),
    .InstrD(InstrD), // Instrucción de 20 bits
    .PCD(PCD), 
	 .PCPlus4D(PCPlus4D), // PC ajustado a 22 bits
    .ResultW(Resultw),
    
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
	 

    // Generación de la señal de reloj
    always #5 clk = ~clk;  // Reloj de 10 unidades de tiempo (5 para cada fase)

    // Procedimiento inicial
    initial begin
        // Inicialización de señales
        clk = 0;
        rst = 1;
        RegWriteW = 0;
        RDW = 0;
        InstrD = 0;
        PCD = 0;
        PCPlus4D = 0;
        ResultW = 0;

        // Aplicar reset
        #10 rst = 0;  // Liberar reset después de 10 unidades de tiempo
        #10 rst = 1;  // Quitar reset

        // Caso de prueba 1: Cargar una instrucción ficticia y valores iniciales
        // Ejemplo: Instrucción tipo R (suma en la ISA de 20 bits)
        InstrD = 20'b0001_00000_00001_00010; // Operación ficticia
        PCD = 22'h0001A;  // PC en alguna dirección ficticia
        PCPlus4D = PCD + 22'h4;  // PC + 4
        ResultW = 22'h0000F; // Resultado ficticio de la ALU de una etapa anterior

        #20;  // Esperar 20 unidades de tiempo

        // Verificar las salidas esperadas para el caso de prueba
        $display("Test 1: InstrD = %b", InstrD);
        $display("RD1_E = %h, RD2_E = %h", RD1_E, RD2_E);
        $display("Imm_Ext_E = %h", Imm_Ext_E);
        $display("ALUControlE = %b", ALUControlE);

        // Caso de prueba 2: Cambiar la instrucción
        InstrD = 20'b0010_00011_00001_00100; // Otra instrucción ficticia
        PCD = 22'h00020;  // PC en una nueva dirección
        PCPlus4D = PCD + 22'h4;  // PC + 4

        #20;  // Esperar 20 unidades de tiempo

        // Verificar las salidas esperadas para el segundo caso de prueba
        $display("Test 2: InstrD = %b", InstrD);
        $display("RD1_E = %h, RD2_E = %h", RD1_E, RD2_E);
        $display("Imm_Ext_E = %h", Imm_Ext_E);
        $display("ALUControlE = %b", ALUControlE);

        // Finalizar la simulación
        #100 $finish;
    end
	 
	 
	 
endmodule 