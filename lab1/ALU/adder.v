//`include "one_bit_adder.v"

module adder(A, B, C, overflow);
	input [5:0] A;
	input [5:0] B;
	output [5:0] C;
	output overflow;

	wire [5:0] cout;

	one_bit_adder a0(A[0], B[0], 1'b0, cout[0], C[0]);
	one_bit_adder a1(A[1], B[1], cout[0], cout[1], C[1]);
	one_bit_adder a2(A[2], B[2], cout[1], cout[2], C[2]);
	one_bit_adder a3(A[3], B[3], cout[2], cout[3], C[3]);
	one_bit_adder a4(A[4], B[4], cout[3], cout[4], C[4]);
	one_bit_adder a5(A[5], B[5], cout[4], cout[5], C[5]);

	assign overflow = ((A[5]&B[5]&(~C[5])) | ((~A[5])&(~B[5])&C[5]));
	 
endmodule




