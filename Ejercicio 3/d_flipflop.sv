//////////////////////////////////////////////////////////////////////////////////
// 
// Codificador de salida para la interfaz del teclado hexadecimal.
// 
//////////////////////////////////////////////////////////////////////////////////

//Flip Flop D
module d_flipflop
(
    input logic clk, rst, D, EN,
    output logic Q
);

    always @(posedge clk or posedge rst) 
    begin
        if(rst)
            Q <= 1'b0;
        else if (EN)
            Q <= D; 
    end 
endmodule 