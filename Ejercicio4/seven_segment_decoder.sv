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
    
        4'b0000: begin assign segments = 7'b1111111; end // 0
         
        4'b0001: begin assign segments = 7'b1001111; end // 1
            
        4'b0010: begin assign segments = 7'b0010010; end // 2
            
        4'b0011: begin assign segments = 7'b0000110; end // 3
            
        4'b0100: begin assign segments = 7'b1001100; end // 4
        
        4'b0101: begin assign segments = 7'b0100100; end // 5
            
        4'b0110: begin assign segments = 7'b0100000; end // 6
            
        4'b0111: begin assign segments = 7'b0001111; end // 7
            
        4'b1000: begin assign segments = 7'b0000000; end // 8
            
        4'b1001: begin assign segments = 7'b0001100; end // 9
            
        4'b1010: begin assign segments = 7'b0001000; end // A
            
        4'b1011: begin assign segments = 7'b0000000; end // B
            
        4'b1100: begin assign segments = 7'b0110001; end // C
            
        4'b1101: begin assign segments = 7'b0000001; end // D       
        
        4'b1110: begin assign segments = 7'b0110000; end // E

        4'b1111: begin assign segments = 7'b0111000; end // F
        
        default: begin assign segments = 7'b1111111; end // 0
            
    endcase
    
    end
     
endmodule
