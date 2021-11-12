module alu(
    input logic [23:0] a,
    input logic [23:0] b,
    output logic [23:0] r,
    input logic [1:0] op
);
    always_comb begin
        case(op)
        0: begin r = a + b; end
        1: begin r = a&b; end
        2: begin r = (b > 23) ? 0 : a >> b; end
        3: begin r = (b > 23) ? 0 : a << b; end 
        endcase 
    end

endmodule