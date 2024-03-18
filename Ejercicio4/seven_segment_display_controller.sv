//////////////////////////////////////////////////////////////////////////////////
//
// Controlador para el display de siete segmentos de cuatro dígitos.
// 
//////////////////////////////////////////////////////////////////////////////////

module seven_segment_display_controller(
    input logic clk, // señal de reloj (10 MHz)
    input logic [15:0] displayed_num, // señales para el número de 16 bits a mostrar en el display
    output logic [7:0] anode, // señales para los ánodos que encienden los dígitos del display
    output logic [6:0] segments // señales para los siete segmentos del display
    );
    
    logic new_clk = 0; // señal para un nuevo reloj con frecuencia menor a clk
    logic [14:0] count = 5'd00000; // variable para contar ciclos de clk
    logic [1:0] digit = 2'b00; // variable para el dígito del display a encencer (uno de los cuatro dígitos)
    logic [3:0] displayed_digit = 4'b0000; // variable para el valor del dígito hex a mostrar en un dígito del display
    
    // crear nuevo reloj a partir de clk con frecuencia de 400 Hz (clk tiene frecuencia de 10 MHz)
    always@(posedge clk) begin
        if (count == 25000-1) begin // 10 M / 400 = 25000
            count <= 0; // reiniciar cuenta si se alcanzó la frecuencia de 400 Hz
            new_clk <= !new_clk; // cambiar nivel lógico del reloj
        end
        else begin
            count <= count + 1; // aumentar cuenta en 1
        end
    end

    // crear nuevo reloj a partir de clk con frecuencia de 10 MHz para testbench (clk tiene frecuencia de 100 MHz)
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
        digit <= digit + 1; // seceuncia de iluminación de dígitos: 00 > 01 > 10 > 11 y se reinicia
    end
    
    always@(*) begin
        case(digit)
            2'b00: begin displayed_digit = displayed_num[3:0]; anode = 8'b11111110; end // primer dígito a la derecha
            2'b01: begin displayed_digit = displayed_num[7:4]; anode = 8'b11111101; end // segundo dígito a la derecha
            2'b10: begin displayed_digit = displayed_num[11:8]; anode = 8'b11111011; end // tercer dígito a la derecha
            2'b11: begin displayed_digit = displayed_num[15:12]; anode = 8'b11110111; end // cuarto dígito a la derecha
            default: begin displayed_digit = displayed_num[3:0]; anode = 8'b11111110; end // primer dígito a la derecha
        endcase
    end
    
    // decodificar el dígito hex a siete segmentos
    always@(*) begin
    case(displayed_digit)
    
        // 1: segmento apagado, 0: segmento encendido
        // segment_a = segments[6], segment_b = segments[5]...
    
        4'b0000: segments = 7'b0000001; // 0
         
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
            
        4'b1011: segments = 7'b1100000; // B
            
        4'b1100: segments = 7'b0110001; // C
            
        4'b1101: segments = 7'b1000010; // D       
        
        4'b1110: segments = 7'b0110000; // E

        4'b1111: segments = 7'b0111000; // F
        
        default: segments = 7'b0000001; // 0
            
    endcase
    
    end
 
endmodule
