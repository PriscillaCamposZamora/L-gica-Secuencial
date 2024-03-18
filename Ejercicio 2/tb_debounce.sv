`timescale 1ns / 1ps

/*Se crea un reloj de 20ns y la entrada btn se pone a 0 y luego a 1 después de 10ns. 
La señal dbsig y LED será "1" a los 2ms. 

*/
module debounce_tb();

//Inputs in the module enable_sr. Need to use register type

reg clk = 0; //clock signal
reg btn; //input button
//Outputs in the module enable_sr. Need to use net type
wire LED; //LED output. Light up when btn is pressed
wire dbsig; //debounced signal to logic analyzer
wire button_out1; //flip-flop1 signal to logic analyzer
wire button_out2; //flip-flop2 signal to logic analyzer
// Instantiate the Unit Under Test (UUT) for module debouncing

debouncing uut(
.clk(clk),
.btn(btn),
.LED(LED),
.dbsig(dbsig),
.button_out1(button_out1),
.button_out2(button_out2)
);

// Generate the continuous clock signal. Wait for 10ns. Period is 20ns

always #10 clk = ~clk;
//Generate the button stimulus
initial begin
btn = 0;
#10 btn = 1;
end

// Need initial whenever we run finish or we need to include it in the begin end
initial
#4000 $finish;
endmodule