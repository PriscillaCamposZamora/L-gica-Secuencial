//////////////////////////////////////////////////////////////////////////////////
// 
//  Módulo superior del diseño para mostrar un número hexadecimal de cuatro dígitos
//  en el display de siete segmentos.
//
//////////////////////////////////////////////////////////////////////////////////

module top_module_hex_to_seven_seg(
    input logic clk,
    input logic rst,
    input logic enable,
    output logic [7:0] anode,
    output logic [6:0] segments,
    output logic dp, write_enable
    );
    
    logic [15:0] binary_16b_num;
    logic [15:0] hex_num_4digit;
    
    lfsr_16b lfsr_inst(.clk(clk), .rst(rst), .enable(enable), .WE(write_enable), .lfsr_out(binary_16b_num));
    
    register_16b register_16b_inst(.clk(clk), .WE(write_enable), .D(binary_16b_num), .Q(hex_num_4digit));
    
    seven_segment_display_controller controller_inst(.clk(clk) , .displayed_num(hex_num_4digit), .anode(anode), .segments(segments));
    
    assign dp = 1;

endmodule
