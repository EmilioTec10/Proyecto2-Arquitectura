module main_top(input clock_50,
				input reset,
				input start,
				input logic boton_cursor,
				output [7:0] red_out,
				output [7:0] green_out,
				output [7:0] blue_out,
				output hsync,
				output vsync,
				output n_blank,
				output vgaclock);
				
		
	// Reloj de la vga
	logic clock_25;
	
	// ROM
	reg [17:0] address;
	logic [23:0] data_out;
	logic [23:0] data_out_salida;
	
	// RAM
	logic we;
	logic [31:0] rd;
	logic [23:0] pixel;
	logic [3:0] pos_cursor;
	
		
	//Instancias de módulos
	clock25mh clock(clock_50, clock_25);
	
		
	controlador_vga controlador (.clock_25(clock_25),
										  .reset(reset),
										  .start(start),
										  .data_rom(data_out),
										  .data_interpolado(pixel),
										  .boton_cursor(boton_cursor),
										  .address(address),
										  .we(0),
										  .red(red_out),
										  .green(green_out),
										  .blue(blue_out),
										  .hsync(hsync), 
										  .vsync(vsync), 
										  .pos_cursor(pos_cursor),
										  .n_blank(n_blank));
	
	//Memoria Rom de la imagen original
	imagen_original inst_imagen (.address(address),
										  .clock(clock_50),
										  .q(data_out));
										  
	// Procesador
	Pipeline_Top inst_pipeline (.clk(clock), 
										 .rst(reset),
										 .start(start),
										 .pos_cursor(pos_cursor),
										 .pixel(pixel));
	
											
	assign vgaclock = clock_25;
	
		
endmodule 