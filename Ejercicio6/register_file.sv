//////////////////////////////////////////////////////////////////////////////////
//  
// Banco de registros parametrizable con 2**n registros de w bits
// 
//////////////////////////////////////////////////////////////////////////////////


module register_file #(parameter n = 3, parameter w = 8)(
    input logic clk, // señal de reloj (10 MHz)
    input logic rst, // señal de reseteo para el banco de registros
    input logic WE, // señal de escritura para el banco de registros
    input logic [w-1:0] data_in, // señales para el dato de entrada al banco de registros
    input logic [n-1:0] add_data_in, // señales para la dirección del dato de entrada
    input logic [n-1:0] add_data_out1, // señales para la dirección del primer dato a leer
    input logic [n-1:0] add_data_out2, // señales para la dirección del segundo dato a leer
    output logic [w-1:0] data_out1, // señales para el primer dato de salida
    output logic [w-1:0] data_out2 // señales para el segundo dato de salida
    );
    
    logic [(2**n)-1:0] [w-1:0] registers; // 2**n registros de w bits para el banco
    
    // gestionar escritura en el banco de registros
    always@(posedge clk) begin
        registers[0] <= {w{1'b0}}; // establecer el registro cero en cero
        if (WE&&(add_data_in!=0)) begin
            registers[add_data_in] <= data_in; // cargar el dato de entrada en el registro indicado
        end
        if (rst) begin
            registers[(2**n)-1:1] <= {w{1'b0}}; // resetear todos los registros a cero
        end
    end
    
    assign data_out1 = registers[add_data_out1]; // asignar primer dato de salida según dirección dada
    assign data_out2 = registers[add_data_out2]; // asignar segundo dato de salida según dirección dada
    
endmodule
