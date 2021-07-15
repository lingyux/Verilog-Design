/*
	00表示0
	01表示1
	10表示-1
*/


module hdb3_decode (
	input i_rst_n,
	input i_clk,
	input [1:0] i_hdb3_code,
	output o_data
);
	reg [1:0] temp0_code, temp1_code;
	reg [4:0] r_hdb3_plus;
	reg [4:0] r_hdb3_minus;

	assign o_data = (1'b1 == r_hdb3_minus[4] || 1'b1 == r_hdb3_plus[4]) ? 1'b1 : 1'b0;

	always@(posedge i_clk, negedge i_rst_n)
	begin
		if(1'b0 == i_rst_n)
		begin
			temp0_code <= 2'b0;
			temp1_code <= 2'b0;
		end
		else
		begin
			temp0_code <= i_hdb3_code;
			temp1_code <= temp0_code;
		end
	end

	always@(posedge i_clk, negedge i_rst_n)
	begin
		if(1'b0 == i_rst_n)
		begin
			r_hdb3_plus <= 5'b0;
			r_hdb3_minus <= 5'b0;
		end
		else 
		begin
			if(1'b1 == temp1_code[1] && 4'b1000 == r_hdb3_plus[3:0] && 4'b0000 == r_hdb3_minus[3:0])
			begin
				r_hdb3_plus <= {r_hdb3_plus[3], 4'b0000};
				r_hdb3_minus <= {r_hdb3_minus[3:0], temp1_code[0]};
			end
			else if(1'b1 == temp1_code[0] && 4'b1000 == r_hdb3_minus[3:0] && 4'b0000 == r_hdb3_plus[3:0])
			begin
				r_hdb3_minus <= {r_hdb3_minus[3], 4'b0000};
				r_hdb3_plus <= {r_hdb3_plus[3:0], temp1_code[1]};
			end
			else if(1'b1 == temp1_code[1] && 3'b100 == r_hdb3_plus[2:0] && 3'b000 == r_hdb3_minus[2:0])
			begin
				r_hdb3_plus <= {r_hdb3_plus[3], 4'b0000};
				r_hdb3_minus <= {r_hdb3_minus[3:0], temp1_code[0]};
			end
			else if(1'b1 == temp1_code[0] && 3'b100 == r_hdb3_minus[2:0] && 3'b000 == r_hdb3_plus[2:0])
			begin
				r_hdb3_minus <= {r_hdb3_minus[3], 4'b0000};
				r_hdb3_plus <= {r_hdb3_plus[3:0], temp1_code[1]};
			end
			else
			begin
				r_hdb3_plus <= {r_hdb3_plus[3:0], temp1_code[1]};
				r_hdb3_minus <= {r_hdb3_minus[3:0], temp1_code[0]};
			end
		end
	end
endmodule
