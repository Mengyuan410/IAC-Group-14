module rg_tb (
);
logic clk, write_enable;
logic[1:0] read_a_index,read_b_index,write_index;
logic[31:0] read_a_data, read_b_data, write_data;

initial begin
    clk = 0;
    repeat(1000)begin
        #5
        clk = !clk;
    end
end


initial begin
    @(negedge clk)begin
        write_index = 1;
        write_data = 45;
        write_enable = 1;
    end
    @(posedge clk);
    @(negedge clk)begin
        read_a_index = 1;
        read_b_index = 2;
        write_index = 2;
        write_data = 47;
        write_enable = 1;
    end
    @(posedge clk);
    @(posedge clk);
    $display("aport = %d, bport = %d", read_a_data, read_b_data);
    $finish;
end
regfile test (
    .clk(clk),
    .read_a_index(read_a_index),
    .read_a_data(read_a_data),
    .read_b_index(read_b_index),
    .read_b_data(read_b_data),
    .write_index(write_index),
    .write_enable(write_enable),
    .write_data(write_data)
);

endmodule