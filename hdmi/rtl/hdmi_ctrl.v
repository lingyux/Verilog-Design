module hdmi_ctrl
(
	input	wire		vga_clk		,
	input	wire		clk_5x		,
	input	wire		sys_rst_n	,
	input	wire		rgb_valid	,
	input	wire		hsync		,
	input	wire		vsync		,
	input	wire [7:0]	red			,	
	input	wire [7:0]	green		,
	input	wire [7:0]	blue		,

	output	wire		red_p		,
	output	wire		red_n		,
	output	wire		green_p		,
	output	wire		green_n		,
	output	wire		blue_p		,
	output	wire		blue_n		,
	output	wire		clk_p		,
	output	wire		clk_n		 
);

wire [9:0]	data_out_r	;
wire [9:0]	data_out_g	;
wire [9:0]	data_out_b	;

encode encode_r(
	.vga_clk		(vga_clk	),
	.sys_rst_n		(sys_rst_n	),
	.data_in		(red		),
	.hsync			(hsync		),
	.vsync			(vsync		),
	.de				(rgb_valid	),

	.data_out		(data_out_r) 
);

encode encode_g(
	.vga_clk		(vga_clk	),
	.sys_rst_n		(sys_rst_n	),
	.data_in		(green		),
	.hsync			(hsync		),
	.vsync			(vsync		),
	.de				(rgb_valid	),

	.data_out		(data_out_g) 
);

encode encode_b(
	.vga_clk		(vga_clk	),
	.sys_rst_n		(sys_rst_n	),
	.data_in		(blue		),
	.hsync			(hsync		),
	.vsync			(vsync		),
	.de				(rgb_valid	),

	.data_out		(data_out_b) 
);

par_to_ser par_to_ser_r
(
	.clk_5x			(clk_5x		),
	.data_in		(data_out_r	),

	.ser_p			(red_p		),
	.ser_n			(red_n		) 
);

par_to_ser par_to_ser_g
(
	.clk_5x			(clk_5x		),
	.data_in		(data_out_g	),

	.ser_p			(green_p	),
	.ser_n			(green_n	) 
);

par_to_ser par_to_ser_b
(
	.clk_5x			(clk_5x		),
	.data_in		(data_out_b	),

	.ser_p			(blue_p		),
	.ser_n			(blue_n		) 
);

par_to_ser par_to_ser_clk
(
	.clk_5x			(clk_5x			),
	.data_in		(10'b11111_00000),

	.ser_p			(clk_p			),
	.ser_n			(clk_n			) 
);

endmodule
