//`include "seven_segment.v"

module two_digit_ss(num_i, hi_o, lo_o);
input [6:0] num_i;
output [6:0] hi_o, lo_o;
wire [3:0] hi, lo;

assign hi = num_i / 10;
assign lo = num_i % 10;

seven_segment ss_hi(hi, hi_o);
seven_segment ss_lo(lo, lo_o);

endmodule
