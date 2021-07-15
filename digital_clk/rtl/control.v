module control(
	clk					,
	rst_n				,
	key_in_p			,
	key_in_n			,
	key_in_e			,
	key_in_m			,
	data_in				,
	ring_load			,
	clock_load			,
	en_clk				,
	data_out			,
	mode_clk			,
	mode_ring			,
	mode_clk_ad			,
	mode_ring_ad		
);
	input					clk						;
	input					rst_n					;
	input					key_in_p				;
	input					key_in_n				;
	input					key_in_e				;
	input					key_in_m				;
	input  [15:0]			data_in					;

	output					mode_clk				;
	output					mode_ring				;
	output					mode_clk_ad				;
	output					mode_ring_ad			;
	output					clock_load				;
	output					ring_load				;
	output					en_clk					;
	output [15:0]			data_out				;


	
	wire					en_keyboard				;
	wire					keyboard_load			;
	wire					data_out_vld			;
	wire					ring_load_m				;
	wire					clock_load_m			;

	assign ring_load = data_out_vld && ring_load_m ;
	assign clock_load = data_out_vld && clock_load_m;

	keyboard_ctrl keyboard_ctrl(
		.clk				(clk			),
		.rst_n				(rst_n			),
		.en					(en_keyboard	),
		.load				(keyboard_load	),
		.key_in_p			(key_in_p		),
		.key_in_n			(key_in_n		),
		.key_in_e			(key_in_e		),
		.data_in			(data_in		),
		.data_out			(data_out		),
		.data_out_vld		(data_out_vld	) 	
	);


	mode_chose mode_chose(
		.clk				(clk			),
		.rst_n				(rst_n			),
		.key_in_m			(key_in_m		),
		.en_clk				(en_clk			),
		.en_keyboard		(en_keyboard	),
		.clock_load			(clock_load_m	),
		.ring_load			(ring_load_m	),
		.keyboard_load		(keyboard_load	),
		.mode_clk			(mode_clk		),
		.mode_ring			(mode_ring		),
		.mode_clk_ad		(mode_clk_ad	),
		.mode_ring_ad		(mode_ring_ad	) 
	);

endmodule

