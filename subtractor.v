`include "adder.v"
module subtractor(A, B, C, overflow);
	input [5:0] A, B;
	output [5:0] C;
	output overflow;

	//A-B = A+(-B)
	wire [5:0] B_com;
	wire tmp;
	adder a0(6'b000001, ~B, B_com, tmp);
	adder a1(A, B_com, C, overflow);

endmodule

