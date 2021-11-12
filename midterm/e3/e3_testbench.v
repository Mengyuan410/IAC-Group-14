module e3_testbench();
logic [23:0] a;
logic [23:0] b;
logic [23:0] r;
logic [1:0] op;
logic [23:0] tmp;

initial begin
    $dumpfile("e3_testbench.vcd");
    $dumpvars(0, e3_testbench);
//test different opcodes 
    /* op == 0 */
    op = 0;
    #1
    a = 15;
    b = 7;
    #5
    assert (r == 22) else $fatal(0, "failed, r = %d", r);
   
    /* op == 1 */
    op = 1;
    #1
    a = 11;
    b = 13;
    #5
    


    /* op == 2 */
    op = 2;
    #1
    a = 6;
    b = 24;
    #5
    assert (r == 0) else $fatal(0, "failed, r = %d", r);
    

    op = 2;
    #1
    a = 6;
    b = 2;
    #5
    assert (r == 24'h000001) else $fatal(0, "failed, r = %d", r);
    
    /* op == 3 */
    op = 3;
    #1
    a = 12;
    b = 30;
    #5
    assert (r == 0) else $fatal(0, "failed, r = %d", r);
    
    
    op = 3;
    #1
    a = 7;
    b = 5;
    #5
    assert (r == 24'h0000E0) else $fatal(0, "failed, r = %d", r);
    
    
    $display("pass.");
    $finish;

end

//initiation
    alu alu1(
        .a(a),
        .b(b),
        .r(r),
        .op(op)
    );

endmodule
