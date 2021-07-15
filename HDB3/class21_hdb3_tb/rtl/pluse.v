module pluse (
	input i_clk,    // Clock
	input i_rst_n,
	output o_pluse
);
	parameter plu = 16'b1111_0000_0000_1110;
	reg [15:0] temp;

	assign o_pluse = temp[15];

	always@(posedge i_clk, negedge i_rst_n)
	begin
		if(1'b0 == i_rst_n)
		begin
			temp <= plu;
		end
		else begin
			temp <= {temp[14:0], temp[15]};
		end
	end

	// always@(posedge i_clk, negedge i_rst_n)
	// begin
	// 	if(1'b0 == i_rst_n)
	// 	begin
	// 		o_pluse <= 1'b0;
	// 	end
	// 	else begin
	// 		o_pluse <= temp[31];
	// 	end
	// end

	
endmodule