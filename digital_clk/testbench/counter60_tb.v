module counter60_tb();

	reg			clk		;
	reg			rst_n	;
	reg			load	;
	reg			en		;
	reg [7:0] 	data_in	;
	wire[7:0] 	data_out;
	wire		next_en	;

	initial begin
		clk = 1'b1;
		forever
			#1 clk = ~clk;
	end	

	initial begin
		en 		= 1'b1	;
		rst_n 	= 1'b0	;
		#5;
		rst_n	= 1'b1	;
		#10; 
		load 	= 1'b1	;
		data_in = 8'h23	;
		#10;
		load	= 1'b0	;
	end
	
	counter60 counter60(
		.clk			(clk		),
		.rst_n			(rst_n		),
		.load			(load		),
		.en				(en			),
		.data_in		(data_in	),
		.data_out		(data_out	),
		.next_en		(next_en	)
	);

endmodule

