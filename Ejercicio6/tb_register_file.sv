//////////////////////////////////////////////////////////////////////////////////
// 
// Banco de pruebas para el banco de registros parametrizable.
// 
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ps

module tb_register_file();

// dut para 8 registros de 8 bits

logic clk, rst, WE;
logic [7:0] data_in, data_out1, data_out2;
logic [7:0] add_data_in, add_data_out1, add_data_out2;


register_file #(3, 8) dut1(
    .clk(clk), 
    .rst(rst), 
    .WE(WE), 
    .data_in(data_in),
    .add_data_in(add_data_in),
    .add_data_out1(add_data_out1), 
    .add_data_out2(add_data_out2),
    .data_out1(data_out1),
    .data_out2(data_out2)
    );

// dut para 8 registros de 4 bits

logic [3:0] DUT2_data_in, DUT2_data_out1, DUT2_data_out2;
logic [7:0] DUT2_add_data_in, DUT2_add_data_out1, DUT2_add_data_out2;

register_file #(3, 4) dut2(
    .clk(clk), 
    .rst(rst), 
    .WE(WE), 
    .data_in(DUT2_data_in),
    .add_data_in(DUT2_add_data_in),
    .add_data_out1(DUT2_add_data_out1), 
    .add_data_out2(DUT2_add_data_out2),
    .data_out1(DUT2_data_out1),
    .data_out2(DUT2_data_out2)
    );


// señal de reloj
always begin
    #10;
    clk = !clk;
end


// función para esperar n veces el flanco de subida del clock
task automatic wait_n_clks(input int n);
    repeat(n) @(posedge clk);
endtask

// inicializar entradas y salidas
initial begin
    clk <= 0;
    rst <= 1;
    WE <= 0;
    data_in <= 0;
    add_data_in <= 0;
    add_data_out1 <= 0;
    add_data_out2 <= 0;
    DUT2_data_in <= 0;
    DUT2_add_data_in <= 0;
    DUT2_add_data_out1 <= 0;
    DUT2_add_data_out2 <= 0;
end

// función para escribir las palabras aleatorias en los registros de 8 bits
task automatic write_test8(input bit [7:0] data, input bit [7:0] i);
    $display($sformatf("Dato: %0d cargado en registro: %0d", data, i));
    WE = 1;
    data_in = data;
    add_data_in = i;
    add_data_out1 = 0;
    add_data_out2 = 0;
    wait_n_clks(1);
endtask

// función para escribir las palabras aleatorias en los registros de 4 bits
task automatic write_test4(input bit [3:0] data, input bit [7:0] i);
    $display($sformatf("Dato: %0d cargado en registro: %0d", data, i));
    WE = 1;
    DUT2_data_in = data;
    DUT2_add_data_in = i;
    DUT2_add_data_out1 = 0;
    DUT2_add_data_out2 = 0;
    wait_n_clks(1);
endtask

// empezar pruebas
initial begin
    wait_n_clks(1);
    
    rst <= 0;
    
    // prueba para 8 registros de 8 bits
    
    $display("Cargando números aleatorios de 8 bits en los registros...");
    for (int i = 1; i <= 7; i++) begin
        write_test8($urandom_range(255, 0), i);
    end
    
    wait_n_clks(1);
    
    $display("Leyendo registros aleatorios...");
    for (int i = 0; i < 7; i++) begin
        WE = 0;
        data_in = 0;
        add_data_in = 0;
        add_data_out1 = $urandom_range(7, 0);
        add_data_out2 = $urandom_range(7, 0);
        $display($sformatf("Registro: %0d tiene el valor: %0d", add_data_out1, data_out1));
        $display($sformatf("Registro: %0d tiene el valor: %0d", add_data_out2, data_out2));
        wait_n_clks(1);
    end
    
    // prueba para 8 registros de 4 bits
    
    wait_n_clks(10);
    
    $display("Cargando números aleatorios de 4 bits en los registros...");
    for (int i = 1; i <= 7; i++) begin
        write_test4($urandom_range(15, 0), i);
    end
    
    wait_n_clks(1);
    
    $display("Leyendo registros aleatorios...");
    for (int i = 0; i < 7; i++) begin
        WE = 0;
        DUT2_data_in = 0;
        DUT2_add_data_in = 0;
        DUT2_add_data_out1 = $urandom_range(7, 0);
        DUT2_add_data_out2 = $urandom_range(7, 0);
        $display($sformatf("Registro: %0d tiene el valor: %0d", DUT2_add_data_out1, DUT2_data_out1));
        $display($sformatf("Registro: %0d tiene el valor: %0d", DUT2_add_data_out2, DUT2_data_out2));
        wait_n_clks(1);
    end
    
    $finish;
end
    
endmodule