module ALU(
    A_i,
    B_i,
    Op_i,
    Led_i,
    data_o,
    A_hi_o,
    A_lo_o,
    B_hi_o,
    B_lo_o,
    C_first_o,
    C_second_o,
    C_third_o,
    C_fourth_o
);

input [5:0] A_i;
input [5:0] B_i;
input [1:0] Op_i;
input   Led_i;
output [11:0] data_o;
output [6:0] A_hi_o, A_lo_o, B_hi_o, B_lo_o, C_first_o, C_second_o, C_third_o, C_fourth_o;
wire [11:0] A, B, result, mult, div;
wire [5:0] add, sub, q, r;
wire over, add_over, sub_over;
adder adder(
  .A(A_i),
  .B(B_i),
  .C(add),
  .overflow(add_over)
);
subtractor subtractor(
  .A(A_i),
  .B(B_i),
  .C(sub),
  .overflow(sub_over)
);
multiply multiply(
  .A(A_i),
  .B(B_i),
  .O(mult)
);
divider divider(
  .a(A_i),
  .b(B_i), 
  .q(q), 
  .r(r)
);
two_digit_ss A_ss(
  .data_i(A_i),
  .hi_o(A_hi_o),
  .lo_o(A_lo_o)
);
two_digit_ss B_ss(
  .data_i(B_i),
  .hi_o(B_hi_o),
  .lo_o(B_lo_o)
);
four_digit_ss C_ss(
  .data_i(result),
  .first_o(C_first_o), 
  .second_o(C_second_o), 
  .third_o(C_third_o), 
  .fourth_o(C_fourth_o)
);
assign over = (Op_i == 2'b00)? add_over: (Op_i == 2'b01)? sub_over: 1'b0;
assign A = {{6{A_i[5]}}, A_i};
assign B = {{6{B_i[5]}}, B_i};
assign div = {r, q};
assign result = (Op_i == 2'b00)? {{6{1'b0}}, add[5:0]}:
                (Op_i == 2'b01)? {{6{1'b0}}, sub[5:0]}:
                (Op_i == 2'b10)? mult:
                (Op_i == 2'b11)? div : 0;
assign data_o = (Led_i == 1'b1)? {A, B}: result;
endmodule