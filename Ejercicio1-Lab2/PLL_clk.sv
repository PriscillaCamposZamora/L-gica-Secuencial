module pll_clk (
    input wire CLK_IN_100MHz,  // Reloj externo de 100 MHz
    output reg CLK_OUT_10MHz    // Reloj interno de 10 MHz generado por el PLL
);

// Parámetros del PLL
parameter integer CLK_IN_PERIOD = 10; // Periodo del reloj de entrada en unidades de tiempo (en nanosegundos)
parameter integer CLK_OUT_PERIOD = 100; // Periodo del reloj de salida deseado en unidades de tiempo (en nanosegundos)

// Instancia del PLL
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

endmodule