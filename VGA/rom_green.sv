module rom_green (input wire clk,
				input wire [31:0] address,
				output logic [23:0] data_out);
				
	
	// Variables requeridas
  	reg [7:0] memory [159999:0];

	// Función para cargar los datos de la memoria
	function void load_memory;
		$readmemh("C:/Users/manue/Escritorio/Proyecto2-Arquitectura/VGA/datos_imagen/valores_verde.txt", memory);
		
	endfunction
	
	initial begin
		load_memory();
	end

	
	always @(posedge clk) begin
		data_out <= memory[address];
	end
	
endmodule
