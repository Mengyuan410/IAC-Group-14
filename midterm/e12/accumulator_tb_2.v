module accumulator_tb_2 (
);
/*this testbench is used to test the error when the sum is going 
 out of range*/
logic clk, clear;
logic[31:0] up, down, sum;
initial begin
    clk = 0;
    repeat(1000)begin
        #5
        clk = !clk;
    end
end

initial begin
    //let it be 
    @(negedge clk)begin
        clear = 1;
        up = 8;
        down = 8;
        //here we change the sum to 0;
    end
    @(posedge clk);
    @(negedge clk)begin
        clear = 0;
        up = 5;
        down = 15;
    end
    //the accumulator did not consider the negative condition
    @(posedge clk);
    @(posedge clk);
    assert(sum == -10) else $fatal(1, "wrong");

    @(negedge clk)begin
        clear = 1;
        up = 8;
        down = 8;
        //here we change the sum to 0 again;
    end
    @(posedge clk);
    @(negedge clk)begin
        clear = 0;
        up = 32'hFFFFFFFF;
        down = 0;
    end
    @(posedge clk);
    @(posedge clk);
    assert(sum == 32'hFFFFFFFF) else $fatal(1, "wrong2");


    $finish;
end

accumulator acc(
    .clk(clk),
    .clear(clear),
    .up(up),
    .down(down),
    .sum(sum)
);
    
endmodule