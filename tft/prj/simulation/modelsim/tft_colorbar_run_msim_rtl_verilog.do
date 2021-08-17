transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+D:/01workplace/Quartus/class40_tft/rtl {D:/01workplace/Quartus/class40_tft/rtl/tft_pic.v}
vlog -vlog01compat -work work +incdir+D:/01workplace/Quartus/class40_tft/rtl {D:/01workplace/Quartus/class40_tft/rtl/tft_ctrl.v}
vlog -vlog01compat -work work +incdir+D:/01workplace/Quartus/class40_tft/rtl {D:/01workplace/Quartus/class40_tft/rtl/tft_colorbar.v}
vlog -vlog01compat -work work +incdir+D:/01workplace/Quartus/class40_tft/prj/ip/clk_9m {D:/01workplace/Quartus/class40_tft/prj/ip/clk_9m/clk_9m.v}
vlog -vlog01compat -work work +incdir+D:/01workplace/Quartus/class40_tft/prj/db {D:/01workplace/Quartus/class40_tft/prj/db/clk_9m_altpll.v}

vlog -vlog01compat -work work +incdir+D:/01workplace/Quartus/class40_tft/prj/../testbench {D:/01workplace/Quartus/class40_tft/prj/../testbench/tb_tft_colorbar.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  tb_tft_colorbar

add wave *
view structure
view signals
run 1 us
