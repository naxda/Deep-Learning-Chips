
module mul #(
// tb_rtl과 연결하는 부분의 parameter부분
 parameter A = 8,
 parameter B = 8,
 parameter O = A+B
)
(
	input wire	i_clk	,
	input wire	i_resetn,
	
	input wire	[A-1:0] mul_a,
	input wire	[B-1:0] mul_b,
	output wire	[O-1:0] mul_out
);

// output wire의 mul_out이 계산되는 부분

assign mul_out = $signed(mul_a) * $signed(mul_b); 

endmodule

