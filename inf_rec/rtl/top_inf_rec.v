module top_inf_rec(
	input			wire			sys_clk			,
	input			wire			sys_rst_n		,
	input			wire			inf_in			,

	output			wire			led				,
	output			wire	[06:0]	seg				,
	output			wire	[05:0]	sel				 
);

wire			[23:0]		data		;
wire						repeat_en	;


led_ctrl led_ctrl_inst(
	.sys_clk		(sys_clk	),
	.sys_rst_n		(sys_rst_n	),
	.repeat_en		(repeat_en	),
                                
	.led			(led		)	 
);

HEX8 HEX8_inst
(
	.clk			(sys_clk	), 
	.rst_n			(sys_rst_n	), 
	.en				(1'b1		), 
	.disp_data		(data		), 
	.sel			(sel		), 
	.seg			(seg		) 
);

inf_rec inf_rec_inst(
	.sys_clk			(sys_clk	),
	.sys_rst_n			(sys_rst_n	),
	.inf_in				(inf_in		),
                                    
	.data				(data		),
	.repeat_en			(repeat_en	) 
);

endmodule

