
module mul16(
    input clk,
    input logic[15:0] a,
    input logic[15:0] b,
    output logic[31:0] r
);
    // logic [7:0] aLow, aHigh, bLow, bHigh;
    logic [15:0] aLow_bLow, aHigh_bLow, aLow_bHigh, aHigh_bHigh;
    logic [16:0] aHbL_add;
    logic [31:0] temp_r, temp1, temp2;
    
    assign aHbL_add=aHigh_bLow + aLow_bHigh;

    always @(*) begin
        // aLow = (a & 16'h00FF); 
        // aHigh = (b & 16'hFF00) >> 8; 
        // bLow = (a & 16'h00FF); 
        // bHigh = (b & 16'hFF00) >> 8; 
        // temp1 = ;
        // temp2 = mHigh_nHigh << 16;
        temp_r = { 16'h0000, aLow_bLow } + {7'b0000000,aHbL_add,8'h00} + {aHigh_bHigh,16'h0000};
        //$display("a = %d", a);
        //$display("b = %d" , b);
        //$display("albl = %d", aLow_bLow);
        //$display("ahbl = %d", aHigh_bLow);
        //$display("albh = %d", aLow_bHigh);
        //$display("ahbh = %d", aHigh_bHigh);
    end

    mul8 mul1(.clk(clk), .a(a[7:0]), .b(b[7:0]), .r(aLow_bLow));
    mul8 mul2(.clk(clk), .a(a[15:8]), .b(b[7:0]), .r(aHigh_bLow));
    mul8 mul3(.clk(clk), .a(a[7:0]), .b(b[15:8]), .r(aLow_bHigh));
    mul8 mul4(.clk(clk), .a(a[15:8]), .b(b[15:8]), .r(aHigh_bHigh));

    always_ff  @(posedge clk) begin
        r <= temp_r;
    end


endmodule