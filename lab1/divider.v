module divider(a, b, q, r);
input [5:0] a, b;
output reg [5:0] q, r;
reg [11:0] a_tmp, b_tmp;
reg neg;
integer i;

always@(*)
begin
    q = 0;
    r = 0;
    neg = a[5] ^ b[5];
    a_tmp = (a[5] == 1'b1) ? {{6{1'b0}}, ~a + 1} : {{6{1'b0}}, a};
    b_tmp = (b[5] == 1'b1) ? {~b + 1, {6{1'b0}}} : {b, {6{1'b0}}};
        
    //quotient
    for(i = 0; i < 6+1; i = i + 1)     
    begin
        if(a_tmp >= b_tmp)
        begin
            a_tmp = a_tmp - b_tmp;
            q[0] = 1'b1;
        end
        if(i<6) begin
          q = q << 1;
          a_tmp = a_tmp << 1;
        end
    end

    //remainder
    r = a_tmp[11:6];
end
endmodule
