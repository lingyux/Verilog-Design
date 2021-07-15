`timescale 1ns/1ns
module keyboard_tb();

	reg				clk			;
	reg				rst_n		;
	reg  [15:0]		data_in		;
	reg				press_p		;
	reg				press_n		;
	reg				press_e		;
	reg				load		;
	wire			key_in_p	; 	
	wire			key_in_n	; 
	wire			key_in_e	; 
	wire			key_p_flag	;
	wire			key_p_state	;
	wire			key_n_flag	;
	wire			key_n_state	;
	wire			key_e_flag	;
	wire			key_e_state	;
	wire [15:0]		data_out	;
	wire			data_out_vld;

	initial begin
		clk = 1'b1;
		forever
			#1 clk = ~clk;
	end

	initial begin
		rst_n = 1'b0;
		press_p = 0;
		press_n = 0;
		press_e = 0;
		load = 0;
		#10;
		rst_n = 1'b1;
		#5;
		load = 1;
		data_in = 16'h1223;
		# 6;
		load = 0;
		press_p = 1;
		# 6;
		press_p = 0;
		# 80_000_000;
		press_p = 1;
		# 6;
		press_p = 0;
		# 80_000_000;
		press_n = 1;
		# 6;
		press_n = 0;
		# 80_000_000;
		press_p = 1;
		# 6;
		press_p = 0;
		# 80_000_000;
		press_p = 1;
		# 6;
		press_p = 0;
		#80_000_000;
		press_e = 1;
		# 6;
		press_e = 0;
		#80_000_000;
		$stop;
	end

	key_model key_model_p(
		.press			(press_p), 
		.key			(key_in_p	)
	);
	key_model key_model_n(
		.press			(press_n), 
		.key			(key_in_n	)
	);
	key_model key_model_e(
		.press			(press_e), 
		.key			(key_in_e	)
	);
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
		.en				(1'b1		 )	,
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

