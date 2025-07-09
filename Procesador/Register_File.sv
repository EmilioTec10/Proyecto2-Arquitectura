module Register_File(
    input clk,                  // Señal de reloj
    input rst,                  // Señal de reset
    input WE3,                  // Señal de habilitación de escritura
    input [4:0] A1,             // Dirección de registro fuente 1 (4 bits: 16 registros)
    input [4:0] A2,             // Dirección de registro fuente 2 (4 bits: 16 registros)
    input [4:0] A3,             // Dirección de registro destino (4 bits: 16 registros)
	 input [4:0] A4,
    input [17:0] WD3,           // Dato de escritura (24 bits)

    output [17:0] RD1,          // Dato de lectura del registro fuente 1 (24 bits)
    output [17:0] RD2,          // Dato de lectura del registro fuente 2 (24 bits)
  output [17:0] RD4,
  output [8:0] R29

);

    // Definimos 16 registros de 34 bits
    reg [17:0] Register [31:0] ;
	 
	 initial begin
		integer i;
		for (i = 0; i < 32; i = i + 1) begin
				  Register[i] = 18'd0; // Inicializa cada registro en 0
		 end
	 end
	 
    // Bloque secuencial para escritura
    always @ (posedge clk) begin
	 
        if (WE3 && (A3 != 5'b00000))  // Escribimos si WE3 está activo y no se selecciona el registro 0
            Register[A3] <= WD3;    // Escribimos los 33 bits completos
    end

    // Lectura asincrónica de los registros (34 bits)
    assign RD1 = (rst == 1'b0) ? 18'd0 : Register[A1];  // Leer 34 bits completos
    assign RD2 = (rst == 1'b0) ? 18'd0 : Register[A2];  // Leer 34 bits completos
	 assign RD4 = (rst == 1'b0) ? 18'd0 : Register[A4];  // Leer 34 bits completos
  assign R29 = (rst == 1'b0) ? 18'd0 : Register[29];

endmodule
