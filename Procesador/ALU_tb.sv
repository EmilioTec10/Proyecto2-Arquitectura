module ALU_tb;

  // Entradas del testbench
  reg [17:0] A;
  reg [17:0] B;
  reg [1:0] ALUControl;
  
  // Salidas de la ALU
  wire [17:0] Result;
  wire OverFlow;
  wire Carry;
  wire Zero;
  wire Negative;

  // Instanciación de la ALU
  ALU uut (
    .A(A),
    .B(B),
    .ALUControl(ALUControl),
    .Result(Result),
    .OverFlow(OverFlow),
    .Carry(Carry),
    .Zero(Zero),
    .Negative(Negative)
  );

  // Inicialización de la simulación
  initial begin
    // Generar el archivo VCD para ver las señales en simulación
    $dumpfile("tb_ALU.vcd");
    $dumpvars(0, ALU_tb);

    // Prueba de suma (ALUControl = 2'b00)
    A = 18'd10; B = 18'd5; ALUControl = 2'b00;
    #10;
    $display("Suma: A = %d, B = %d, Result = %d, Carry = %b, Zero = %b, OverFlow = %b, Negative = %b", A, B, Result, Carry, Zero, OverFlow, Negative);
    
    // Prueba de resta (ALUControl = 2'b01)
    A = 18'd20; B = 18'd20; ALUControl = 2'b01;
    #10;
    $display("Resta: A = %d, B = %d, Result = %d, Carry = %b, Zero = %b, OverFlow = %b, Negative = %b", A, B, Result, Carry, Zero, OverFlow, Negative);
    
    // Prueba de multiplicación (ALUControl = 2'b10)
    A = 18'd4; B = 18'd3; ALUControl = 2'b10;
    #10;
    $display("Multiplicacion: A = %d, B = %d, Result = %d, Carry = %b, Zero = %b, OverFlow = %b, Negative = %b", A, B, Result, Carry, Zero, OverFlow, Negative);

    // Prueba de división (ALUControl = 2'b11)
    A = 18'd20; B = 18'd5; ALUControl = 2'b11;
    #10;
    $display("Division: A = %d, B = %d, Result = %d, Carry = %b, Zero = %b, OverFlow = %b, Negative = %b", A, B, Result, Carry, Zero, OverFlow, Negative);

    // Casos límite - Overflow y Carry
    // Prueba con números grandes para verificar Overflow y Carry
    A = 18'h3FFFF; B = 18'h3FFFF; ALUControl = 2'b00; // Suma grande
    #10;
    $display("Suma grande (Overflow y Carry): A = %h, B = %h, Result = %h, Carry = %b, Zero = %b, OverFlow = %b, Negative = %b", A, B, Result, Carry, Zero, OverFlow, Negative);
    
    // Resta con un número negativo
    A = 18'h1FFFF; B = 18'h20000; ALUControl = 2'b01; // Resta que genera un número negativo
    #10;
    $display("Resta con negativo: A = %h, B = %h, Result = %h, Carry = %b, Zero = %b, OverFlow = %b, Negative = %b", A, B, Result, Carry, Zero, OverFlow, Negative);

    // Prueba de división por 0 (B = 0)
    A = 18'd50; B = 18'd0; ALUControl = 2'b11;
    #10;
    $display("Division por cero: A = %d, B = %d, Result = %d, Carry = %b, Zero = %b, OverFlow = %b, Negative = %b", A, B, Result, Carry, Zero, OverFlow, Negative);
    
    // Fin de la simulación
    $finish;
  end

endmodule
