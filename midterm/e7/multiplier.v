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
    
    assign mp_next = ((valid_in ==1) ? a : ((i <= 7) ? mp>>4 : mp_next));
    assign mc_next = ((valid_in ==1) ? b : ((i <= 7) ? mc<<4 : mc_next));
    assign acc_next = ((valid_in ==1) ? 0 : ((i <= 7) ? acc + mp_nibble * mc : acc_next));
    assign i_next = ((valid_in ==1) ? 0 : ((i <= 7) ? ((mp == 0) ? 8 : i + 1) : i_next));

    initial begin
        repeat(10000) begin
            @(posedge clk);
                mp <= mp_next;
                mc <= mc_next;
                acc <= acc_next;
                i <= i_next;
            
                if (i_next==8) begin
                    r <= acc_next;
                    valid_out <= 1;
                end
                else begin
                    r <= r;
                    valid_out <= 0;
                end
        end
    end
    
endmodule
