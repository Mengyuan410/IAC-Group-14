module regfile (
    input logic clk,
    input logic[1:0]    read_a_index,
    output logic[31:0]  read_a_data,
    input logic[1:0]    read_b_index,
    output logic[31:0]  read_b_data,
    input logic[1:0]    write_index,
    input logic         write_enable,
    input logic[31:0]   write_data
);
    logic[31:0] regs[3:0];
    always_comb begin
        case(read_a_index)
            0:  read_a_data = 0;
            1:  read_a_data = regs[1];
            2:  read_a_data = regs[2];
            3:  read_a_data = regs[3];
            endcase
        case(read_b_index)
            0:  read_b_data = 0;
            1:  read_b_data = regs[1];
            2:  read_b_data = regs[2];
            3:  read_b_data = regs[3];
            endcase
        
    end

    always @(posedge clk)begin
        if(write_enable)begin
            if(write_index == 0)begin
                $display("cannot write into reg0");
            end
            else begin
                regs[write_index] <= write_data;
            end
        end
    end

endmodule