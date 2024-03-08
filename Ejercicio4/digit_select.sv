//////////////////////////////////////////////////////////////////////////////////
// 
// Seleccionador para uno de los cuatro dígitos del display de siete segmentos.
// 
//////////////////////////////////////////////////////////////////////////////////

module digit_select(
    clk,
    digit
    );
    
    input logic clk;
    output logic [1:0] digit = 2'b00;
    
    logic [9:0] count = 10'd0;
    logic new_clk = 0;
    
    // crear nuevo reloj a partir de clk con frecuencia de 50 kHz (clk tiene frecuencia de 100 MHz)
    always@(posedge clk) begin
        if (count == 1000) begin
            count <= 0;
            new_clk <= !new_clk;
        end
        else begin
            count <= count + 1;
        end
    end
    
    // actualizar el dígito que se va a iluminar del display con base en el nuevo reloj
    always@(posedge new_clk) begin
        digit <= digit + 1;
    end
    
endmodule
