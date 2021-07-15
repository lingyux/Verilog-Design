module keyboard(
	clk				,
	rst_n			,
	load			,	// 数据加载信号
	en				,	// 修改允许信号
	key_p_state		,	// 闹钟调整按钮
	key_p_flag		,	
	key_n_state		,	// 调整位数选择
	key_n_flag		,
	key_e_state		,	// 调整确认按钮
	key_e_flag		,
	data_in			,	// 输入调整数据
	data_out		,	// 输出数据
	data_out_vld		// 输出数据有效信号
);
	input			clk			;
	input			rst_n		;
	input			load		;
	input			en			;
	input			key_p_state	;
	input			key_p_flag	;
	input			key_n_state	;
	input			key_n_flag	;
	input			key_e_state	;
	input			key_e_flag	;
	input  [15:0]	data_in		;
	output [15:0]	data_out	;
	output			data_out_vld;

	wire			add_cnt0		;
	wire			end_cnt0		;
	reg		[2:0]	cnt0			;
	reg		[3:0]	data_temp [3:0]	;	// 定义数据暂存
//	位数选择计数器
	always @(posedge clk or negedge rst_n)begin
		if(!rst_n)begin
			cnt0 <= 0;
		end
		else if(add_cnt0)begin
			if(end_cnt0)
				cnt0 <= 0;
			else
				cnt0 <= cnt0 + 1'b1;
		end
	end

	assign add_cnt0 = key_n_flag && !key_n_state && en;       
	assign end_cnt0 = add_cnt0 && cnt0 == 4 - 1;   

	always  @(posedge clk or negedge rst_n)begin
		if(rst_n==1'b0)begin
			data_temp[0] <= 4'b0;
			data_temp[1] <= 4'b0;
			data_temp[2] <= 4'b0;
			data_temp[3] <= 4'b0;
		end
		else if(load) begin
			{data_temp[3], data_temp[2], data_temp[1], data_temp[0]} <= data_in;
		end
		else if (en) begin
			if(key_p_flag && !key_p_state) begin
				if(data_temp[cnt0] == 4'h9)
					data_temp[cnt0] <= 4'h0;
				else
					data_temp[cnt0] <= data_temp[cnt0] + 1'b1;
			end
		end
	end

	assign data_out = {data_temp[3], data_temp[2], data_temp[1], data_temp[0]};
	assign data_out_vld = key_e_flag && !key_e_state && en;

endmodule

