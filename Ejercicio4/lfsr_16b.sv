//////////////////////////////////////////////////////////////////////////////////
//
//  Bloque de pruebas que genera números aleatorios de 16 bits mediante un LFSR.
// 
//////////////////////////////////////////////////////////////////////////////////

module lfsr_16b(
    input logic clk, // señal de reloj (10 MHz)
    input logic rst, // señal de reseteo para el LFSR
    input logic enable, // señal de habilitación para el LFSR
    output logic WE, // señal de escritura para el registro de 16 bits
    output logic [15:0] lfsr_out // señales para el número de 16 bits generado por el LFSR
    );
    
    logic lf, new_clk = 0; // señal para un nuevo reloj de frecuencia menor a la de clk
    logic [24:0] count = 8'd00000000; // variable para contar ciclos de clk
    
    // crear nuevo reloj a partir de clk con frecuencia de 0.5 Hz (clk tiene frecuencia de 10 MHz)
    always@(posedge clk) begin
        if (count == 20000000-1) begin // 10 M / 0.5 = 20 M
            count <= 0; // reiniciar cuenta si se alcanzó la frecuencia de 0.5 Hz
            new_clk <= !new_clk; // cambiar nivel lógico del reloj
        end
        else begin
            count <= count + 1; // aumentar cuenta en 1
        end
    end

    // crear nuevo reloj a partir de clk con frecuencia de 50 MHz para testbench (clk tiene frecuencia de 100 MHz)
    /*always@(posedge clk) begin
        if (count == 2-1) begin
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
            lfsr_out <= 16'b0111010100110000; // valor inicial para LFSR
        else if (enable)
            lfsr_out <= {lfsr_out[14:0], lf}; // número pseudo-aleatorio de 16 bits
    end
    
endmodule
