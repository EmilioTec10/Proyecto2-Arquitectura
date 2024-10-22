module PC_Adder(a,b,c);

    input [8:0]a,b;
    output [8:0]c;

    assign c = a + b;
    
endmodule


module PC_Adder_18b(input [8:0] a,
						input [8:0]b,
						input PCsrc,
						output [8:0] c);

 

	 assign c =(PCsrc== 1'b0)? a + b : a - b ;
	 
    
endmodule
