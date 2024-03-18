//////////////////////////////////////////////////////////////////////////////////
//
// Sistema para probar banco de registros en la FPGA, para 4 registros de 8 bits.
// 
//////////////////////////////////////////////////////////////////////////////////


module fpga_test(
    input logic clk, // señal de reloj (10 MHz)
    input logic rst, // señal de reseteo del sistema
    input logic reset_pll, // señal de reseteo del reloj generado con clock wizard
    input logic WE, // señal de habilitación de escritura en el banco
    input logic [13:0] sws, // switches para ingresar datos y direcciones
    output logic [15:0] leds // leds para leer datos
    );
    
    logic [7:0] data_in; // señales para dato de entrada
    logic [1:0] add_data_in; // señales para dirección del dato de entrada
    logic [1:0] add_data_out1; // señales para la dirección de lecutura de un primer dato
    logic [1:0] add_data_out2; // señales para la dirección de lecutura de un segundo dato
    logic CLK_OUT_10MHz; // señal para el reloj de 10 MHz
      
    // asignar señales de entrada desde la FPGA hacia el banco de registros
    always@(posedge clk) begin
        data_in  <= sws[7:0];
        add_data_in <= sws[9:8];
        add_data_out1 <= sws[11:10];
        add_data_out2 <= sws[13:12];
    end

    // instancia del reloj creado con el clock wizard
    clk_wiz_0 pll_clk(.clk_10MHz(CLK_OUT_10MHz), .reset(reset_pll), .locked(locked), .clk_100MHz(clk));

    // instancia del banco de registros
    register_file #(2, 8) inst(
        .clk(CLK_OUT_10MHz),
        .rst(rst), 
        .WE(WE), 
        .data_in(data_in), 
        .add_data_in(add_data_in), 
        .add_data_out1(add_data_out1), 
        .add_data_out2(add_data_out2), 
        .data_out1(leds[7:0]), 
        .data_out2(leds[15:8]));
    
endmodule