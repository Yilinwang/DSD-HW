module	reset_delay_m(iCLK,oRESET);
input		iCLK;
output reg	oRESET;
reg	[31:0]	Cont;
reg flag;

always@(posedge iCLK)
begin
	if(Cont!=32'd12500000)
	begin
		Cont	<=	Cont+1;
	end
	else begin
		flag <= ~flag;
		Cont <= 32'd0;
	end

	if(flag)
		oRESET <= 1'b1;
	else
		oRESET <= 1'b0;
end

endmodule
