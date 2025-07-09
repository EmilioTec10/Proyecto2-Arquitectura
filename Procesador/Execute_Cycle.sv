module execute_cycle(
    input clk, rst,
    input RegWriteE, ALUSrcE, MemWriteE, ResultSrcE, BranchE, JumpE, PCDirectionE, BranchLinkE,
    input [2:0] ALUControlE,
  input [17:0] RD1_E, RD2_E, RD4_E, Imm_Ext_E, ResultW,
    input [4:0] RD_E,
    input [8:0] PCE, PCPlus4E, 
    input [1:0] ForwardA_E, ForwardB_E, ForwardC_E, RGB_E, 
    
    output PCSrcE, RegWriteM, MemWriteM, ResultSrcM, BranchLinkM,
    output [4:0] RD_M,
    output [17:0] PCPlus4M, WriteDataM, ALU_ResultM,
    output [1:0] RGB_M,
    output [8:0] PCTargetE, PCM
);

    // Declaración de señales internas
    logic [17:0] Src_A, Src_B_interim, Src_B, Scr_Write;
    logic [17:0] ResultE;
    logic ZeroE;

    // Registros para almacenar los valores intermedios
    reg RegWriteE_r, MemWriteE_r, ResultSrcE_r, BranchLinkE_r;
    reg [4:0] RD_E_r;
    reg [17:0] RD2_E_r, RD4_E_r, Scr_Write_r;
    reg [8:0] PCPlus4E_r, PCE_r;
    reg [17:0] ResultE_r;  // Registro ajustado a 34 bits para almacenar el resultado de la ALU
	 reg [1:0] RGB_E_r;

    // Multiplexores 3 a 1 para las entradas de la ALU (Fuente A y Fuente B)
	 
	 Mux3Parametrizado #(18) scra_mux(
		  .a(RD1_E),
        .b(ResultW),
        .c(ALU_ResultM),
        .s(ForwardA_E),
        .d(Src_A)
		
	 );
	 
    Mux3Parametrizado #(18) srcb_mux (
        .a(RD2_E),
        .b(ResultW),
        .c(ALU_ResultM),
        .s(ForwardB_E),
        .d(Src_B_interim)
    );
	 
	 Mux3Parametrizado #(18) writedata_mux (
        .a(RD4_E),
        .b(ResultW),
        .c(ALU_ResultM),
        .s(ForwardC_E),
        .d(Scr_Write)
    );

    // Multiplexor para seleccionar entre el valor de inmediato o RD2_E
    Mux2Parametrizado #(18) alu_src_mux (
        .a(Src_B_interim),
        .b(Imm_Ext_E),
        .s(ALUSrcE),
        .c(Src_B)
    );

    // ALU
    ALU alu (
        .A(Src_A),
        .B(Src_B),
        .Result(ResultE),
        .ALUControl(ALUControlE),
		  
        .OverFlow(),
        .Carry(),
        .Zero(ZeroE),
        .Negative()
    );

    // Sumador para el branch (PCE + Imm_Ext_E)
    PC_Adder_18b branch_adder (
        .a(PCE),
        .b(Imm_Ext_E[8:0]),
		  .PCDirectionE(PCDirectionE),
        .c(PCTargetE)
    );

    // Lógica de registros para los valores intermedios
    always @(posedge clk or negedge rst) begin
        if (rst == 1'b0) begin
		  
            RegWriteE_r <= 1'b0; 
            MemWriteE_r <= 1'b0; 
            ResultSrcE_r <= 1'b0;
            RD_E_r <= 5'h00;
            PCPlus4E_r <= 9'd0;  
            RD2_E_r <= 18'd0; 
				RD4_E_r <= 18'd0; 	
            ResultE_r <= 18'd0;  // Inicializar a 0
				RGB_E_r <= 2'd0;
				Scr_Write_r <= 17'd0;
				PCE_r <= 9'b0;
				BranchLinkE_r <= 1'b0;
			end
			
         else begin
            RegWriteE_r <= RegWriteE; 
            MemWriteE_r <= MemWriteE; 
            ResultSrcE_r <= ResultSrcE;
            RD_E_r <= RD_E;
				RGB_E_r <= RGB_E;
            PCPlus4E_r <= PCPlus4E; 
            RD2_E_r <= Src_B_interim;
				RD4_E_r <= RD4_E;	
				Scr_Write_r <= Scr_Write;
            ResultE_r <= ResultE;  // Almacenar el resultado de la ALU
				PCE_r <= PCE;
				BranchLinkE_r <= BranchLinkE;
        end
    end

    // Asignaciones de salida
    assign PCSrcE = (ZeroE & BranchE) || JumpE;
    assign RegWriteM = RegWriteE_r;
    assign MemWriteM = MemWriteE_r;
    assign ResultSrcM = ResultSrcE_r;
    assign RD_M = RD_E_r;
    assign PCPlus4M = PCPlus4E_r;
    assign WriteDataM = Scr_Write_r;
    assign ALU_ResultM = ResultE_r;
	 assign RGB_M = RGB_E_r;
	 assign PCM = PCE_r;
	 assign BranchLinkM = BranchLinkE_r;

endmodule
