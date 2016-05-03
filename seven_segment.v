module seven_segment(num, data_o);
input [3:0] num;
output reg [6:0] data_o;
//reg a, b, c, d, e, f, g;

always@(*) begin 
    data_o[0] = (num != 1 && num != 4) ? 1 : 0;
    data_o[1] = (num != 5 && num != 6) ? 1 : 0;
    data_o[2] = (num != 2) ? 1 : 0;
    data_o[3] = (num != 1 && num != 4 && num != 7) ? 1 : 0;
    data_o[4] = (num == 0 || num == 2 || num == 6 || num == 8) ? 1 : 0;
    data_o[5] = (num != 1 && num != 2 && num != 3 && num != 7) ? 1 : 0;
    data_o[6] = (num != 0 && num != 1 && num != 7) ? 1 : 0;
end
endmodule
