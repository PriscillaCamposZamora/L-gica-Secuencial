//////////////////////////////////////////////////////////////////////////////////
// 
// Registro de 16 bits de entrada y salida paralela, con habilitación de escritura.
// 
//////////////////////////////////////////////////////////////////////////////////

module register_16b(
    input logic clk,
    input logic WE,
    input logic [15:0] D,
    output logic [15:0] Q
    );
    
    logic [15:0] register;
    
    always@(posedge clk) begin
        if (WE) begin
            register <= D;
        end
    end
    
    assign Q = register;
    
endmodule