module Mux_tb;

    // Señales para Mux_3_by_1_24b
    reg [23:0] a, b, c;
    reg [1:0] s;
    wire [23:0] d;

    // Señales para Mux_24b
    reg [23:0] x, y;
    reg sel;
    wire [23:0] z;

    // Instancia del Mux_3_by_1_24b
    Mux_3_by_1_24b uut1 (
        .a(a),
        .b(b),
        .c(c),
        .s(s),
        .d(d)
    );

    // Instancia del Mux_24b
    Mux_24b uut2 (
        .a(x),
        .b(y),
        .s(sel),
        .c(z)
    );

    // Estímulos
    initial begin
        $display("=== Iniciando testbench para Mux_3_by_1_24b y Mux_24b ===");

        // Estímulos para Mux_3_by_1_24b
        a = 24'hAAAAAA;
        b = 24'hBBBBBB;
        c = 24'hCCCCCC;

        // Pruebas con todos los valores posibles de s
        s = 2'b00; #10;
        $display("Mux_3_by_1_24b: s=%b, d=%h (esperado: %h)", s, d, a);

        s = 2'b01; #10;
        $display("Mux_3_by_1_24b: s=%b, d=%h (esperado: %h)", s, d, b);

        s = 2'b10; #10;
        $display("Mux_3_by_1_24b: s=%b, d=%h (esperado: %h)", s, d, c);

        s = 2'b11; #10;
        $display("Mux_3_by_1_24b: s=%b, d=%h (esperado: %h)", s, d, 24'h000000);

        // Estímulos para Mux_24b
        x = 24'h123456;
        y = 24'h789ABC;

        // Pruebas con ambos valores de sel
        sel = 1'b0; #10;
        $display("Mux_24b: sel=%b, z=%h (esperado: %h)", sel, z, x);

        sel = 1'b1; #10;
        $display("Mux_24b: sel=%b, z=%h (esperado: %h)", sel, z, y);

        // Finaliza la simulación
        $finish;
    end

endmodule
