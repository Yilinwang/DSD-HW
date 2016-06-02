module two_digit_ss(data_i, hi_o, lo_o);
input [5:0] data_i;
output [6:0] hi_o, lo_o;
wire [3:0] hi, lo;
wire [6:0] data;

assign data = (data_i[5] == 1'b0)? {1'b0, data_i}: 7'd32 - {2'b0, data_i[4:0]};
assign hi = data / 10;
assign lo = data % 10;

seven_segment lo_segment(
  .num(lo),
  .data_o(lo_o)
);
seven_segment hi_segment(
  .num(hi),
  .data_o(hi_o)
);

endmodule