module rom (
    input logic[7:0] word_address,
    output logic[31:0] data 
);

logic [31:0] regs[7:0];
assign regs[0] = 32'hE3FF00CC;


assign data = regs[word_address];

    
endmodule