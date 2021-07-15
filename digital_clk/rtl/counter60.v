module counter60(
	clk			,
	rst_n		,
	load		,
	en			,
	data_in		,
	data_out	,
	next_en		
);
	input			clk			;
	input			rst_n		;
	input			load		;
	input			en			;
	input [7:0]		data_in		;
	output[7:0]		data_out	;
	output			next_en		;
	
	wire			add_cnt_l	;
	wire			add_cnt_h	;
	wire			end_cnt_l	;
	wire			end_cnt_h	;

	reg [3:0]		cnt_l		;
	reg [3:0]		cnt_h		;

	assign data_out = {cnt_h, cnt_l};
	assign next_en 	= add_cnt_h && end_cnt_h;


	always @(posedge clk or negedge rst_n)begin
		if(!rst_n)begin
			cnt_l <= 0;
		end
		else if(load) begin
			cnt_l <= data_in[3:0];
		end
		else if(add_cnt_l)begin
			if(end_cnt_l)
				cnt_l <= 0;
			else
				cnt_l <= cnt_l + 1'b1;
		end
	end

	assign add_cnt_l = en;       
	assign end_cnt_l = add_cnt_l && cnt_l == 10 - 1;   

	always @(posedge clk or negedge rst_n)begin
		if(!rst_n)begin
			cnt_h <= 0;
		end
		else if(load) begin
			cnt_h <= data_in[7:4];
		end
		else if(add_cnt_h)begin
			if(end_cnt_h)
				cnt_h <= 0;
			else
				cnt_h <= cnt_h + 1'b1;
		end
	end

	assign add_cnt_h = add_cnt_l && end_cnt_l;       
	assign end_cnt_h = add_cnt_h && cnt_h == 6 - 1;   

endmodule

