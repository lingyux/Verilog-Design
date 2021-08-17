module tft_ctrl(
	input	wire			clk_9m			,
	input	wire			sys_rst_n		,
	input	wire  [15:0]	pix_data		,

	output	wire  [15:0]	tft_rgb				,
	output	wire 			hsync				,
	output	wire 			vsync				,
	output	wire  [9:0]		pix_x				,
	output	wire  [9:0]		pix_y				,
	output	wire			tft_de				,
	output	wire			tft_clk				,
	output	wire			tft_bl				 
);

	reg	   [9:0]		cnt_h				;
	reg	   [9:0]		cnt_v				;
	wire				rgb_valid			;
	wire				add_cnt_h			;
	wire				add_cnt_v			;
	wire				end_cnt_h			;
	wire				end_cnt_v			;
	wire				rgb_valid_req		;

	parameter		H_SYNC	= 10'd41		,
					H_BACK	= 10'd02		,
					H_VALID = 10'd480		,
					H_FRONT = 10'd2			,
					H_TOTAL	= 10'd525		;

	parameter		V_SYNC	= 10'd10		,
					V_BACK	= 10'd02		,
					V_VALID = 10'd272		,
					V_FRONT	= 10'd2			,
					V_TOTAL	= 10'd286		;
	assign	tft_de	 = rgb_valid	; 
	assign	tft_clk	 = clk_9m		;
	assign	tft_bl	 = sys_rst_n	;
	
	always @(posedge clk_9m or negedge sys_rst_n)begin
		if(!sys_rst_n)begin
			cnt_h <= 0;
		end
		else if(add_cnt_h)begin
			if(end_cnt_h)
				cnt_h <= 0;
			else
				cnt_h <= cnt_h + 1'b1;
		end
	end

	assign add_cnt_h = 1;       
	assign end_cnt_h = add_cnt_h && cnt_h == H_TOTAL - 1'b1;   
	always @(posedge clk_9m or negedge sys_rst_n)begin
		if(!sys_rst_n)begin
			cnt_v <= 0;
		end
		else if(add_cnt_v)begin
			if(end_cnt_v)
				cnt_v <= 0;
			else
				cnt_v <= cnt_v + 1'b1;
		end
	end

	assign add_cnt_v = end_cnt_h;       
	assign end_cnt_v = add_cnt_v && cnt_v == V_TOTAL - 1'b1;   
	assign rgb_valid = ((cnt_h >= H_SYNC + H_BACK) 
						&& (cnt_h < H_SYNC + H_BACK + H_VALID)
						&& (cnt_v >= V_SYNC + V_BACK)
						&& (cnt_v < V_SYNC + V_BACK + V_VALID)
					   ) ? 1'b1 : 1'b0;

	assign rgb_valid_req = ((cnt_h >= H_SYNC + H_BACK - 1'b1) 
						&& (cnt_h < H_SYNC + H_BACK + H_VALID - 1'b1)
						&& (cnt_v >= V_SYNC + V_BACK)
						&& (cnt_v < V_SYNC + V_BACK + V_VALID)
					   ) ? 1'b1 : 1'b0;

	assign pix_x 	 = (rgb_valid_req == 1'b1) ? (cnt_h - (H_SYNC + H_BACK - 1'b1)) : 10'h3ff;
	
	assign pix_y	 = (rgb_valid_req == 1'b1) ? (cnt_v - (V_SYNC + V_BACK)) : 10'h3ff;

	assign hsync	 = (cnt_h <= H_SYNC - 1'b1) ? 1'b1 : 1'b0;
	assign vsync	 = (cnt_v <= V_SYNC - 1'b1) ? 1'b1 : 1'b0;
	assign tft_rgb	 = (rgb_valid == 1'b1) ? pix_data : 16'h0000;



endmodule

