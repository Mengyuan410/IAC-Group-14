module opcode_decoder(
    input logic[5:0] opcode,   
    output logic itype,
    output logic rtype,
    output logic jtype
);
  
    always @(*) begin
        if(opcode == 6'b000000) begin
            rtype = 1;
            jtype = 0;
            itype = 0;
        end
        else if(opcode == 6'b000010 || opcode ==6'b000011) begin
            jtype = 1;
            rtype = 0;
            itype = 0;
        end
        else begin
            itype = 1;
            rtype = 0;
            jtype = 0;
        end
    end
endmodule