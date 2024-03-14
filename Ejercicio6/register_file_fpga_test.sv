//////////////////////////////////////////////////////////////////////////////////
//
// Sistema para probar banco de registros en la FPGA, para 4 registros de 8 bits.
// 
//////////////////////////////////////////////////////////////////////////////////


module fpga_test(
    input logic clk,
    input logic rst,
    input logic WE,
    input logic [13:0] sws,
    output logic [15:0] leds
    );
    
    logic [7:0] data_in;
    logic [1:0] add_data_in;
    logic [1:0] add_data_out1;
    logic [1:0] add_data_out2;
      
    always@(posedge clk) begin
        data_in  <= sws[7:0];
        add_data_in <= sws[9:8];
        add_data_out1 <= sws[11:10];
        add_data_out2 <= sws[13:12];
    end
    
    register_file #(2, 8) inst(
        .clk(clk),
        .rst(rst), 
        .WE(WE), 
        .data_in(data_in), 
        .add_data_in(add_data_in), 
        .add_data_out1(add_data_out1), 
        .add_data_out2(add_data_out2), 
        .data_out1(leds[7:0]), 
        .data_out2(leds[15:8]));
    
endmodule