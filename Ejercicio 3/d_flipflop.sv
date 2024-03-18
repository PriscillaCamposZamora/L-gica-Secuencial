//////////////////////////////////////////////////////////////////////////////////
// 
// Codificador de salida para la interfaz del teclado hexadecimal.
// 
//////////////////////////////////////////////////////////////////////////////////

//Flip Flop D para 
module d_flipflop
(
    input logic D, clk, rst,
    output logic Q
);

    always @(posedge clk or posedge rst) 
    begin
        if(rst)
            Q <= 1'b0;
        else 
            Q <= D; 
    end 
endmodule 