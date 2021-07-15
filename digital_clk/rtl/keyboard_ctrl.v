module keyboard_ctrl(
	clk				,
	rst_n			,
	en				,
	load			,
	key_in_p		,
	key_in_n		,
	key_in_e		,
	data_in			,
	data_out		,
	data_out_vld	
);


	input			clk			;
	input			rst_n		;
	input			en			;
	input			load		;
	input			key_in_p	;
	input			key_in_n	;
	input			key_in_e	;
	input  [15:0]	data_in		;
	output [15:0]	data_out	;
	output			data_out_vld;
	
	wire			key_p_state			;
	wire			key_p_flag			;
	wire			key_n_state			;
	wire			key_n_flag			;
	wire			key_e_state			;
	wire			key_e_flag			;

	
	key_filter key_filter_p(
		.clk				(clk		),
		.rst_n				(rst_n		),
		.key_in				(key_in_p	),
		.key_flag			(key_p_flag	),
		.key_state			(key_p_state)
	);

	key_filter key_filter_n(
		.clk				(clk		),
		.rst_n				(rst_n		),
		.key_in				(key_in_n	),
		.key_flag			(key_n_flag	),
		.key_state			(key_n_state)
	);
	

	key_filter key_filter_e(
		.clk				(clk		),
		.rst_n				(rst_n		),
		.key_in				(key_in_e	),
		.key_flag			(key_e_flag	),
		.key_state			(key_e_state)
	);

	keyboard keyboard1(
		.clk			(clk		 )	,
		.rst_n			(rst_n		 )	,
		.load			(load		 )	,
		.en				(en			 )	,
		.key_p_state	(key_p_state )	,	// 闹钟调整按钮
		.key_p_flag		(key_p_flag	 )	,	
		.key_n_state	(key_n_state )	,	// 调整位数选择
		.key_n_flag		(key_n_flag	 )	,
		.key_e_state	(key_e_state )	,	// 调整确认按钮
		.key_e_flag		(key_e_flag	 )	,
		.data_in		(data_in	 )	,	// 输入调整数据
		.data_out		(data_out	 )	,	// 输出数据
		.data_out_vld	(data_out_vld)		// 输出数据有效信号
	);


endmodule

