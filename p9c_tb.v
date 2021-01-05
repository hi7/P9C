`default_nettype none
`timescale 1ns / 1ns
`include "p9c.v"

module p9c_tb();

parameter DURATION = 130_000_000; // 120ms

reg clk_12=1;
always #41.666 clk_12 = ~clk_12; // 12MHz

wire resx,
  led1, led2, led3, led4, 
  led5, led6, led7, led8,
  lcol1, lcol2, lcol3, lcol4; //, dcx, bl, csx, sda, scl, usbpu;

top UUT(
  .clk(clk_12),
  .resx(resx),
  /*.DCX(dcx),
  .BL(bl),
  .CSX(csx),
  .SDA(sda),
  .SCL(scl),
  .USBPU(usbpu),*/
  .led1(led1), .led2(led2), .led3(led3), .led4(led4),
  .led5(led5), .led6(led6), .led7(led7), .led8(led8),
  .lcol1(lcol1), .lcol2(lcol2), .lcol3(lcol3), .lcol4(lcol4)
);

initial begin
    $dumpfile("p9c_tb.vcd");
    $dumpvars(0, p9c_tb);
    #(DURATION) $display("end of sim");
    $finish;
end

endmodule
