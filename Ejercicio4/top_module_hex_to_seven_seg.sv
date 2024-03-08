//////////////////////////////////////////////////////////////////////////////////
// 
//  Módulo superior del diseño para mostrar un número hexadecimal de cuatro dígitos
//  en el display de siete segmentos.
//
//////////////////////////////////////////////////////////////////////////////////

module top_module_hex_to_seven_seg(
    input logic clk,
    input logic rst,
    output logic [3:0] anode,
    output logic [6:0] segments
    );
    
    logic write_enable;
    logic [15:0] binary_16b_num;
    logic [15:0] hex_num_4digit;
    
    random_tester random_tester1(.clk(clk), .rst(rst), .random_num(binary_16b_num), .WE(write_enable));
    
    register_16b register_16b1(.clk(clk), .WE(write_enable), .D(binary_16b_num), .Q(hex_num_4digit));
    
    seven_segment_display_controller(.clk(clk) , .hex_num_4digit(hex_num_4digit), .anode(anode), .segments(segments));
    
endmodule
