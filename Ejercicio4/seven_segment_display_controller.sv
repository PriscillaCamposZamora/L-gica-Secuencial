//////////////////////////////////////////////////////////////////////////////////
//
// Controlador para el display de siete segmentos de cuatro dígitos.
// 
//////////////////////////////////////////////////////////////////////////////////

module seven_segment_display_controller(
    input logic clk,
    input logic [15:0] hex_num_4digit,
    output logic [3:0] anode,
    output logic [6:0] segments
    );
    
    logic [1:0] digit;
    logic [3:0] selected_digit;
    
    digit_select digit_select1(.clk(clk), .digit(digit));
    
    anode_select anode_select1(.digit(digit), .anode(anode));
    
    digit_control digit_control(.digit(digit), .hex_num_4digit(hex_num_4digit), .selected_digit(selected_digit));
    
    seven_segment_decoder seven_segment_decoder1(.hex_digit(selected_digit), .segments(segments));
 
endmodule
