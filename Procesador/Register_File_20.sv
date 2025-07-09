module Register_File_20(
    input clk,                  // Señal de reloj
    input rst,                  // Señal de reset
    input WE3,                  // Señal de habilitación de escritura
    input [2:0] A1,             // Dirección de registro fuente 1 (3 bits: 8 registros)
    input [2:0] A2,             // Dirección de registro fuente 2 (3 bits: 8 registros)
    input [2:0] A3,             // Dirección de registro destino (3 bits: 8 registros)
    input [33:0] WD3,           // Dato de escritura (34 bits)

    output [33:0] RD1,          // Dato de lectura del registro fuente 1 (34 bits)
    output [33:0] RD2           // Dato de lectura del registro fuente 2 (34 bits)
);

    // Definimos 8 registros de 34 bits
    reg [23:0] Register [7:0]; 

    // Bloque secuencial para escritura
    always @ (posedge clk) begin
        if (WE3 && (A3 != 3'b000))  // Escribimos si WE3 está activo y no se selecciona el registro 0
            Register[A3] <= WD3;    // Escribimos los 34 bits completos
    end

    // Lectura asincrónica de los registros (34 bits)
    assign RD1 = (rst == 1'b0) ? 24'd0 : Register[A1];  // Leer 34 bits completos
    assign RD2 = (rst == 1'b0) ? 24'd0 : Register[A2];  // Leer 34 bits completos

    // Inicialización del registro 0 a cero
    initial begin
        Register[0] = 24'h000000000;  // El registro 0 siempre contiene 0 (34 bits)
    end

endmodule
