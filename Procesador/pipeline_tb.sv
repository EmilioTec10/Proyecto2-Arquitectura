module pipeline_tb;

    reg clk=0, rst; 
	 
    timeunit 1ps;
	
    always begin
        clk = ~clk;
        #5;
    end

    initial begin
        rst <= 1'b0;
        #5;
        rst <= 1'b1;
        
        // Monitorear el contenido de la memoria RAM
        // Esto imprimirá el valor de Data_23 en cada ciclo de reloj
        $monitor("Time=%0t: Data_23=%h", $time, pipeline_tb.dut.Memory.Data_23);
        
        #1000;
        $finish;    
    end

    // Instancia del módulo Pipeline_Top
    Pipeline_Top dut (.clk(clk), .rst(rst));
	
endmodule
