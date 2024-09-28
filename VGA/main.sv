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
	logic [31:0] data_out;
	
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
										  
	rom rom_image (.clk(clock_50),
						.address(address),
						.data_out(data_out));
											


				
	assign vgaclock = clock_25;
	
		
endmodule 