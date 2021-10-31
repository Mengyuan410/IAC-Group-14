//we get a success code if all test case passes.

module e3_testbench(
);
    logic itype;
    logic rtype;
    logic jtype;
    logic[5:0] opcode;
    logic clk;

//we know rtype of format 00000
// jtype is of 0001X
// itype is of XXXXX 

    initial begin
        $dumpvars(0,e3_testbench);
        
        opcode = 6'b000000; //this corresponds to r-type instruction
        #1
        assert(rtype == 1);// hence this is true whilst below false
        assert(jtype == 0);
        assert(itype == 0);
        
        opcode = 6'b000010;
        #1
        assert(jtype == 1);
        assert(rtype == 0);
        assert(itype == 0);
        
        opcode = 6'b100010;
        #1
        assert(itype == 1);
        assert(rtype == 0);
        assert(jtype == 0);
        
        opcode = 6'b010011;
        #1
        assert(itype == 1);//this is a same test for itype
        assert(rtype == 0);
        assert(jtype == 0);

       

        opcode = 6'b000011;
        #1
        assert(jtype == 1);// just running a final testcase on the J.
        assert(rtype == 0);
        assert(itype == 0);
 

    end
    opcode_decoder test(
        .itype(itype),
        .rtype(rtype),
        .jtype(jtype),
        .opcode(opcode)
    );
endmodule
/*






*/