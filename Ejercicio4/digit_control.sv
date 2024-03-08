//////////////////////////////////////////////////////////////////////////////////
// 
// Seleccionar el valor del dígito a iluminar en el display.
// 
//////////////////////////////////////////////////////////////////////////////////

module digit_control(
    input logic [1:0] digit,
    input logic [15:0] hex_num_4digit,
    output logic [3:0] selected_digit
    );
    
    always@(digit) begin
        case(digit)
            2'b00: selected_digit = hex_num_4digit[3:0]; // primer dígito a la derecha
            2'b01: selected_digit = hex_num_4digit[7:4]; // segundo dígito a la derecha
            2'b10: selected_digit = hex_num_4digit[11:8]; // tercer dígito a la derecha
            2'b11: selected_digit = hex_num_4digit[15:12]; // cuarto dígito a la derecha
        endcase
    end
    
endmodule
