# conexión de puertos físicos de la FPGA

## Clock signal

set_property -dict { PACKAGE_PIN E3    IOSTANDARD LVCMOS33 } [get_ports { clk }];
create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports { clk }];

##Switches

set_property -dict { PACKAGE_PIN J15   IOSTANDARD LVCMOS33 } [get_ports { sws[0] }];
set_property -dict { PACKAGE_PIN L16   IOSTANDARD LVCMOS33 } [get_ports { sws[1] }];
set_property -dict { PACKAGE_PIN M13   IOSTANDARD LVCMOS33 } [get_ports { sws[2] }];
set_property -dict { PACKAGE_PIN R15   IOSTANDARD LVCMOS33 } [get_ports { sws[3] }];
set_property -dict { PACKAGE_PIN R17   IOSTANDARD LVCMOS33 } [get_ports { sws[4] }];
set_property -dict { PACKAGE_PIN T18   IOSTANDARD LVCMOS33 } [get_ports { sws[5] }];
set_property -dict { PACKAGE_PIN U18   IOSTANDARD LVCMOS33 } [get_ports { sws[6] }];
set_property -dict { PACKAGE_PIN R13   IOSTANDARD LVCMOS33 } [get_ports { sws[7] }];
set_property -dict { PACKAGE_PIN T8    IOSTANDARD LVCMOS18 } [get_ports { sws[8] }];
set_property -dict { PACKAGE_PIN U8    IOSTANDARD LVCMOS18 } [get_ports { sws[9] }];
set_property -dict { PACKAGE_PIN R16   IOSTANDARD LVCMOS33 } [get_ports { sws[10] }];
set_property -dict { PACKAGE_PIN T13   IOSTANDARD LVCMOS33 } [get_ports { sws[11] }];
set_property -dict { PACKAGE_PIN H6   IOSTANDARD LVCMOS33 } [get_ports { sws[12] }];
set_property -dict { PACKAGE_PIN U12   IOSTANDARD LVCMOS33 } [get_ports { sws[13] }];
set_property -dict { PACKAGE_PIN U11   IOSTANDARD LVCMOS33 } [get_ports { WE }];

##Buttons

set_property -dict { PACKAGE_PIN N17   IOSTANDARD LVCMOS33 } [get_ports { rst }];

## LEDs

set_property -dict { PACKAGE_PIN H17   IOSTANDARD LVCMOS33 } [get_ports { leds[0] }]; 
set_property -dict { PACKAGE_PIN K15   IOSTANDARD LVCMOS33 } [get_ports { leds[1] }];
set_property -dict { PACKAGE_PIN J13   IOSTANDARD LVCMOS33 } [get_ports { leds[2] }]; 
set_property -dict { PACKAGE_PIN N14   IOSTANDARD LVCMOS33 } [get_ports { leds[3] }]; 
set_property -dict { PACKAGE_PIN R18   IOSTANDARD LVCMOS33 } [get_ports { leds[4] }]; 
set_property -dict { PACKAGE_PIN V17   IOSTANDARD LVCMOS33 } [get_ports { leds[5] }]; 
set_property -dict { PACKAGE_PIN U17   IOSTANDARD LVCMOS33 } [get_ports { leds[6] }]; 
set_property -dict { PACKAGE_PIN U16   IOSTANDARD LVCMOS33 } [get_ports { leds[7] }]; 
set_property -dict { PACKAGE_PIN V16   IOSTANDARD LVCMOS33 } [get_ports { leds[8] }]; 
set_property -dict { PACKAGE_PIN T15   IOSTANDARD LVCMOS33 } [get_ports { leds[9] }]; 
set_property -dict { PACKAGE_PIN U14   IOSTANDARD LVCMOS33 } [get_ports { leds[10] }]; 
set_property -dict { PACKAGE_PIN T16   IOSTANDARD LVCMOS33 } [get_ports { leds[11] }]; 
set_property -dict { PACKAGE_PIN V15   IOSTANDARD LVCMOS33 } [get_ports { leds[12] }]; 
set_property -dict { PACKAGE_PIN V14   IOSTANDARD LVCMOS33 } [get_ports { leds[13] }]; 
set_property -dict { PACKAGE_PIN V12   IOSTANDARD LVCMOS33 } [get_ports { leds[14] }]; 
set_property -dict { PACKAGE_PIN V11   IOSTANDARD LVCMOS33 } [get_ports { leds[15] }];