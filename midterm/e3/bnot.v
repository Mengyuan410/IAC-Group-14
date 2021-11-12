module bnot(
    input logic a,
    output logic r
);
    always @(*) begin
        if (a==1) begin
        r = 0;
        end
        else begin
        r = 1;
        end
    end
endmodule