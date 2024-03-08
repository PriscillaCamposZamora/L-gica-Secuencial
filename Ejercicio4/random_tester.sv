//////////////////////////////////////////////////////////////////////////////////
//
//  Bloque de pruebas que genera números aleatorios de 16 bits mediante un LFSR.
// 
//////////////////////////////////////////////////////////////////////////////////

module random_tester(
    input logic clk,
    input logic rst,
    output logic [15:0] random_num,
    output logic WE
    );
    
    logic [15:0] random_num_register, random_num_next;
    logic taps;
    
    logic [9:0] count = 9'd0;
    logic new_clk = 0;
    
    // crear nuevo reloj a partir de clk con frecuencia de 0.5 Hz (clk tiene frecuencia de 100 MHz)
    always@(posedge clk) begin
        if (count == 100000000) begin
            count <= 0;
            new_clk <= !new_clk;
        end
        else begin
            count <= count + 1;
        end
    end
    
    //sequential logic
    always@(posedge new_clk, posedge rst) begin
        if (rst)
            random_num_register <= 16'b0111010100110000;
        else
            random_num_register <= random_num_next;
    end
    
    // next state logic
    always@(taps, random_num_register) begin
        random_num_next = {random_num_register[15:1], taps};
    end
    
    // output logic
    assign taps =  ( (random_num_register[14] ^ random_num_register[13]) 
                   ^  random_num_register[12] ) ^  random_num_register[10];
                   
    assign random_num = random_num_register;
    
    assign WE = random_num_register[7];
    
endmodule
