module Mux (a,b,s,c);

    input [19:0]a,b;
    input s;
    output [19:0]c;

    assign c = (~s) ? a : b ;
    
endmodule

module Mux_3_by_1 (a,b,c,s,d);
    input [19:0] a,b,c;
    input [1:0] s;
    output [19:0] d;

    assign d = (s == 2'b00) ? a : (s == 2'b01) ? b : (s == 2'b10) ? c : 19'h00000000;
    
endmodule