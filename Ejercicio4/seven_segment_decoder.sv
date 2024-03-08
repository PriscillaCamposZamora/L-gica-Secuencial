//////////////////////////////////////////////////////////////////////////////////
// 
// Decodificador de dígito hexadecimal a display de siete segmentos.
// 
//////////////////////////////////////////////////////////////////////////////////

module seven_segment_decoder(
    hex_digit,
    segments
    );
    
    input logic [3:0] hex_digit;
    output logic [6:0] segments = 7'b1111111; // segment_a = segments[6], segment_b = segments[5]...
    
    always_comb begin
    
    case(hex_digit)
    
        // 1: segment is off, 0: segment is on
    
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
