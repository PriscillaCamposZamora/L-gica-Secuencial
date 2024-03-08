//////////////////////////////////////////////////////////////////////////////////
// 
// Seleccionador del ánodo correspondiente al dígito que se va a iluminar en el disp.
// 
//////////////////////////////////////////////////////////////////////////////////

module anode_select(
    digit,
    anode
    );
    
    input logic [1:0] digit;
    output logic [3:0] anode;
    
    always@(digit) begin
        case(digit)
            2'b00: anode = 4'b1110; // primer dígito a la derecha
            2'b01: anode = 4'b1101; // segundo dígito a la derecha
            2'b10: anode = 4'b1011; // tercer dígito a la derecha
            2'b11: anode = 4'b0111; // cuarto dígito a la derecha
        endcase
    end
endmodule
