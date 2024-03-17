

module pll_clk (
    input CLK_in_100MHz,//clock de entrada con f=100Mhz
    input reset,//señal de control reset
    output locked,//parámetro de bloqueo del PLL
    output CLK_OUT_10MHz//clock de salida con f=10Mhz
);
// Instancia del PLL
//instanciado del clocking Wizard   
  clk_wiz_0 pll_clk
   (
    // Clock out ports
    .CLK_OUT_10MHz(CLK_OUT_10MHz),     // output CLK_OUT_10MHz
    // Status and control signals
    .reset(reset), // input reset
    .locked(locked),       // output locked
   // Clock in ports
    .CLK_in_100MHz(CLK_in_100MHz)      // input CLK_in_100MHz
);
//Aqui termina el instanciado del clocking Wizard

endmodule