module hdb3_tb();

	wire hdb3_decode;
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
		.hdb3_decode(hdb3_decode)
	);

endmodule
