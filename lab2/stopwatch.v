`include "counter.v"
`include "two_digit_ss.v"
//`include "lcd.v"

module stopwatch(
	clock_i,
   	button_i, 
	ms_hi_o, ms_lo_o,
	sec_hi_o, sec_lo_o,
	min_hi_o, min_lo_o,
	hr_hi_o, hr_lo_o,
	lcd_o
);

input clock_i;
input [3:0] button_i;
output [6:0] ms_hi_o, ms_lo_o, sec_hi_o, sec_lo_o, min_hi_o, min_lo_o, hr_hi_o, hr_lo_o;

reg record_times;
reg [31:0] first, second;

initial begin
	record_times = 0;
	first = 0;
	second = 0;
end

/*
 * button_i[0]: clear LCD
 * button_i[1]: reset ss / stop
 * button_i[2]: record LCD
 * button_i[3]: begin / pause
*/

// electric potential of button: high -> low(press) -> high
// module counter(enable, reset, clock, counter_o);
counter c0(~button_i[1] | ~button_[3], ~button_i[1], clock_i, counter_o);

wire [6:0] milisecond, second, minute, hour;
assign milisecond = counter_o % 100;
assign second = counter_o / 100 % 60;
assign minute = counter_o / 100 / 60 % 24;
assign hour = counter_o / 100 / 60 / 24;

// module two_digit_ss(num_i, hi_o, lo_o);
two_digit_ss milisecond_ss(milisecond, ms_hi_o, ms_lo_o);
two_digit_ss second_ss(second, sec_hi_o, sec_lo_o);
two_digit_ss minute_ss(minute, min_hi_o, min_lo_o);
two_digit_ss hour_ss(hour, hr_hi_o, hr_lo_o);

// LCD
always @(posedge button_i[2])
begin
	record_times = record_times + 1;
	// copy old record to second
	assign second = first;
	// record the new record
	assign first[4:0] = milisecond % 10;
	assign first[8:5] = milisecond / 10;
	assign first[12:9] = second % 10;
	assign first[16:13] = second / 10;
	assign first[20:17] = minute % 10;
	assign first[24:21] = minute / 10;
	assign first[28:25] = hour % 10;
	assign first[32:29] = hour / 10;
	
	lcd lcd(first, second, lcd_o);
	
end

always @(posedge button_i[0])
begin
	record_times = 0;
	first = 0;
	second = 0;
	lcd lcd(first, second, lcd_o);
end
	


endmodule
