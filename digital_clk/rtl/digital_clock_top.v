module digital_clock_top(
	clk					,
	rst_n				,
	key_in_p			,
	key_in_n			,
	key_in_e			,
	key_in_m			,
	
	led					,
	seg					,
	sel					
);
	input							clk				;
	input							rst_n			;
	input							key_in_p		;
	input							key_in_n        ;
	input							key_in_e		;
	input							key_in_m		;

	output [3:0]					led				;
	output [6:0]					seg				;
	output [5:0]					sel				;

	wire   [23:0]					data_clk		;
	wire   [23:0]					disp_data		;
	wire							ring_load		;
	wire							clock_load		;
	wire							en_clk			;
	wire							mode_clk		;
	wire							mode_ring		;
	wire							mode_clk_ad		;
	wire							mode_ring_ad	;
	wire							ring			;
	wire   [15:0]					data_load		;
	wire   [15:0]					data_ring		;
	reg    [15:0]					disp_data_tmp	;
	reg	   [15:0]					data_keyboard_in;
	assign led = ring ? 4'b1111 : {mode_ring_ad, mode_ring, mode_clk_ad, mode_clk};

	always  @(posedge clk or negedge rst_n)begin
		if(rst_n==1'b0)begin
			data_keyboard_in <= 16'h0;
		end
		else if(mode_clk_ad)begin
			data_keyboard_in <= data_clk[23:8];
		end
		else if(mode_ring_ad)begin
			data_keyboard_in <= data_ring;
		end
	end

	always  @(posedge clk or negedge rst_n)begin
		if(rst_n==1'b0)begin
			disp_data_tmp <= 16'h0;
		end
		else if(mode_clk)begin
			disp_data_tmp <= data_clk[23:8];
		end
		else if(mode_ring)begin
			disp_data_tmp <= data_ring;
		end
		else if(mode_clk_ad)begin
			disp_data_tmp <= data_load;
		end
		else if(mode_ring_ad) begin
			disp_data_tmp <= data_load;
		end
	end

	assign	disp_data = {disp_data_tmp, data_clk[7:0]}	;

	HEX8 HEX8
	(
		.clk				(clk		), 
		.rst_n				(rst_n		), 
		.en					(1'b1		), 
		.disp_data			(disp_data	), 
		.sel				(sel		), 
		.seg				(seg		) 
	);


	ring ring1(
		.clk				(clk		),
		.rst_n				(rst_n		),
		.load				(ring_load	),
		.data_in_load		(data_load	),
		.data_in_cmp		(data_clk[23:8]),
		.data_ring			(data_ring	),
		.ring				(ring		) 	
	);

	control control(
		.clk					(clk				),
		.rst_n					(rst_n				),
		.key_in_p				(key_in_p			),
		.key_in_n				(key_in_n			),
		.key_in_e				(key_in_e			),
		.key_in_m				(key_in_m			),
		.data_in				(data_keyboard_in	),
		.ring_load				(ring_load			),
		.clock_load				(clock_load			),
		.en_clk					(en_clk				),
		.data_out				(data_load			),
		.mode_clk				(mode_clk			),
		.mode_ring				(mode_ring			),
		.mode_clk_ad			(mode_clk_ad		),
		.mode_ring_ad			(mode_ring_ad		) 
	);

	clock clock(
		.clk			(clk			),
		.rst_n			(rst_n			),
		.en				(en_clk			),
		.load			(clock_load		),
		.data_in		(data_load		),
		.data_out		(data_clk		) 
	);
endmodule

