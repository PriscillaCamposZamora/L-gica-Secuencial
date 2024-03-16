//////////////////////////////////////////////////////////////////////////////////
// 
// Banco de pruebas para el sistema LFSR-Registro-Display.
// 
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ps

module tb();

logic clk, rst, enable, write_enable, dp;
logic [3:0] anode;
logic [6:0] segments;

top_module_hex_to_seven_seg dut(
    .clk(clk),
    .rst(rst),
    .enable(enable),
    .anode(anode),
    .segments(segments),
    .dp(dp), .write_enable(write_enable)
    );

// señal de reloj
always begin
    #5;
    clk = !clk;
end

// inicializar entradas y salidas
initial begin
    clk <= 0;
    rst <= 0;
    enable <= 1;
    write_enable <= 0;
end

// empezar pruebas
initial begin

    rst <= 1;
    enable <= 1;
    
    #10;
    rst <= 0;
    enable <= 1;
    #10000;
    $finish;
end
    
endmodule