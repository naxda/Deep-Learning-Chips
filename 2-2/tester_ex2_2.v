module tester_ex2_2 #(

//tb_rtl과 연결되는 부분 정의
 parameter A = 8,	
 parameter B = 8,
 parameter ADDER_0 = A+1,
 parameter MUL_0 = A+B+2,
 parameter O = A+B+2
)
(
	input wire			i_clk		,
	output reg			o_resetn	,
	output reg [3*A-1:0] pe_mul_a, // 맨아래에서 mul_a[0],[1],[2]로 들어갈 수 있도록, 23비트 공간을 확보
	output reg [3*B-1:0] pe_mul_b

);
reg	[A-1:0]		mul_a[0:2]; // 이 파일 내에서 바로 사용
reg	[B-1:0]		mul_b[0:2];



	initial
	begin
		#1; //1ns
		#5 // 6ns
		o_resetn = 1'b0;
		#10 // 16ns
		o_resetn = 1'b1;
		#5; // 21ns

		mul_a[0] = 8'b0011_0000; //3
		mul_a[1] = 8'b0001_0100; //1.25
		mul_a[2] = 8'b0011_0000;//3.0

		mul_b[0] = 8'b0100_1000;//4.5
		mul_b[1] = 8'b0011_1100;//3.75
		mul_b[2] = 8'b0100_1000;//4.5
		
/* 검증
		mul_a[0]*mul_b[0] = 3*4.5 = 13.5
		mul_a[1]*mul_b[1] = 1.25*3.75 = 4.6875
		mul_a[1]*mul_b[2] = 3.0*4.5 = 13.5

		out = 13.5 + 4.6875 + 13.5 = 31.6875

		simulation_out = 000001111110110000 => 0000011111_10110000 => (16+8+4+2+1).(0.5+0.125+0.0625) => 31.6875
		error = out - simulation_out = 0
*/
 
		pe_mul_a[A-1:0] = mul_a[0];
		pe_mul_a[2*A-1:A] = mul_a[1];
		pe_mul_a[3*A-1:2*A] = mul_a[2];		

		pe_mul_b[B-1:0] = mul_b[0];
		pe_mul_b[2*B-1:B] = mul_b[1];
		pe_mul_b[3*B-1:2*B] = mul_b[2];
		#100;
		$finish;
	end		 
endmodule



