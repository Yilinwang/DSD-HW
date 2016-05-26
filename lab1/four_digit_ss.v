module four_digit_ss(op, data_i, first_o, second_o, third_o, fourth_o);
input [11:0] data_i;
input [1:0] op;
output [6:0] first_o, second_o, third_o, fourth_o;
wire [12:0] first, second, third, fourth;
wire [12:0] data;
wire [6:0] add;

assign data = (data_i[11] == 1'b0)? {1'b0, data_i}: 13'd2048 - {2'b0, data_i[10:0]};
assign add = (data_i[5] == 1'b0)? {1'b0, data_i}: 7'd32 - {2'b0, data_i[4:0]};
assign first = (op[1]==1'b0)? 0: ((op[1:0] == 2'b10)? data / 1000 : data_i[11:6]/10);
assign second = (op[1]==1'b0)? 0: ((op[1:0] == 2'b10)? (data % 1000)/100 : data_i[11:6]%10);
assign third = (op[1]==1'b0)? (add/10): ((op[1:0] == 2'b10)? (data % 100) / 10 : data_i[5:0]/10);
assign fourth = (op[1]==1'b0)? add%10: ((op[1:0] == 2'b10)? data % 10 : data_i[5:0]%10);
seven_segment first_segment(
  .num(first[3:0]),
  .data_o(first_o)
);
seven_segment second_segment(
  .num(second[3:0]),
  .data_o(second_o)
);
seven_segment third_segment(
  .num(third[3:0]),
  .data_o(third_o)
);
seven_segment fourth_segment(
  .num(fourth[3:0]),
  .data_o(fourth_o)
);

endmodule

