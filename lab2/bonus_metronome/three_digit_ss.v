module three_digit_ss(num_i, ss1_o, ss2_o, ss3_o);
input [9:0] num_i;
output [6:0] ss1_o;
output [6:0] ss2_o;
output [6:0] ss3_o;
wire [3:0] num1_o;
wire [3:0] num2_o;
wire [3:0] num3_o;

assign num1_o = (num_i / 1) % 10;
assign num2_o = (num_i / 10) % 10;
assign num3_o = (num_i / 100) % 10;

seven_segment s1(num1_o, ss1_o);
seven_segment s2(num2_o, ss2_o);
seven_segment s3(num3_o, ss3_o);

endmodule
