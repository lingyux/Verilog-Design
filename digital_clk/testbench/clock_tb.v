`timescale 1ns/1ns
module clock_tb();

	reg			clk		;
	reg			rst_n	;
	reg			load	;
	reg			en		;
	reg [15:0] 	data_in	;
	wire[23:0] 	data_out;

	initial begin
		clk = 1'b1;
		forever
			#1 clk = ~clk;
	end	

	initial begin
		en 		= 1'b1		;
		rst_n 	= 1'b0		;
		#5;
		rst_n	= 1'b1		;
		#10; 
		load 	= 1'b1		;
		data_in = 16'h1223	;
		#10;
		load	= 1'b0		;
	end
	
	clock clock(
		.clk			(clk		),
		.rst_n			(rst_n		),
		.load			(load		),
		.en				(en			),
		.data_in		(data_in	),
		.data_out		(data_out	)
	);

endmodule
