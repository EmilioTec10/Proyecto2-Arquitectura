module fetch_cycle_tb;
	logic clk, rst, PCSrcE;
	logic [8:0] PCTargetE, PCD, PCPlus4D;
	logic [33:0] InstrD;
	

	fetch_cycle fetch_cycle(clk, rst, PCSrcE, PCTargetE, InstrD, PCD, PCPlus4D);

	initial begin
		clk = 0;
		forever #1 clk = ~clk;
	end
	
	initial begin
		#50;
		rst <= 1'b1;
		PCSrcE <= 1'b1;
		PCTargetE <= 34'b0;
		#100;
		$finish;
	end

endmodule
