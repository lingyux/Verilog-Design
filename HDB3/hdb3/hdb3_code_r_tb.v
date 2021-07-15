`timescale 1ns/1ns
module hdb3_code_r_tb;
	reg r_rst_n;
	reg r_clk;

	wire r_data;
	wire [1:0] w_hdb3_code;


	initial begin
		r_rst_n = 1'b0;
		#10 r_rst_n = 1'b1;
	end

	initial begin
		r_clk = 1'b0;
		forever
		    #1 r_clk = ~r_clk;
	end


	hdb3_code_r I1_hbd3_code(
		.i_rst_n(r_rst_n),
		.i_clk(r_clk),
		.i_data(r_data),
		.o_hdb3_code(w_hdb3_code)
	);

	pluse pluse(
		.i_clk(r_clk),    // Clock
		.i_rst_n(r_rst_n),
		.o_pluse(r_data)
	);
endmodule
