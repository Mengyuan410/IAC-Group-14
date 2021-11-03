module fadd4();
    logic[3:0] a;
    logic[3:0] b;
    logic[3:0] sum;
    logic interm_carry;
    logic interim_val;

   my_fadd my_fadd0(a[0],b[0],0,sum[0],interim_carry);
   my_fadd my_fadd1(a[1],b[1],interim_carry,sum[1],interim_carry);
   my_fadd my_fadd2(a[2],b[2],interim_carry,sum[2],interim_carry);
   //we now have sorted 3 bits of the o/p.
   //still have another bit that we need to worry about.
   my_fadd my_fadd3(a[3],b[3],interim_carry,sum[3],interim_carry);// my hope is this will work. 
   // this is how I think the implementation works though I'm unsure. 
endmodule





    


/*
module my_fadd1(
    input logic a,
    input logic b,
    input logic carry_in
    output logic sum,
    output logic carry_out
    
);*/