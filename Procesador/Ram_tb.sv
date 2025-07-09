module Ram_tb;

    reg [17:0] address;
    reg clock;
    reg [23:0] data;
    reg wren;
    reg [2:0] byteena;
    wire [23:0] q;
		timeunit 1ps;
    // Instancia del módulo Ram
    Ram dut (
        .address(address),
        .clock(clock),
        .data(data),
        .wren(wren),
        .byteena(byteena),
        .q(q)
    );

    // Generación del reloj
    always #5 clock = ~clock;

    initial begin
        // Inicialización de señales
        clock = 0;
        wren = 0;
        address = 18'h00000;
        data = 24'h000000;
        byteena = 3'b000;

        // Esperar un ciclo de reloj
        #10;

        // Prueba 1: Escribir en los bits 23-16 (primer bloque)
        address = 18'h00001;
        data = 24'hFF0000; // Datos a escribir: 0xFF en los bits 23-16
        byteena = 3'b100;  // Habilitar escritura en los bits 23-16
        wren = 1;
        #10;
        wren = 0;
        #10;
        
        // Leer y verificar
        $display("Prueba 1: Dirección = %h, Data = %h, Byteena = %b, Salida = %h", address, data, byteena, q);

        // Prueba 2: Escribir en los bits 15-8 (segundo bloque)
        address = 18'h00002;
        data = 24'h00FF00; // Datos a escribir: 0xFF en los bits 15-8
        byteena = 3'b010;  // Habilitar escritura en los bits 15-8
        wren = 1;
        #10;
        wren = 0;
        #10;
        
        // Leer y verificar
        $display("Prueba 2: Dirección = %h, Data = %h, Byteena = %b, Salida = %h", address, data, byteena, q);

        // Prueba 3: Escribir en los bits 7-0 (tercer bloque)
        address = 18'h00003;
        data = 24'h0000FF; // Datos a escribir: 0xFF en los bits 7-0
        byteena = 3'b001;  // Habilitar escritura en los bits 7-0
        wren = 1;
        #10;
        wren = 0;
        #10;
        
        // Leer y verificar
        $display("Prueba 3: Dirección = %h, Data = %h, Byteena = %b, Salida = %h", address, data, byteena, q);

        // Prueba 4: Escribir en todos los bloques
        address = 18'h00004;
        data = 24'hABCDEF; // Datos a escribir: 0xAB en bits 23-16, 0xCD en bits 15-8, 0xEF en bits 7-0
        byteena = 3'b111;  // Habilitar escritura en todos los bloques
        wren = 1;
        #10;
        wren = 0;
        #10;
        
        // Leer y verificar
        $display("Prueba 4: Dirección = %h, Data = %h, Byteena = %b, Salida = %h", address, data, byteena, q);
			
		  // Prueba de escritura de 24 bits completos
		 address = 18'h00001;
		 data = 24'hABCDEF; // Datos a escribir: 0xAB en bits 23-16, 0xCD en bits 15-8, 0xEF en bits 7-0
		 byteena = 3'b111;  // Habilitar escritura en todos los bloques de 8 bits
		 wren = 1;
		 #10;
		 wren = 0; // Desactivar wren después de la escritura
		 #10;
		 
		 // Leer y verificar el valor escrito
		 $display("Escritura completa: Dirección = %h, Data = %h, Byteena = %b, Salida = %h", address, data, byteena, q);
			
        // Fin de la simulación
        $finish;
    end

endmodule
