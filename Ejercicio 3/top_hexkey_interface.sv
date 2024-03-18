//////////////////////////////////////////////////////////////////////////////////
// 
// Interfaz del teclado hexadecimal. Este es el archivo top.
// 
//////////////////////////////////////////////////////////////////////////////////

module top_hexkey_interface (
    input logic clk, rst,
    bitkey1, bitkey2, //Salida recibida del teclado hexadecimal
    presskey1, presskey2, presskey3, presskey4, //Botones pulsados en el teclado hexadecimal
    output logic bitcounter1, bitcounter2, //Bits del contador de 2 bits. Deben ser recibidos por el teclado hexadecimal
    D, C, B, A, //Bits de salida del codificador del teclado
    output logic [15:0] LED //LEDs para verificar que todo esté funcionando como se tiene previsto
);
    //Creación de conexiones y registros necesarios
    logic CLK_OUT_10MHz; //Reloj de 10 MHz
    logic [1:0] counter;  //Almacena las cuentas del contador
    logic presskey1_deb, presskey2_deb, presskey3_deb, presskey4_deb; //Botones con antirrebote
    logic EN = 0; //Señal de habilitación para los flip-flops
    logic bit1, bit2, bit3, bit4; //Bits almacenados por los flip-flops anteriores al codificador del teclado
    logic [3:0] LED_on; //Decide el LED que se debe encender

    //Creación de nuevo reloj de 10 MHz
    clk_wiz_0 pll_clk (.CLK_OUT_10MHz(CLK_OUT_10MHz), .reset(rst), .locked(locked), .CLK_in_100MHz(clk));
    //Contador de 2 bits
    twobit_counter bits_counter (.clk(CLK_OUT_10MHz), .rst(rst), .counter(counter));

    //Almacenar los bits del contador en donde corresponde para enviarlos al PMOD JA
    assign bitcounter1 = counter[1];
    assign bitcounter2 = counter[0];

    //Verificar que se realice antirrebote para todos los botones
    debouncing debounce1 (.clk(CLK_OUT_10MHz), .rst(rst), .btn_in(presskey1), .btn_out(presskey1_deb));
    debouncing debounce2 (.clk(CLK_OUT_10MHz), .rst(rst), .btn_in(presskey2), .btn_out(presskey2_deb));
    debouncing debounce3 (.clk(CLK_OUT_10MHz), .rst(rst), .btn_in(presskey3), .btn_out(presskey3_deb));
    debouncing debounce4 (.clk(CLK_OUT_10MHz), .rst(rst), .btn_in(presskey4), .btn_out(presskey4_deb));

    always@ (posedge CLK_OUT_10MHz)
    begin
        if (presskey1_deb || presskey2_deb || presskey3_deb || presskey4_deb) //Si algún botón es pulsado
            EN <= 1'b1;
        else
            EN <= 1'b0;
    end

    d_flipflop DFF1 (.clk(CLK_OUT_10MHz), .rst(rst), .D(bitcounter1), .EN(EN), .Q(bit1));
    d_flipflop DFF2 (.clk(CLK_OUT_10MHz), .rst(rst), .D(bitcounter2), .EN(EN), .Q(bit2));
    d_flipflop DFF3 (.clk(CLK_OUT_10MHz), .rst(rst), .D(bitkey1), .EN(EN), .Q(bit3));
    d_flipflop DFF4 (.clk(CLK_OUT_10MHz), .rst(rst), .D(bitkey2), .EN(EN), .Q(bit4));

    //Codificador del teclado
    key_encoder encoder (.bitcounter1(bit1), .bitcounter2(bit2), .bitkey1(bit3), .bitkey2(bit4), .D(D), .C(C), .B(B), .A(A));

    //Asignar el valor obtenido del codificador del teclado para encender un LED
    assign LED_on = {D, C, B, A};
    always_comb
    begin
        case (LED_on)
            4'b0000: LED = 16'b0000000000000001; //Salida igual a 0 -> Encender LED 1
            4'b0001: LED = 16'b0000000000010000; //Salida igual a 4 -> Encender LED 5
            4'b0010: LED = 16'b0000000100000000; //Salida igual a 8 -> Encender LED 9
            4'b0011: LED = 16'b0001000000000000; //Salida igual a 12 -> Encender LED 13
            4'b0100: LED = 16'b0000000000000010; //Salida igual a 1 -> Encender LED 2
            4'b0101: LED = 16'b0000000000100000; //Salida igual a 5 -> Encender LED 6
            4'b0110: LED = 16'b0000001000000000; //Salida igual a 9 -> Encender LED 10
            4'b0111: LED = 16'b0010000000000000; //Salida igual a 13 -> Encender LED 14
            4'b1000: LED = 16'b0000000000000100; //Salida igual a 2 -> Encender LED 3
            4'b1001: LED = 16'b0000000001000000; //Salida igual a 6 -> Encender LED 7
            4'b1010: LED = 16'b0000010000000000; //Salida igual a 10 -> Encender LED 11
            4'b1011: LED = 16'b0100000000000000; //Salida igual a 14 -> Encender LED 15
            4'b1100: LED = 16'b0000000000001000; //Salida igual a 3 -> Encender LED 4
            4'b1101: LED = 16'b0000000010000000; //Salida igual a 7 -> Encender LED 8
            4'b1110: LED = 16'b0000100000000000; //Salida igual a 11 -> Encender LED 12
            4'b1111: LED = 16'b1000000000000000; //Salida igual a 15 -> Encender LED 16
            default: LED = 16'b0000000000000000; //Dejar LEDs apagados
        endcase    
    end
    
endmodule