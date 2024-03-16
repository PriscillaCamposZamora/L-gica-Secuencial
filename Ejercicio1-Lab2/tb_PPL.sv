`timescale 1ns / 1ps

module tb_clocking_wizard;

  // Parámetros del reloj
  parameter CLK_PERIOD = 0.000000001; // Periodo de reloj en unidades de tiempo, con f=100Mhz
  
  // Señales de reloj
  reg CLK_100MHz;
  initial begin
    CLK_100MHz = 0;
    forever #((CLK_PERIOD)/2) CLK_100MHz = ~CLK_100MHz; // Generar el reloj
  end
  
//instanciado del clocking Wizard   
    clk_wiz_0 instance_name
   (
    // Clock out ports
    .CLK_10MHz(CLK_10MHz),     // output CLK_10MHz
    // Status and control signals
    .reset(reset), // input reset
    .locked(locked),       // output locked
   // Clock in ports
    .CLK_100MHz(CLK_100MHz)      // input CLK_100MHz
);
//Aqui termina el instanciado del clocking Wizard


  // Aquí debo agregar las señales de prueba y lógica de control

  // Aqui empieza la simulación del comportamiento
  initial begin
    #1000; // Simulación inicial
  // Cambiar la frecuencia de entrada
 // clk_wiz_0 instance_name.clk_in_period = new_period_value; esta linea tira error
  #1000; // Continuar simulación con nueva frecuencia de entrada
    $finish; // Terminar la simulación
  end

endmodule