`timescale 1ns / 1ps

module tb_clocking_wizard;

  // Parámetros del reloj
  parameter CLK_PERIOD_IN = 10; // Periodo de reloj en unidades de tiempo, con f=100Mhz
 
  
  // Señales de reloj
  reg CLK_in_100MHz;//reloj de 100Mhz
  reg CLK_OUT_10MHz;//reloj de 10MHz

//instanciado del clocking Wizard   
    clk_wiz_0 instance_name
   (
    // Clock out ports
    .CLK_OUT_10MHz(CLK__OUT_10MHz),     // output CLK_10MHz
    // Status and control signals
    .reset(reset), // input reset
    .locked(locked),       // output locked
   // Clock in ports
    .CLK_in_100MHz(CLK_in_100MHz)      // input CLK_100MHz
);
//Aqui termina el instanciado del clocking Wizard

  // Simular el comportamiento
  initial begin
    // Inicialización de señales
    CLK_in_100MHz = 0;
    CLK_OUT_10MHz = 0;
    
    // Generar el reloj de entrada de 100 MHz
    forever #((CLK_PERIOD_IN)/2) CLK_in_100MHz = ~CLK_in_100MHz; 
    
    // Esperar 5 ciclos para asegurar la estabilidad del reloj
    #5;
    
    // Simular durante un período de tiempo suficiente
    #1000;
    
    // Terminar la simulación
    $finish;
  end

endmodule