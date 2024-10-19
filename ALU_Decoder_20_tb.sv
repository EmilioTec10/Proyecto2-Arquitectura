module ALU_Decoder_20_tb;

    // Entradas del decodificador
    reg [1:0] ALUOp; // Control general de la operación
    reg [1:0] op;    // Operación específica

    // Salida del decodificador
    wire [2:0] ALUControl; // Señales de control de la ALU

    // Instancia del módulo bajo prueba (DUT)
    ALU_Decoder uut (
        .ALUOp(ALUOp),
        .op(op),
        .ALUControl(ALUControl)
    );

    // Procedimiento inicial
    initial begin
        // Imprimir título
        $display("Probando ALU_Decoder_20...");
        $display("ALUOp | op  -> ALUControl");

        // Test 1: Prueba de operación Suma (ALUOp = 00, op = 00)
        ALUOp = 2'b00; op = 2'b00;
        #10; // Esperar 10 unidades de tiempo
        $display("  %b   | %b ->  %b (Suma)", ALUOp, op, ALUControl);

        // Test 2: Prueba de operación Resta (ALUOp = 00, op = 01)
        ALUOp = 2'b00; op = 2'b01;
        #10;
        $display("  %b   | %b ->  %b (Resta)", ALUOp, op, ALUControl);

        // Test 3: Prueba de operación Multiplicación (ALUOp = 00, op = 10)
        ALUOp = 2'b00; op = 2'b10;
        #10;
        $display("  %b   | %b ->  %b (Multiplicación)", ALUOp, op, ALUControl);

        // Test 4: Prueba de operación División (ALUOp = 00, op = 11)
        ALUOp = 2'b00; op = 2'b11;
        #10;
        $display("  %b   | %b ->  %b (División)", ALUOp, op, ALUControl);

        // Test 5: Prueba de cuando ALUOp es diferente de 00 (ALU no debe hacer nada)
        ALUOp = 2'b01; op = 2'b00;
        #10;
        $display("  %b   | %b ->  %b (No operación aritmética)", ALUOp, op, ALUControl);

        ALUOp = 2'b10; op = 2'b01;
        #10;
        $display("  %b   | %b ->  %b (No operación aritmética)", ALUOp, op, ALUControl);

        ALUOp = 2'b11; op = 2'b10;
        #10;
        $display("  %b   | %b ->  %b (No operación aritmética)", ALUOp, op, ALUControl);

        // Finalizar la simulación
        $display("Pruebas completadas.");
        $finish;
    end

endmodule
