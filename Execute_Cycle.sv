
module execute_cycle(
    input clk, rst,
    input RegWriteE, ALUSrcE, MemWriteE, ResultSrcE, BranchE,
    input [2:0] ALUControlE,
    input [23:0] RD1_E, RD2_E, Imm_Ext_E,
    input [4:0] RD_E,
    input [23:0] PCE, PCPlus4E, ResultW,
    input [1:0] ForwardA_E, ForwardB_E,
    
    output PCSrcE, RegWriteM, MemWriteM, ResultSrcM,
    output [4:0] RD_M,
    output [23:0] PCPlus4M, WriteDataM, ALU_ResultM, PCTargetE
);

    // Declaración de señales internas
    wire [23:0] Src_A, Src_B_interim, Src_B;
    wire [23:0] ResultE;
    wire ZeroE;

    // Registros para almacenar los valores intermedios
    reg RegWriteE_r, MemWriteE_r, ResultSrcE_r;
    reg [4:0] RD_E_r;
    reg [23:0] PCPlus4E_r, RD2_E_r;
    reg [33:0] ResultE_r;  // Registro ajustado a 34 bits para almacenar el resultado de la ALU

    // Multiplexores 3 a 1 para las entradas de la ALU (Fuente A y Fuente B)
    Mux_3_by_1_24b srca_mux (
        .a(RD1_E),
        .b(ResultW),
        .c(ALU_ResultM),
        .s(ForwardA_E),
        .d(Src_A)
    );

    Mux_3_by_1_24b srcb_mux (
        .a(RD2_E),
        .b(ResultW),
        .c(ALU_ResultM),
        .s(ForwardB_E),
        .d(Src_B_interim)
    );

    // Multiplexor para seleccionar entre el valor de inmediato o RD2_E
    Mux_24b alu_src_mux (
        .a(Src_B_interim),
        .b(Imm_Ext_E),
        .s(ALUSrcE),
        .c(Src_B)
    );

    // ALU
    ALU alu (
        .A(Src_A),
        .B(Src_B),
        .Result(ResultE),       // Salida de 34 bits de la ALU
        .ALUControl(ALUControlE),
		  
        .OverFlow(),
        .Carry(),
        .Zero(ZeroE),
        .Negative()
    );

    // Sumador para el branch (PCE + Imm_Ext_E)
    PC_Adder_24b branch_adder (
        .a(PCE),
        .b(Imm_Ext_E),
        .c(PCTargetE)
    );

    // Lógica de registros para los valores intermedios
    always @(posedge clk or negedge rst) begin
        if (rst == 1'b0) begin
            RegWriteE_r <= 1'b0; 
            MemWriteE_r <= 1'b0; 
            ResultSrcE_r <= 1'b0;
            RD_E_r <= 5'h00;
            PCPlus4E_r <= 24'd0; 
            RD2_E_r <= 24'd0; 
            ResultE_r <= 34'd0;  // Inicializar a 0
        end else begin
            RegWriteE_r <= RegWriteE; 
            MemWriteE_r <= MemWriteE; 
            ResultSrcE_r <= ResultSrcE;
            RD_E_r <= RD_E;
            PCPlus4E_r <= PCPlus4E; 
            RD2_E_r <= Src_B_interim; 
            ResultE_r <= ResultE;  // Almacenar el resultado de la ALU
        end
    end

    // Asignaciones de salida
    assign PCSrcE = ZeroE & BranchE;
    assign RegWriteM = RegWriteE_r;
    assign MemWriteM = MemWriteE_r;
    assign ResultSrcM = ResultSrcE_r;
    assign RD_M = RD_E_r;
    assign PCPlus4M = PCPlus4E_r;
    assign WriteDataM = RD2_E_r;
    assign ALU_ResultM = ResultE_r[23:0];  // Truncar el resultado de la ALU a 24 bits

endmodule
