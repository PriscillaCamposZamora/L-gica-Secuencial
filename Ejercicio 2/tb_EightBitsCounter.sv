// Banco de pruebas para el contador de 8 bits.
`timescale 1ns / 1ps
module tb_8bitscounter;

logic clk;
logic rst;
logic enable;
logic [7:0] contador;

EightBitscounter uut(
    .clk(clk), .rst(rst), .enable(enable), .contador(contador)
);
 //Señal de reloj
    initial
    begin
        clk = 0;
        forever #5 clk = ~clk;    
    end

    initial
    begin
        enable=0;
        rst = 0;
        #20
        rst = 1;
        forever #10 enable=~enable;
        #100;
        
        $finish;
    end

endmodule