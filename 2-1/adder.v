
module adder #(
// tb_rtl과 연결하는 부분의 parameter부분
 parameter A = 8,
 parameter B = 8,
 parameter ADDER_0 = A+1
)
(
	input wire	i_clk	,
	input wire	i_resetn	,
	
	input wire	[A-1:0] adder_a,
	input wire	[B-1:0] adder_b,
	output wire	[ADDER_0-1:0] adder_out
);

// output wire의 adder_out이 계산되는 부분

assign adder_out = $signed(adder_a) + $signed(adder_b); 
// 21ns에서 adder_a=48, adder_b=20값을 받아서 adder_out을 68로 계산해서 내보내고
// 26ns에서 adder_a=-4, adder_b=2값을 받아서 adder_out을 -2로 계산해서 내보냄-스크린샷

endmodule

