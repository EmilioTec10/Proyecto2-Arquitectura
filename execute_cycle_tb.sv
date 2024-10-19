module execute_cycle_tb;

  // Entradas del testbench
  reg clk, rst;
  reg RegWriteE, ALUSrcE, MemWriteE, ResultSrcE, BranchE;
  reg [2:0] ALUControlE;
  reg [23:0] RD1_E, RD2_E, Imm_Ext_E;
  reg [4:0] RD_E;
  reg [23:0] PCE, PCPlus4E, ResultW;
  reg [1:0] ForwardA_E, ForwardB_E;

  // Salidas del DUT
  wire PCSrcE, RegWriteM, MemWriteM, ResultSrcM;
  wire [4:0] RD_M;
  wire [23:0] PCPlus4M, WriteDataM, ALU_ResultM, PCTargetE;

  // Instanciación del módulo execute_cycle
  execute_cycle uut (
    .clk(clk),
    .rst(rst),
    .RegWriteE(RegWriteE),
    .ALUSrcE(ALUSrcE),
    .MemWriteE(MemWriteE),
    .ResultSrcE(ResultSrcE),
    .BranchE(BranchE),
    .ALUControlE(ALUControlE),
    .RD1_E(RD1_E),
    .RD2_E(RD2_E),
    .Imm_Ext_E(Imm_Ext_E),
    .RD_E(RD_E),
    .PCE(PCE),
    .PCPlus4E(PCPlus4E),
    .PCSrcE(PCSrcE),
    .PCTargetE(PCTargetE),
    .RegWriteM(RegWriteM),
    .MemWriteM(MemWriteM),
    .ResultSrcM(ResultSrcM),
    .RD_M(RD_M),
    .PCPlus4M(PCPlus4M),
    .WriteDataM(WriteDataM),
    .ALU_ResultM(ALU_ResultM),
    .ResultW(ResultW),
    .ForwardA_E(ForwardA_E),
    .ForwardB_E(ForwardB_E)
  );

  // Generación de reloj
  always #5 clk = ~clk;  // Reloj con un periodo de 10 unidades de tiempo

  initial begin
    // Inicialización de señales
    clk = 0;
    rst = 1;
    RegWriteE = 0; ALUSrcE = 0; MemWriteE = 0; ResultSrcE = 0; BranchE = 0;
    ALUControlE = 3'b000;  // Operación de suma
    RD1_E = 24'd10; RD2_E = 24'd5; Imm_Ext_E = 24'd3;
    RD_E = 5'd1; 
    PCE = 24'd100; PCPlus4E = 24'd104;
    ResultW = 24'd0;
    ForwardA_E = 2'b00; ForwardB_E = 2'b00;

    // Generar archivo VCD para analizar la simulación con GTKWave
    $dumpfile("execute_cycle_tb.vcd");
    $dumpvars(0, execute_cycle_tb);

    // Establecer reset
    rst = 0;
    #10;
    
    rst = 1;  // Quitar reset y comenzar las pruebas

		// Prueba 1: ALU Suma (sin forwarding)
	 
    ALUControlE = 3'b000; // Operación de suma
    ALUSrcE = 0; // Operar con RD2_E
    #10;
    $display("ALU Suma: Result = %d, WriteDataM = %d, PCSrcE = %b", ALU_ResultM, WriteDataM, PCSrcE);
	 
    // Prueba 2: ALU Suma con Inmediato (ALUSrcE activado)
    ALUControlE = 3'b000; // Suma
    ALUSrcE = 1; // Usar inmediato en vez de RD2_E
    Imm_Ext_E = 24'd8; // Inmediato es 8
    #10;
    $display("ALU Suma Inmediato: Result = %d, PCTargetE = %d", ALU_ResultM, PCTargetE);

    // Prueba 3: ALU Resta
    ALUControlE = 3'b001; // Operación de resta
    ALUSrcE = 0; // Usar RD2_E
    RD1_E = 24'd30; RD2_E = 24'd25;
    #10;
    $display("ALU Resta: Result = %d", ALU_ResultM);

    // Prueba 4: Multiplicación (ALUControl = 3'b010)
    ALUControlE = 3'b010; // Multiplicación
    RD1_E = 24'd4; RD2_E = 24'd3;
    #10;
    $display("ALU Multiplicación: Result = %d", ALU_ResultM);

    // Prueba 5: División (ALUControl = 3'b011)
    ALUControlE = 3'b011; // División
    RD1_E = 24'd100; RD2_E = 24'd4;
    #10;
    $display("ALU División: Result = %d", ALU_ResultM);

    // Prueba 6: Forwarding desde la etapa MEM (ForwardB_E activado)
    ForwardB_E = 2'b10; // Usar ALU_ResultM como segundo operando
    ALUControlE = 3'b000; // Suma
    #10;
    $display("ALU con Forwarding desde MEM: Result = %d", ALU_ResultM);

    // Prueba 7: Forwarding desde la etapa WB (ForwardA_E activado)
    ForwardA_E = 2'b01; // Usar ResultW como primer operando
    ResultW = 24'd50;
    #10;
    $display("ALU con Forwarding desde WB: Result = %d", ALU_ResultM);

    // Prueba 8: Overflow en Suma
    ALUControlE = 3'b000; // Suma
    RD1_E = 24'hFFFFFF; // Máximo valor posible para 24 bits
    RD2_E = 24'd1; // Sumar 1 para causar overflow
    #10;
    $display("ALU Suma con Overflow: Result = %d, Overflow esperado", ALU_ResultM);

    // Prueba 9: Branch tomado (BranchE activado y ZeroE = 1)
    ALUControlE = 3'b001; // Resta para generar Zero
    RD1_E = 24'd10; RD2_E = 24'd10; // RD1_E - RD2_E = 0
    BranchE = 1; // Activar branch
    #10;
    $display("Branch tomado: PCSrcE = %b, PCTargetE = %d", PCSrcE, PCTargetE);

    // Prueba 10: Reset y operaciones después del reset
    rst = 1'b0; // Activar reset
    #10;
    rst = 1'b1; // Quitar reset
    RD1_E = 24'd15; RD2_E = 24'd10;
    ALUControlE = 3'b000; // Suma
    #10;
    $display("ALU Suma después del Reset: Result = %d", ALU_ResultM);

    // Finalizar la simulación
    $finish;
  end

endmodule
