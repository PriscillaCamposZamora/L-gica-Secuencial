//////////////////////////////////////////////////////////////////////////////////
// 
// Codificador de salida para la interfaz del teclado hexadecimal.
// 
//////////////////////////////////////////////////////////////////////////////////

module key_encoder (
    input logic bitcounter1, bitcounter2, bitkey1, bitkey2,
    output logic D, C, B, A
);
    //Almacena los bits de entrada
    logic [3:0] in = {bitcounter1, bitcounter2, bitkey1, bitkey2};
    //Almacena los bits de salida
    logic [3:0] out;

    always_comb
    begin
        case (in)
            4'b0000: out = 0000; //Salida igual a 0
            4'b0001: out = 0100; //Salida igual a 4
            4'b0010: out = 1000; //Salida igual a 8
            4'b0011: out = 1100; //Salida igual a 12
            4'b0100: out = 0001; //Salida igual a 1
            4'b0101: out = 0101; //Salida igual a 5
            4'b0110: out = 1001; //Salida igual a 9
            4'b0111: out = 1101; //Salida igual a 13
            4'b1000: out = 0010; //Salida igual a 2
            4'b1001: out = 0110; //Salida igual a 6
            4'b1010: out = 1010; //Salida igual a 10
            4'b1011: out = 1110; //Salida igual a 14
            4'b1100: out = 0011; //Salida igual a 3
            4'b1101: out = 0111; //Salida igual a 7
            4'b1110: out = 1011; //Salida igual a 11
            4'b1111: out = 1111; //Salida igual a 15
        endcase
    end

    assign D = out[3];
    assign C = out[2];
    assign B = out[1];
    assign A = out[0];
    
endmodule