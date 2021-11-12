module e7_tb(
);
    logic clk;
    logic[31:0] a, b;
    logic[63:0] r;
    logic valid_in, valid_out;

    initial begin
        $dumpfile("multiplier_iterative.vcd");
        $dumpvars(0, e7_tb);
        clk = 0;

        #5;

        repeat (100000) begin
            #10 clk = !clk;
        end

        $fatal(2, "Fail : test-bench timed out without positive exit.");
    end

    initial begin
        a = 0;
        b = 0;

         repeat (100) begin
            @(posedge clk);
            #1;
            valid_in = 1;

            @(posedge clk);
            #1;
            valid_in = 0;
// this is used to renew the valid_in variable
            while (valid_out==0) begin
                @(posedge clk);
                #1;
// it is used to wait for the outcome of the output. coz it takes 32 cycles to get the result. 
            end
            $display("a=%d, b=%d, r=%d,  time=%t", a, b, r, $time);

            a = a+1;
            b = b+1;
        end

        repeat (100) begin
            @(posedge clk);
            #1;
            valid_in = 1;

            @(posedge clk);
            #1;
            valid_in = 0;

            while (valid_out==0) begin
                @(posedge clk);
                #1;
            end
            $display("a=%d, b=%d, r=%d", a, b, r);
            assert(a*b == r); //else $fatal(1, "Product is wrong.");
// to check the result.
            a = a+32'h23456789;
            b = b+32'h34567891;
        end

        $display("Finished. Total time = %t", $time);
        $finish;
    end

    multiplier m(
        .clk(clk),
        .valid_in(valid_in), .valid_out(valid_out),
        .a(a), .b(b), .r(r)
    );
endmodule
