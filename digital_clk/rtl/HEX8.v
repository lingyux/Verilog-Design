module HEX8(clk, rst_n, en, disp_data, sel, seg);

	input clk, rst_n, en;
	input [23:0] disp_data;
	output [5:0] sel; //数码管位选
	output reg [6:0] seg; //数码管段选
	
	reg [14:0] divider_cnt;
	
	reg clk_1k;
	
	reg [5:0] sel_r;
	
	reg [3:0] data_temp;//数据缓存

	//产生分频计数模块
	always@(posedge clk, negedge rst_n) begin
		if(!rst_n)
			divider_cnt <= 15'b0;
		else if(!en)
			divider_cnt <= 15'b0;
		else begin
			if(divider_cnt == 15'd24999)
				divider_cnt <= 15'b0;
			else
				divider_cnt <= divider_cnt + 1'b1;
		end
	end
	//1khz的扫描时钟
	always@(posedge clk, negedge rst_n) begin
		if(!rst_n)
			clk_1k <= 1'b0;
		else if(divider_cnt == 15'd24999)
			clk_1k <= ~clk_1k;
	end
	//6位循环移位寄存器
	always@(posedge clk_1k or negedge rst_n) begin
		if(!rst_n)
			sel_r <= 6'b11_1110;
		else if(sel_r == 6'b01_1111)
			sel_r <= 6'b11_1110;
		else
			sel_r <= {sel_r[4:0], sel_r[5]};
	end
	
	always@(*) begin
		case(sel_r)
			6'b11_1110:	data_temp = disp_data[3:0];
			6'b11_1101:	data_temp = disp_data[7:4];
			6'b11_1011:	data_temp = disp_data[11:8];
			6'b11_0111:	data_temp = disp_data[15:12];
			6'b10_1111:	data_temp = disp_data[19:16];
			6'b01_1111:	data_temp = disp_data[23:20];	
			default: data_temp = 4'b0000;
		endcase
	end
	
	always@(*) begin
		case(data_temp)
			4'h0:	seg = 7'b100_0000;
			4'h1:	seg = 7'b111_1001;
			4'h2:	seg = 7'b010_0100;
			4'h3:	seg = 7'b011_0000;
			4'h4:	seg = 7'b001_1001;
			4'h5:	seg = 7'b001_0010;
			4'h6:	seg = 7'b000_0010;
			4'h7:	seg = 7'b111_1000;
			4'h8:	seg = 7'b000_0000;
			4'h9:	seg = 7'b001_0000;
			4'hA:	seg = 7'b000_1000;
			4'hB:	seg = 7'b000_0011;
			4'hC:	seg = 7'b100_0110;
			4'hD:	seg = 7'b010_0001;
			4'hE:	seg = 7'b000_0110;
			4'hF:	seg = 7'b000_1110;
		endcase
	end
	
	assign sel = (en) ? sel_r : 6'b00_0000;

endmodule 