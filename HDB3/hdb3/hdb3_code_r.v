`timescale 1ns/1ns
module hdb3_code_r (
	input i_rst_n,
	input i_clk,
	input i_data,
	output [1:0] o_hdb3_code
);
	wire [1:0] w_plug_v;
	wire [1:0] w_plug_b;

	hdb3_plug_v hdb3_plug_v1(
		.i_rst_n(i_rst_n),
		.i_clk(i_clk),
		.i_data(i_data),
		.o_plug_v_code(w_plug_v)
	);
	
	hdb3_plug_b hdb3_plug_b1(
		 .i_rst_n(i_rst_n),
		 .i_clk(i_clk),
		 .i_plug_v_code(w_plug_v),
		 .o_plug_b_code(w_plug_b)
	);

	hdb3_d2t hdb3_d2t1(
		.i_rst_n(i_rst_n),
		.i_clk(i_clk),
		.i_plug_b_code(w_plug_b),
		.o_hdb3_code(o_hdb3_code)
	);
endmodule