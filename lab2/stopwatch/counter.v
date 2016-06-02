module counter(enable, reset, clock, freq, counter_o);
input [32:0] freq;
input enable;
input reset;
input clock;
output reg [63:0] counter_o;
reg [32:0] tmp;

initial begin
	tmp = 0;
	counter_o = 0;	//10^-2
end


always @(posedge clock)
begin
	if(reset == 1'b1) begin
		counter_o = 0;
		tmp = 0;
	end
	else if(enable == 1'b1) begin
		tmp = tmp + 1;
	end

	if(tmp == freq) begin
		tmp = 0;
		counter_o = counter_o + 1;
		$display("%4dns: counter_o=%d", $time, counter_o); 
	end
end

endmodule
