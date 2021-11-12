module bor(
    input logic a,
    input logic b,
    output logic r
);
    always @(*) begin
        if (a==0 & b ==0) begin
            r = 0;
        end
        else begin
            r = 1;
        end
    end
endmodule