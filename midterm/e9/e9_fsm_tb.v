module e9_fsm_tb();
    logic clk,reset;
    logic orange,red,green;
    initial begin
        $dumpfile("e9_fsm_tb.vcd");
        $dumpvars(0, e9_fsm_tb);

        clk=0;
        #5;

        clk=1;
        #1
        reset=1;
        #5

        clk=0;
        #5

        clk=1;
        #1
        reset=0;
        #5;

        clk=0;
        
        repeat(100)begin
            #5;
            clk = !clk;
        end
    end

    traffic t1(
        .clk(clk),
        .reset(reset),
        .orange(orange),
        .red(red),
        .green(green)
    );
    
endmodule