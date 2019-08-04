
module adder #(
// tb_rtl과 연결하는 부분의 parameter부분
 parameter A = A+B,
 parameter B = A+B,
 parameter O = A+B+1
)
(
	input wire	i_clk	,
	input wire	i_resetn,
	
	input wire	[A-1:0] mul_out_0,
	input wire	[B-1:0] mul_out_1,
	output wire	[O-1:0] adder_out
);

// output wire의 adder_out이 계산되는 부분

assign adder_out = $signed(mul_out_0) + $signed(mul_out_1); 


endmodule

