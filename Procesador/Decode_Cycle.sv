module decode_cycle(
    input clk, rst, RegWriteW, StallD,
    input [4:0] RDW,
    input [32:0] InstrD, // Instrucción de 34 bits
    input [8:0] PCD, PCPlus4D, // PC ajustado a 18 bits
    input [17:0] ResultW,
    
    output RegWriteE, ALUSrcE, MemWriteE, ResultSrcE, BranchE, FlushE,
    output [2:0] ALUControlE,
    output [17:0] RD1_E, RD2_E, Imm_Ext_E,
    output [4:0] RS1_E, RS2_E, RD_E,
    output [8:0] PCE, PCPlus4E,
	 output [1:0] RGB_D,
	 output JumpE
);

    // Declaring Interim Wires
    wire RegWriteD, ALUSrcD, MemWriteD, ResultSrcD, BranchD;
    wire [1:0] ImmSrcD, RGB;
    wire [2:0] ALUControlD;
    wire [17:0] RD1_D, RD2_D, Imm_Ext_D; // Registros de 18 bits ahora
	 wire JumpD; 

    // Declaration of Interim Register
    reg RegWriteD_r, ALUSrcD_r, MemWriteD_r, ResultSrcD_r, BranchD_r, StallD_r;
    reg [2:0] ALUControlD_r, RGB_D_r;
    reg [17:0] RD1_D_r, RD2_D_r, Imm_Ext_D_r;
    reg [4:0] RD_D_r, RS1_D_r, RS2_D_r;
    reg [8:0] PCD_r, PCPlus4D_r;
	 reg [4:0] A2;
	 reg JumpD_r;
	 


    assign A2 = (InstrD[32] == 1'b0 && InstrD[31:30] == 2'b01 && InstrD[29:28] == 2'b00 ) ? InstrD[4:0]  : InstrD[22:18];


	 Control_Unit_Top control(
    .tipo(InstrD[31:30]),   // Tipo de instrucción
    .op(InstrD[29:28]),     // Operación específica
    .Inm(InstrD[32]),          // Bit de inmediato

	 
    .RegWrite(RegWriteD),    // Habilitar escritura en registros
    .ImmSrc(ImmSrcD),  // Fuente del inmediato
    .ALUSrc(ALUSrcD),      // Selección entre registro o inmediato en la ALU
    .MemWrite(MemWriteD),    // Habilitar escritura en memoria
    .ResultSrc(ResultSrcD),   // Selección del resultado (ALU/memoria)
    .Branch(BranchD),      // Indicar si es una instrucción de salto condicional
    .ALUControl(ALUControlD),  // Control para la ALU
	 .RGB(RGB),						// Control de color
	 .Jump(JumpD)
);
	 
    // Archivo de registros
    Register_File rf (
        .clk(clk),
        .rst(rst),
        .WE3(RegWriteW),
        .WD3(ResultW),    // Escribimos en registros de 18 bits
        .A1(InstrD[27:23]), // Fuente A1 ajustada a la ISA
        .A2(A2),  // Fuente A2 ajustada a la ISA
        .A3(RDW),
		  
        .RD1(RD1_D),      // Lectura de registros de 22 bits
		  
        .RD2(RD2_D)
    );

    // Extensión de signo
    Sign_Extend extension (
        .In(InstrD),     // Instrucción de 34 bits
        .Imm_Ext(Imm_Ext_D),  // Inmediato extendido de 18 bits
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
            RD1_D_r <= 18'd0; 
            RD2_D_r <= 18'd0; 
            Imm_Ext_D_r <= 18'd0;
            RD_D_r <= 5'h00;
            PCD_r <= 9'd0; 
            PCPlus4D_r <= 9'd0;
            RS1_D_r <= 5'h00;
            RS2_D_r <= 5'h00;
				RGB_D_r <= 2'd0;
				StallD_r <= 1'd0;
				JumpD_r <= 1'd0;
        end
		  else if (StallD) begin
			  // No actualizar, mantener los valores actuales
			  RegWriteD_r <= RegWriteD_r;
			  ALUSrcD_r <= ALUSrcD_r;
			  MemWriteD_r <= MemWriteD_r;
			  ResultSrcD_r <= ResultSrcD_r;
			  BranchD_r <= BranchD_r;
			  ALUControlD_r <= ALUControlD_r;
			  RD1_D_r <= RD1_D_r; 
			  RD2_D_r <= RD2_D_r; 
			  Imm_Ext_D_r <= Imm_Ext_D_r;
			  RD_D_r <= RD_D_r;
			  PCD_r <= PCD_r; 
			  PCPlus4D_r <= PCPlus4D_r;
			  RS1_D_r <= RS1_D_r;
			  RS2_D_r <= RS2_D_r;
			  RGB_D_r <= RGB_D_r;
			  StallD_r <= StallD;
			  JumpD_r <= JumpD_r; 
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
				RD_D_r <= (InstrD[31:30] == 2'b01 && InstrD[29:28]== 2'b00) ? InstrD[22:18]  : 
           (InstrD[32] == 1'b1) ? InstrD[22:18] : InstrD[4:0];
            PCD_r <= PCD; 
            PCPlus4D_r <= PCPlus4D;
            RS1_D_r <= InstrD[27:23]; // Ajustado para 5 bits
            RS2_D_r <= A2;  // Ajustado para 5 bits
				RGB_D_r <= RGB;
				StallD_r <= StallD;
				JumpD_r <= JumpD;
        end
    end

    
    // Asignación de las salidas, manejando el StallD
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
	assign RGB_D = RGB_D_r;
	assign FlushE = StallD_r;
	assign JumpE = JumpD_r;

endmodule
