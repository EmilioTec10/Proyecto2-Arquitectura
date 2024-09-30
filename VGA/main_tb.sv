module tb_main;

  // Entradas
  reg clock_50;

  // Salidas
  wire [7:0] red_out;
  wire [7:0] green_out;
  wire [7:0] blue_out;
  wire hsync;
  wire vsync;
  wire n_blank;
  wire vgaclock;

  // Instancia del módulo 'main'
  main uut (
    .clock_50(clock_50),
    .reset(1'b0),        // Reset deshabilitado
    .start(1'b0),        // Start deshabilitado
    .red_out(red_out),
    .green_out(green_out),
    .blue_out(blue_out),
    .hsync(hsync),
    .vsync(vsync),
    .n_blank(n_blank),
    .vgaclock(vgaclock)
  );

  // Generador de reloj
  always begin
    #10 clock_50 = ~clock_50; // Generar un ciclo de reloj de 50 MHz (20 ns de periodo)
  end

  // Bloque inicial
  initial begin
    // Inicializa señales
    clock_50 = 0;
    
    // Simulación durante algunos ciclos
    #1000;  // Corre la simulación por 1000 ns

    // Finalizar simulación
    $finish;
  end

  // Monitor para observar los valores de las salidas
  initial begin
    $monitor("Time=%0t | Red=%h, Green=%h, Blue=%h, HSync=%b, VSync=%b, n_Blank=%b, VGAClock=%b",
             $time, red_out, green_out, blue_out, hsync, vsync, n_blank, vgaclock);
  end

endmodule
