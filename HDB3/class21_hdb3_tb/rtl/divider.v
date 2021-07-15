module divider(
	i_clk,
	i_rst_n,
	clk_1ms
);
	input i_clk;
	input i_rst_n;
	output clk_1ms;
	reg clk_1ms;
	parameter T = 17'd25_000;
	reg [16:0] cnt;
	
	wire add_cnt;
	wire end_cnt;
	
	
	assign add_cnt = 1;
	assign end_cnt = add_cnt && cnt == T - 1'b1;
	always@(posedge i_clk, negedge i_rst_n)
	begin
		if(!i_rst_n)
			cnt <= 0;
		else if(add_cnt)
			if(end_cnt)
				cnt <= 0;
			else
				cnt <= cnt + 1'b1;
	end
	

/*
	always@(posedge i_clk, negedge i_rst_n)
	begin
		if(1'b0 == i_rst_n)
			cnt <= 17'd0;
		else begin
			if(T == cnt)
				cnt <= 17'd0;
			else
				cnt <= cnt + 1'b1;
		end
	end
*/
	
	always@(posedge i_clk, negedge i_rst_n)
	begin
		if(1'b0 == i_rst_n)
			clk_1ms <= 1'b0;
		else if(end_cnt)
			clk_1ms <= ~clk_1ms;
		else
			clk_1ms <= clk_1ms;
	end
	
	

endmodule
