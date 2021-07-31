module inf_rec(
	input			wire			sys_clk			,
	input			wire			sys_rst_n		,
	input			wire			inf_in			,

	output			reg		[23:0]	data			,
	output			reg				repeat_en		 
);

parameter			IDLE	 		= 5'b0_0001	,
					TIME_9MS 		= 5'b0_0010	,
					ARBIT	 		= 5'b0_0100	,
					DATA	 		= 5'b0_1000	,
					REPEAT	 		= 5'b1_0000	;

parameter			CNT_560US_MIN	= 19'd20_000	,
					CNT_560US_MAX	= 19'd35_000	,
					CNT_1_69MS_MIN	= 19'd80_000	,
					CNT_1_69MS_MAX	= 19'd90_000	,
					CNT_2_25MS_MIN	= 19'd100_000	,
					CNT_2_25MS_MAX	= 19'd125_000	,
					CNT_4_5MS_MIN	= 19'd175_000	,
					CNT_4_5MS_MAX	= 19'd275_000	,
					CNT_9MS_MIN		= 19'd400_000	,
					CNT_9MS_MAX		= 19'd490_000	;

wire					inf_in_rise	;
wire					inf_in_fall	;
reg						inf_in_dly1	;
reg						inf_in_dly2	;
//reg			[4:0]		n_state		;
reg			[4:0]		state		;
reg			[18:0]		cnt			;
reg						flag_9ms	;
reg						flag_4_5ms	;
reg			[5:0]		cnt_data	;
reg						flag_560us	;
reg						flag_1_69ms	;
reg			[31:0]		data_reg	;
reg						flag_2_25ms	;

always@(posedge sys_clk or negedge sys_rst_n)
    if(sys_rst_n == 1'b0)
        state   <=  IDLE;
    else    case(state)
        IDLE:   if(inf_in_fall == 1'b1)
                    state   <=  TIME_9MS;
                else
                    state   <=  IDLE;
        TIME_9MS:if((inf_in_rise == 1'b1) && (flag_9ms == 1'b1))
                    state   <=  ARBIT;
                 else   if((inf_in_rise == 1'b1) && (flag_9ms == 1'b0))
                    state   <=  IDLE;
                 else
                    state   <=  TIME_9MS;
        ARBIT:  if((inf_in_fall == 1'b1) && (flag_2_25ms == 1'b1))
                    state   <=  REPEAT;
                else    if((inf_in_fall == 1'b1) && (flag_4_5ms == 1'b1))
                    state   <=  DATA;
                else    if((inf_in_fall == 1'b1) && (flag_4_5ms == 1'b0) && (flag_2_25ms == 1'b0))
                    state   <=  IDLE;
                else
                    state   <=  ARBIT;
        DATA:   if((inf_in_rise == 1'b1) && (flag_560us == 1'b0))
                    state   <=  IDLE;
                else    if((inf_in_fall == 1'b1) && (flag_560us == 1'b0) && (flag_1_69ms == 1'b0))
                    state   <=  IDLE;
                else    if((inf_in_rise == 1'b1) && (cnt_data == 6'd32))
                    state   <=  IDLE;
				else
					state	<= 	DATA;
        REPEAT: if(inf_in_rise == 1'b1)
                    state   <=  IDLE;
                else
                    state   <=  REPEAT;
        default:state   <=  IDLE;
    endcase


always  @(posedge sys_clk or negedge sys_rst_n)begin
	if(sys_rst_n==1'b0)begin
		inf_in_dly1	<= 1'b0;
		inf_in_dly2	<= 1'b0;
	end
	else begin
		inf_in_dly1	<= inf_in;
		inf_in_dly2	<= inf_in_dly1;
	end
end

assign	inf_in_fall = (inf_in_dly1 == 1'b0) && (inf_in_dly2 == 1'b1);
assign 	inf_in_rise = (inf_in_dly1 == 1'b1) && (inf_in_dly2 == 1'b0);

always  @(posedge sys_clk or negedge sys_rst_n)begin
	if(sys_rst_n==1'b0)begin
		cnt	<= 19'd0;
	end
	else begin
		case(state)
			IDLE	:
				cnt	<= 19'd0;
			TIME_9MS:
				if((inf_in_rise == 1'b1) && (flag_9ms == 1'b1))
					cnt	<= 19'd0;
				else
					cnt	<= cnt + 1'b1;
			ARBIT	:
				if((inf_in_fall == 1'b1) && ((flag_4_5ms == 1'b1) || (flag_2_25ms == 1'b1)))
					cnt	<= 19'd0;
				else
					cnt	<= cnt + 1'b1;
			DATA	:
				if((inf_in_rise == 1'b1) && (flag_560us == 1'b1))
					cnt	<= 19'd0;
				else if((inf_in_fall == 1'b1) && ((flag_1_69ms == 1'b1) || (flag_560us == 1'b1)))
					cnt	<= 19'd0;
				else
					cnt	<= cnt + 1'b1;
			default	:
				cnt	<= 19'd0;
		endcase
	end
end

always  @(posedge sys_clk or negedge sys_rst_n)begin
	if(sys_rst_n==1'b0)begin
		flag_9ms <= 1'b0;
	end
	else if((state == TIME_9MS) && ( cnt >= CNT_9MS_MIN) && (cnt <= CNT_9MS_MAX))
		flag_9ms <= 1'b1;
	else begin
		flag_9ms <= 1'b0;
	end
end

always  @(posedge sys_clk or negedge sys_rst_n)begin
	if(sys_rst_n==1'b0)begin
		flag_4_5ms	<= 1'b0;
	end
	else if((state == ARBIT) && (cnt >= CNT_4_5MS_MIN) && (cnt <= CNT_4_5MS_MAX)) begin
		flag_4_5ms	<= 1'b1;
	end
	else begin
		flag_4_5ms	<= 1'b0;
	end
end

always  @(posedge sys_clk or negedge sys_rst_n)begin
	if(sys_rst_n==1'b0)begin
		flag_560us	<= 1'b0;
	end
	else if((state == DATA) && (cnt >= CNT_560US_MIN) && (cnt <= CNT_560US_MAX)) begin
		flag_560us	<= 1'b1;
	end
	else begin
		flag_560us	<= 1'b0;
	end
end

always  @(posedge sys_clk or negedge sys_rst_n)begin
	if(sys_rst_n==1'b0)begin
		flag_1_69ms	<= 1'b0;
	end
	else if((state == DATA) && (cnt >= CNT_1_69MS_MIN) && (cnt <= CNT_1_69MS_MAX)) begin
		flag_1_69ms	<= 1'b1;
	end
	else begin
		flag_1_69ms	<= 1'b0;
	end
end

always  @(posedge sys_clk or negedge sys_rst_n)begin
	if(sys_rst_n==1'b0)begin
		flag_2_25ms	<= 1'b0;
	end
	else if((state == ARBIT) && (cnt >= CNT_2_25MS_MIN) && (cnt <= CNT_2_25MS_MAX)) begin
		flag_2_25ms	<= 1'b1;
	end
	else begin
		flag_2_25ms	<= 1'b0;
	end
end

always  @(posedge sys_clk or negedge sys_rst_n)begin
	if(sys_rst_n==1'b0)begin
		cnt_data	<= 6'd0;
	end
	else if((inf_in_rise == 1'b1) && (cnt_data == 6'd32)) begin
		cnt_data	<= 6'd0;
	end
	else if((inf_in_fall == 1'b1) && (state == DATA)) begin
		cnt_data	<= cnt_data + 1'b1;
	end
	else begin
		cnt_data	<= cnt_data;
	end
end

always  @(posedge sys_clk or negedge sys_rst_n)begin
	if(sys_rst_n==1'b0)begin
		data_reg	<= 32'd0;
	end
	else if((state == DATA) && (inf_in_fall == 1'b1) && (flag_560us == 1'b1)) begin
		data_reg[cnt_data]	<= 1'b0;
	end
	else if((state == DATA) && (inf_in_fall == 1'b1) && (flag_1_69ms == 1'b1)) begin
		data_reg[cnt_data]	<= 1'b1;
	end
	else begin
		data_reg	<= data_reg;
	end
end

always  @(posedge sys_clk or negedge sys_rst_n)begin
	if(sys_rst_n==1'b0)begin
		data	<= 24'd0;
	end
	else if((cnt_data == 6'd32) && (~data_reg[23:16] == data_reg[31:24]) && (~data_reg[15:8] == data_reg[7:0])) begin
		data	<= {16'b0, data_reg[23:16]};
	end
	else begin
		data	<= data;
	end
end

always  @(posedge sys_clk or negedge sys_rst_n)begin
	if(sys_rst_n==1'b0)begin
		repeat_en	<= 1'b0;
	end
	else if((state == REPEAT) && (~data_reg[23:16] == data_reg[31:24])) begin
		repeat_en 	<= 1'b1;
	end
	else begin
		repeat_en	<= 1'b0;
	end
end


endmodule

