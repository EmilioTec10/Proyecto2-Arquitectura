module Pipeline_Top(input clk, input rst);

    // Declaration of Interim Wires
    wire PCSrcE, RegWriteW, RegWriteE, ALUSrcE, MemWriteE, ResultSrcE, BranchE, RegWriteM, MemWriteM, ResultSrcM, ResultSrcW;
    wire [2:0] ALUControlE;
    wire [4:0] RD_E, RD_M, RDW;
	 wire [32:0]  InstrD;
   wire [17:0] ResultW, RD1_E, RD2_E, RD4_E, Imm_Ext_E, WriteDataM, ALU_ResultM;
	 wire [8:0] PCPlus4W, PCTargetE, PCD, PCPlus4D,  PCE, PCPlus4E, PCPlus4M, R29_E, PCM, PCW;
	 wire [17:0]  ALU_ResultW, ReadDataW;
   wire [4:0] RS1_E, RS2_E, RS4_E;
   wire [1:0] ForwardBE, ForwardAE, ForwardCE, RGB_E, RGB_M;
   wire ForwardAD, ForwardBD, ForwardCD;
	 wire Jump; 
	 wire PCDirection, PCReturnSignal, BranchLinkE, BranchLinkM, BranchLinkW;


    // Module Initiation
    // Fetch Stage
    fetch_cycle Fetch (
                        .clk(clk), 
                        .rst(rst), 
                        .PCSrcE(PCSrcE), 
                        .PCTargetE(PCTargetE), 
                        .InstrD(InstrD), 
                        .PCD(PCD), 

      .PCPlus4D(PCPlus4D),
      .PCReturnSignalE(PCReturnSignal),
								.PCReturnE(R29_E)


                    );

    // Decode Stage
    decode_cycle Decode (
                        .clk(clk), 
                        .rst(rst), 
                        .InstrD(InstrD), 
                        .PCD(PCD), 
								.PCW(PCW),
								.BranchLinkW(BranchLinkW),
                        .PCPlus4D(PCPlus4D), 
                        .RegWriteW(RegWriteW), 
                        .RDW(RDW), 
                        .ResultW(ResultW),
								.ForwardAD(ForwardAD),
								.ForwardBD(ForwardBD),
								.ForwardCD(ForwardCD),
								
                        .RegWriteE(RegWriteE), 
                        .ALUSrcE(ALUSrcE), 
                        .MemWriteE(MemWriteE), 
                        .ResultSrcE(ResultSrcE),
                        .BranchE(BranchE),  
                        .ALUControlE(ALUControlE), 
                        .RD1_E(RD1_E), 
                        .RD2_E(RD2_E),
								.RD4_E(RD4_E),	
                        .Imm_Ext_E(Imm_Ext_E), 
                        .RD_E(RD_E), 
                        .PCE(PCE), 
                        .PCPlus4E(PCPlus4E),
								
                        .RS1_E(RS1_E),
                        .RS2_E(RS2_E),
								.RS4_E(RS4_E),
								.BranchLinkE(BranchLinkE),

								
      .RGB_E(RGB_E),
                .JumpE(Jump),
								.PCDirectionE(PCDirection),
								.PCReturnSignalE(PCReturnSignal),
								.R29_E(R29_E)

                    );

    // Execute Stage
    execute_cycle Execute (
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
								.RD4_E(RD4_E),
                        .Imm_Ext_E(Imm_Ext_E), 
                        .RD_E(RD_E), 
                        .PCE(PCE), 
                        .PCPlus4E(PCPlus4E),
								.JumpE(Jump),
								.PCDirectionE(PCDirection),
								.BranchLinkE(BranchLinkE),

								
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
                        .ForwardA_E(ForwardAE),
                        .ForwardB_E(ForwardBE),
								.ForwardC_E(ForwardCE),
								.RGB_E(RGB_E),
								.RGB_M(RGB_M),
								.PCM(PCM),
								.BranchLinkM(BranchLinkM)
                    );
    
    // Memory Stage
    memory_cycle Memory (
                        .clk(clk), 
                        .rst(rst), 
								.PCM(PCM),
								.BranchLinkM(BranchLinkM),
                        .RegWriteM(RegWriteM), 
                        .MemWriteM(MemWriteM), 
                        .ResultSrcM(ResultSrcM), 
                        .RD_M(RD_M), 
                        .PCPlus4M(PCPlus4M), 
                        .WriteDataM(WriteDataM), 
                        .ALU_ResultM(ALU_ResultM), 
                        .RegWriteW(RegWriteW), 
                        .ResultSrcW(ResultSrcW), 
                        .RD_W(RDW), 
                        .PCPlus4W(PCPlus4W), 
                        .ALU_ResultW(ALU_ResultW), 
                        .ReadDataW(ReadDataW),
								.RGB_M(RGB_M),
								.RGB_E(RGB_E),
								.PCW(PCW),
								.BranchLinkW(BranchLinkW)
                    );

    // Write Back Stage
    writeback_cycle WriteBack (
                        .clk(clk), 
                        .rst(rst), 
								.PCW(PCW),
								.BranchLinkW(BranchLinkW),
                        .ResultSrcW(ResultSrcW), 
                        .PCPlus4W(PCPlus4W), 
                        .ALU_ResultW(ALU_ResultW), 
                        .ReadDataW(ReadDataW), 
                        .ResultW(ResultW)
                    );

    // Hazard Unit
    hazard_unit Forwarding_block (
                        .rst(rst), 
                        .RegWriteM(RegWriteM), 
                        .RegWriteW(RegWriteW), 
                        .RD_M(RD_M), 
                        .RD_W(RDW), 
                        .Rs1_E(RS1_E), 
                        .Rs2_E(RS2_E),
								.Rs4_E(RS4_E),
							   .Rs1_D(InstrD[27:23]), // Usar Rs1_D en Decode
								.Rs2_D(InstrD[22:18]), // Usar Rs2_D en Decode	
								.Rs4_D(InstrD[4:0]),
                        .ForwardAE(ForwardAE), 
                        .ForwardBE(ForwardBE),
								.ForwardAD(ForwardAD),
								.ForwardBD(ForwardBD),
								.ForwardCD(ForwardCD),
								.ForwardCE(ForwardCE)
                        );
endmodule