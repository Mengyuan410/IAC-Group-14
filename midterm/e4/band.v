module band(
    input logic a,
    input logic b,
    output logic r
);
    always @(*) begin
        if (a==1 & b ==1) begin
            r = 1;
        end
        else begin
            r = 0;
        end
    end
endmodule