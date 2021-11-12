module traffic(
    input logic clk,
    input logic reset,
    output logic red,
    output logic orange,
    output logic green
);
    logic reset_1,count_red, count_green;

    always_ff @(posedge clk) begin
        reset_1 <= reset;
        if (reset_1 == 1 && reset == 0) begin
            red <= 1;
            orange <= 0;
            green <= 0;
            count_red <= 1;
            count_green <= 0;
        end
        else if (reset==0 && count_red==1 && red==1 && orange==0 && green==0) begin
            red <= 1;
            orange <= 0;
            green <= 0;
            count_red <= 0;
            count_green <= 0;
        end
        else if (reset==0 && count_red ==0 && red==1 && orange==0 && green==0)begin
            red <= 1;
            orange <= 1;
            green <= 0;
            count_red <= 0;
            count_green <= 0;
        end
        else if (reset==0 && red==1 && orange==1 && green==0)begin
            red <= 0;
            orange <= 0;
            green <= 1;
            count_red <= 0;
            count_green <= 1;
        end
        else if (reset==0 && count_green==1 && red==0 && orange==0 && green==1)begin
            red <= 0;
            orange <= 0;
            green <= 1;
            count_red <= 0;
            count_green <= 0;
        end
        else if (reset==0 && count_green==0 && red==0 && orange==0 && green==1)begin
            red <= 0;
            orange <= 1;
            green <= 0;
            count_red <= 0;
            count_green <= 0;
        end
    end
endmodule