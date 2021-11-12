module mul16_tb();
    logic clk;
    logic[15:0] a, a1, a2;
    logic[15:0] b, b1, b2;
    logic[31:0] r;

    initial begin
        $dumpfile("mul16.vcd");
        $dumpvars(0, mul16_tb);

        clk = 0;
        repeat(1000) begin
            #1;
            clk = ~clk;
        end
    end


    initial begin
        a = 60000;
        b = 50000;
        @(posedge clk);
        @(posedge clk);
        repeat (10) begin
            @(negedge clk)begin
                a = $urandom_range(0, 1024);
                b = $urandom_range(0, 1024);
            end
            @(posedge clk)
            #1;
            assert(r == (a2*b2)) else  $fatal(2, "a2 = %d, b2 = %d, r = %d", a2, b2, r);
            $display("a2 = %d, b2 = %d, r = %d", a2, b2, r);
        end

    end

    always_ff @(posedge clk) begin
        a1 <= a;
        a2 <= a1;
        b1 <= b;
        b2 <= b1;

    end

    mul16 m(
        .clk(clk),
        .a(a),
        .b(b),
        .r(r)
    );

endmodule