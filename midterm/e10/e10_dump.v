module e10_dump (
);
logic [7:0] word_address;
logic[31:0] value_out;
logic clk;
logic [7:0] value0, value1, value2, value3;
logic[9:0] byte_add, byte_add0, byte_add1, byte_add2, byte_add3;

initial begin
    word_address = 0;
    repeat(255)begin
        #5
        word_address += 1;
    end
end

always @(*) begin
    value0 = value_out[7:0];
    value1 = value_out[15:8];
    value2 = value_out[23:16];
    value3 = value_out[31:24];
    byte_add = word_address << 2;
    byte_add0 = byte_add;
    byte_add1 = byte_add + 1;
    byte_add2 = byte_add + 2;
    byte_add3 = byte_add + 3;
    $display("rom[",byte_add0,"]=",value0);
    $display("rom[",byte_add1,"]=",value1);
    $display("rom[",byte_add2,"]=",value2);
    $display("rom[",byte_add3,"]=",value3);
end

rom r(
    .word_address(word_address),
    .data(value_out)
);

endmodule