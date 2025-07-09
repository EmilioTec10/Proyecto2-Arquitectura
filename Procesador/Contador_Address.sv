module Contador_Address (
    input wire clk,      // Señal de reloj
    input wire rst,      // Señal de reset
    output reg [17:0] count // Salida del contador (18 bits)
);

    // Rango del contador
    localparam START = 18'd160000;  // Valor inicial
    localparam END   = 18'd199999;  // Valor final

    // Lógica del contador
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            count <= START;  // Reiniciar el contador al valor inicial
        end else begin
            if (count == END) begin
                count <= START;  // Reiniciar el contador cuando llega al valor final
            end else begin
                count <= count + 1;  // Incrementar el contador
            end
        end
    end

endmodule
