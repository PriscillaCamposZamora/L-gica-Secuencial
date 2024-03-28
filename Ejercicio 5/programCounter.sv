


module PC(clk,pc_i,pc_op_i,pc_o,pcinc_o);
parameter W=4;
input clk;
input [W-1:0] pc_i;
input [1:0] pc_op_i;
output [W-1:0] pc_o;
output [W-1:0] pcinc_o;




always @(posedge clk)
    begin
        case (pc_op_i)
            2'b00: pc_o<=rst;
            2'b01: pc_o<= hold;
            2'b10 pc_o<=PC_plus_four;
            2'b11;pc_o<=salto;
        endcase
    end
endmodule
