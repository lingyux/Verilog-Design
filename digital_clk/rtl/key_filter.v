module key_filter(
	clk				,
	rst_n			,
	key_in			,
	key_flag		,
	key_state		
);
	input			clk			;
	input 			rst_n		;
	input			key_in		;


	output			key_flag	;
	output			key_state	;

	reg 			key_flag	;
	reg				key_state	;

	localparam
				IDLE		= 4'b0001,
				FILTER0		= 4'b0010,
				DOWN		= 4'b0100,
				FILTER1		= 4'b1000;
	reg [3:0]		state_c		;
	reg [3:0]		state_n		;
	reg				key_tempa	;
	reg				key_tempb	;
	wire			pedge		;
	wire			nedge		;
	reg				cnt_full	;
	reg	[19:0]		cnt			;
	reg				key_in_sa	;
	reg				key_in_sb	;
	reg				en_cnt		;
	//异步信号处理
	always  @(posedge clk or negedge rst_n)begin
		if(rst_n==1'b0)begin
			key_in_sa <= 1'b0;
			key_in_sb <= 1'b0;
		end
		else begin
			key_in_sa <= key_in;
			key_in_sb <= key_in_sa;
		end
	end


	always  @(posedge clk or negedge rst_n)begin
		if(rst_n==1'b0)begin
			key_tempa <= 1'b0;
			key_tempb <= 1'b0;
		end
		else begin
			key_tempa <= key_in_sb;
			key_tempb <= key_tempa;
		end
	end

	assign nedge = !key_tempa && key_tempb;// 下降沿检测
	assign pedge = key_tempa && !key_tempb;// 上升沿检测

	always  @(posedge clk or negedge rst_n)begin
		if(rst_n==1'b0)begin
			state_c <= IDLE;
		end
		else begin
			state_c <= state_n;	
		end
	end

	always  @(*)begin
		case(state_c)
			IDLE: begin
				if(nedge) begin
					state_n <= FILTER0;
				end
				else
					state_n <= IDLE;
			end
			FILTER0: begin
				if(cnt_full) begin
					state_n <= DOWN;
				end
				else if(pedge) begin
					state_n <= IDLE;
				end
				else begin
					state_n <= FILTER0;
				end
			end
			DOWN: begin
				if(pedge)
					state_n <= FILTER1;
				else
					state_n <= DOWN;
			end
			FILTER1: begin
				if(cnt_full)
					state_n <= IDLE;
				else if(nedge)
					state_n <= DOWN;
				else
					state_n <= FILTER1;
			end
			default: begin
				state_n <= IDLE;
			end
		endcase
	end

	always  @(posedge clk or negedge rst_n)begin
		if(rst_n==1'b0)begin
			key_flag 	<= 1'b0;
			key_state 	<= 1'b1;
			en_cnt		<= 1'b0;
		end
		else begin
			case(state_c)
				IDLE: begin
					key_flag <= 1'b0;
					if(nedge)
						en_cnt <= 1'b1;
				end
				FILTER0: begin
					if(cnt_full) begin
						key_flag 	<= 1'b1;
						key_state	<= 1'b0;
						en_cnt		<= 1'b0;
					end
					else if(pedge) begin
						en_cnt		<= 1'b0;
					end
				end
				DOWN: begin
					key_flag	<= 1'b0;
					if(pedge)
						en_cnt	<= 1'b1;
				end
				FILTER1: begin
					if(cnt_full) begin
						key_flag	<= 1'b1;
						key_state	<= 1'b1;
					end
					else if(nedge)
						en_cnt		<= 1'b0;
				end
				default: begin
					en_cnt		<= 1'b0;
					key_flag 	<= 1'b0;
					key_state	<= 1'b1;
				end
			endcase
		end
	end

	always  @(posedge clk or negedge rst_n)begin
		if(rst_n==1'b0)begin
			cnt <= 20'd0;
		end
		else if(en_cnt) begin
			cnt <= cnt + 1'b1;
		end
		else begin
			cnt <= 20'd0;
		end
	end

	always  @(posedge clk or negedge rst_n)begin
		if(rst_n==1'b0)begin
			cnt_full <= 1'b0;
		end
		else if(cnt == 999_999) begin
			cnt_full <= 1'b1;
		end
		else begin
			cnt_full <= 1'b0;
		end
	end


endmodule

