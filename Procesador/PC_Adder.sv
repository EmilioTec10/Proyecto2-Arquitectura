module PC_Adder(a,b,c);

    input [8:0]a,b;
    output [8:0]c;

    assign c = a + b;
    
endmodule


module PC_Adder_24b(a,b,c);

    input [23:0]a,b;
    output [23:0]c;

    assign c = a + b;
    
endmodule