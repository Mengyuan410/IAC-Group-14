module my_fadd1(
    input logic a,
    input logic b,
    input logic carry_in
    output logic sum,
    output logic carry_out
    
);
    logic hold_vals[2:0]; #my implementation
    hold_vals[0] = bxor(a,b);
    sum = xor(hold_vals[0],carry_in);
    hold_vals[1] = bxor(carry_in,hold_vals[0]);
    hold_vals[2] = band(a,b);//not entirely sure this works but oh well. 
    carry_out = bor(a,b);
endmodule


    

    