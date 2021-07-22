module my_vga(
	clk				,
	rst_n			,

	hsync			,
	vsync			,
	vga_rgb
);
	input				clk			;
	input				rst_n		;

	output				hsync		;
	output				vsync		;
	output [15:0]		vga_rgb		;

	wire   [15:0]		pix_data	;
	wire				locked		;
	wire				vga_clk		;
	wire   [9:0]		pix_x		;
	wire   [9:0]		pix_y		;
	wire				sys_rst_n	;


	assign sys_rst_n = rst_n && locked	;
	vga_pic vga_pic_inst(
		.vga_clk				(vga_clk	),
		.rst_n					(sys_rst_n	),
		.pix_x					(pix_x		),
		.pix_y					(pix_y		),
	                                        
		.pix_data			 	(pix_data	) 
	);

	pll_25Mhz	pll_25Mhz_inst (
		.areset ( ~rst_n 	),
		.inclk0 ( clk 		),
		.c0 	( vga_clk 	),
		.locked ( locked 	)
	);


	vga_ctrl vga_ctrl_inst(
		.vga_clk				(vga_clk	),
		.rst_n					(sys_rst_n	),
		.pix_data				(pix_data	),
	                                        
		.vga_rgb				(vga_rgb	),
		.hsync					(hsync		),
		.vsync					(vsync		),
		.pix_x					(pix_x		),
		.pix_y					(pix_y		) 
	);



endmodule

