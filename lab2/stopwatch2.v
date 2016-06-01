module stopwatch2(
	clock_i,
 	button_i, 
	ms_hi_o, ms_lo_o,
	sec_hi_o, sec_lo_o,
	min_hi_o, min_lo_o,
	hr_hi_o, hr_lo_o,
	LCD_DATA,LCD_RW,LCD_EN,LCD_RS,LCD_ON,LCD_BLON
);

output	[7:0]	LCD_DATA;
output			LCD_RW,LCD_EN,LCD_RS, LCD_ON, LCD_BLON;

input clock_i;
input [3:0] button_i;
output [6:0] ms_hi_o, ms_lo_o, sec_hi_o, sec_lo_o, min_hi_o, min_lo_o, hr_hi_o, hr_lo_o;

reg enable, reset;
wire [63:0] counter_o;
wire [6:0] milisecond, second, minute, hour;
reg [31:0] first_rec, second_rec;
reg [32:0] button2_tmp, button3_tmp;
wire lcd_reset;


initial begin
	enable = 0;
	reset = 0;
	first_rec = 0;
	second_rec = 0;
	button2_tmp = 0;
	button3_tmp = 0;
end

/*
 * button_i[0]: clear LCD
 * button_i[1]: reset ss / time back to 0
 * button_i[2]: record LCD
 * button_i[3]: begin / pause
 * electric potential of button: high -> low(press) -> high
*/

counter c0(enable, reset, clock_i, freq, counter_o);

reset_delay r0(button_i[2], button_i[0], clock_i, lcd_reset);
wire [32:0] freq;
assign freq = 33'd500000;
LCD_TEST lcd0(clock_i, lcd_reset, first_rec, second_rec, LCD_DATA,LCD_RW,LCD_EN,LCD_RS,LCD_ON,LCD_BLON);

assign milisecond = counter_o % 100;
assign second = counter_o / 100 % 60;
assign minute = counter_o / 100 / 60 % 24;
assign hour = counter_o / 100 / 60 / 24;

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

always @(posedge clock_i)
begin
	if(~button_i[0]) begin
		first_rec = 0;
		second_rec = 0;
	end
	if(~button_i[1]) begin
		enable = 0;
		reset = 1;
	end

	if(~button_i[2]) begin
		button2_tmp = button2_tmp + 1;
		if(button2_tmp == 1) begin
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
	end
	else if(button_i[2]) begin	//not pressed
		button2_tmp = 0;
	end
	if(~button_i[3]) begin
		button3_tmp = button3_tmp + 1;
		if(button3_tmp == 1) begin
			enable = ~enable;
			reset = 0;
		end
	end
	if(button_i[3]) begin	//not pressed
		button3_tmp = 0;
	end
end

endmodule
