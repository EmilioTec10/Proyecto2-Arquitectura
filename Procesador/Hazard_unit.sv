module hazard_unit(
    input logic rst, RegWriteM, RegWriteW,
    input [4:0] RD_M, RD_W, Rs1_E, Rs2_E,
    input [4:0] Rs1_D, Rs2_D, // Registros fuente en la etapa Decode
    output [1:0] ForwardAE, ForwardBE,
    output logic StallF, StallD // Señales para hacer el stall
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

    // Detectar hazard en la etapa Decode y generar stall
    // Si la instrucción en Decode (Rs1_D o Rs2_D) necesita un valor que está en WB (RD_W)
    assign StallF = (RegWriteW == 1'b1) & ((RD_W != 5'h00) & ((RD_W == Rs1_D) | (RD_W == Rs2_D)));
    assign StallD = StallF; // Hacer el stall tanto en Fetch como en Decode

endmodule
