module hdb3(
	input i_clk,
	input i_rst_n,
	output data_decode,
	output [1:0] hdb3_code,
	output r_data
);

	//wire data;
	//wire [1:0] hdb3_code;
	//wire clk_1ms;
	/*
	defparam divider.T = 49;
	divider divider(
		.i_clk(i_clk),
		.i_rst_n(i_rst_n),
		.clk_1ms(clk_1ms)
	);
	*/

	pluse pluse1(
		.i_clk(i_clk),    // Clock
		.i_rst_n(i_rst_n),
		.o_pluse(r_data)
	);

	hdb3_code hdb3_code1(
		 .i_rst_n(i_rst_n),
		 .i_clk(i_clk),
		 .i_data(r_data),
		 .o_hdb3_code(hdb3_code)
	);

	hdb3_decode hdb3_decode1(
		.i_rst_n(i_rst_n),
		.i_clk(i_clk),
		.i_hdb3_code(hdb3_code),
		.o_data(data_decode)
	);

endmodule

