module ring(
	clk				,
	rst_n			,
	load			,
	data_in_load	,
	data_in_cmp		,
	data_ring		,
	ring			
);
	input 			clk				;
	input			rst_n			;
	input			load			;
	input  [15:0]	data_in_load	;
	input  [15:0]	data_in_cmp		;
	output [15:0]	data_ring		;
	output			ring			;

	reg		[15:0]	data_ring			;
	reg		[15:0]	data_in_load_tmp0	;
	reg		[15:0]	data_in_load_tmp1	;
	reg		[15:0]	data_in_load_tmp2	;
	reg		[15:0]	data_in_cmp_tmp0	; 
	reg		[15:0]	data_in_cmp_tmp1	; 
	reg		[15:0]	data_in_cmp_tmp2	; 

	assign ring = data_ring == data_in_cmp_tmp2;

	always  @(posedge clk or negedge rst_n)begin
		if(rst_n==1'b0)begin
			data_in_load_tmp0	<= 16'b0; 
            data_in_load_tmp1	<= 16'b0;
            data_in_load_tmp2	<= 16'b0;
		end
		else begin
			data_in_load_tmp0	<= data_in_load; 
            data_in_load_tmp1	<= data_in_load_tmp0;
            data_in_load_tmp2	<= data_in_load_tmp1;
		end
	end
	
	always  @(posedge clk or negedge rst_n)begin
		if(rst_n==1'b0)begin
			data_ring <= 16'h0;
		end
		else if(load)begin
			data_ring <= data_in_load_tmp2;
		end
	end


	always  @(posedge clk or negedge rst_n)begin
		if(rst_n==1'b0)begin
			data_in_cmp_tmp0	<= 16'b0; 
            data_in_cmp_tmp1	<= 16'b0;
            data_in_cmp_tmp2	<= 16'b0;
		end
		else begin
			data_in_cmp_tmp0	<= data_in_cmp; 
            data_in_cmp_tmp1	<= data_in_cmp_tmp0;
            data_in_cmp_tmp2	<= data_in_cmp_tmp1;
		end
	end

endmodule

