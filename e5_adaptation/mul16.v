module mul16(
    input logic clk,
    input logic[15:0] a,
    input logic[15:0] b,
    output logic[15:0] r
);
    always @(posedge clk) begin:
       r <= a*b;
    end
endmodule