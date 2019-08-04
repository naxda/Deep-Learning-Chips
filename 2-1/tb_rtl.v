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
// wire설정 
	wire	[A-1:0]		adder_a;
	wire	[B-1:0]		adder_b;
	wire	[ADDER_0-1:0]	a_out;
	wire	[A-1:0]		mul_a;
	wire	[B-1:0]		mul_b;
	wire	[MUL_0-1:0]	m_out;
	
// i_clk를 0으로 생성하고 2.5ns마다 0,1로 변경 맨위 time scale이 1ns이므로 #2.5 = 2.5ns
	initial	i_clk = 1'b0;
	always	#2.5	i_clk = ~i_clk;

initial
begin
	$dumpfile("test.vcd");
	$dumpvars;
end
//adder
	adder
	#( .A(A), .B(B), .ADDER_0(ADDER_0)) // adder.v와 연결할 parameter 설정
	adder_inst(
		.i_clk		(i_clk),
		.i_resetn	(i_resetn),
		.adder_a	(adder_a), 
		.adder_b	(adder_b),
		.adder_out	(a_out)
);
// multiplier
	mul
	#( .A(A), .B(B), .MUL_0(MUL_0))
	mul_inst(
		.i_clk		(i_clk),
		.i_resetn	(i_resetn),
		.mul_a		(mul_a),
		.mul_b		(mul_b),
		.mul_out	(m_out)
);
// tester

	tester_ex2
	#( .A(A), .B(B), .ADDER_0(ADDER_0), .MUL_0(MUL_0))
	tester_ex2_inst(
		.i_clk		(i_clk),
		.o_resetn	(i_resetn),
		.adder_a	(adder_a),
		.adder_b	(adder_b),
		.adder_out	(a_out), //윗부분의 a_out과 tester_ex2의 adder_out을 연결
		.mul_a		(mul_a),
		.mul_b		(mul_b),
		.mul_out	(m_out)		
);


endmodule

