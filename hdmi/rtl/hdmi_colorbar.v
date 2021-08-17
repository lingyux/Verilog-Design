module hdmi_colorbar
(
	input	wire		sys_clk		,
	input	wire		sys_rst_n	,

	output	wire		ddc_scl		,
	output	wire		ddc_sda		,
	output	wire		red_p		,
	output	wire		red_n		,
	output	wire		green_p		,
	output	wire		green_n		,
	output	wire		blue_p		,
	output	wire		blue_n		,
	output	wire		clk_p		,
	output	wire		clk_n		 	
);

wire			locked			;
wire			rst_n			;
wire			vga_clk			;
wire			clk_5x			;
wire [15:0]		pix_data		;
wire [09:0]		pix_x			;
wire [09:0]		pix_y			;
wire [15:0]		vga_rgb			;
wire			vsync			;
wire			hsync			;
wire			rgb_valid		;

assign ddc_scl = 1'b1	;
assign ddc_sda = 1'b1	;
assign	rst_n = sys_rst_n & locked	;

vga_ctrl vga_ctrl_inst(
	.vga_clk			(vga_clk	),
	.rst_n				(rst_n		),
	.pix_data			(pix_data	),

	.vga_rgb			(vga_rgb	),
	.hsync				(hsync		),
	.vsync				(vsync		),
	.pix_x				(pix_x		),
	.pix_y				(pix_y		),
	.rgb_valid			(rgb_valid	)
);

vga_pic vga_pic_inst(
	.vga_clk			(vga_clk	),
	.rst_n				(rst_n		),
	.pix_x				(pix_x		),
	.pix_y				(pix_y		),

	.pix_data			(pix_data	) 
);

hdmi_ctrl hdmi_ctrl_inst
(
	.vga_clk		(vga_clk	),
	.clk_5x			(clk_5x		),
	.sys_rst_n		(rst_n		),
	.rgb_valid		(rgb_valid	),
	.hsync			(hsync		),
	.vsync			(vsync		),
	.red			({vga_rgb[04:00], 3'b0}),	
	.green			({vga_rgb[10:05], 2'b0}),
	.blue			({vga_rgb[15:11], 3'b0}),

	.red_p			(red_p		),
	.red_n			(red_n		),
	.green_p		(green_p	),
	.green_n		(green_n	),
	.blue_p			(blue_p		),
	.blue_n			(blue_n		),
	.clk_p			(clk_p		),
	.clk_n			(clk_n		) 
);

clk_gen	clk_gen_inst (
	.areset 	(~sys_rst_n	),
	.inclk0 	(sys_clk	),
	.c0 		(vga_clk	),
	.c1 		(clk_5x		),
	.locked 	(locked		)
);

endmodule
