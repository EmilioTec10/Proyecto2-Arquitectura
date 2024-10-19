module fetch_cycle_tb;
	logic clk, rst, PCSrcE;
	logic [8:0] PCTargetE, PCD, PCPlus4D;
	logic [37:0] InstrD;
	
	timeunit 1ps;
	

	fetch_cycle fetch_cycle(clk, rst, PCSrcE, PCTargetE, InstrD, PCD, PCPlus4D);
	
	always #1 clk = ~clk;
	
	
	initial begin
		clk = 1'b0;
		rst <= 1'b0;
		PCSrcE <= 1'b1;
		PCTargetE <= 38'b0;
		#5;
		rst <= 1'b1;
		#1;
		PCSrcE <= 1'b0;
		PCTargetE <= 38'd0;
		#20;
		$finish;
	end

endmodule