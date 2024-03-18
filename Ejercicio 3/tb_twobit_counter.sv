//////////////////////////////////////////////////////////////////////////////////
// 
// Banco de pruebas para el contador de 2 bits.
// 
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ps

module tb_twobit_counter();

logic clk, rst;
logic [1:0] counter;

twobit_counter dut
(
    .clk(clk), .rst(rst), .counter(counter)
);

    //Señal de reloj
    initial
    begin
        clk = 0;
        forever #5 clk = ~clk;    
    end

    initial
    begin
        rst = 1;
        #20
        rst = 0;
        #100;
        $finish;
    end


endmodule