`timescale 1ns/1ns
module hdb3_tb();

	wire data_decode;
	wire [1:0] data_code;
	wire r_data;
	reg r_rst_n;
	reg r_clk;

	initial begin
		r_rst_n = 1'b0;
		#9 r_rst_n = 1'b1;
	end

	initial begin
		r_clk = 1'b0;
		forever
		    #1 r_clk = ~r_clk;
	end

	hdb3 hdb3(
		.i_clk(r_clk),
		.i_rst_n(r_rst_n),
		.data_decode(data_decode),
		.r_data(r_data),
		.hdb3_code(data_code)
	);

endmodule

