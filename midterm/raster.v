module raster(
    input logic clk,
    input logic reset,
    output logic[3:0] x,
    output logic[3:0] y
);

    logic start;
    logic i, j;

    // do i need to build a clock here


    always @(posedge clk) begin
        if (reset == 1) begin
            #2; // how do we allow one cycle delay first
            if (reset == 0) begin
                for (i = 0; i <= 11; i=i+1) begin
                    for (j = 0; j <= 11; j=j+1) begin
                        x = j;
                        y = i;  
                    end
                end
            end
        end

        else begin // if always reset = 1 then reset to x=0, y=0
            x = 0;
            y = 0;
        end
    end

endmodule