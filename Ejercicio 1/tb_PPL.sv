`timescale 1ns / 1ps

module tb_clocking_wizard();
`define  CLK_PERIOD_IN 10 // Periodo de reloj en unidades de tiempo, con f=100Mhz


reg clk_100MHz;//clock de entrada con f=100Mhz
reg reset;//señal de control reset
wire locked;//parámetro de bloqueo del PLL
wire clk_10MHz;

pll_clk PLL_clk
(
    clk_100MHz,//clock de entrada con f=100Mhz
    reset,//señal de control reset
    locked,//parámetro de bloqueo del PLL
    clk_10MHz//clock de salida con f=10Mhz
);


  // Simular el comportamiento
  initial 
    // Inicialización de señales
    clk_100MHz = 1'b1;
     // Generar el reloj de entrada de 100 MHz
    always#((`CLK_PERIOD_IN)/2) 
    clk_100MHz = ~clk_100MHz; 
    
    initial begin
    reset=1'b1;
    #(`CLK_PERIOD_IN)
    // Esperar 5 ciclos para asegurar la estabilidad del reloj
    //#5;
    reset=1'b0;
    #(`CLK_PERIOD_IN)
    
    // Simular durante un período de tiempo suficiente
    //#1000;
    
    // Terminar la simulación
    $finish;
  end

endmodule