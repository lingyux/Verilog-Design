module vga_ctrl(
	vga_clk				,
	rst_n				,
	pix_data			,

	vga_rgb				,
	hsync				,
	vsync				,
	pix_x				,
	pix_y				
);
	input				vga_clk				;
	input				rst_n				;
	input  [15:0]		pix_data			;

	output [15:0]		vga_rgb				;
	output				hsync				;
	output				vsync				;
	output [9:0]		pix_x				;
	output [9:0]		pix_y				;

	reg	   [9:0]		cnt_h				;
	reg	   [9:0]		cnt_v				;
	wire				rgb_valid			;
	wire				add_cnt_h			;
	wire				add_cnt_v			;
	wire				end_cnt_h			;
	wire				end_cnt_v			;
	wire				rgb_valid_req		;

	parameter		H_SYNC	= 10'd96		,
					H_BACK	= 10'd40		,
					H_LEFT	= 10'd8			,
					H_VALID = 10'd640		,
					H_RIGHT	= 10'd8			,
					H_FRONT = 10'd8			,
					H_TOTAL	= 10'd800		;

	parameter		V_SYNC	= 10'd2			,
					V_BACK	= 10'd25		,
					V_TOP	= 10'd8			,
					V_VALID = 10'd480		,
					V_BOTTOM= 10'd8			,
					V_FRONT	= 10'd2			,
					V_TOTAL	= 10'd525		;
	
	always @(posedge vga_clk or negedge rst_n)begin
		if(!rst_n)begin
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
	always @(posedge vga_clk or negedge rst_n)begin
		if(!rst_n)begin
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
	assign rgb_valid = ((cnt_h >= H_SYNC + H_BACK + H_LEFT) 
						&& (cnt_h < H_SYNC + H_BACK + H_LEFT + H_VALID)
						&& (cnt_v >= V_SYNC + V_BACK + V_TOP)
						&& (cnt_v < V_SYNC + V_BACK + V_TOP + V_VALID)
					   ) ? 1'b1 : 1'b0;

	assign rgb_valid_req = ((cnt_h >= H_SYNC + H_BACK + H_LEFT - 1'b1) 
						&& (cnt_h < H_SYNC + H_BACK + H_LEFT + H_VALID - 1'b1)
						&& (cnt_v >= V_SYNC + V_BACK + V_TOP)
						&& (cnt_v < V_SYNC + V_BACK + V_TOP + V_VALID)
					   ) ? 1'b1 : 1'b0;

	assign pix_x 	 = (rgb_valid_req == 1'b1) ? (cnt_h - (H_SYNC + H_BACK + H_LEFT - 1'b1)) : 10'h3ff;
	
	assign pix_y	 = (rgb_valid_req == 1'b1) ? (cnt_v - (V_SYNC + V_BACK + V_TOP)) : 10'h3ff;

	assign hsync	 = (cnt_h <= H_SYNC - 1'b1) ? 1'b1 : 1'b0;
	assign vsync	 = (cnt_v <= V_SYNC - 1'b1) ? 1'b1 : 1'b0;
	assign vga_rgb	 = (rgb_valid == 1'b1) ? pix_data : 16'h0000;



endmodule

