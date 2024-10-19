module memory_cycle_tb;
	logic clk, rst, RegWriteM, MemWriteM, ResultSrcM;
	logic [4:0] RD_M; // Seguramente tenga q cambiar con el isa
	logic [8:0] PCPlus4M;
	logic [17:0] ALU_ResultM, WriteDataM; 
	logic RegWriteW, ResultSrcW;
	logic [4:0] RD_W; // Seguramente tenga q cambiar con el isa
	logic [8:0] PCPlus4W;
	logic [17:0] ALU_ResultW, ReadDataW;
	
	timeunit 1ps;
	
	memory_cycle memory_cycle(clk, rst, RegWriteM, MemWriteM, ResultSrcM, RD_M, PCPlus4M, ALU_ResultM, WriteDataM, RegWriteW, ResultSrcW, RD_W, PCPlus4W, ALU_ResultW, ReadDataW);
	
	initial begin
		clk = 0;
		forever #1 clk = ~clk;
	end
	
	initial begin
		rst <= 1'b0;
		#10;
		rst <= 1'b1;
		ALU_ResultM <= 18'b0;
		MemWriteM <= 1'b0;
		WriteDataM <= 18'b0;
		#10;
		ALU_ResultM <= 18'b0;
		MemWriteM <= 1'b1;
		WriteDataM <= 18'b0;
		#10;
		$finish;
	end
	
endmodule
