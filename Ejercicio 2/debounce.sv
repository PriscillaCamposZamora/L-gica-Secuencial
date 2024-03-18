/* utilizamos dos flip-flops (logic button_ff1 & logic button_ff2) 
para sincronizar la señal del botón con el dominio de reloj "clk".
Cuando se pulsa o suelta el pulsador, se incrementa o disminuye la "cuenta" del contador. 
El contador tiene que alcanzar el threshold antes de que decidamos que el estado del pulsador ha cambiado.

Condición 1: El flip-flop de botón 2 (reg button_ff2) está a "1" alto y la cuenta "count" no está en el límite de 
cuenta.Esto asegura que no contaremos hacia arriba en el límite. Si esta condición coincide, contaremos hacia 
arriba(esto significa btn presionado)
*/



module debouncing #(parameter threshold = 100000 )
// set parameter thresehold to guage how long button pressed
(
input clk, //clock signal
input btn, //input button
output LED, //LED output. Light up when btn is pressed
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

logic button_ff1 = 0; //button flip-flop for synchronization. Initialize it to 0
logic button_ff2 = 0; //button flip-flop for synchronization. Initialize it to 0
logic [20:0]count = 0; //20 bits count for increment & decrement when button is pressed or released. Initialize it to 0
// First use two flip-flops to synchronize the button signal the "clk" clock domain

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
        if (|count)//if count has at least 1 in it. Make sure no subtraction when count is 0
            count <= count-1; //when btn relesed, count down
    end
    if (count > threshold)//if the count is greater the threshold
        dbsig <= 1; //debounced signal is 1
    else
        dbsig <= 0; //debounced signal is 0
end

assign LED = dbsig; // assign debounced signal to LED
assign button_out1 = button_ff1; //assign button_out1 to button_ff1
assign button_out2 = button_ff2; //assign button_out2 to button_ff2


endmodule