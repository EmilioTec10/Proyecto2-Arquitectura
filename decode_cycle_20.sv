module decode_cycle_20 (
    input clk, rst, RegWriteW,
    input [4:0] RDW,
    input [33:0] InstrD, // Instrucción de 34 bits
    input [23:0] PCD, PCPlus4D, // PC ajustado a 24 bits
    input [23:0] ResultW,
    
    output RegWriteE, ALUSrcE, MemWriteE, ResultSrcE, BranchE,
    output [2:0] ALUControlE,
    output [23:0] RD1_E, RD2_E, Imm_Ext_E,
    output [4:0] RS1_E, RS2_E, RD_E,
    output [23:0] PCE, PCPlus4E
);

    // Declaring Interim Wires
    wire RegWriteD, ALUSrcD, MemWriteD, ResultSrcD, BranchD;
    wire [1:0] ImmSrcD;
    wire [2:0] ALUControlD;
    wire [23:0] RD1_D, RD2_D, Imm_Ext_D; // Registros de 24 bits ahora

    // Declaration of Interim Register
    reg RegWriteD_r, ALUSrcD_r, MemWriteD_r, ResultSrcD_r, BranchD_r;
    reg [2:0] ALUControlD_r;
    reg [21:0] RD1_D_r, RD2_D_r, Imm_Ext_D_r;
    reg [4:0] RD_D_r, RS1_D_r, RS2_D_r;
    reg [23:0] PCD_r, PCPlus4D_r;

    // Iniciar los módulos
    // Unidad de Control
//    Control_Unit_Top_20 control (
//        .Op(InstrD[3:0]), // Op ajustado a la ISA de 20 bits
//        .RegWrite(RegWriteD),
//        .ImmSrc(ImmSrcD),
//        .ALUSrc(ALUSrcD),
//        .MemWrite(MemWriteD),
//        .ResultSrc(ResultSrcD),
//        .Branch(BranchD),
//        .funct3(InstrD[6:4]),  // funct3 ajustado
//        .funct7(InstrD[9:7]),  // funct7 ajustado
//        .ALUControl(ALUControlD)
//    );

	 Control_Unit_Top_20 control(
    .tipo(InstrD[32:31]),   // Tipo de instrucción
    .op(InstrD[30:29]),     // Operación específica
    .Inm(InstrD[33]),          // Bit de inmediato
	 
    .RegWrite(RegWriteD),    // Habilitar escritura en registros
    .ImmSrc(ImmSrcD),  // Fuente del inmediato
    .ALUSrc(ALUSrcD),      // Selección entre registro o inmediato en la ALU
    .MemWrite(MemWriteD),    // Habilitar escritura en memoria
    .ResultSrc(ResultSrcD),   // Selección del resultado (ALU/memoria)
    .Branch(BranchD),      // Indicar si es una instrucción de salto condicional
     .ALUControl(ALUControlD)  // Control para la ALU
);
	 
	 
    // Archivo de registros
    Register_File_20 rf (
        .clk(clk),
        .rst(rst),
        .WE3(RegWriteW),
        .WD3(ResultW),    // Escribimos en registros de 24 bits
        .A1(InstrD[28:26]), // Fuente A1 ajustada a la ISA
        .A2(InstrD[25:23]),  // Fuente A2 ajustada a la ISA
        .A3(RDW),
		  
        .RD1(RD1_D),      // Lectura de registros de 22 bits
        .RD2(RD2_D)
    );

    // Extensión de signo
    Sign_Extend_20 extension (
        .In(InstrD),     // Instrucción de 34 bits
        .Imm_Ext(Imm_Ext_D),  // Inmediato extendido de 24 bits
        .ImmSrc(ImmSrcD)
    );

    // Declaración de lógica de registros
    always @(posedge clk or negedge rst) begin
        if(rst == 1'b0) begin
            RegWriteD_r <= 1'b0;
            ALUSrcD_r <= 1'b0;
            MemWriteD_r <= 1'b0;
            ResultSrcD_r <= 1'b0;
            BranchD_r <= 1'b0;
            ALUControlD_r <= 3'b000;
            RD1_D_r <= 24'h000000; 
            RD2_D_r <= 24'h000000; 
            Imm_Ext_D_r <= 22'h000000;
            RD_D_r <= 5'h00;
            PCD_r <= 22'h000000; 
            PCPlus4D_r <= 24'h000000;
            RS1_D_r <= 5'h00;
            RS2_D_r <= 5'h00;
        end
        else begin
            RegWriteD_r <= RegWriteD;
            ALUSrcD_r <= ALUSrcD;
            MemWriteD_r <= MemWriteD;
            ResultSrcD_r <= ResultSrcD;
            BranchD_r <= BranchD;
            ALUControlD_r <= ALUControlD;
            RD1_D_r <= RD1_D; 
            RD2_D_r <= RD2_D; 
            Imm_Ext_D_r <= Imm_Ext_D;
            RD_D_r <= InstrD[4:0]; // Ajustado para 5 bits
            PCD_r <= PCD; 
            PCPlus4D_r <= PCPlus4D;
            RS1_D_r <= InstrD[28:26]; // Ajustado para 3 bits
            RS2_D_r <= InstrD[25:23];  // Ajustado para 3 bits
        end
    end

    // Asignación de las salidas
    assign RegWriteE = RegWriteD_r;
    assign ALUSrcE = ALUSrcD_r;
    assign MemWriteE = MemWriteD_r;
    assign ResultSrcE = ResultSrcD_r;
    assign BranchE = BranchD_r;
    assign ALUControlE = ALUControlD_r;
    assign RD1_E = RD1_D_r;
    assign RD2_E = RD2_D_r;
    assign Imm_Ext_E = Imm_Ext_D_r;
    assign RD_E = RD_D_r;
    assign PCE = PCD_r;
    assign PCPlus4E = PCPlus4D_r;
    assign RS1_E = RS1_D_r;
    assign RS2_E = RS2_D_r;

endmodule
