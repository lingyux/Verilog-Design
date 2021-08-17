module tft_pic(
	input	wire			clk_9m			,
	input	wire			sys_rst_n		,
	input	wire  	[9:0]	pix_x			,
	input	wire  	[9:0] 	pix_y			,

	output	reg		[15:0]	pix_data		 
);

	parameter		H_VALID = 10'd480,
					V_VALID = 10'd272;

	parameter		RED			= 16'hF800	, 
					ORANGE		= 16'hFC00	,
					YELLOW		= 16'hFFE0	,
					GREEN		= 16'h07E0	,
					CYAN		= 16'h07FF	,
					BLUE		= 16'h001F	,
					PURPPLE		= 16'hF81F	,
					BLACK		= 16'h0000	,
					WHITE		= 16'hFFFF	,
					GRAY		= 16'hD69A	;

	always  @(posedge clk_9m or negedge sys_rst_n)begin
		if(sys_rst_n==1'b0)begin
			pix_data		<= BLACK	;
		end
		else if(pix_x >= 0 && pix_x <= (H_VALID / 10) * 1) begin
			pix_data		<= RED		;
		end
		else if(pix_x >= (H_VALID / 10) * 1 && pix_x <= (H_VALID / 10) * 2) begin
			pix_data		<= ORANGE		;
		end
		else if(pix_x >= (H_VALID / 10) * 2 && pix_x <= (H_VALID / 10) * 3) begin
			pix_data		<= YELLOW		;
		end
		else if(pix_x >= (H_VALID / 10) * 3 && pix_x <= (H_VALID / 10) * 4) begin
			pix_data		<= GREEN		;
		end
		else if(pix_x >= (H_VALID / 10) * 4 && pix_x <= (H_VALID / 10) * 5) begin
			pix_data		<= CYAN		;
		end
		else if(pix_x >= (H_VALID / 10) * 5 && pix_x <= (H_VALID / 10) * 6) begin
			pix_data		<= BLUE		;
		end
		else if(pix_x >= (H_VALID / 10) * 6 && pix_x <= (H_VALID / 10) * 7) begin
			pix_data		<= PURPPLE		;
		end
		else if(pix_x >= (H_VALID / 7) * 2 && pix_x <= (H_VALID / 10) * 8) begin
			pix_data		<= BLACK		;
		end
		else if(pix_x >= (H_VALID / 8) * 2 && pix_x <= (H_VALID / 10) * 9) begin
			pix_data		<= WHITE		;
		end
		else if(pix_x >= (H_VALID / 10) * 9 && pix_x <= H_VALID ) begin
			pix_data		<= GRAY			;
		end
		else begin
			pix_data		<= BLACK		;
		end
	end

endmodule

