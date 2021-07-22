module Rs232_rx
#(
	parameter	UART_BPS	=	'd9600		,
	parameter	CLK_FREQ	= 	'd50_000_000
)
(
	clk					,
	rst_n				,
	rx					,

	po_data				,
	po_flag				 
);

localparam	BAUD_CNT_MAX 	=	CLK_FREQ / UART_BPS	;

input					clk				;
input					rst_n			;
input					rx				;

output [7:0]			po_data			;
output					po_flag			;

reg  [7:0]				po_data			;
reg						po_flag			;
reg						rx_reg1			;
reg						rx_reg2			;
reg						rx_reg3			;
reg						start_flag		;
reg						work_en			;
reg  [15:0]				baud_cnt		;
reg						bit_flag		;
reg  [4:0]				bit_cnt			;
reg  [7:0]				rx_data			;
reg						rx_flag			;


wire					add_bit_cnt		;
wire					end_bit_cnt		;

always  @(posedge clk or negedge rst_n)begin
	if(rst_n==1'b0)begin
		rx_reg1	<= 1'b1;
	end
	else begin
		rx_reg1	<= rx		;
	end
end

always  @(posedge clk or negedge rst_n)begin
	if(rst_n==1'b0)begin
		rx_reg2	<= 1'b1;
	end
	else begin
		rx_reg2 <= rx_reg1	;
	end
end

always  @(posedge clk or negedge rst_n)begin
	if(rst_n==1'b0)begin
		rx_reg3	<= 1'b1;
	end
	else begin
		rx_reg3 <= rx_reg2	;
	end
end

always  @(posedge clk or negedge rst_n)begin
	if(rst_n==1'b0)begin
		start_flag	<= 1'b0;
	end
	else if(rx_reg2 == 1'b0 && rx_reg3 == 1'b1 && work_en == 1'b0)begin
		start_flag	<= 1'b1;
	end
	else begin
		start_flag	<= 1'b0;
	end
end

always  @(posedge clk or negedge rst_n)begin
	if(rst_n==1'b0)begin
		work_en	<= 1'b0;
	end
	else if(start_flag)begin
		work_en	<= 1'b1;
	end
	else if(bit_cnt == 4'd8 && bit_flag == 1'b1)begin
		work_en	<= 1'b0;
	end
end

always  @(posedge clk or negedge rst_n)begin
	if(rst_n==1'b0)begin
		baud_cnt	<= 16'd0;
	end
	else if((baud_cnt == BAUD_CNT_MAX - 1) || (work_en == 1'b0)) begin
		baud_cnt	<= 16'd0;
	end
	else begin
		baud_cnt	<= baud_cnt + 1'b1;
	end
end

always  @(posedge clk or negedge rst_n)begin
	if(rst_n==1'b0)begin
		bit_flag	<= 1'b0;
	end
	else if(baud_cnt == BAUD_CNT_MAX/2 - 1'b1)begin
		bit_flag	<= 1'b1;
	end
	else begin
		bit_flag	<= 1'b0;	
	end
end

always @(posedge clk or negedge rst_n)begin
	if(!rst_n)begin
		bit_cnt <= 0;
	end
	else if(add_bit_cnt)begin
		if(end_bit_cnt)
			bit_cnt <= 0;
		else
			bit_cnt <= bit_cnt + 1'b1;
	end
end

assign add_bit_cnt = bit_flag == 1'b1;       
assign end_bit_cnt = add_bit_cnt && bit_cnt == 9 - 1'b1;   

always  @(posedge clk or negedge rst_n)begin
	if(rst_n==1'b0)begin
		rx_data	<= 8'h00;
	end
	else if(bit_flag == 1'b1 && bit_flag >= 4'd1 && bit_flag <= 4'd8)begin
		rx_data	<= {rx_reg3, rx_data[7:1]};
	end
end

always  @(posedge clk or negedge rst_n)begin
	if(rst_n==1'b0)begin
		rx_flag	<= 1'b0;
	end
	else if(bit_flag == 1'b1 && bit_cnt == 4'd8)begin
		rx_flag <= 1'b1;
	end
	else begin
		rx_flag	<= 1'b0;
	end
end

always  @(posedge clk or negedge rst_n)begin
	if(rst_n==1'b0)begin
		po_data	<= 8'h00;
	end
	else if(rx_flag)begin
		po_data	<= rx_data;
	end
end

always  @(posedge clk or negedge rst_n)begin
	if(rst_n==1'b0)begin
		po_flag	<= 1'b0;
	end
	else if(rx_flag)begin
		po_flag	<= 1'b1;
	end
	else begin
		po_flag	<= 1'b0;
	end
end


endmodule

