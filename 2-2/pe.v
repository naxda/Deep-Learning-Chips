module pe #(
	parameter A = 8,
	parameter B = 8,
	parameter O = A+B+2
)
(
	input wire i_clk,
	input wire i_resetn,

	input wire [3*A-1:0] pe_mul_a, 
	input wire [3*B-1:0] pe_mul_b,
	output reg [A+B+2-1:0]	out
);

	wire [O-1:0] out_tmp;
	wire [A-1:0] mul_a [0:2];
	wire [B-1:0] mul_b [0:2];

	wire [(A+B)-1:0] mul_out[0:2];
	wire [(A+B+1)-1:0] adder_out;

	assign mul_a[0] = pe_mul_a[A-1:0]; // mul_0은 7:0, mul_1은 15:8, mul_2는 23:16자리(pe_mul_a의 자리)에서 assign. 
	assign mul_a[1] = pe_mul_a[2*A-1:A];
	assign mul_a[2] = pe_mul_a[3*A-1:2*A];

	assign mul_b[0] = pe_mul_b[B-1:0]; // 위와 동일
	assign mul_b[1] = pe_mul_b[2*B-1:B];
	assign mul_b[2] = pe_mul_b[3*B-1:2*B];


// multiplier mul.v와 연결
	mul
	#( .A(A), .B(B), .O(A+B))
	mul_0_inst(
		.i_clk		(i_clk),
		.i_resetn	(i_resetn),

		.mul_a		(mul_a[0]),
		.mul_b		(mul_b[0]),
		.mul_out	(mul_out[0])
);

	mul
	#( .A(A), .B(B), .O(A+B))
	mul_1_inst(
		.i_clk		(i_clk),
		.i_resetn	(i_resetn),

		.mul_a		(mul_a[1]),
		.mul_b		(mul_b[1]),
		.mul_out	(mul_out[1])
);




//adder adder.v와 연결. 위의 mul_0 과 mul_1의 out값을 받아서 input으로 넣고, adder_out값을 output으로받음
	adder
	#( .A(A+B), .B(A+B), .O(A+B+1) )
	adder_0_inst(
		.i_clk		(i_clk),
		.i_resetn	(i_resetn),

		.mul_out_0	(mul_out[0]), 
		.mul_out_1	(mul_out[1]),
		.adder_out	(adder_out)
);


//mul mul.v 파일과 연결

	mul
	#( .A(A), .B(B), .O(A+B))
	mul_2_inst(
		.i_clk		(i_clk),
		.i_resetn	(i_resetn),

		.mul_a		(mul_a[2]),
		.mul_b		(mul_b[2]), // mul_a와 b는 mul.v에 input으로 연결
		.mul_out	(mul_out[2]) // mul_out은 output wire로 연결
);

//adder adder.v 파일과 연결. 바로위의 mul_out[2]값과 두칸 위의 adder_out값을 받아 out_tmp값을 내보냄
	adder
	#( .A(A+B+1), .B(A+B+1), .O(A+B+2) )
	adder_1_inst(
		.i_clk		(i_clk),
		.i_resetn	(i_resetn),

		.mul_out_0	(adder_out), 
		.mul_out_1	({mul_out[2][(A+B)-1],mul_out[2]}), //차원이 17 vs 16bit로 다르므로 처리
		.adder_out	(out_tmp)
);


always@(posedge i_clk or negedge i_resetn) begin
	if(~i_resetn) begin
		out<=0;
end
	else begin
		out<=out_tmp;
	end
end
//이 코드로  i_resetn이 0으로 바뀌는 6ns에서 out을 0으로 저장하고. 
// 22.5ns에서 out값을 out_tmp에서 저장함 




endmodule
