module ALU_tb;

  // Entradas del testbench
  reg [33:0] A;
  reg [33:0] B;
  reg [1:0] ALUControl;
  
  // Salidas de la ALU
  wire [33:0] Result;
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
    A = 34'd10; B = 34'd5; ALUControl = 2'b00;
    #10;
    $display("Suma: A = %d, B = %d, Result = %d, Carry = %b, Zero = %b, OverFlow = %b, Negative = %b", A, B, Result, Carry, Zero, OverFlow, Negative);
    
    // Prueba de resta (ALUControl = 2'b01)
    A = 34'd20; B = 34'd15; ALUControl = 2'b01;
    #10;
    $display("Resta: A = %d, B = %d, Result = %d, Carry = %b, Zero = %b, OverFlow = %b, Negative = %b", A, B, Result, Carry, Zero, OverFlow, Negative);
    
    // Prueba de multiplicación (ALUControl = 2'b10)
    A = 34'd4; B = 34'd3; ALUControl = 2'b10;
    #10;
    $display("Multiplicacion: A = %d, B = %d, Result = %d, Carry = %b, Zero = %b, OverFlow = %b, Negative = %b", A, B, Result, Carry, Zero, OverFlow, Negative);

    // Prueba de división (ALUControl = 2'b11)
    A = 34'd20; B = 34'd5; ALUControl = 2'b11;
    #10;
    $display("Division: A = %d, B = %d, Result = %d, Carry = %b, Zero = %b, OverFlow = %b, Negative = %b", A, B, Result, Carry, Zero, OverFlow, Negative);

    // Casos límite - Overflow y Carry
    // Prueba con números grandes para verificar Overflow y Carry
    A = 34'h3FFFFFFFF; B = 34'h3FFFFFFFF; ALUControl = 2'b00; // Suma grande
    #10;
    $display("Suma grande (Overflow y Carry): A = %h, B = %h, Result = %h, Carry = %b, Zero = %b, OverFlow = %b, Negative = %b", A, B, Result, Carry, Zero, OverFlow, Negative);
    
    // Resta con un número negativo
    A = 34'h7FFFFFFFF; B = 34'h800000000; ALUControl = 2'b01; // Resta que genera un número negativo
    #10;
    $display("Resta con negativo: A = %h, B = %h, Result = %h, Carry = %b, Zero = %b, OverFlow = %b, Negative = %b", A, B, Result, Carry, Zero, OverFlow, Negative);

    // Prueba de división por 0 (B = 0)
    A = 34'd50; B = 34'd0; ALUControl = 2'b11;
    #10;
    $display("Division por cero: A = %d, B = %d, Result = %d, Carry = %b, Zero = %b, OverFlow = %b, Negative = %b", A, B, Result, Carry, Zero, OverFlow, Negative);
    
    // Fin de la simulación
    $finish;
  end

endmodule