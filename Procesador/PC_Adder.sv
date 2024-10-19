module PC_Adder(a,b,c);

    input [8:0]a,b;
    output [8:0]c;

    assign c = a + b;
    
endmodule


module PC_Adder_18b(input [17:0] a,b,
						output [17:0] c);

    assign c = a + b;
    
endmodule