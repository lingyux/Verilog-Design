module	tft_colorbar
(
	input	wire		sys_clk		,
	input	wire		sys_rst_n	,
	
	output	wire [15:00]tft_rgb		,
	output	wire		hsync		,
	output	wire		vsync		,
	output	wire		tft_de		,
	output	wire		tft_clk		,
	output	wire		tft_bl		 
);

wire			locked		;
wire			rst_n		;
wire			clk_9m		;
wire [15:00]	pix_data	;
wire [09:00]	pix_x		;
wire [09:00]	pix_y		;


assign rst_n = sys_rst_n & locked	;

tft_ctrl tft_ctrl_inst
(
	.clk_9m			(clk_9m		),
	.sys_rst_n		(rst_n		),
	.pix_data		(pix_data	),
                                
	.tft_rgb		(tft_rgb	),
	.hsync			(hsync		),
	.vsync			(vsync		),
	.pix_x			(pix_x		),
	.pix_y			(pix_y		),
	.tft_de			(tft_de		),
	.tft_clk		(tft_clk	),
	.tft_bl			(tft_bl		) 
);

tft_pic tft_pic_inst
(
	.clk_9m			(clk_9m		),
	.sys_rst_n		(rst_n		),
	.pix_x			(pix_x		),
	.pix_y			(pix_y		),
                                
	.pix_data		(pix_data	) 
);

clk_9m	clk_9m_inst (
	.areset (~sys_rst_n),
	.inclk0 (sys_clk	),
	.c0 	(clk_9m		),
	.locked (locked		)
);

endmodule
