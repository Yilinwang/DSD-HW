//`include "counter.v"
//`include "two_digit_ss.v"
//`include "lcd.v"

module stopwatch(
	iRST_N,
	clock_i,
 	button_i, 
	ms_hi_o, ms_lo_o,
	sec_hi_o, sec_lo_o,
	min_hi_o, min_lo_o,
	hr_hi_o, hr_lo_o,
	LCD_DATA,LCD_RW,LCD_EN,LCD_RS,LCD_ON,LCD_BLON,
	led
);

input iRST_N;
output	[7:0]	LCD_DATA;
output			LCD_RW,LCD_EN,LCD_RS, LCD_ON, LCD_BLON;
output reg [3:0] led;

input clock_i;
input [3:0] button_i;
output [6:0] ms_hi_o, ms_lo_o, sec_hi_o, sec_lo_o, min_hi_o, min_lo_o, hr_hi_o, hr_lo_o;
//output lcd_o;

reg enable, reset;
//reg iRST_N;
wire [63:0] counter_o;
wire [6:0] milisecond, second, minute, hour;
reg [31:0] first_rec, second_rec;

initial begin
	led[3] = 0;
	led[2] = 0;
	led[1] = 0;
	led[0] = 0;
	enable = 0;
	reset = 0;
	first_rec = 0;
	second_rec = 0;
end

/*
 * button_i[0]: clear LCD
 * button_i[1]: reset ss / time back to 0
 * button_i[2]: record LCD
 * button_i[3]: begin / pause
*/

// electric potential of button: high -> low(press) -> high
// module counter(enable, reset, clock, counter_o);
wire [32:0] freq;
assign freq = 33'd500000;

counter c0(
	.enable(enable),
	.reset(reset),
	.clock(clock_i),
	.freq(freq),
	.counter_o(counter_o));
//counter c0(enable, reset, clock_i, freq, counter_o);
//counter c0(enable, reset, clock_i, 5, counter_o);
LCD_TEST lcd0(clock_i, iRST_N, first_rec, second_rec, LCD_DATA,LCD_RW,LCD_EN,LCD_RS,LCD_ON,LCD_BLON);

/*
always @(negedge button_i[2])
begin
	iRST_N = 0;
	# 5;
	iRST_N = 1;
	# 5;
end
*/

always @(negedge button_i[3], negedge button_i[1])
begin
	if(~button_i[3]) begin
		enable = ~enable;
		reset = 0;
		//led[3] = ~led[3];
	end
	if (~button_i[1]) begin
		enable = 0;
		reset = 1;
		//led[1] = ~led[1];
	end
	//$display("enable = %d", enable);
end

assign milisecond = counter_o % 100;
assign second = counter_o / 100 % 60;
assign minute = counter_o / 100 / 60 % 24;
assign hour = counter_o / 100 / 60 / 24;

// module two_digit_ss(num_i, hi_o, lo_o);
two_digit_ss milisecond_ss(milisecond, ms_hi_o, ms_lo_o);
two_digit_ss second_ss(second, sec_hi_o, sec_lo_o);
two_digit_ss minute_ss(minute, min_hi_o, min_lo_o);
two_digit_ss hour_ss(hour, hr_hi_o, hr_lo_o);

reg [6:0] rec_tmp1;
reg [6:0] rec_tmp2;
reg [6:0] rec_tmp3;
reg [6:0] rec_tmp4;
reg [6:0] rec_tmp5;
reg [6:0] rec_tmp6;
reg [6:0] rec_tmp7;
reg [6:0] rec_tmp8;
// LCD

always @(negedge button_i[0])
begin
		led[0] = ~led[0];
end

always @(negedge button_i[1])
begin
		led[1] = ~led[1];
end

always @(negedge button_i[2])
begin
		led[2] = ~led[2];
		// copy old record to second
		second_rec = first_rec;
		// record the new record
		rec_tmp1 = milisecond % 10;
		rec_tmp2 = milisecond / 10;
		rec_tmp3 = second % 10;
		rec_tmp4 = second / 10;
		rec_tmp5 = minute % 10;
		rec_tmp6 = minute / 10;
		rec_tmp7 = hour % 10;
		rec_tmp8 = hour / 10;
		first_rec = {rec_tmp8[3:0], rec_tmp7[3:0], rec_tmp6[3:0], rec_tmp5[3:0], rec_tmp4[3:0], rec_tmp3[3:0], rec_tmp2[3:0], rec_tmp1[3:0]};

end

always @(negedge button_i[3])
begin
		//enable = ~enable;
		//reset = 0;
		led[3] = ~led[3];
end
/*
always @(negedge button_i[2], negedge button_i[0])
begin
	if(~button_i[2]) begin
		led[2] = ~led[2];
		// copy old record to second
		second_rec = first_rec;
		// record the new record
		rec_tmp1 = milisecond % 10;
		rec_tmp2 = milisecond / 10;
		rec_tmp3 = second % 10;
		rec_tmp4 = second / 10;
		rec_tmp5 = minute % 10;
		rec_tmp6 = minute / 10;
		rec_tmp7 = hour % 10;
		rec_tmp8 = hour / 10;
		first_rec = {rec_tmp8[3:0], rec_tmp7[3:0], rec_tmp6[3:0], rec_tmp5[3:0], rec_tmp4[3:0], rec_tmp3[3:0], rec_tmp2[3:0], rec_tmp1[3:0]};
	end

	if(~button_i[0]) begin
		//led[0] = ~led[0];
		first_rec = 0;
		second_rec = 0;
	end
end
*/
	


endmodule
