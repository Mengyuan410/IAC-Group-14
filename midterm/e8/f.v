module f(
    input logic[11:0] x,
    input logic[11:0] y,
    output logic[11:0] a,
    output logic[11:0] b
);
    assign a = x-2;
    assign b = y-2;
endmodule