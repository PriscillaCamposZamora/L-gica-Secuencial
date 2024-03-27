module EightBitscounter(clk,rst,contador,enable);
input clk,rst,enable;
output logic [7:0] contador;

always@(posedge clk)begin
    if(!rst)
        contador<=8'b0;
    else if(enable)
        contador<=contador+1;
    end

endmodule