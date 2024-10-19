module writeback_cycle(
	input clk, 
	input rst, 
	input [1:0] ResultSrcW, 
	input [17:0] PCPlus4W, 
	input [17:0] ALU_ResultW, 
	input [17:0] ReadDataW, 
	output [17:0] ResultW
);


// Declaration of Module
Mux3Parametrizado #(18) result_mux (    
                .a(ALU_ResultW),
                .b(ReadDataW),
					 .c(PCPlus4W),
                .s(ResultSrcW),
					 .d(ResultW)
                );
endmodule 