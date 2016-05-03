module one_bit_adder(a, b, carry_in, carry_out, result);
	input a, b, carry_in;
	output carry_out, result;

	assign carry_out = (b&carry_in) | (a&(b^carry_in));
	assign result = a^b^carry_in;

endmodule

