module invert(
    input logic clk,
    input logic start,
    input logic[7:0] y,
    output logic[7:0] x
);
    logic[7:0] x_inc, y_cal;

    always_ff @(posedge clk) begin
        if (start) begin
            x_inc <= 0;
        end
        else begin
            if(y_cal == y) begin
                x <= x_inc;
            end
            x_inc <= x_inc + 1;
        end
    end

    f f1(
        .x(x_inc),
        .y(y_cal)
    );
endmodule
