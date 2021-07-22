`timescale 1ns/1ns
module vga_ctrl_tb();
	
	reg					clk				;
	reg					rst_n			;
	wire  [15:0]		pix_data		;

	wire				vga_clk			;
	wire				locked			;
	wire [15:0]			vga_rgb			;
	wire                hsync			;
	wire                vsync			;	
	wire [9:0]			pix_x			;
    wire [9:0]          pix_y			;
	wire				sys_rst_n		;
	initial begin
		clk = 1'b1;
		rst_n = 1'b0;
		#10 rst_n = 1'b1;
	end

	always #10 clk = ~clk;

	assign sys_rst_n = rst_n && locked ;
/*
	always  @(posedge vga_clk or negedge rst_n)begin
		if(rst_n==1'b0)begin
			pix_data <= 16'h0000;
		end
		else if(pix_x >= 10'd0 && pix_x <= 10'd639 && pix_y >= 10'd0 && pix_y <= 10'd479)begin
			pix_data <= 16'hffff;
		end
		else begin
			pix_data <= 16'h0000;
		end
	end
*/
	vga_pic vga_pic_inst(
		.vga_clk				(vga_clk	),
		.rst_n					(sys_rst_n	),
		.pix_x					(pix_x		),
		.pix_y					(pix_y		),
	                                        
		.pix_data			 	(pix_data	) 
	);

	pll_25Mhz	pll_25Mhz_inst (
		.areset ( ~rst_n 	),
		.inclk0 ( clk 		),
		.c0 	( vga_clk 	),
		.locked ( locked 	)
	);


	vga_ctrl vga_ctrl_inst(
		.vga_clk				(vga_clk	),
		.rst_n					(sys_rst_n	),
		.pix_data				(pix_data	),
	                                        
		.vga_rgb				(vga_rgb	),
		.hsync					(hsync		),
		.vsync					(vsync		),
		.pix_x					(pix_x		),
		.pix_y					(pix_y		) 
	);

endmodule

