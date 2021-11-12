module accumulator_tb_1 (
);
/*this testbench is used to test the error when the 
clear is asserted the result is not equal to up - down*/
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
    @(negedge clk)begin
        clear = 1;
        up = 6;
        down = 8;
    end
    @(posedge clk);
    @(posedge clk);
    assert(sum == 0) else $fatal(1, "wrong");

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