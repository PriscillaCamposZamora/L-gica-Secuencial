//////////////////////////////////////////////////////////////////////////////////
// 
// Circuito antirrebote y sincronizador.
// 
//////////////////////////////////////////////////////////////////////////////////

//Se define el parámetro threshold para saber cuánto tiempo el botón debe ser presionado
//Se sigue la siguiente fórmula
//Valor_dividido = [10 Mhz/(2*Frecuencia_deseada)] - 1 => Valor dividido = 10000
//Con esto se obtiene que el botón debe ser pulsado al menos 2 ms
module debouncing #(parameter threshold = 10000)
(
    input logic clk, rst,
    input logic btn_in, //Botón de entrada
    output logic btn_out //Botón con antirrebote aplicado
);

    logic button_ff1 = 0; //Flip-flop de botón para sincronización
    logic button_ff2 = 0; //Otro flip-flop de botón para sincronización
    logic [20:0] count = 0; //Contador para incrementar o decrementar cuándo tiempo el botón debe ser pulsado

    //Primero se usan dos flip-flops para sincronizar el botón con el clk
    always @(posedge clk)begin
        button_ff1 <= btn_in;
        button_ff2 <= button_ff1;
    end

    //Cuando el botón es presionado o soltado, se incrementa o decrementa el contador
    //Hasta que el contador alcance el valor límite (threshold) se considera que el botón ya posee antirrebote
    always @(posedge clk)begin
        if (button_ff2) //Si button_ff2 es 1
        begin
            if (~&count)//Si aún no se llegado al ancho del contador. Para asegurarse que esto no se sobrepase
                count <= count+1; //Cuenta btn_in es pulsado, suma
        end 
        else begin
            if (|count)//Si el contador tiene al menos un bit en él. Para asegurarse que no se reste cuando count sea cero
                count <= count-1; //Cuando btn_in deja de ser pulsado, resta
        end
        if (count > threshold)//Si el contador es mayor que el límite
            btn_out <= 1; //La señal sin antirrebote es 1
        else
            btn_out <= 0; //La señal sin antirrebote es 0
    end

endmodule