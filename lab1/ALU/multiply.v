module multiply(A, B, O);

input [5:0] A;
input [5:0] B;
output [11:0] O;

wire [11:0] a;
wire [5:0] b;
assign a = (A[5] == 1'b1)? ~{{6{A[5]}} ,A} +1 : {{6{A[5]}} ,A};
assign b = (B[5] == 1'b1)? ~B+1 : B;

assign O = (A[5]^B[5] == 1'b1)? 

		   ~(((b[0] == 1'b1)? a:0) +
		   ((b[1] == 1'b1)? a<<1:0) +
		   ((b[2] == 1'b1)? a<<2:0) +
		   ((b[3] == 1'b1)? a<<3:0) +
		   ((b[4] == 1'b1)? a<<4:0) +
		   ((b[5] == 1'b1)? a<<5:0)) +1

		   :
	
		   ((b[0] == 1'b1)? a:0) +
		   ((b[1] == 1'b1)? a<<1:0) +
		   ((b[2] == 1'b1)? a<<2:0) +
		   ((b[3] == 1'b1)? a<<3:0) +
		   ((b[4] == 1'b1)? a<<4:0) +
		   ((b[5] == 1'b1)? a<<5:0);

endmodule
