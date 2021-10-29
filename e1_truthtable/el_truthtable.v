module el_truthtable(
    input logic[2:0] a,
    input logic[3:0] b,
    input logic x,
    output logic[2:0] y
);
// what this does is instantiate a simple truthtable. 
// We have an output logic y gate which can contain the o/ps

    always @(*) begin
        if (a == 3'b100 && b==1 && x == 0) begin
            y = 3;//on this
        end
        else if (a == 3'b001 || a==3'b011) begin
           if (b == 1 && x == 0) begin
                 y = 2;
            end
           else if (b == 4 && x == 1) begin
                 y = 0;
           end
        end
        else if(&a && b == 2 && x==1) begin
            y = 2;//
        end
        else begin //these conditions aren't defined by the truth table I assume we can assign them to a value of 1. 
            y = 1; //set the value of don't care to equal 1 for undefined cases
        end
    end
endmodule
    
