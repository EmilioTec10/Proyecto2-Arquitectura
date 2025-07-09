module fetch_cycle_tb;

    // Señales del banco de pruebas
    logic clk, rst, PCSrcE, StallF;
    logic [8:0] PCTargetE;
    logic [32:0] InstrD;
    logic [8:0] PCD, PCPlus4D;
		
		
	  timeunit 1ps;
    // Instancia del módulo bajo prueba (DUT)
    fetch_cycle uut (
        .clk(clk),
        .rst(rst),
        .PCSrcE(PCSrcE),
        .PCTargetE(PCTargetE),
        .StallF(StallF),
        .InstrD(InstrD),
        .PCD(PCD),
        .PCPlus4D(PCPlus4D)
    );

    // Reloj de 10 ns de período
    always #5 clk = ~clk;

    // Inicialización de señales y generación de estímulos
    initial begin
        // Inicializar señales
        clk = 0;
        rst = 0;
        PCSrcE = 0;
        PCTargetE = 9'h0;
        StallF = 0;

        // Generar una señal de reinicio
        #10 rst = 1;  // Desactivar reinicio después de 10 ns
        #10 rst = 0;
        #10 rst = 1;  // Habilitar el módulo después de reiniciar

        // Simular varios ciclos de reloj para observar el comportamiento normal
        repeat (10) @(posedge clk);

        // Probar la señal de StallF
        StallF = 1;
        repeat (5) @(posedge clk);
        StallF = 0;
        @(posedge clk);

        // Probar la señal de PCSrcE
        PCSrcE = 1;
        PCTargetE = 9'h10; // Cambiar la dirección objetivo
        @(posedge clk);
        PCSrcE = 0;

        // Esperar unos ciclos adicionales para observar el comportamiento final
        repeat (10) @(posedge clk);

        // Finalizar la simulación
        $finish;
    end

    // Monitorear las señales de salida
    initial begin
        $monitor("Time=%0t | rst=%b | PCSrcE=%b | StallF=%b | PCTargetE=%h | InstrD=%h | PCD=%h | PCPlus4D=%h", 
                 $time, rst, PCSrcE, StallF, PCTargetE, InstrD, PCD, PCPlus4D);
    end

endmodule
