module counter(enable, reset, clock, counter_o);
input enable;
input reset;
input clock;
output reg [7:0] counter_o;
reg [20:0] tmp;

initial begin
	tmp = 8'b00000000;
	counter_o = 8'b00000000;	//10^-2
end


always @(posedge clock)
begin
	if(reset) begin
		counter_o = 8'b00000000;
	end
	else if(enable) begin
		tmp = tmp + 1;
	end

	if(tmp == 500000) begin
		tmp = 8'b00000000;
		counter_o = counter_o + 1;
		$display("%4dns: counter_o=%d", $time, counter_o); 
	end
end

endmodule