module counter(enable, reset, clock, counter_o);
input enable;
input reset;
input clock;
output reg [63:0] counter_o;
reg [20:0] tmp;

initial begin
	tmp = 0;
	counter_o = 0;	//10^-2
end


always @(posedge clock)
begin
	if(reset == 1) begin
		counter_o = 0;
		tmp = 0;
		$diplay("counter_o=%d, tmp=%d", counter_o, tmp);
	end
	if(enable == 1) begin
		tmp = tmp + 1;
		$diplay("tmp=%d", tmp);
	end

	//if(tmp == 500000) begin
	if(tmp == 5) begin
		tmp = 0;
		counter_o = counter_o + 1;
		$display("%4dns: counter_o=%d", $time, counter_o); 
	end
end

endmodule
