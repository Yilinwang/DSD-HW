`include "stopwatch.v"
module stopwatch_test_bench;

//reg enable, reset;
reg clock;
//wire [63:0] counter_o;
reg [3:0] button_i;
wire [6:0] ms_hi_o, ms_lo_o, sec_hi_o, sec_lo_o, min_hi_o, min_lo_o, hr_hi_o, hr_lo_o;

stopwatch s1(clock, button_i, ms_hi_o, ms_lo_o,
	sec_hi_o, sec_lo_o,
	min_hi_o, min_lo_o,
	hr_hi_o, hr_lo_o);

initial begin
	$display("start program!");
	clock = 0;
	button_i[0] = 1;	//not pressed
	button_i[2] = 1;
	button_i[1] = 1;  
	button_i[3] = 1;  

	//begin
	#1000000000
	$display("begin!");
	button_i[3] = 1; 
	#10 button_i[3] = 0; 
	#10 button_i[3] = 1;

	//pause
	#100000000
	$display("pause!");
	button_i[3] = 1; 
	#10 button_i[3] = 0; 
	#10 button_i[3] = 1;

	//reset
	#100000000
	$display("reset!");
	button_i[1] = 1;
	#10 button_i[1] = 0;
	#5 button_i[1] = 1;

	//begin
	#100000000
	$display("begin!");
	button_i[3] = 1; 
	#10 button_i[3] = 0; 
	#10 button_i[3] = 1;

	//reset
	#100000000
	$display("reset!");
	button_i[1] = 1;
	#10 button_i[1] = 0;
	#5 button_i[1] = 1;

	//begin
	#100000000
	$display("begin!");
	button_i[3] = 1; 
	#10 button_i[3] = 0; 
	#10 button_i[3] = 1;

end

always #10 begin	//20ns clock: 1->0->1
	clock=~clock; 
end

endmodule
