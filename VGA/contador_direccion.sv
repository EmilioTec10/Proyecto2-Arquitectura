module contador_direccion #(parameter n = 18) (
    input logic clk,
    input logic reset,
    input [9:0] x,
    input [9:0] y,
    output logic we,
    output reg [n-1:0] out
);
    
    // Variables
    reg [n-1:0] contador = 0;
    logic flag_contador = 0;
    integer base_address;
    integer block_x, block_y;
    integer local_x, local_y;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            contador <= 0;
            flag_contador <= 0;
            we <= 0;
        end else begin
            // Activar contador cuando x = 120 y y = 40 (primer píxel)
            if ((x == 120) && (y == 40)) begin
                contador <= 0;
                flag_contador <= 1;
                we <= 1;  // Habilitar escritura
            end

            // Incrementar el contador mientras estemos en la región de la imagen
            else if (flag_contador) begin
                // Calcular el bloque actual (ajustando a la posición de inicio en x = 120, y = 40)
                block_x = (x - 120) / 100;
                block_y = (y - 40) / 100;
                base_address = (block_y * 4 + block_x) * 10000;

                // Calcular la posición dentro del bloque actual
                local_x = (x - 120) % 100;
                local_y = (y - 40) % 100;
                contador <= base_address + local_y * 100 + local_x;

                // Desactivar el contador cuando se haya recorrido toda la imagen
                if ((x == 520) && (y == 440)) begin
                    flag_contador <= 0;
                    we <= 0;
                end
            end
        end
    end

    assign out = contador;  // Dirección de la ROM basada en el contador

endmodule
