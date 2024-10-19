module memory_cycle(
	input logic clk, rst, RegWriteM, MemWriteM, ResultSrcM,
	input logic [4:0] RD_M, // Seguramente tenga q cambiar con el isa
	input logic [8:0] PCPlus4M, ALU_ResultM,
	input logic [33:0] WriteDataM, 
	output logic RegWriteW, ResultSrcW, 
	output logic [4:0] RD_W,
	output logic [33:0] PCPlus4W, ALU_ResultW, ReadDataW
	);
	
	logic [33:0] ReadDataM;
	logic RegWriteM_reg, ResultSrcM_reg;
	logic [4:0] RD_M_reg;
	logic [31:0] PCPlus4M_reg, ALU_ResultM_reg, ReadDataM_reg;	

	Ram ram(
			.address(ALU_ResultM),
			.clock(clk),
			.data(WriteDataM),
			.wren(MemWriteM),
			.q(ReadDataM));
	
	// Memory Stage Register Logic
	always @(posedge clk or negedge rst) begin
	  if (rst == 1'b0) begin
			RegWriteM_reg <= 1'b0; 
			ResultSrcM_reg <= 1'b0;
			RD_M_reg <= 5'h00;
			PCPlus4M_reg <= 32'h00000000; 
			ALU_ResultM_reg <= 32'h00000000; 
			ReadDataM_reg <= 32'h00000000;
	  end
	  else begin
			RegWriteM_reg <= RegWriteM; 
			ResultSrcM_reg <= ResultSrcM;
			RD_M_reg <= RD_M;
			PCPlus4M_reg <= PCPlus4M; 
			ALU_ResultM_reg <= ALU_ResultM; 
			ReadDataM_reg <= ReadDataM;
	  end
	end 

	// Declaration of output assignments
	assign RegWriteW = RegWriteM_reg;
	assign ResultSrcW = ResultSrcM_reg;
	assign RD_W = RD_M_reg;
	assign PCPlus4W = PCPlus4M_reg;
	assign ALU_ResultW = ALU_ResultM_reg;
	assign ReadDataW = ReadDataM_reg;

endmodule
