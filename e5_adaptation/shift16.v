module shift16(
    /*The shifter 
    should take a 1-bit clock clk, 
    a 16-bit input a, a 4-bit 
    input distance, and produce 
    a 16-bit result r,
    */
    input logic clk,
    input logic[15:0] a,
    input logic[4:0] distance,// we shift by how many we want
    output logic[15:0] r    
);
    logic[15:0] temp_multiplier = 2**distance;
    mul mul16(.clk(clk),.a(a),.b(temp_multiplier),.r(r));
endmodule

