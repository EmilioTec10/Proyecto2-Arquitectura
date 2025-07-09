module mostrarImagen (
    input [0:9] x,
    input [0:9] y,
    input reset,
    input start,
    input reg [23:0] data_ram,
    input reg [23:0] data_interpolado,
	 input reg [3:0] pos_cursor,
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
            if ((x >= 120 && x <= 520) && (y >= 40 && y <= 440)) begin
                 // Colorear el resto de los píxeles con el color de los datos de RAM
                 pixel_data = data_ram;
                 red = pixel_data[23:16];
                 green = pixel_data[15:8];
                 blue = pixel_data[7:0];
            end
            else begin
                red = 8'b00000000;
                green = 8'b00000000;
                blue = 8'b00000000;
            end
        end
        else begin
            // Verificar si x y y están dentro del rango de la imagen
            if ((x >= 120 && x <= 520) && (y >= 40 && y <= 440) && ~start) begin
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
					 
					 // Fila uno cursor
					 if ((x >= 145 && x <= 195) && (y >= 65 && y <= 115) && pos_cursor == 4'd0) begin
						  red = 8'b11111111;
                    green = 8'b00000000;  // Verde fuerte
                    blue = 8'b00000000;
					 end
					 
					 else if ((x >= 245 && x <= 295) && (y >= 65 && y <= 115) && pos_cursor == 4'd1) begin
						  red = 8'b11111111;
                    green = 8'b00000000;  // Verde fuerte
                    blue = 8'b00000000;
					 end
					 
					 else if ((x >= 345 && x <= 395) && (y >= 65 && y <= 115) && pos_cursor == 4'd2) begin
						  red = 8'b11111111;
                    green = 8'b00000000;  // Verde fuerte
                    blue = 8'b00000000;
					 end
					 
					 else if ((x >= 445 && x <= 495) && (y >= 65 && y <= 115) && pos_cursor == 4'd3) begin
						  red = 8'b11111111;
                    green = 8'b00000000;  // Verde fuerte
                    blue = 8'b00000000;
					 end
					 
					 // Fila dos cursor
					  if ((x >= 145 && x <= 195) && (y >= 165 && y <= 215) && pos_cursor == 4'd4) begin
						  red = 8'b11111111;
                    green = 8'b00000000;  // Verde fuerte
                    blue = 8'b00000000;
					 end
					 
					 else if ((x >= 245 && x <= 295) && (y >= 165 && y <= 215) && pos_cursor == 4'd5) begin
						  red = 8'b11111111;
                    green = 8'b00000000;  // Verde fuerte
                    blue = 8'b00000000;
					 end
					 
					 else if ((x >= 345 && x <= 395) && (y >= 165 && y <= 215) && pos_cursor == 4'd6) begin
						  red = 8'b11111111;
                    green = 8'b00000000;  // Verde fuerte
                    blue = 8'b00000000;
					 end
					 
					 else if ((x >= 445 && x <= 495) && (y >= 165 && y <= 215) && pos_cursor == 4'd7) begin
						  red = 8'b11111111;
                    green = 8'b00000000;  // Verde fuerte
                    blue = 8'b00000000;
					 end
					 
					 // Fila tres cursor
					  if ((x >= 145 && x <= 195) && (y >= 265 && y <= 315) && pos_cursor == 4'd8) begin
						  red = 8'b11111111;
                    green = 8'b00000000;  // Verde fuerte
                    blue = 8'b00000000;
					 end
					 
					 else if ((x >= 245 && x <= 295) && (y >= 265 && y <= 315) && pos_cursor == 4'd9) begin
						  red = 8'b11111111;
                    green = 8'b00000000;  // Verde fuerte
                    blue = 8'b00000000;
					 end
					 
					 else if ((x >= 345 && x <= 395) && (y >= 265 && y <= 315) && pos_cursor == 4'd10) begin
						  red = 8'b11111111;
                    green = 8'b00000000;  // Verde fuerte
                    blue = 8'b00000000;
					 end
					 
					 else if ((x >= 445 && x <= 495) && (y >= 265 && y <= 315) && pos_cursor == 4'd11) begin
						  red = 8'b11111111;
                    green = 8'b00000000;  // Verde fuerte
                    blue = 8'b00000000;
					 end
					 
					 // Fila cuatro cursor
					  if ((x >= 145 && x <= 195) && (y >= 365 && y <= 415) && pos_cursor == 4'd12) begin
						  red = 8'b11111111;
                    green = 8'b00000000;  // Verde fuerte
                    blue = 8'b00000000;
					 end
					 
					 else if ((x >= 245 && x <= 295) && (y >= 365 && y <= 415) && pos_cursor == 4'd13) begin
						  red = 8'b11111111;
                    green = 8'b00000000;  // Verde fuerte
                    blue = 8'b00000000;
					 end
					 
					 else if ((x >= 345 && x <= 395) && (y >= 365 && y <= 415) && pos_cursor == 4'd14) begin
						  red = 8'b11111111;
                    green = 8'b00000000;  // Verde fuerte
                    blue = 8'b00000000;
					 end
					 
					 else if ((x >= 445 && x <= 495) && (y >= 365 && y <= 415) && pos_cursor == 4'd15) begin
						  red = 8'b11111111;
                    green = 8'b00000000;  // Verde fuerte
                    blue = 8'b00000000;
					 end
					 
            end
				else if ((x >= 220 && x <= 420) && (y >= 140 && y <= 340) && start) begin
					red = data_interpolado[23:16];
               green = data_interpolado[15:8];
               blue = data_interpolado[7:0];
				
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
