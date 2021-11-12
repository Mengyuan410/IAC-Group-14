module mul2x2_tb (
);

//this is a simple testbench
logic [1:0] a;
logic [1:0] b;
logic [3:0] r;

initial begin
    a = 2;
    b = 0;
    #5
    assert (r == 0) else $fatal(0, "r = %d", r);
    
    $display("a = %d, b = %d, r = %d", a, b, r);
    a = 3;
    b = 3;
    #5
    assert (r == 4'h9) else $fatal(0, "r = %d", r);
    $display("a = %d, b = %d, r = %d", a, b, r);
    a = 1;
    b = 2;
    #5
    assert (r == 4'h2) else $fatal(0, "r = %d", r);
    $display("a = %d, b = %d, r = %d", a, b, r);

end

mul2x2 dut(
    .a(a),
    .b(b),
    .r(r)
);

endmodule