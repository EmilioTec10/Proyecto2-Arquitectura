module Fetch_Cycle_tb();
	
	reg clk=1, rst, PCSrcsE;
	reg [19:0] PCTargetE;
	wire [19:0] InstrD, PCD, PCPlus4d;

	fetch_cycle Fetch_cycle (
									.clk(clk),
									.rst(rst),
									.PCSrcE(PCSrcE),
									.PCTargetE(PCTargetE),
									.InstrD(InstrD),
									.PCD(PCD),
									.PCPlus4D(PCPlus4D)
									);
	
	always begin
		clk = ~clk;
		#50;
	end
	
	initial begin
	rst <= 1'b0;
	#200;
	rst <= 1'b1;
	PCSrcsE <= 1'b1;
	PCTargetE <= 20'b0;
	#500;
	$finish;
	end

endmodule