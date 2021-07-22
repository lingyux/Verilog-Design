`timescale 1ns/1ns
module tb_my_vga();
	
	reg					clk				;
	reg					rst_n			;

	wire				hsync			;
	wire				vsync			;
	wire [15:0]			vga_rgb			;


	initial begin
		clk = 1'b1;
		rst_n = 1'b0;
		#20 rst_n = 1'b1;
	end

	always #10 clk = ~clk	;

	my_vga my_vga_inst(
		.clk				(clk		),
		.rst_n				(rst_n		),
	                                    
		.hsync				(hsync		),
		.vsync				(vsync		),
		.vga_rgb			(vga_rgb	) 
	);

endmodule 
