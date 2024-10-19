module Register_File(
    input clk,                  // Señal de reloj
    input rst,                  // Señal de reset
    input WE3,                  // Señal de habilitación de escritura
    input [3:0] A1,             // Dirección de registro fuente 1 (4 bits: 16 registros)
    input [3:0] A2,             // Dirección de registro fuente 2 (4 bits: 16 registros)
    input [3:0] A3,             // Dirección de registro destino (4 bits: 16 registros)
    input [23:0] WD3,           // Dato de escritura (24 bits)

    output [23:0] RD1,          // Dato de lectura del registro fuente 1 (24 bits)
    output [23:0] RD2           // Dato de lectura del registro fuente 2 (24 bits)
);

    // Definimos 16 registros de 34 bits
    reg [23:0] Register [3:0];

    // Bloque secuencial para escritura
    always @ (posedge clk) begin
        if (WE3 && (A3 != 4'b0000))  // Escribimos si WE3 está activo y no se selecciona el registro 0
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
