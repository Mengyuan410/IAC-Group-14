module f(
    input logic[7:0] x,
    output logic[7:0] y
);
    always @(*) begin
        // y = x + 8'b00000001;
        y=(x<<1)|(x>>7);
    end
endmodule
