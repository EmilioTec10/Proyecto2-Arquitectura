module fetch_cycle(clk, rst, PCSrcE, PCTargetE, InstrD, PCD, PCPlus4D);
    // Declare input & outputs
    input clk, rst;
    input PCSrcE;
    input [33:0] PCTargetE;
    output [33:0] InstrD;
    output [8:0] PCD, PCPlus4D;
	
	 // Declaring wires
    wire [8:0] PC_F, PCF, PCPlus4F;
    wire [33:0] InstrF;

    // Declaration of Register
    reg [33:0] InstrF_reg;
    reg [8:0] PCF_reg, PCPlus4F_reg;


    // Initiation of Modules
    // Declare PC Mux
    Mux PC_MUX (.a(PCPlus4F),
                .b(PCTargetE),
                .s(PCSrcE),
                .c(PC_F)
                );

    // Declare PC Counter
    PC_Module Program_Counter (
                .clk(clk),
                .rst(rst),
                .PC(PCF),
                .PC_Next(PC_F)
                );

    // Declare Instruction Memory
    Instruction_Memory IMEM (
                .clock(clk),
                .address(PCF),
                .q(InstrF)
                );

    // Declare PC adder
    PC_Adder PC_adder (
                .a(PCF),
                .b(9'd4),
                .c(PCPlus4F)
                );

    // Fetch Cycle Register Logic
    always @(posedge clk or negedge rst) begin
        if(rst == 1'b0) begin
            InstrF_reg <= 34'h0;
            PCF_reg <= 9'd0;
            PCPlus4F_reg <= 9'd0;
        end
        else begin
            InstrF_reg <= InstrF;
            PCF_reg <= PCF;
            PCPlus4F_reg <= PCPlus4F;
        end
    end


    // Assigning Registers Value to the Output port
    assign  InstrD = (rst == 1'b0) ? 34'h00000000 : InstrF_reg;
    assign  PCD = (rst == 1'b0) ? 9'h00000000 : PCF_reg;
    assign  PCPlus4D = (rst == 1'b0) ? 9'h00000000 : PCPlus4F_reg;

endmodule
