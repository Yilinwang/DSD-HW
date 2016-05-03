module test_bench;
integer i, j, k;
reg [5:0] A, B;
reg [1:0] Op;
reg Led;
wire [11:0] result, test;
ALU ALU(
  .A_i(A),
  .B_i(B),
  .Op_i(Op),
  .Led_i(Led),
  .data_o(result)
);
ALU_test ALU_test(
  .A_i(A),
  .B_i(B),
  .Op_i(Op),
  .Led_i(Led),
  .data_o(test)
);
initial begin
  A=6'b000000;
  B=6'b000000;
  Op=2'b00;
  Led=1'b0;
  for(k=0; k<3; k=k+1) begin
    for(i=-32; i<32; i=i+1) begin
      for(j=-32; j<32; j=j+1) begin
        A=i[5:0];
        B=j[5:0];
        Op=k[1:0];
        Led=1'b0;
        #5;
        if(result != test) begin
          $display("%d %d", i, j);
          $display("wrong!!!!!");
          $display("result = %d, ans %d", result, test);
        end
        
        Led=1'b1;
        #5;
        if(result != test) begin
          $display("%d %d", i, j);
          $display("wrong!!!!!");
          $display("result = %d, ans %d", result, test);
        end
        
      end
    end
  end
  for(i=0; i<32; i=i+1) begin
    for(j=1; j<32; j=j+1) begin
      A=i[5:0];
      B=j[5:0];
      Op=2'b11;
      Led=1'b0;
      #5;
      if(result != test) begin
        $display("wrong!!!!!");
        $display("%d %d", i, j);
        $display("result_r = %d, ans_r %d", result[11:6], test[11:6]);
        $display("result_q = %d, ans_q %d", result[5:0], test[5:0]);
      end
      Led=1'b1;
      #5;
      if(result != test) begin
        $display("wrong!!!!!");
        $display("%d %d", i, j);
        $display("result_r = %d, ans_r %d", result[11:6], test[11:6]);
        $display("result_q = %d, ans_q %d", result[5:0], test[5:0]);
      end
    end
  end
end
endmodule