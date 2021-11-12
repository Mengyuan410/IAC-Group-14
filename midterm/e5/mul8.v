
module mul8(
    input clk,
    input logic[7:0] a,
    input logic[7:0] b,
    output logic[15:0] r
);
    logic[15:0] r_temp;
    always @(*) begin
        r_temp = a*b;
    end

    always_ff  @(posedge clk) begin
        r <= r_temp;
    end
endmodule