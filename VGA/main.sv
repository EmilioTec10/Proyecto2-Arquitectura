module main(input clock_50,
				input reset,
				input start,
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
	
	
   rom_red rom_image_red (.clk(clock_50),
						.address(address),
						.data_out(data_out_red));
						
	rom_blue rom_image_blue (.clk(clock_50),
						.address(address),
						.data_out(data_out_blue));
						
	rom_green rom_image_green (.clk(clock_50),
						.address(address),
						.data_out(data_out_green));
											


				
	assign vgaclock = clock_25;
	
		
endmodule 