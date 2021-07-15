`timescale 1ns/1ns
module keyboard_ctrl_tb();
	
	reg				clk				;
	reg				rst_n			;
	reg				load			;
	reg				press_p			;
	reg				press_n			;
	reg				press_e			;
	reg  [15:0]		data_in			;

	wire [15:0]		data_out		;
	wire			data_out_vld	;
	wire			key_in_p		;
	wire			key_in_n		;
	wire			key_in_e		;


	initial begin
		clk = 1'b1;
		forever
			#1 clk = ~clk;
	end

	initial begin
		rst_n = 1'b0;
		press_p = 0;
		press_n = 0;
		press_e = 0;
		load = 0;
		#10;
		rst_n = 1'b1;
		#5;
		load = 1;
		data_in = 16'h1223;
		# 6;
		load = 0;
		press_p = 1;
		# 6;
		press_p = 0;
		# 80_000_000;
		press_p = 1;
		# 6;
		press_p = 0;
		# 80_000_000;
		press_n = 1;
		# 6;
		press_n = 0;
		# 80_000_000;
		press_p = 1;
		# 6;
		press_p = 0;
		# 80_000_000;
		press_p = 1;
		# 6;
		press_p = 0;
		#80_000_000;
		press_e = 1;
		# 6;
		press_e = 0;
		#80_000_000;
		$stop;
	end


	key_model key_model_p(
		.press			(press_p), 
		.key			(key_in_p	)
	);
	key_model key_model_n(
		.press			(press_n), 
		.key			(key_in_n	)
	);
	key_model key_model_e(
		.press			(press_e), 
		.key			(key_in_e	)
	);

	
	keyboard_ctrl keyboard_ctrl(
		.clk				(clk		 ),
		.rst_n				(rst_n		 ),
		.en					(1'b1		 ),
		.load				(load		 ),
		.key_in_p			(key_in_p	 ),
		.key_in_n			(key_in_n	 ),
		.key_in_e			(key_in_e	 ),
		.data_in			(data_in	 ),
		.data_out			(data_out	 ),
		.data_out_vld		(data_out_vld) 
	);

endmodule

