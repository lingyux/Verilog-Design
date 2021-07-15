/*
	00表示0
	01表示1
	10表示-1
*/

/*
输出采用00代表0
	采用01代表1
	采用10代表V
	采用11代表B
*/
module hdb3_d2t (
	input i_rst_n,
	input i_clk,
	input [1:0] i_plug_b_code,
	output reg [1:0] o_hdb3_code
);
	reg r_not_0_parity;//用于表示当前1的取值, 若为1则为1，为0则为-1
	always@(posedge i_clk, negedge i_rst_n)
	begin
		if(1'b0 == i_rst_n)
		begin
			r_not_0_parity <= 1'b0;
			o_hdb3_code <= 2'b0;
		end
		else
		begin
			if(2'b01 == i_plug_b_code)
				if(1'b1 == r_not_0_parity)
				begin
					o_hdb3_code <= 2'b01;
					r_not_0_parity <= ~r_not_0_parity;
				end
				else
				begin
					o_hdb3_code <= 2'b10;
					r_not_0_parity <= ~r_not_0_parity;
				end
			else if(2'b10 == i_plug_b_code)
				if(1'b1 == r_not_0_parity)
				begin
					o_hdb3_code <= 2'b10;
					r_not_0_parity <= r_not_0_parity;
				end
				else
				begin
					o_hdb3_code <= 2'b01;
					r_not_0_parity <= r_not_0_parity;
				end
			else if(2'b11 == i_plug_b_code)
				if(1'b1 == r_not_0_parity)
				begin
					o_hdb3_code <= 2'b01;
					r_not_0_parity <= ~r_not_0_parity;
				end
				else
				begin
					o_hdb3_code <= 2'b10;
					r_not_0_parity <= ~r_not_0_parity;
				end
			else
			begin
				o_hdb3_code <=2'b00;
				r_not_0_parity <= r_not_0_parity;
			end
		end
	end
endmodule
