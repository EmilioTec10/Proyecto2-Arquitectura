module writeback_cycle(
	input clk, 
	input rst, 
	input ResultSrcW, 
	input [20:0] PCPlus4W, 
	input [20:0] ALU_ResultW, 
	input [20:0] ReadDataW, 
	output [20:0]ResultW
);


// Declaration of Module
Mux result_mux (    
                .a(ALU_ResultW),
                .b(ReadDataW),
                .s(ResultSrcW),
                .c(ResultW)
                );
endmodule