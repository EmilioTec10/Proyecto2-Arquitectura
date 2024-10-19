module Mux (a,b,s,c);

    input [33:0]a,b;
    input s;
    output [33:0]c;

    assign c = (~s) ? a : b ;
    
endmodule

module Mux_3_by_1 (a,b,c,s,d);
    input [33:0] a,b,c;
    input [1:0] s;
    output [33:0] d;

    assign d = (s == 2'b00) ? a : (s == 2'b01) ? b : (s == 2'b10) ? c : 33'h00000000;
    
endmodule


module Mux_3_by_1_24b (a,b,c,s,d);
    input [23:0] a,b,c;
    input [1:0] s;
    output [23:0] d;

    assign d = (s == 2'b00) ? a : (s == 2'b01) ? b : (s == 2'b10) ? c : 23'h00000000;
    
endmodule

module Mux_24b (a,b,s,c);

    input [23:0]a,b;
    input s;
    output [23:0]c;

    assign c = (~s) ? a : b ;
    
endmodule

module Mux2Parametrizado #(parameter WIDTH = 18) (
    input [WIDTH-1:0] a, 
    input [WIDTH-1:0] b, 
    input s,
    output [WIDTH-1:0] c
);

    assign c = (~s) ? a : b;

endmodule

module Mux3Parametrizado #(parameter WIDTH = 18) (
    input [WIDTH-1:0] a, 
    input [WIDTH-1:0] b, 
    input [WIDTH-1:0] c, 
    input [1:0] s,
    output [WIDTH-1:0] d
);

    assign d = (s == 2'b00) ? a : 
               (s == 2'b01) ? b : 
               (s == 2'b10) ? c : 
               {WIDTH{1'b0}};
    
endmodule

