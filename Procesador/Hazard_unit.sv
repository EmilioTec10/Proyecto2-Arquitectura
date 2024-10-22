module hazard_unit(
    input logic rst, RegWriteM, RegWriteW,
    input [4:0] RD_M, RD_W, Rs1_E, Rs2_E, Rs4_E,
    input [4:0] Rs1_D, Rs2_D, Rs4_D, // Registros fuente en la etapa Decode
    output [1:0] ForwardAE, ForwardBE, ForwardCE,
    output logic ForwardAD, ForwardBD, ForwardCD // Señales para hacer el stall
);
    
    // Forwarding para la entrada A de la ALU
    assign ForwardAE = (rst == 1'b0) ? 2'b00 :  
                       ((RegWriteM == 1'b1) & (RD_M != 5'h00) & (RD_M == Rs1_E)) ? 2'b10 :
                       ((RegWriteW == 1'b1) & (RD_W != 5'h00) & (RD_W == Rs1_E)) ? 2'b01 :
                       2'b00;

    // Forwarding para la entrada B de la ALU
    assign ForwardBE = (rst == 1'b0) ? 2'b00 : 
                       ((RegWriteM == 1'b1) & (RD_M != 5'h00) & (RD_M == Rs2_E)) ? 2'b10 :
                       ((RegWriteW == 1'b1) & (RD_W != 5'h00) & (RD_W == Rs2_E)) ? 2'b01 :
                       2'b00;
							  
	assign ForwardAD = (rst == 1'b0) ? 1'b0 :
							 (RegWriteW == 1'b1) & (RD_W != 5'h00) & (RD_W == Rs1_D) ? 1'b1 :
							 1 'b0;
							 
	assign ForwardBD = (rst == 1'b0) ? 1'b0 :
							 (RegWriteW == 1'b1) & (RD_W != 5'h00) & (RD_W == Rs2_D) ? 1'b1 :
							 1 'b0;
	
	assign ForwardCE = (rst == 1'b0) ? 2'b00 : 
                       ((RegWriteM == 1'b1) & (RD_M != 5'h00) & (RD_M == Rs4_E)) ? 2'b10 :
                       ((RegWriteW == 1'b1) & (RD_W != 5'h00) & (RD_W == Rs4_E)) ? 2'b01 :
                       2'b00;
	
	assign ForwardCD = (rst == 1'b0) ? 1'b0 :
							 (RegWriteW == 1'b1) & (RD_W != 5'h00) & (RD_W == Rs4_D) ? 1'b1 :
							 1 'b0;

endmodule
