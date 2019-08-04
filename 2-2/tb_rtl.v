`timescale 1 ns / 10 ps

module tb_rtl;
// wire는 데이터를 전달하는선, reg 는 data를 저장
	reg			i_clk	;
	wire			i_resetn;
	
// parameter 선언부분 data를 저장/전송할 공간을 할당함.
// Adder_0은 A와 B의 합의 공간이므로 8비트 + 8비트 = 9비트를 위한 공간설정 
// MUL_0은 A와 B의 곱의 공간이므로 8비트x8비트 = 16비트공간설정
	localparam A = 8;
	localparam B = 8;
	localparam ADDER_0 = A+1;
	localparam MUL_0 = A+B;
	localparam PE_0 = A+B+2; 
	

// wire설정 
	wire	[A-1:0]		adder_a[0:2];
	wire	[B-1:0]		adder_b[0:2];
	wire	[ADDER_0-1:0]	adder_out;

	wire	[A-1:0]		mul_a [0:2];
	wire	[B-1:0]		mul_b [0:2];
	wire	[MUL_0-1:0]	mul_out;

	wire	[3*A-1:0]		pe_mul_a;
	wire	[3*B-1:0]		pe_mul_b;
	wire	[MUL_0-1:0]	pe_mul_out;
	
	wire   [A+B+2-1:0]	out;

// i_clk를 0으로 생성하고 2.5ns마다 0,1로 변경 맨위 time scale이 1ns이므로 #2.5 = 2.5ns
	initial	i_clk = 1'b0;
	always	#2.5	i_clk = ~i_clk;

initial
begin
	$dumpfile("test.vcd");
	$dumpvars;
end



// pe
	pe
//	#( .A(A), .B(B), .O(PE_0)) 굳이 선언할 필요 없음
	pe_inst(
		.i_clk		(i_clk),
		.i_resetn	(i_resetn),
		.pe_mul_a	(pe_mul_a), // pe.v의 input wire로 pe_mul_a를 받음
		.pe_mul_b	(pe_mul_b),
		.out		(out) // pe.v의 output reg로 out을 받음
	);


// tester
	tester_ex2_2
	tester_ex2_inst(
		.i_clk		(i_clk),
		.o_resetn	(i_resetn),
		.pe_mul_a	(pe_mul_a), // tester_ex2_2.v의 output reg로 pe_mul_a, b를 받음
		.pe_mul_b	(pe_mul_b)

);

endmodule

