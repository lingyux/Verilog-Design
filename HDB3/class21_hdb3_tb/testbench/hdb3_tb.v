`timescale 1ns/1ns
`define clk_period 20
module hdb3_tb();

	wire hdb3_decode;
	reg r_rst_n;
	reg r_clk;
	wire r_data;
	wire [1:0] hdb3_code;

	initial begin
		r_rst_n = 1'b0;
		#(`clk_period) r_rst_n = 1'b1;
	end

	initial begin
		r_clk = 1'b0;
		forever
		    #(`clk_period/2) r_clk = ~r_clk;
	end

	hdb3 hdb3(
		.i_clk(r_clk),
		.i_rst_n(r_rst_n),
		.hdb3_decode(hdb3_decode),
		.hdb3_code(hdb3_code),
		.r_data(r_data)
	);

endmodule
