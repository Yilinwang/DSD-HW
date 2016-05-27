`include "stopwatch.v"
module stopwatch_test_bench();

reg enable, reset, clock;
wire [7:0] counter_o;

counter c0(enable, reset, clock, counter_o);

initial begin
	clock = 1;
	reset = 0;  
	enable = 0;
	#5 reset = 1;
	#10 reset = 0;
	#5 enable = 1;
end

always #10 begin	//20ns clock: 1->0->1
	clock=~clock; 
end

endmodule
