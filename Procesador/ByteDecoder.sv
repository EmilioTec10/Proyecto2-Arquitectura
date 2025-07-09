module ByteDecoder (
    input [17:0] data_in,   // Dato de entrada de 18 bits
    input [2:0] byteena,    // Señal de byteena de 3 bits
    output reg [23:0] data_out // Salida de 24 bits
);

    always @(*) begin
        // Inicializar la salida a cero
        data_out = 24'b0;
        
        // Dependiendo del valor de byteena, habilitar la escritura en el bloque correspondiente
        case (byteena)
            3'b100: data_out[23:16] = data_in[7:0];  // Escribir en los bits 23-16
            3'b010: data_out[15:8]  = data_in[7:0];  // Escribir en los bits 15-8
            3'b001: data_out[7:0]   = data_in[7:0];  // Escribir en los bits 7-0
            default: data_out = 24'b0; // Si byteena no es válido, mantener la salida en cero
        endcase
    end

endmodule
