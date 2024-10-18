module fetch_cycle_tb;
	logic clk, rst, PCSrcE;
	logic [8:0] PCTargetE, PCD, PCPlus4D;
	logic [33:0] InstrD;
	
	timeunit 1ps;
	

	fetch_cycle fetch_cycle(clk, rst, PCSrcE, PCTargetE, InstrD, PCD, PCPlus4D);

	initial begin
		clk = 0;
		forever #1 clk = ~clk;
	end
	
	initial begin
		rst <= 1'b0;
		#10;
		rst <= 1'b1;
		PCSrcE <= 1'b1;
		PCTargetE <= 34'b0;
		#10;
		PCSrcE <= 1'b1;
		PCTargetE <= 34'd1;
		#10;
		$finish;
	end

endmodule
