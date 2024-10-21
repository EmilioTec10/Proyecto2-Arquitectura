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
        #1000;
        $finish;    
		 end

    Pipeline_Top dut (.clk(clk), .rst(rst));
	
endmodule