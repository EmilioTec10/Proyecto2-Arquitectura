module fetch_cycle(
	input logic clk, rst, PCSrcE, PCReturnSignalE,
	input logic [8:0] PCTargetE, PCReturnE,
	input logic StallF,
	output logic [32:0] InstrD,
	output logic [8:0] PCD, PCPlus4D
	);
	
	logic [8:0] PC_F, PCF, PCPlus4F;
	logic [32:0] InstrF;

	logic [32:0] InstrF_reg;
	logic [8:0] PCF_reg, PCPlus4F_reg;
	
	reg [32:0] stall_reg;

	assign PC_F = (PCReturnSignalE) ? PCReturnE : (~PCSrcE) ? PCPlus4F : PCTargetE;
	assign PCPlus4F = PCF + 9'd1;

	// Declare Instruction Memory
	Instruction_Memory IMEM (
						.clock(clk),
						.address(PCF),
						.q(InstrF)
						);
	 
	 // Fetch Cycle Register Logic
	always @(posedge clk or negedge rst) begin
    if (rst == 1'b0) begin
        // Pre-fetch durante el reset
        PCF <= 9'h0;
        InstrF_reg <= InstrF; // Cargar la primera instrucción durante el reset
        PCF_reg <= 9'd0;
        PCPlus4F_reg <= 9'd1;
    end 
    else if (StallF) begin
        // Mantener los valores actuales si StallF está activo
        PCF <= PCF;
        InstrF_reg <= InstrF_reg;
		  stall_reg <= InstrF;
        PCF_reg <= PCF_reg;
        PCPlus4F_reg <= PCPlus4F_reg;
    end
    else begin
        // Comportamiento normal
        PCF <= PC_F;
        InstrF_reg <= (stall_reg != 33'h0) ? stall_reg : InstrF;
		  stall_reg <= 33'h0; // Reiniciar stall_reg después de usarlo
        PCF_reg <= PCF;
        PCPlus4F_reg <= PCPlus4F;
    end
	end



	// Assigning Registers Value to the Output port
	assign  InstrD =  InstrF_reg;
	assign  PCD = PCF_reg;
	assign  PCPlus4D = PCPlus4F_reg;

endmodule
