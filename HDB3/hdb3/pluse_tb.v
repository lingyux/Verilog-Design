`timescale 1ns/1ns

module pluse_tb();

	reg r_rst_n;
	reg r_clk;
	wire o_pluse;

	initial begin
		r_rst_n = 1'b0;
		#10 r_rst_n = 1'b1;
	end

	initial begin
		r_clk = 1'b0;
		forever
		    #1 r_clk = ~r_clk;
	end
	

	pluse pluse1(
		.i_clk(r_clk),    // Clock
		.i_rst_n(r_rst_n),
		.o_pluse(o_pluse)
	);
endmodule