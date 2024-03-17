`timescale 1ns / 1ps
module DebouncerAndSynchronizer (
    input logic clk,            // Reloj de sistema
    input logic reset_n,        // Señal de reinicio activa baja
    input logic raw_input,      // Entrada cruda del pulsador o interruptor
    output logic debounced_sync_input // Salida sincronizada y sin rebotes
);

// Parámetros de configuración
parameter COUNTER_WIDTH = 4;  // Ancho del contador para el debouncer
parameter SYNC_DELAY = 1;      // Retraso para sincronización

// Declaración de registros y cables internos
logic [COUNTER_WIDTH-1:0] counter;
logic sync_input_reg, sync_input_delayed;

// Lógica para el debouncer y sincronización
always_ff @(posedge clk or negedge reset_n) begin
    if (!reset_n) begin
        counter <= '0;
        sync_input_reg <= 1'b0;
    end else begin
        if (raw_input != sync_input_reg) begin
            counter <= counter + 1;
        end else begin
            counter <= '0;
        end
        
        if (counter == (1 << COUNTER_WIDTH) - 1) begin
            sync_input_reg <= raw_input;
        end
    end
end

// Retraso para sincronización
always_ff @(posedge clk or negedge reset_n) begin
    if (!reset_n) begin
        sync_input_delayed <= 1'b0;
    end else begin
        sync_input_delayed <= sync_input_reg;
    end
end

// Salida sincronizada y sin rebotes
assign debounced_sync_input = sync_input_delayed;

endmodule