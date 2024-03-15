//////////////////////////////////////////////////////////////////////////////////
//
//  Bloque de pruebas que genera números aleatorios de 16 bits mediante un LFSR.
// 
//////////////////////////////////////////////////////////////////////////////////

module lfsr_16b(
    input logic clk,
    input logic rst,
    input logic enable,
    output logic WE,
    output logic [15:0] lfsr_out
    );
    
    logic lf, new_clk = 0;
    logic [9:0] count = 9'd0;
    
    // crear nuevo reloj a partir de clk con frecuencia de 0.5 Hz (clk tiene frecuencia de 100 MHz)
    always@(posedge clk) begin
        if (count == 200000000-1) begin
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
    
     // obtener bit de realimentación o tap
    assign lf = ( (lfsr_out[15] ^ lfsr_out[14]) 
                ^  lfsr_out[13] ) ^  lfsr_out[11];
                
    // asignar bit aleatorio a la señal de escritura para el registro de 16 bits    
    assign WE = lf;
    
    // aplicar realimentación para generar núm. aleatorio
    always@(posedge new_clk, posedge rst) begin
        if (rst)
            lfsr_out <= 16'b0111010100110000;
        else if (enable)
            lfsr_out <= {lfsr_out[14:0], lf};
    end
    
endmodule
