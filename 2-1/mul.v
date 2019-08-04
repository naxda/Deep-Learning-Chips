
module mul #(
// tb_rtl과 연결하는 부분의 parameter부분
 parameter A = 8,
 parameter B = 8,
 parameter MUL_0 = A+B
)
(
	input wire	i_clk	,
	input wire	i_resetn	,
	
	input wire	[A-1:0] mul_a,
	input wire	[B-1:0] mul_b,
	output wire	[MUL_0-1:0] mul_out
);

// output wire의 mul_out이 계산되는 부분

assign mul_out = $signed(mul_a) * $signed(mul_b); 
// 21ns에서 mul_a=48, mul_b=20값을 받아서 adder_out을 960으로 계산해서 내보내고
// 26ns에서 mul_a=-4, uml_b=2값을 받아서 adder_out을 -8으로 계산해서 내보냄-스크린샷

endmodule

