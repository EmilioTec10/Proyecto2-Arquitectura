module ByteEnableDecoder(
    input  [1:0] byteena_in,  // Señal de entrada de 2 bits
	 input logic wren,
    output reg [2:0] byteena  // Señal de salida de 3 bits para la RAM
);

always @(*) begin
	//case (wren)
			 //1'b1: 
				 case (byteena_in)
					  2'b00: byteena = 3'b100; // Escribir en los bits 23-16
					  2'b01: byteena = 3'b010; // Escribir en los bits 15-8
					  2'b10: byteena = 3'b001; // Escribir en los bits 7-0
					  default: byteena = 3'b000; // No habilitar escritura si la señal es inválida
				 endcase
			//1'b0:
				//byteena = 3'b111;
	//endcase
end

endmodule
