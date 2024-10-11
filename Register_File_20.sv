module Register_File_20(
    input clk,
    input rst,
    input WE3,           // Señal de habilitación de escritura
    input [2:0] A1,      // Dirección de registro fuente 1 (3 bits: 8 registros)
    input [2:0] A2,      // Dirección de registro fuente 2 (3 bits: 8 registros)
    input [2:0] A3,      // Dirección de registro destino (3 bits: 8 registros)
    input [19:0] WD3,    // Dato de escritura (20 bits desde la ISA)
    output [19:0] RD1,   // Dato de lectura del registro fuente 1 (20 bits)
    output [19:0] RD2    // Dato de lectura del registro fuente 2 (20 bits)
);

    // Definimos 8 registros de 22 bits
    reg [21:0] Register [7:0]; 

    // Bloque secuencial para escritura
    always @ (posedge clk) begin
        if (WE3 && (A3 != 3'b000))  // Escribimos si WE3 está activo y no se selecciona el registro 0
            Register[A3][19:0] <= WD3;  // Escribimos solo los 20 bits menos significativos
    end

    // Lectura asincrónica de los registros (solo los 20 bits menos significativos)
    assign RD1 = (rst == 1'b0) ? 20'd0 : Register[A1][19:0];  // Leer solo los bits [19:0]
    assign RD2 = (rst == 1'b0) ? 20'd0 : Register[A2][19:0];  // Leer solo los bits [19:0]

    // Inicialización del registro 0 a cero
    initial begin
        Register[0] = 22'h000000;  // El registro 0 siempre contiene 0 (22 bits)
    end

endmodule
