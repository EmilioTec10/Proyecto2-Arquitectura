module main(input clock_50,
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
				
	
	
	// Variables requeridas
	
	// Reloj
	logic clock_25;
	
	// ROM
	reg [31:0] address;
	logic [23:0] data_out;
	logic [7:0] data_out_red;
	logic [7:0] data_out_blue;
	logic [7:0] data_out_green;
	
	// RAM
	logic we;
	logic [31:0] rd;
	
	// Procesador
	logic [31:0] WriteData;
	logic [31:0] DataAdr;
	logic MemWrite;
	logic [31:0] rd_dmem;
	

	
		
	//Instancias de módulos
	clock25mh clock(clock_50, clock_25);
	
			
	controlador_vga controlador (.clock_25(clock_25),
										  .reset(reset),
										  .start(start),
										  .data_ram(data_out),
										  .data_dmem(rd),
										  .boton_cursor(boton_cursor),
										  .address(address),
										  .we(0),
										  .red(red_out),
										  .green(green_out),
										  .blue(blue_out),
										  .hsync(hsync), 
										  .vsync(vsync), 
										  .n_blank(n_blank));
										 
	
	concatenar_24 inst_concatenar (.num1(data_out_red),
											 .num2(data_out_green),
											 .num3(data_out_blue),
											 .result(data_out));
	
	
	
	ram_rojo ram_image_red (.address(address),
	                        .clock(clock_50),
	                        .data(7'd0),
	                        .wren(1'b0),
	                        .q(data_out_red));
									
	ram_verde ram_image_green (.address(address),
	                        .clock(clock_50),
	                        .data(7'd0),
	                        .wren(1'b0),
	                        .q(data_out_green));
									
	ram_azul ram_image_blue (.address(address),
	                        .clock(clock_50),
	                        .data(7'd0),
	                        .wren(1'b0),
	                        .q(data_out_blue));
	
											
	assign vgaclock = clock_25;
	
		
endmodule 