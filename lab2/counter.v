module counter(enable, reset, clock, counter_o);
input enable;
input reset;
input clock;
output reg [63:0] counter_o;
reg [30:0] tmp;

initial begin
	tmp = 0;
	counter_o = 0;	//10^-2
end


always @(posedge clock)
begin
	if(reset == 1) begin
		#5 counter_o = 0;
		#5 tmp = 0;
	end
	else if(enable == 1) begin
		#5 tmp = tmp + 1;
	end

	//if(tmp == 5) begin
	if(tmp == 500000) begin
		#5 tmp = 0;
		#5 counter_o = counter_o + 1;
		#5 $display("%4dns: counter_o=%d", $time, counter_o); 
	end
end

endmodule
