
module raster(
    input logic clk,
    input logic reset,
    output logic[3:0] x,
    output logic[3:0] y
);

    logic[3:0] x_next,y_next;
    

    // do i need to build a clock here

    always_comb begin
        if (reset == 1) begin
            x = 0;
            y = 0;
            x_next = 0;
            y_next = 0;
            
        end
        else begin
            if (x < 11) begin
                x_next = x + 1;
                y_next = y;
            end
            else if (y <11) begin 
                x_next = 0;
                y_next = y+1;
            end
        
        end
    end

    always_ff @(posedge clk) begin
        x <= x_next;
        y <= y_next;
        
    end
 

endmodule

   // always @(posedge clk) begin
    //     if (reset == 1) begin
    //         #2; // how do we allow one cycle delay first
    //     end
    //     if (reset == 0) begin
    //             for (i = 0; i <= 11; i=i+1) begin
    //                 for (j = 0; j <= 11; j=j+1) begin
    //                     x = j;
    //                     y = i;  
    //                 end
    //             end
    //     end

    //     else begin // if always reset = 1 then reset to x=0, y=0
    //         x = 0;
    //         y = 0;
    //     end
    // end