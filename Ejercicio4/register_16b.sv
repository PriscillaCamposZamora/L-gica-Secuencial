//////////////////////////////////////////////////////////////////////////////////
// 
// Registro de 16 bits de entrada y salida paralela, con habilitación de escritura.
// 
//////////////////////////////////////////////////////////////////////////////////

module register_16b(
    input logic clk, // señal de reloj (10 MHz)
    input logic WE, // señal de habilitación de escritura
    input logic [15:0] D, // señales para el dato de entrada al registro
    output logic [15:0] Q// señales para el dato de salida del registro
    );
    
    logic [15:0] register; // registro de 16 bits para cargar dato de entrada
    
    always@(posedge clk) begin
        if (WE) begin // 
            register <= D; // cargar dato de entrada en el registro
        end
    end
    
    assign Q = register; // mostrar dato cargado en la salida del registro
    
endmodule