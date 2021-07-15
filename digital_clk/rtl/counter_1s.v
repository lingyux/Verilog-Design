module counter_1s(
	clk			,
	rst_n		,
	en			,
	next_en		
);
	input		clk		;
	input		rst_n	;
	input 		en		;

	output		next_en	;

	reg [11:0]	cnt		;
	wire		add_cnt	;
	wire		end_cnt	;

	assign next_en = add_cnt && end_cnt;

	always @(posedge clk or negedge rst_n)begin
		if(!rst_n)begin
			cnt <= 0;
		end
		else if(add_cnt)begin
			if(end_cnt)
				cnt <= 0;
			else
				cnt <= cnt + 1'b1;
		end
	end

	assign add_cnt = en;       
	assign end_cnt = add_cnt && cnt == 1000 - 1;   


endmodule

