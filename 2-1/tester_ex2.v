module tester_ex2 #(

//tb_rtl과 연결되는 부분 정의
 parameter A = 8,	
 parameter B = 8,
 parameter ADDER_0 = A+1,
 parameter MUL_0 = A+B
)
(
	input wire			i_clk		,
	output reg			o_resetn	,
	
	output reg	[A-1:0]		adder_a		,
	output reg	[B-1:0]		adder_b		,
	input wire	[ADDER_0-1:0]	adder_out	,

	output reg	[A-1:0]		mul_a		,
	output reg	[B-1:0]		mul_b		,
	input wire	[MUL_0-1:0]	mul_out
);


	initial
	begin
		#1; //1ns
		#5 // 6ns
		o_resetn = 1'b0;
		#10 // 16ns
		o_resetn = 1'b1;
		#5; // 21ns

		adder_a = 8'b0011_0000; // 3.0 (n=4,f=4) // 21ns일때 48
		adder_b = 8'b0001_0100; // 1.25 (n=4, f=4) // 21ns일때 20

		mul_a = 8'b0011_0000; // 3.0 (n=4,f=4) // 21ns일때 48
		mul_b = 8'b0001_0100; // 1.25 (n=4, f=4) // 21ns일때 20
	

		#5; // 26ns
		adder_a = 8'b1111_1100; // -4.0 (n=8, f=0) // 26ns일때 -4
		adder_b = 8'b0000_0010; // 4.0 (n=8, f=0) // 26ns일때 2

		mul_a = 8'b1111_1100; // -4.0 (n=8, f=0) // 26ns일때 -4
		mul_b = 8'b0000_0010; // 4.0 (n=8, f=0) // 26ns일때 2

		#100;
		$finish;
	end		 
endmodule



