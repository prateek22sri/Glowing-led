`timescale 1ns / 1ps

module tb_led;

reg clk = 0;
reg reset = 0;
wire led;

always
    #4 clk = !clk;

LEDglow uut
(
  .clk(clk),
  .reset(reset),
  .led(led)
);

initial
    #10_000_000 $finish;

endmodule