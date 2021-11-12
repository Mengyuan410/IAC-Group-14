
module invert_tb();
    logic[7:0] x,y;
    logic clk,start;

    initial begin
        $dumpfile("invert.vcd");
        $dumpvars(0, invert_tb);
        start = 1;
        clk = 0;
        #1
        clk = 1;
        #1
        start = 0;
        clk = 0;
        #1
        y = 8;
        repeat (1000) begin
            clk = 1;  
            #1;
            clk = 0;  
            #1;
        end
        $display(x);
        // assert(i==50);
        
    end

    /* Check output of test-bench */
    initial begin
        @(posedge clk);

        repeat (256) begin
            @(posedge clk)
            // Collect output 1ns after clock edge
            #1;
            $display(x,y);
        end
    end

    invert s(
        .clk(clk),
        .start(start),
        .x(x),
        .y(y)
    );
endmodule
