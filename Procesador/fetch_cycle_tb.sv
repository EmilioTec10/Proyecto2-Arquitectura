module fetch_cycle_tb;
	logic clk, rst, PCSrcE;
	logic [8:0] PCTargetE, PCD, PCPlus4D;
	logic [32:0] InstrD;
	
	timeunit 1ps;
	

	fetch_cycle fetch_cycle(clk, rst, PCSrcE, PCTargetE, InstrD, PCD, PCPlus4D);
	
	always #1 clk = ~clk;
	
	
	initial begin
		clk = 1'b0;
		rst <= 1'b1;
		PCSrcE <= 1'b1;
		PCD <= 0;
		PCTargetE <= 32'b0;
		#1;
		PCSrcE <= 1'b0;
		PCTargetE <= 32'd0;
		#20;
		$finish;
	end

endmodule
