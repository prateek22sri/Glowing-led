module LEDglow(
    input clk,
    input reset,
    output led,
    output pin
    );    

localparam magic_bit = 10;

reg prev_slow_counter = 0;
reg [31:0] slow_counter = 0;
reg [9:0] pwm_counter = 0;
reg [8:0] pwm_period_counter = 0;
reg [9:0] counter_10 = 1;
reg prev_counter_10 = 0;
reg [9:0] intensity_val = 0; 
reg state = 0;

always @ (posedge clk) begin
    if (reset) begin 
        slow_counter <= 1;
        prev_slow_counter <= 0;
        pwm_counter <= 0;
        pwm_period_counter <= 0;
        intensity_val <= 1;
    end
    else begin
        prev_slow_counter <= slow_counter[magic_bit];
        slow_counter <= slow_counter + 1;        
    end

    if(prev_slow_counter == 0 && slow_counter[magic_bit] == 1) begin
        pwm_period_counter <= pwm_period_counter+1;
        if (pwm_period_counter == 0) begin
            pwm_counter <= intensity_val;
            intensity_val <= (intensity_val < 512)? intensity_val + 1 : 1;
        end
        else begin
            if (pwm_counter > 0)
                pwm_counter <= pwm_counter-1;
        end
    end 
end
assign led = (pwm_counter != 0);
assign pin = led;

endmodule