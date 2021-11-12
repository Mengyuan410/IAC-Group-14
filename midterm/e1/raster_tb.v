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
        $dumpfile("raster_tb.vcd");
        $dumpvars(0,raster_tb);
        clk = 0;
        reset=1;
        #1

        clk=1;
        #1
        $display("reset= ",reset,"x= ",x," y= ", y);             

        clk=0;
        reset=0;
        #1
        
        clk=1;
        #1

        clk=0;

        repeat(143) begin
            $display("reset=",reset,", x=",x,", y=", y);            
            #1
            clk = 1;
            #1
            clk=0;
        end    
    end

    
endmodule
/*
- reset=1, x=?, y=?
- reset=0, x=?, y=?
- reset=0, x=0, y=0
- reset=0, x=1, y=0
- reset=0, x=2, y=0*/