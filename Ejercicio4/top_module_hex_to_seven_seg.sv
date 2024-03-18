//////////////////////////////////////////////////////////////////////////////////
// 
//  Módulo superior del diseño para mostrar un número hexadecimal de cuatro dígitos
//  en el display de siete segmentos.
//
//////////////////////////////////////////////////////////////////////////////////

module top_module_hex_to_seven_seg(
    input logic clk, // señal de reloj de la FPGA (100 MHz)
    input logic rst, // señal de reseteo para el sistema
    input logic enable, // señal de habilitación para el LFSR
    input logic reset_pll, // señal de reseteo para el reloj del clock wizard
    output logic [7:0] anode, // señales para los ánodos que encienden los dígitos del display de siete segmentos
    output logic [6:0] segments, // señales para los siete segmentos del display
    output logic dp, // señal para el punto decimal del display de siete segmentos
    output logic write_enable // señal de escritura para el registro
    );
    
    logic [15:0] binary_16b_num; // señales para el número de 16 bits generado por el LFSR
    logic [15:0] hex_num_4digit; // señales para el número de 16 bits que entra al registro
    logic CLK_OUT_10MHz; // señal para el reloj de 10 MHz

    // instancia del reloj creado con el clock wizard
    clk_wiz_0 pll_clk(.clk_10MHz(CLK_OUT_10MHz), .reset(reset_pll), .locked(locked), .clk_100MHz(clk));
    
    // instancia del LFSR de 16 bits
    lfsr_16b lfsr_inst(.clk(CLK_OUT_10MHz), .rst(rst), .enable(enable), .WE(write_enable), .lfsr_out(binary_16b_num));
    
    // instancia del registro de 16 bits
    register_16b register_16b_inst(.clk(CLK_OUT_10MHz), .WE(write_enable), .D(binary_16b_num), .Q(hex_num_4digit));
    
    // instancia del controlador para el display de siete segmentos de cuatro dígitos
    seven_segment_display_controller controller_inst(.clk(CLK_OUT_10MHz) , .displayed_num(hex_num_4digit), .anode(anode), .segments(segments));
    
    assign dp = 1; // señal de salida para punto decimal del display (apagada)

endmodule
