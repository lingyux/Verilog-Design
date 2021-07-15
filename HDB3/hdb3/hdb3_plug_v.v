/*
输出采用00代表0
	采用01代表1
	采用10代表V
	采用11代表B
*/

`timescale 1ns/1ns

module hdb3_plug_v (
	input i_rst_n, 
	input i_clk,
	input i_data,
	output [1:0] o_plug_v_code
);
	//定义输出信号o_data的缓存
	reg [1:0] r_plug_v_code;
	reg [3:0] r_plug_v_code_h;
	reg [3:0] r_plug_v_code_l;
	reg [2:0] r_data_shift;

	assign o_plug_v_code = {r_plug_v_code_h[3], r_plug_v_code_l[3]};
	//function 对输入的基带信号进行移位寄存操作
	always@(posedge i_clk, negedge i_rst_n)
	begin
		if(1'b0 == i_rst_n)
		begin
			r_data_shift <= 3'b111;
		end
		else
		begin
			r_data_shift <= {r_data_shift[1:0], i_data};
		end
	end

	//判断输入的信号是否为4个连续的0, 若是则执行插入V的操作
	always@(posedge i_clk, negedge i_rst_n)
	begin
		if(1'b0 == i_rst_n)
		begin
			r_plug_v_code_h <= 4'b0000;
			r_plug_v_code_l <= 4'b0000;
		end
		else
		begin
			if(1'b0 == i_data && r_data_shift == 3'b000 && 3'b000 == r_plug_v_code_h[2:0])
			begin
				r_plug_v_code_h <= {r_plug_v_code_h[2:0], 1'b1};
				r_plug_v_code_l <= {r_plug_v_code_l[2:0], 1'b0};
			end
			else if(1'b1 == i_data)
			begin
				r_plug_v_code_h <= {r_plug_v_code_h[2:0], 1'b0};
				r_plug_v_code_l <= {r_plug_v_code_l[2:0], 1'b1};
			end
			else
			begin
				r_plug_v_code_h <= {r_plug_v_code_h[2:0], 1'b0};
				r_plug_v_code_l <= {r_plug_v_code_l[2:0], 1'b0};
			end
		end
	end
endmodule
