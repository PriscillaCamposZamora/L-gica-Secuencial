//////////////////////////////////////////////////////////////////////////////////
//  
// Banco de registros parametrizable con 2**n registros de w bits
// 
//////////////////////////////////////////////////////////////////////////////////


module register_file #(parameter n = 3, parameter w = 8)(
    input logic clk,
    input logic rst,
    input logic WE,
    input logic [w-1:0] data_in,
    input logic [(2**n)-1:0] add_data_in,
    input logic [(2**n)-1:0] add_data_out1,
    input logic [(2**n)-1:0] add_data_out2,
    output logic [w-1:0] data_out1,
    output logic [w-1:0] data_out2
    );
    
    logic [(2**n)-1:0] [w-1:0] registers;
    
    assign registers[0] = {w{1'b0}};
    
    always@(posedge clk) begin
        if (WE&&(add_data_in!=0)) begin
            registers[add_data_in] <= data_in;
        end
        if (rst) begin
            registers[(2**n)-1:1] = {w{1'b0}};
        end
    end
    
    assign data_out1 = registers[add_data_out1];
    assign data_out2 = registers[add_data_out2];
    
endmodule
