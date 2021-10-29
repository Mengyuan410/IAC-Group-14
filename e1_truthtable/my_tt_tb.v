module my_tt_tb(
);
    logic [2:0] a;
    logic [3:0] b;
    logic x;
    logic [2:0] y;

    initial begin
        $dumpfile("my_tt.vcd");
		$dumpvars(0,my_tt_tb);
      
		a = 3'b111;
		b = 4'b0010;
		x = 1;
		#1
		assert(y==2);
		//checking the logical truth last else if

		a = 3'b100;
		b = 1;
		x = 0;
		#1
		assert(y == 3);
		//1st test case
		a = 3'b011;
		b = 4'b0001;
		#1
		assert(y == 2);//check y is 2 for test case
	
		b = 4;
		x = 1;
		#1
		assert(y == 0);
		
		a = 3'b000;
		#1
		assert(y==1);
		//testing the final else cond.

    end 

	el_truthtable e(
        .a(a),
		.b(b),
		.x(x),	
		.y(y)
    );
	
endmodule


	



