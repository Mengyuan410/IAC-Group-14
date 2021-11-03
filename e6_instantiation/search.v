/*
bool f(uint32_t x);
//returns a boolean
uint32_t search()
{
    uint32_t lo=0, hi=0x7FFFFFFFul;//lo is 0 whilst hi is 0x7fffffful
    while(lo+1 < hi){
        uint32_t mid=(lo+hi)/2; // overflow is not a problem as i<2^31
        bool v=f(mid);
        if(v){
            hi=mid;
        }else{
            lo=mid;
        }
    }
    return lo;
}*/

// we need to have a 32 bit input x

module search(
    input logic clk,
    input logic[31:0] lo,
    input logic[31:0] hi,
    output logic[31:0] fin_val    
);
    initial begin
        repeat(1000) begin
        clk = !clk;
        #1; 
    end

    end
    logic[31:0] mid;
    hi = h'7FFFFFFF;
    lo = h'00000000;

    for (i=0; i<hi;i++) begin
        mid = (lo+hi)/2;
        assign v = f(mid); //true on left and false on right
        if (v==1) begin
            hi = mid;
        end
        else begin
            lo = mid;
        end    
    end
    fin_val = lo;
    //don't know if we can specifically return lo/ need to return lo specifically.
    //lo is returned as fin_val not sure if permitted.
endmodule



