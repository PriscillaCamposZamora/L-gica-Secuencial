//////////////////////////////////////////////////////////////////////////////////
// 
// Interfaz del teclado hexadecimal. Este es el archivo top.
// 
//////////////////////////////////////////////////////////////////////////////////

module top_hexkey_interface (
    input logic clk, rst, bitkey1, bitkey2, presskey1, presskey2, presskey3, presskey4,
    output logic bitcounter1, bitcounter2, D, C, B, A,
    output logic [15:0] LED
);
    //Creación de conexiones y registros necesarios
    logic CLK_OUT_10MHz; //Reloj de 10 MHz
    logic [1:0] counter;  //Almacena las cuentas del contador

    //Creación de nuevo reloj de 10 MHz
    clk_wiz_0 pll_clk (.CLK_OUT_10MHz(CLK_OUT_10MHz), .reset(rst), .locked(locked), .CLK_in_100MHz(clk));
    //Contador de 2 bits
    twobit_counter bits_counter (.clk(CLK_OUT_10MHz), .rst(rst), .counter(counter));

    //Almacenar los bits del contador en donde corresponde
    assign bitcounter1 = counter[1];
    assign bitcounter2 = counter[0];

    //Codificador del teclado
    key_encoder encoder (.bitcounter1(bitcounter1), .bitcounter2(bitcounter2), .bitkey1(bitkey1), .bitkey2(bitkey2), .D(D), .C(C), .B(B), .A(A),);
    
endmodule