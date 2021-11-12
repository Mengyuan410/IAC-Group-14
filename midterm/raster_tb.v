module raster_tb();
    logic clk;
    logic reset;
    logic[3:0] x, y;

    raster ras(
        .clk(clk),
        .reset(reset),
        .x(x),
        .y(y)
    );

    initial begin
        reset = 1;
        clk = 0;
        #1;
        clk = 1;
        #1;
        reset = 0;
        clk = 0;
        #1;

        repeat(100) begin
            clk = ~clk;
            #1;
            clk = ~clk;
            #1;
        end

        $display ("%d, %d", x, y);

    end
endmodule


