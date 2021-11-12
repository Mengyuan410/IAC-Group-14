module accumulator(
    input logic clk,
    input logic clear,
    input logic[31:0] up,
    input logic[31:0] down,
    output logic[31:0] sum
);
    logic [30:0] acc;
    //another suspected error.
    //want mod 2^32 [31:0] means 2^32 -1 
    //we might need to consider the situation when it is unsigned number
    always_ff @(posedge clk) begin 
        if ( clear ) begin
            acc <= up - down;
            //if it is clear the sum should be 0
        end else if ( up ) begin 
            acc <= acc + up;
        end else if ( down ) begin 
            acc <= acc - down;
        end
    end

    assign sum = acc;
endmodule
