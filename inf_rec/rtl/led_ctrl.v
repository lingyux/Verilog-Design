module led_ctrl(
	input			wire			sys_clk		,
	input			wire			sys_rst_n	,
	input			wire			repeat_en	,

	output			reg				led			 
);

parameter	CNT_MAX = 23'd2500_000		;

wire			 repeat_en_rise			;

reg				repeat_en_d1			;
reg				repeat_en_d2			;
reg  [22:0]		cnt						;

always  @(posedge sys_clk or negedge sys_rst_n)begin
	if(sys_rst_n==1'b0)begin
		repeat_en_d1	<= 1'b0;
		repeat_en_d2	<= 1'b0;
	end
	else begin
		repeat_en_d1	<= repeat_en	;
		repeat_en_d2	<= repeat_en_d1	;
	end
end

assign repeat_en_rise = (repeat_en_d2 == 1'b0) && (repeat_en_d1 == 1'b1);

always  @(posedge sys_clk or negedge sys_rst_n)begin
	if(sys_rst_n==1'b0)begin
		cnt	<= 23'd0;
	end
	else if(repeat_en_rise == 1'b1) begin
		cnt	<= CNT_MAX;
	end
	else if(cnt > 1'b0) begin
		cnt	<= cnt - 1'b1;
	end
	else begin
		cnt	<= 23'd0;
	end
end

always  @(posedge sys_clk or negedge sys_rst_n)begin
	if(sys_rst_n==1'b0)begin
		led	<= 1'b1;
	end
	else if(cnt > 0)begin
		led	<= 1'b0;
	end
	else begin
		led	<= 1'b1;
	end
end


endmodule

