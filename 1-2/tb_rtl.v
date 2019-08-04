`timescale 1 ns / 10 ps

module tb_rtl;
// wire는 데이터를 전달하는선, reg 는 data를 저장
	reg			i_clk	;
	wire			i_resetn;

// parameter 선언부분
// data를 저장/전송할 공간을 할당함.
// Adder_0은 A와 B의 합의 공간이므로 8비트 + 8비트 = 9비트를 위한 공간설정 
	localparam A = 8;
	localparam B = 8;
	localparam ADDER_0 = A+1;
	localparam MUL_0 = A+B; // 이부분은 실습 1-2 필요없음 
	wire	[A-1:0]		op_a;
	wire	[B-1:0]		op_b;
	
// i_clk를 0으로 생성하고 2.5ns마다 0,1로 변경 맨위 time scale이 1ns이므로 #2.5 = 2.5ns

	initial	i_clk = 1'b0;
	always	#2.5	i_clk = ~i_clk;

//
initial
begin
	$dumpfile("test.vcd");
	$dumpvars;
end

	tester_ex1_2
	#( .A(A), .B(B), .ADDER_0(ADDER_0)) // tester_ex1_2의 parameter설정
	tester_ex1_2_inst(
		.i_clk		(i_clk), // 위의 i_clk와 tester_ex1_2의 i_clk을 연결
		.o_resetn	(i_resetn), //윗부분의 i_resetn과 tester_ex1_2의 o_resetn을 연결
		.op_a		(op_a),// 위의 op_a와 tester_ex1_2의 op_a을 연결
		.op_b		(op_b) // 위의 op_a와 tester_ex1_2의 i_clk을 연결
);
endmodule
