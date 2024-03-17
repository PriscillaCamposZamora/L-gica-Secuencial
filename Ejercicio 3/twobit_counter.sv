//////////////////////////////////////////////////////////////////////////////////
// 
// Contador de 2 bits.
// 
//////////////////////////////////////////////////////////////////////////////////

module twobit_counter
(
    input logic clk, rst,
    output logic [1:0] counter
);
    //Almacena las cuentas realizadas
    logic [1:0] count = 0;
    
    always @(posedge clk or posedge rst)
        begin
            if(rst)
                count <= 2'd0;
            else
                count <= count + 2'd1;
        end

    assign counter = count;
    
endmodule 