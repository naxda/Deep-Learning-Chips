module tester_ex1_2 #(
// tb_rtl.v와 연결하는 부분

 parameter A=8,	
 parameter B = 8,
 parameter ADDER_0 = A+1
)

(
	input wire			i_clk		, // tb_rtl.v와 i_clk연결
	output reg			o_resetn	, // 아래서 계산한 o_restn값 저장
	
	output reg	[A-1:0]		op_a		,
	output reg	[B-1:0]		op_b		// 아래서 계산한 op_a, op_b값 저장
);


//output reg로 보낼 값들이 계산되는 부분

	initial
	begin
		#1; //1 ns
		#5 // 6ns
		o_resetn = 1'b0;
		#10 // 16ns
		o_resetn = 1'b1; // 16ns부터 o_resetn이 0 -> 1로 바뀜
		#5; //21ns

		op_a = 8'b0011_0000; // 3.0 (n=4,f=4)
		op_b = 8'b0001_0100; // 1.25 (n=4, f=4)
		// 21ns에서 op_a와 op_b가 바뀜 위의 binary를 16진수로 바꾸면 각각 30과 14 - 스크린샷 

		#5;
		op_a = 8'b1111_1100; // -4.0 (n=8, f=0)
		op_b = 8'b0000_0100; // 4.0 (n=8, f=0)
		// 26ns에서 op_a와 op_b가 바뀜 각각 FC와 04 - 스크린샷 		

		#100;
		$finish;
	end		 
endmodule
