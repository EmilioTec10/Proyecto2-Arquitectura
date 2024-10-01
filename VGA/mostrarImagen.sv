module mostrarImagen (
    input [0:9] x,
    input [0:9] y,
    input reset,
    input start,
    input reg [23:0] data_ram,
    input reg [31:0] data_dmem,
    output logic [7:0] red,
    output logic [7:0] green,
    output logic [7:0] blue
	 
);
    // Variables requeridas
    logic [23:0] pixel_data;
    
    always_comb begin
        pixel_data = 0;
        red = 8'b00000000;
        green = 8'b00000000;
        blue = 8'b00000000;
        
        if (reset) begin
            // Color de fondo por defecto (puedes cambiar el color)
            if ((x >= 200 && x <= 455) && (y >= 120 && y <= 375)) begin
                red = 8'b00000000;
                green = 8'b11111111;
                blue = 8'b00000000;
            end
            else begin
                red = 8'b00000000;
                green = 8'b00000000;
                blue = 8'b00000000;
            end
        end
        else begin
            // Verificar si x y y están dentro del rango de la imagen
            if ((x >= 120 && x <= 520) && (y >= 40 && y <= 440)) begin
                // Dividir en 4x4 cuadrículas dentro de los límites de la imagen
                if ((x == 220 || x == 320 || x == 420 || y == 140 || y == 240 || y == 340) &&
                    (x <= 520 && y <= 440)) begin
                    // Líneas verdes en los bordes de los cuadrados
                    red = 8'b00000000;
                    green = 8'b11111111;  // Verde fuerte
                    blue = 8'b00000000;
                end
                else begin
                    // Colorear el resto de los píxeles con el color de los datos de RAM
                    pixel_data = data_ram;
                    red = pixel_data[23:16];
                    green = pixel_data[15:8];
                    blue = pixel_data[7:0];
                end
            end
            else begin
                // Color por defecto (negro) fuera del área de la imagen
                red = 8'b00000000;
                green = 8'b00000000;
                blue = 8'b00000000;
            end
        end
    end
endmodule
