module ALU_test(
    A_i,
    B_i,
    Op_i,
    Led_i,
    data_o
);

input [5:0] A_i;
input [5:0] B_i;
input [1:0] Op_i;
input   Led_i;
output [11:0] data_o;
wire [11:0] A, B, result, add, sub, mult, div, r, q;

assign A = {{6{A_i[5]}}, A_i};
assign B = {{6{B_i[5]}}, B_i};
assign add = A+B;
assign sub = A-B;
assign mult = A*B;
assign r = A%B;
assign q = A/B;
assign div = {r[5:0], q[5:0]};
assign result = (Op_i == 2'b00)? {{6{1'b0}}, add[5:0]}:
                (Op_i == 2'b01)? {{6{1'b0}}, sub[5:0]}:
                (Op_i == 2'b10)? mult:
                (Op_i == 2'b11)? div : 0;
assign data_o = (Led_i == 1'b0)? {A, B}: result;
endmodule