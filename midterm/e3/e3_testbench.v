module e3_testbench();
logic [23:0] a;
logic [23:0] b;
logic [23:0] r;
logic [1:0] op;

initial begin
    $dumpfile("e3_testbench.vcd");
    $dumpvars(0, e3_testbench);
//test different opcodes 
    /* op == 0 */
    op = 0;
    #1
    a = 15;
    b = 7;
    assert(r == 16) else $fatal(1, "failed");

    /* op == 1 */
    op = 1;
    #1
    a = 11;
    b = 13;
    assert(r == 9);

    /* op == 2 */
    op = 2;
    #1
    a = 6;
    b = 24;
    assert(r == 0);

    op = 2;
    #1
    a = 6;
    b = 2;
    assert(r == 24'h000001);

    /* op == 3 */
    op = 3;
    #1
    a = 12;
    b = 30;
    assert(r == 0);
    
    op = 3;
    #1
    a = 7;
    b = 5;
    assert(r == 24'h0000E0);

    $display("pass.");

end

//initiation
     alu alu(
         .a(a),
         .b(b),
         .r(r),
         .op(op)
    );

endmodule
