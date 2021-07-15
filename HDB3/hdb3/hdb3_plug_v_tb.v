
`timescale 1ns/1ns
module hdb3_plug_v_tb;
	reg r_rst_n;
	reg r_clk;

	wire r_data;
	wire [1:0] o_plug_v_code;


	initial begin
		r_rst_n = 1'b0;
		#10 r_rst_n = 1'b1;
	end

	initial begin
		r_clk = 1'b1;
		forever
		    #1 r_clk = ~r_clk;
	end

	pluse pluse(
		.i_clk(r_clk),    // Clock
		.i_rst_n(r_rst_n),
		.o_pluse(r_data)
	);

	hdb3_plug_v hdb3_plug_v(
		.i_rst_n(r_rst_n), 
		.i_clk(r_clk),
		.i_data(r_data),
		.o_plug_v_code(o_plug_v_code)
	);
endmodule
