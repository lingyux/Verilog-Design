`timescale 1ns/1ns
module ring_tb();
	
	reg				clk			;
	reg				rst_n		;
	reg				load		;
	reg  [15:0]		data_in_load;
	reg	 [15:0]		data_in_cmp	;
	
	wire [15:0]		data_ring	;
	wire			ring		;
	
	initial begin
		clk = 1'b1;
		forever
			#1 clk = ~clk;
	end	

	initial begin
		rst_n = 0;
		# 6;
		rst_n = 1;
		# 6;
		load  = 1;
		data_in_load = 16'h1234;
		# 6;
		load = 0;
		# 10;
		data_in_cmp = 16'h1234;
		#100;
		$stop;
	end


	ring ring1(
		.clk				(clk			),
		.rst_n				(rst_n			),
		.load				(load			),
		.data_in_load		(data_in_load	),
		.data_in_cmp		(data_in_cmp	),
		.data_ring			(data_ring		),
		.ring				(ring			) 
	);

endmodule

