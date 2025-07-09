module Sign_Extend_20_tb;

    reg [33:0] In;         // Entrada de 34 bits
    reg [1:0] ImmSrc;      // Fuente del inmediato
    wire [23:0] Imm_Ext;   // Salida de inmediato extendido

    // Instancia del módulo a probar
    Sign_Extend uut (
        .In(In),
        .ImmSrc(ImmSrc),
        .Imm_Ext(Imm_Ext)
    );

    initial begin
        // Inicialización
        $monitor("In = %b, ImmSrc = %b -> Imm_Ext = %b", In, ImmSrc, Imm_Ext);

        // Caso 1: Inmediato de 10 bits (ImmSrc == 00)
        In = 34'b0000000000000000000000000000001100;  // Inmediato 10'b0000001100
        ImmSrc = 2'b00; 
        #10;  // Esperar 10 unidades de tiempo

        // Caso 2: Inmediato de 16 bits (ImmSrc == 01)
        In = 34'b0000000000000000000011001100110011;  // Inmediato 16'b1100110011001100
        ImmSrc = 2'b01;
        #10;  // Esperar 10 unidades de tiempo

        // Caso 3: Inmediato corto de 2 bits (ImmSrc == 10)
        In = 34'b00000000000000000000000000000000011;  // Inmediato 2'b11
        ImmSrc = 2'b10;
        #10;  // Esperar 10 unidades de tiempo

        // Caso 4: Valor por defecto (ImmSrc no coincide)
        In = 34'b0000000000000000000000000000001100;  // Inmediato 10'b0000001100
        ImmSrc = 2'b11;  // Ninguna extensión
        #10;  // Esperar 10 unidades de tiempo

        // Finalizar simulación
        $finish;
    end

endmodule
