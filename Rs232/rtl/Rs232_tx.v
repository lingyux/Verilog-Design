module Rs232_tx
#(
	parameter	UART_BPS	=	'd9600		,
	parameter	CLK_FREQ	= 	'd50_000_000
)
(
	clk				,
	rst_n			,
	pi_data			,
	pi_flag			,

	tx
);

localparam			BAUD_CNT_MAX	= CLK_FREQ / UART_BPS	;

input				clk				;
input				rst_n			;
input  [7:0]		pi_data			;
input				pi_flag			;

output				tx				;

reg					tx				;
reg					work_en			;
reg    [15:0]		baud_cnt		;
reg					bit_flag		;
reg    [4:0]		bit_cnt			;

wire				add_bit_cnt		;
wire				end_bit_cnt		;


always  @(posedge clk or negedge rst_n)begin
	if(rst_n==1'b0)begin
		work_en	<= 1'b0;
	end
	else if(pi_flag == 1'b1) begin
		work_en	<= 1'b1;
	end
	else if(bit_flag == 1'b1 && bit_cnt == 4'd9)begin
		work_en	<= 1'b0;
	end
end

always@(posedge clk or negedge rst_n)
    if(rst_n == 1'b0)
        baud_cnt    <=  16'd0;
    else    if((work_en ==  1'b0) || (baud_cnt == BAUD_CNT_MAX - 1))
        baud_cnt    <=  16'd0;
    else    if(work_en ==  1'b1)
        baud_cnt    <=  baud_cnt + 1'b1;


always  @(posedge clk or negedge rst_n)begin
	if(rst_n==1'b0)begin
		bit_flag	<= 1'b0;
	end
	else if(baud_cnt == 16'd1)begin
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

assign add_bit_cnt = bit_flag == 1'b1 && work_en == 1'b1;       
assign end_bit_cnt = add_bit_cnt && bit_cnt == 10 - 1;   

always  @(posedge clk or negedge rst_n)begin
	if(rst_n==1'b0)begin
		tx	<= 1'b1;
	end
	else if(bit_flag == 1'b1)begin
		case(bit_cnt)
			0:	tx	<= 1'b0;
			1:	tx	<= pi_data[0];
			2:	tx	<= pi_data[1];
			3:	tx	<= pi_data[2];
			4:	tx	<= pi_data[3];
			5:	tx	<= pi_data[4];
			6:	tx	<= pi_data[5];
			7:	tx	<= pi_data[6];
			8:	tx	<= pi_data[7];
			9:	tx	<= 1'b1;
			default: tx	<= 1'b1;
		endcase
	end
end


endmodule

