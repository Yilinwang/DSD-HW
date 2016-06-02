module	reset_delay(input button2, input button0, input iCLK, output reg oRESET);
reg	[31:0]	Cont;
reg flag;
reg state;
reg [32:0] button2_tmp, button0_tmp;

initial begin
	button2_tmp = 0;
	button0_tmp = 0;
end

always@(posedge iCLK)
begin
	if(state) begin
		if(~button0 | ~button2) begin
			state = 1'b0;
			button2_tmp = 33'd0;
		end
	end
	if(~state) begin
		if(button2_tmp == 33'd2) begin
			oRESET <= 1'b1;
			state <= 1'b1;
		end
		if(Cont < 32'd12500000)
		begin
			Cont	<=	Cont + 1;
		end
		else
		begin
			flag <= ~flag;
			Cont <= 0;
			button2_tmp <= button2_tmp + 1;
		end

		if(flag)
			oRESET <= 1'b0;
		else
			oRESET <= 1'b1;
	end
end
/*
if(button0) begin
	button0_tmp = 0;
end
if(~button2) begin
	button2_tmp = button2_tmp + 1;
	if(button2_tmp == 1) begin

		if(Cont < 32'd25000000)
		begin
			Cont	<=	Cont + 1;
		end
		else
		begin
			flag <= ~flag;
			Cont <= 0;
		end

		if(flag)
			oRESET <= 1'b0;
		else
			oRESET <= 1'b1;
	end
end
if(button2) begin
	button2_tmp = 0;
end
end
*/
endmodule
