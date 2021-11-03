// my guess is I could replace with a better version of multiplier iterative
// namely multiplier_iterative_v3 would work. 
module multiplier(
    input clk,
    input logic valid_in,
    input logic[31:0] a,
    input logic[31:0] b,
    output logic valid_out,
    output logic[63:0] r
);
    logic[31:0] mp, mp_next;
    logic[63:0] mc, mc_next;
    logic[63:0] acc, acc_next;
    logic[5:0] i, i_next;

    logic[3:0] mp_nibble;

    assign mp_nibble = mp[3:0];

    always_comb begin
        assign mp_next = (valid_in==1) ? a : mp_next;
        assign mc_next = (valid_in==1) ? a : mc_next;
        assign acc_next = (valid_in==1) ? 0 : acc_next;
        assign i_next = (valid_in==1) ? 0 : i_next;

        assign acc_next = (i!=8) ? (acc+mp_nibble*mc) : acc_next;//I choose to keep these at original value
        assign mp_next = (i!=8) ? (mp>>4) : mp_next;
        assign mc_next = (i!=8) ? (mc<<4) : mc_next;
        assign i_next = (i!=8 && mp==0) ? 8 : i+1;
    end


    always_ff  @(posedge clk) begin
        mp <= mp_next;
        mc <= mc_next;
        acc <= acc_next;
        i <= i_next;

        assign r = (i_next==8) ? acc_next : r;//assign to acc_next or keep original value
        assign valid_out = (i_next==8) ? 1 : 0;
        
    end
endmodule
