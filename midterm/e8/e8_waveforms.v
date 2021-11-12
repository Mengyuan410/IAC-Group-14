module e8_waveforms();
    logic[11:0] a,b,x,y;
    assign x = y+1;
    initial begin
        $dumpfile("e8_waveforms.vcd");
        $dumpvars(0,e8_waveforms);
        y = 0;
        repeat(4096)begin
            #1;
            $display("x=%d,y=%d",x,y);
            #1;
            y = y+1;
        end
    end
    f f1(
        .x(x),
        .y(y),
        .a(a),
        .b(b)
    );
endmodule