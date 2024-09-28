
module rom (input wire clk,
				input wire [31:0] address,
				output logic [31:0] data_out);
				
	
	// Variables requeridas
  	reg [31:0] memory [65535:0];

	// Función para cargar los datos de la memoria
	function void load_memory;
		$readmemh("C:/Users/manue/Escritorio/emadrigal_acambronero_hespinoza_digital_design_lab_2023/Proyecto/Archivos/Obtener imagen/datos_imagen_hex.txt", memory);
		
	endfunction
	
	initial begin
		load_memory();
	end

	
	always @(posedge clk) begin
		data_out <= memory[address];
	end
	
endmodule
