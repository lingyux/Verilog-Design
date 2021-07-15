module clock(
	clk			,
	rst_n		,
	en			,
	load		,
	data_in		,
	data_out	
);
	input			clk			;
	input			rst_n		;
	input			en			;
	input			load		;
	input  [15:0]	data_in		;
	output [23:0]	data_out	;

	wire			en_1ms		;
	wire 			en_1s		;
	wire			en_1m		;
	wire			en_1h		;



	counter24 counter24(
		.clk			(clk			),
		.rst_n			(rst_n			),
		.load			(load			),
		.en				(en_1h			),
		.data_in		(data_in[15:8]	),
		.data_out		(data_out[23:16])
	);


	counter60 counter60_min(
		.clk			(clk			),
		.rst_n			(rst_n			),
		.load			(load			),
		.en				(en_1m			),
		.data_in		(data_in[7:0]	),
		.data_out		(data_out[15:8]	),
		.next_en		(en_1h			)
	);

	counter60 counter60_sec(
		.clk			(clk			),
		.rst_n			(rst_n			),
		.load			(1'b0			),
		.en				(en_1s			),
		.data_in		(data_in[7:0]	),
		.data_out		(data_out[7:0]	),
		.next_en		(en_1m			)
	);

	counter_1s counter_1s(
		.clk			(clk			),
		.rst_n			(rst_n			),
		.en				(en_1ms			),
		.next_en		(en_1s			)	
	);
	counter_1ms counter_1ms(
		.clk			(clk			),
		.rst_n			(rst_n			),
		.en				(en				),
		.next_en		(en_1ms			)
	);

endmodule

