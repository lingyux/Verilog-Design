`timescale 1ns/1ns
module Rs232_tx_tb();

reg				clk			;
reg				rst_n		;
reg  			rx			;

wire [7:0]		po_data		;
wire			po_flag		;
wire			tx			;

wire [7:0]		po_data_2	;
wire			po_flag_2	;


initial begin
	clk		=	1'b1;
	rst_n	=	1'b0;
	rx		= 	1'b1;
	#20;
	rst_n	= 	1'b1;
end

always #10 clk = ~clk	;

initial begin
	#200 
	rx_bit(8'd0);
	rx_bit(8'd1);
	rx_bit(8'd2);
	rx_bit(8'd3);
	rx_bit(8'd4);
	rx_bit(8'd5);
	rx_bit(8'd6);
	rx_bit(8'd7);
end


task rx_bit
(
	input  [7:0]	data
);

	integer i;
	for (i = 0; i < 10; i = i + 1)begin
		case(i)
			0:	rx	<= 1'b0;
			1:	rx	<= data[0];
			2:	rx	<= data[1];
			3:	rx	<= data[2];
			4:	rx	<= data[3];
			5:	rx	<= data[4];
			6:	rx	<= data[5];
			7:	rx	<= data[6];
			8:	rx	<= data[7];
			9:	rx	<= 1'b1;
		endcase
		#(5208 * 20);
	end

endtask

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

Rs232_rx 
#(
	.UART_BPS	(9600		),
	.CLK_FREQ	(50_000_000	)
)
Rs232_rx_inst_2
(
	.clk					(clk		),
	.rst_n					(rst_n		),
	.rx						(tx			),
                                        
	.po_data				(po_data_2	),
	.po_flag				(po_flag_2	) 
);



endmodule
