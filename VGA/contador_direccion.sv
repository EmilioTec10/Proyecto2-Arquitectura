module contador_direccion #(parameter n = 18) (input logic clk,      
                                               input logic reset,  
                                               input [9:0] x, 
                                               input [9:0] y,     
                                               output logic we,
                                               output reg [n-1:0] out);  
                                               
    // Variables
    reg [n-1:0] contador = 0;
    logic flag_contador = 0;

    always @ (posedge clk or posedge reset) begin
        if (reset) begin
            contador <= 0;
            flag_contador <= 0;
            we <= 0;
        end else begin
            // Activar contador cuando x = 120 y y = 40
            if ((x == 120) && (y == 40)) begin
                contador <= 0;
                flag_contador <= 1;
                we <= 1;  // Habilitar escritura
            end

            // Incrementar el contador mientras estemos en la región de la imagen
            else if (flag_contador) begin
                if ((x >= 120 && x < 520) && (y >= 40 && y < 440)) begin
                    contador <= contador + 1;
                end

                // Desactivar contador cuando se haya cubierto toda la imagen
                else if (x == 520 && y == 440) begin
                    contador <= 0;
                    flag_contador <= 0;
                    we <= 0;  // Desactivar escritura
                end
            end
        end
    end

    assign out = contador;  // Dirección de la ROM basada en el contador

endmodule





	