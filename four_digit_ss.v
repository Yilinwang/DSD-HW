module four_digit_ss(data_i, first_o, second_o, third_o, fourth_o);
input [11:0] data_i;
output [6:0] first_o, second_o, third_o, fourth_o;
wire [3:0] first, second, third, fourth;
wire [11:0] data;

assign data = (data_i > 0)? data_i: -data_i;
assign first = data / 1000;
assign second = (data % 1000)/100;
assign third = (data % 100) / 10;
assign fourth = data % 10;
seven_segment first_segment(
  .num(first),
  .data_o(first_o)
);
seven_segment second_segment(
  .num(second),
  .data_o(second_o)
);
seven_segment third_segment(
  .num(third),
  .data_o(third_o)
);
seven_segment fourth_segment(
  .num(fourth),
  .data_o(fourth_o)
);

endmodule

