module PC_Module(clk,rst,PC,PC_Next);
    input clk,rst;
    input [19:0]PC_Next;
    output [19:0]PC;
    reg [19:0]PC;

    always @(posedge clk)
    begin
        if(rst == 1'b0)
            PC <= {19{1'b0}};
        else
            PC <= PC_Next;
    end
endmodule