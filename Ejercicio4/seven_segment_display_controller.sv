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
    
    logic new_clk = 0;
    logic [9:0] count = 10'd0;
    logic [1:0] digit = 2'b00;
    logic [3:0] selected_digit = 4'b0000;
    
    // crear nuevo reloj a partir de clk con frecuencia de 50 kHz (clk tiene frecuencia de 100 MHz)
    always@(posedge clk) begin
        if (count == 2000-1) begin
            count <= 0;
            new_clk <= !new_clk;
        end
        else begin
            count <= count + 1;
        end
    end
    
    // crear nuevo reloj a partir de clk con frecuencia de 10 MHz para tb (clk tiene frecuencia de 100 MHz)
    /*always@(posedge clk) begin
        if (count == 10-1) begin
            count <= 0;
            new_clk <= !new_clk;
        end
        else begin
            count <= count + 1;
        end
    end*/
    
    // actualizar el dígito que se va a iluminar del display con base en el nuevo reloj
    always@(posedge new_clk) begin
        digit <= digit + 1;
    end
    
    always@(digit) begin
        case(digit)
            2'b00: begin selected_digit = hex_num_4digit[3:0]; anode = 4'b1110; end// primer dígito a la derecha
            2'b01: begin selected_digit = hex_num_4digit[7:4]; anode = 4'b1101; end // segundo dígito a la derecha
            2'b10: begin selected_digit = hex_num_4digit[11:8]; anode = 4'b1011; end // tercer dígito a la derecha
            2'b11: begin selected_digit = hex_num_4digit[15:12]; anode = 4'b0111; end // cuarto dígito a la derecha
        endcase
    end
    
    
    // decodificar el dígito hex a siete segmentos
    always_comb begin
    
    case(selected_digit)
    
        // 1: segment is off, 0: segment is on
        // segment_a = segments[6], segment_b = segments[5]...
    
        4'b0000: segments = 7'b1111111; // 0
         
        4'b0001: segments = 7'b1001111; // 1
            
        4'b0010: segments = 7'b0010010; // 2
            
        4'b0011: segments = 7'b0000110; // 3
            
        4'b0100: segments = 7'b1001100; // 4
        
        4'b0101: segments = 7'b0100100; // 5
            
        4'b0110: segments = 7'b0100000; // 6
            
        4'b0111: segments = 7'b0001111; // 7
            
        4'b1000: segments = 7'b0000000; // 8
            
        4'b1001: segments = 7'b0001100; // 9
            
        4'b1010: segments = 7'b0001000; // A
            
        4'b1011: segments = 7'b0000000; // B
            
        4'b1100: segments = 7'b0110001; // C
            
        4'b1101: segments = 7'b0000001; // D       
        
        4'b1110: segments = 7'b0110000; // E

        4'b1111: segments = 7'b0111000; // F
        
        default: segments = 7'b1111111; // 0
            
    endcase
    
    end
 
endmodule
