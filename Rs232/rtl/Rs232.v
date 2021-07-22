module Rs232
(
	clk				,
	rst_n			,
	rx				,

	tx				 
);

input			clk				;
input			rst_n			;
input			rx				;		

output			tx				;

wire [7:0]		po_data			;
wire			po_flag			;

Rs232_tx 
#(
	.UART_BPS	(9600		),
	.CLK_FREQ	(50_000_000	)
)
Rs232_tx_inst
(
	.clk				(clk	),
	.rst_n				(rst_n	),
	.pi_data			(po_data),
	.pi_flag			(po_flag),
                                
	.tx					(tx		) 
);


	
Rs232_rx 
#(
	.UART_BPS	(9600		),
	.CLK_FREQ	(50_000_000	)
)
Rs232_rx_inst
(
	.clk					(clk		),
	.rst_n					(rst_n		),
	.rx						(rx			),
                                        
	.po_data				(po_data	),
	.po_flag				(po_flag	) 
);





endmodule
