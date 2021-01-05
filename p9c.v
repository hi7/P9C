/*
 *  Hilger Baumstark (hi7) 
 */

// drive LCD via SPI
module top (clk, // 12MHz
    resx,
    led1, led2, led3, led4, led5, led6, led7, led8, 
    lcol1, lcol2, lcol3, lcol4 
    );
    /* I/O */
    input clk; // 12MHz, 83.333ns period, 41.666 up/down time
    output resx; 
    output led1, led2, led3, led4, led5, led6, led7, led8;
    output lcol1, lcol2, lcol3, lcol4;

    reg [31:0] counter = 32'b0;
    //reg [1:0] index = counter[16:15]; // mux every 2^15 ticks
    reg initx = 0; // low active 
    assign resx = initx | (counter < 12000 | counter > 24000); // reset only once
    reg [7:0] mem[3:0];
    initial begin
        $display("load bitmap");
        $readmemh("bitmap.mem", mem);
    end

    /* LED drivers - counter is inverted for display because leds are active low */
    assign {led8, led7, led6, led5, led4, led3, led2, led1} = mem[counter[16:15]] ^ 8'hff;
    assign {lcol4, lcol3, lcol2, lcol1} = 7'b1110111 >> counter[16:15];

    /* Count up on every rising edge of the incoming 12MHz clk */
    always @ (posedge clk) begin
        counter <= counter + 1;
        if(counter > 24000) initx = 1;
    end

endmodule
