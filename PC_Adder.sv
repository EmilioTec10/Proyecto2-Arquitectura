module PC_Adder (a,b,c);

    input [19:0]a,b;
    output [19:0]c;

    assign c = a + b;
    
endmodule