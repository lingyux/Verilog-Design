module mode_chose(
	clk				,
	rst_n			,
	key_in_m		,
	
	en_clk			,
	en_keyboard		,
	clock_load		,
	ring_load		,
	keyboard_load	,
	mode_clk		,
	mode_ring		,
	mode_clk_ad		,
	mode_ring_ad	
);
	
	input				clk					;
	input				rst_n				;
	input				key_in_m			;
	
	output				en_clk				;
	output				en_keyboard			;
	output				clock_load			;
	output				ring_load			;
	output				keyboard_load		;
	output				mode_clk			;
	output				mode_ring			;
	output				mode_clk_ad			;
	output				mode_ring_ad		;

	reg					en_clk				;
	reg					en_keyboard			;
	reg					clock_load			;
	reg					ring_load			;
	reg					mode_clk			;
	reg					mode_ring			;
	reg					mode_clk_ad			;
	reg					mode_ring_ad		;
	reg					r_keyboard_load		;
	
	
	reg		[2:0]		cnt0				;
	wire				add_cnt0			;
	wire				end_cnt0			;
	wire				key_m_flag			;
	wire				key_m_state			;
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

	assign add_cnt0 = key_m_flag && !key_m_state;       
	assign end_cnt0 = add_cnt0 && cnt0 == 4 - 1;   

	assign keyboard_load = r_keyboard_load && add_cnt0;

	always  @(posedge clk or negedge rst_n)begin
		if(rst_n==1'b0)begin
			en_clk			<= 1'b0	;	 	 
			en_keyboard		<= 1'b0	;
			clock_load		<= 1'b0	;
			ring_load		<= 1'b0	;
			r_keyboard_load	<= 1'b0 ;
			mode_clk		<= 1'b0	;
			mode_ring		<= 1'b0	;
			mode_clk_ad		<= 1'b0	;
			mode_ring_ad	<= 1'b0	;
		end
		else begin
			case(cnt0)
				0: begin	// 闹钟正常运行模式
					en_clk			<= 1'b1 ;
					en_keyboard		<= 1'b0 ;
					clock_load		<= 1'b0	;
					ring_load		<= 1'b0	;
					r_keyboard_load	<= 1'b0 ;
					mode_clk		<= 1'b1 ;
					mode_ring		<= 1'b0 ;
					mode_clk_ad		<= 1'b0 ;
					mode_ring_ad	<= 1'b0 ;
				end
				1: begin	// 调整闹钟运行时间
					en_clk			<= 1'b1 ;
					en_keyboard		<= 1'b1 ;
					clock_load		<= 1'b1 ;
					ring_load		<= 1'b0	;
					r_keyboard_load	<= 1'b1 ;
					mode_clk		<= 1'b0 ;
					mode_ring		<= 1'b0 ;
					mode_clk_ad		<= 1'b1 ;
					mode_ring_ad	<= 1'b0 ;
				end
				2: begin	// 显示闹钟时间
					en_clk			<= 1'b1 ;
					en_keyboard		<= 1'b0 ;
					clock_load		<= 1'b0 ;
					ring_load		<= 1'b0	;
					r_keyboard_load	<= 1'b0 ;
					mode_clk		<= 1'b0 ;
					mode_ring		<= 1'b1 ;
					mode_clk_ad		<= 1'b0 ;
					mode_ring_ad	<= 1'b0 ;
				end
				3: begin	// 调整闹钟时间
					en_clk			<= 1'b1 ;
					en_keyboard		<= 1'b1 ;
					clock_load		<= 1'b0 ;
					ring_load		<= 1'b1	;
					r_keyboard_load	<= 1'b1 ;
					mode_clk		<= 1'b0 ;
					mode_ring		<= 1'b0 ;
					mode_clk_ad		<= 1'b0 ;
					mode_ring_ad	<= 1'b1 ;
				end
			endcase
		end
	end


	key_filter key_filter_m(
		.clk				(clk		),
		.rst_n				(rst_n		),
		.key_in				(key_in_m	),
		.key_flag			(key_m_flag	),
		.key_state			(key_m_state)
	);
endmodule

