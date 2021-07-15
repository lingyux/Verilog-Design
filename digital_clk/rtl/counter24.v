module counter24(
	clk			,
	rst_n		,
	load		,
	en			,
	data_in		,
	data_out	
);
	input			clk		;
	input			rst_n	;
	input			load	;
	input			en		;
	input [7:0]		data_in	;
	output[7:0]		data_out;

	reg   [3:0]		cnt_l	;
	reg   [3:0]		cnt_h	;
	
	assign data_out = {cnt_h, cnt_l};
	always @(posedge clk or negedge rst_n)begin
		if(!rst_n)begin
			cnt_l <= 4'd0;
			cnt_h <= 4'd0;
		end
		else if(load) begin
			cnt_l <= data_in[3:0];
			cnt_h <= data_in[7:4];
		end
		else if(en)begin
			if(cnt_l == 4'd3 && cnt_h == 4'd2)begin
				cnt_l <= 4'd0;
				cnt_h <= 4'd0;
			end
			else if(cnt_l == 4'd9) begin
				cnt_l <= 4'd0;
				if(cnt_h == 4'd2)
					cnt_h <= 4'd0;
				else
					cnt_h <= cnt_h + 1'b1;
			end
			else
				cnt_l <= cnt_l + 1'b1;
		end
	end 


endmodule

