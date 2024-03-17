//////////////////////////////////////////////////////////////////////////////////
// 
// Codificador de salida para la interfaz del teclado hexadecimal.
// 
//////////////////////////////////////////////////////////////////////////////////

//Flip Flop D para 
module d_flipflop
(
    input D, clk, rst
    output Q
);

    always @(posedge clk or posedge async_reset) 
    begin
        if(rst)
            Q <= 1'b0;
        else 
            Q <= D; 
    end 
endmodule 