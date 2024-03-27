/* utilizamos dos flip-flops (logic button_ff1 & logic button_ff2) 
para sincronizar la señal del botón con el dominio de reloj "clk".
Cuando se pulsa o suelta el pulsador, se incrementa o disminuye la "cuenta" del contador. 

Condición 1: El flip-flop de botón 2 (reg button_ff2) está a "1" alto y la cuenta "count" no está en el límite de 
cuenta.Esto asegura que no contaremos hacia arriba en el límite. Si esta condición coincide, contaremos hacia 
arriba(esto significa btn presionado)
*/

/*Se define el parámetro threshold para saber cuánto tiempo el botón debe ser presionado
Se sigue la siguiente fórmula
Valor_dividido = [10 Mhz/(2*Frecuencia_deseada)] - 1 => Valor dividido = 10000
Con esto se obtiene que el botón debe ser pulsado al menos 2 ms
*/

module debouncing #(parameter threshold = 100000 )

(
input clk, //clock de entrada
input btn, //boton de entradas
output LED, //LED. Se va encender conforme el contador aumenta
output logic dbsig, //debounced signal to logic analyzer
output button_out1, //flip-flop1 signal to logic analyzer
output button_out2 //flip-flop2 signal to logic analyzer
);
/*
 clk_wiz_0 pll_clk
   (
    // Clock out ports
    .CLK_OUT_10MHz(CLK_OUT_10MHz),     // output CLK_OUT_10MHz
    // Status and control signals
    .reset(reset), // input reset
    .locked(locked),       // output locked
   // Clock in ports
    .CLK_in_100MHz(clk)      // input CLK_in_100MHz
);
*/

logic button_ff1 = 0; ////Flip-flop de botón para sincronización
logic button_ff2 = 0; //Otro flip-flop de botón para sincronización
logic [20:0]count = 0; //Contador para incrementar o decrementar cuándo tiempo el botón debe ser pulsado
// Primero se usan dos flip-flops para sincronizar el botón con el clk

always @(posedge clk)begin
button_ff1 <= btn;
button_ff2 <= button_ff1;
end
// When the push-button is pushed or released, we increment or decrement the counter
// The counter has to reach threshold before we decide that the push-button state has changed
always @(posedge clk) begin
    if (button_ff2) //if button_ff2 is 1
    begin
        if (~&count)//if it isn't at the count limit. Make sure won't count up at the limit. First AND all count and then not the AND
            count <= count+1; // when btn pressed, count up
    end 
    else begin
        if (|count)//Si el contador tiene al menos un bit en él. Para asegurarse que no se reste cuando count sea cero
            count <= count-1; ///Cuando btn_in deja de ser pulsado, resta
    end
    if (count > threshold)//Si el contador es mayor que el límite
        dbsig <= 1; //La señal sin antirrebote es 1
    else
        dbsig <= 0; //La señal sin antirrebote es 0
end

assign LED = dbsig; // assign debounced signal to LED
assign button_out1 = button_ff1; //assign button_out1 to button_ff1
assign button_out2 = button_ff2; //assign button_out2 to button_ff2

endmodule
