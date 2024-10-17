module Register_File_20_tb;

    reg clk;
    reg rst;
    reg WE3;
    reg [2:0] A1, A2, A3;
    reg [33:0] WD3;
    wire [33:0] RD1, RD2;

    // Instanciar el registro bajo prueba
    Register_File_20 uut (
        .clk(clk),
        .rst(rst),
        .WE3(WE3),
        .A1(A1),
        .A2(A2),
        .A3(A3),
        .WD3(WD3),
        .RD1(RD1),
        .RD2(RD2)
    );

    // Generación de reloj
    always #5 clk = ~clk;

    initial begin
        // Inicialización
        clk = 0;
        rst = 1;
        WE3 = 0;
        A1 = 3'b000; A2 = 3'b000; A3 = 3'b000; WD3 = 34'h0;

        // Reset activo
        #10;
        rst = 0;  // Desactivar el reset
        #10;
        rst = 1;  // Activar el reset

        // Escribir en el registro 1
        WE3 = 1;
        A3 = 3'b001;  // Escribimos en el registro 1
        WD3 = 34'h0000000A1;  // Dato a escribir en el registro 1
        #10;

        // Leer del registro 1 y registro 0
        WE3 = 0;  // Deshabilitar la escritura
        A1 = 3'b001;  // Leer del registro 1
        A2 = 3'b000;  // Leer del registro 0
        #10;

        $display("Lectura del registro 1: %h", RD1);
        $display("Lectura del registro 0: %h", RD2);

        // Escribir en el registro 0 (esto no debería hacer nada)
        WE3 = 1;
        A3 = 3'b000;  // Intentar escribir en el registro 0
        WD3 = 34'hFFFFFFFF;  // Dato a escribir en el registro 0
        #10;

        // Leer del registro 0 nuevamente
        WE3 = 0;
        A1 = 3'b000;  // Leer del registro 0
        #10;

        $display("Lectura del registro 0 (después de intento de escritura): %h", RD1);

        // Finalizar simulación
        $finish;
    end

endmodule
