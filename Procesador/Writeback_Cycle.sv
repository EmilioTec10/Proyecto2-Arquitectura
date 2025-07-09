module writeback_cycle(
	input clk, 
	input rst, BranchLinkW,
	input [1:0] ResultSrcW, 
	input [17:0] PCPlus4W, 
	input [17:0] ALU_ResultW, 
	input [17:0] ReadDataW, 
	input [8:0] PCW,
	output [17:0] ResultW
);


// Declaration of Module
Mux2Parametrizado #(18) result_mux (    
                .a(ALU_ResultW),
                .b(ReadDataW),
					 //.c(PCPlus4W),
                .s(ResultSrcW[0]),
					 .c(ResultW)
                );
endmodule 