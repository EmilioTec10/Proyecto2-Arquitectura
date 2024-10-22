module memory_cycle(
	input logic clk, rst, RegWriteM, MemWriteM, ResultSrcM,
	input logic [4:0] RD_M, // Seguramente tenga q cambiar con el isa
	input logic [8:0] PCPlus4M,
	input logic [17:0] ALU_ResultM, WriteDataM, 
	input logic [1:0] RGB_M, RGB_E,
	output logic RegWriteW, ResultSrcW, 
	output logic [4:0] RD_W, // Seguramente tenga q cambiar con el isa
	output logic [8:0] PCPlus4W,
	output logic [17:0] ALU_ResultW, ReadDataW
	);
	
	logic [17:0] ReadDataM;
	logic [23:0] Data_23;
	logic [24:0] WriteDataIn;
	logic RegWriteM_reg, ResultSrcM_reg;
	logic [4:0] RD_M_reg; // Seguramente tenga q cambiar con el isa
	logic [8:0] PCPlus4M_reg;
	logic [17:0] ALU_ResultM_reg, ReadDataM_reg;	
	logic [2:0] byteena;
	
	reg [23:0] Data_23_r;
	reg [1:0] RGB_M_r;
	
	ByteDecoder byte_deco(
    .data_in(WriteDataM),   // Dato de entrada de 18 bits
    .byteena(byteena),    // Señal de byteena de 3 bits
    .data_out(WriteDataIn) // Salida de 24 bits
	);
	
	Ram ram(
			.address(ALU_ResultM),
			.clock(clk),
			.data(WriteDataIn),
			.wren(MemWriteM),
			.byteena(byteena),
			.q(Data_23));
			
	ByteEnableDecoder deco_byt (
			.byteena_in(RGB_M),
			.wren(MemWriteM),
			.byteena(byteena));
			
			
	Mux3_8 MUX_Read (    
                .a(Data_23[23:16]),
                .b(Data_23[15:8]),
					 .c(Data_23[7:0]),
                .s(RGB_M_r),
					 .d(ReadDataM)
                );
	
	// Memory Stage Register Logic
	always @(posedge clk or negedge rst) begin
	  if (rst == 1'b0) begin
			RegWriteM_reg <= 1'b0; 
			ResultSrcM_reg <= 1'b0;
			RD_M_reg <= 5'h00;
			PCPlus4M_reg <= 9'h00000000; 
			ALU_ResultM_reg <= 18'h00000000; 
			ReadDataM_reg <= 18'h00000000;
			Data_23_r <= 18'h00000000;
	  end
	  else begin
			RegWriteM_reg <= RegWriteM; 
			ResultSrcM_reg <= ResultSrcM;
			RD_M_reg <= RD_M;
			PCPlus4M_reg <= PCPlus4M; 
			ALU_ResultM_reg <= ALU_ResultM; 
			ReadDataM_reg <= ReadDataM;
			Data_23_r <= ReadDataM_reg;
			RGB_M_r <= RGB_M;
	  end
	end 

	// Declaration of output assignments
	assign RegWriteW = RegWriteM_reg;
	assign ResultSrcW = ResultSrcM_reg;
	assign RD_W = RD_M_reg;
	assign PCPlus4W = PCPlus4M_reg;
	assign ALU_ResultW = ALU_ResultM_reg;
	assign ReadDataW = ReadDataM;

endmodule
