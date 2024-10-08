module contador_cuadrado #(parameter n = 32) (
    input logic clk,          // Señal de reloj
    input logic reset,        // Señal de reset
    input [9:0] x,            // Coordenada x (hasta 1023)
    input [9:0] y,            // Coordenada y (hasta 1023)
    output reg [n-1:0] addr   // Dirección de memoria generada
);

    // Variables internas
    reg [15:0] contador;      // Contador de valores generados
    reg [6:0] fila;           // Contador para las filas (controla cuando sumar 301)
    reg flag_contador;        // Señal que indica si el proceso ha comenzado

    // Inicialización
    initial begin
        addr = 0;
        contador = 0;
        fila = 0;
        flag_contador = 0;
    end

    // Bloque secuencial que genera las direcciones de memoria
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            // Reinicia todos los registros
            addr <= 0;
            contador <= 0;
            fila <= 0;
            flag_contador <= 0;
        end else begin
            if (flag_contador == 0) begin
                // Iniciar el contador cuando se llegue a las coordenadas (120, 40)
                if (x == 120 && y == 40) begin
                    contador <= 0;
                    flag_contador <= 1;
                end
            end else begin
                // Generar direcciones solo para el primer área de 100x100
                if (contador < 10000) begin
                    if ((x >= 120 && x < 220) && (y >= 40 && y < 140)) begin
                        if (contador % 100 == 0 && contador != 0) begin
                            addr <= addr + 301;  // Al terminar una fila, sumar 301
                            fila <= fila + 1;
                        end else begin
                            addr <= addr + 1;    // Sumar 1 dirección dentro de una fila
                        end
                        contador <= contador + 1;
                    end
                end else begin
                    // Detener la generación de direcciones después de 10000 valores generados
                    flag_contador <= 0;
                end
            end
        end
    end

endmodule
