module Imem (
	 input clock,
    input logic [8:0] address,
    output logic [32:0] q
);
    // Declarar un arreglo de registros para almacenar las instrucciones
    logic [32:0] memory [0:511];

    // Inicializar la memoria con algunas instrucciones para la simulación
    initial begin
        memory[0] = 33'b101000001100000000000000000001010;
		  memory[1] = 33'b101000001000000000000000000010100;
		  memory[2] = 33'b000000001100010000000000000000100;
		  memory[3] = 33'b100000001100101000000000001100100;
		  memory[4] = 33'b101000000100000000000000001100100;
		  memory[5] = 33'b001000001000001000000000000000000;
    end

    always @(posedge clock) begin
		 q <= memory[address];
	end
endmodule
