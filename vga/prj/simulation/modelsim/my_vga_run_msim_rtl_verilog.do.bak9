transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+D:/01workplace/Quartus/class27_vga/rtl {D:/01workplace/Quartus/class27_vga/rtl/my_vga.v}
vlog -vlog01compat -work work +incdir+D:/01workplace/Quartus/class27_vga/rtl {D:/01workplace/Quartus/class27_vga/rtl/vga_pic.v}
vlog -vlog01compat -work work +incdir+D:/01workplace/Quartus/class27_vga/rtl {D:/01workplace/Quartus/class27_vga/rtl/vga_ctrl.v}
vlog -vlog01compat -work work +incdir+D:/01workplace/Quartus/class27_vga/prj/ip/pll_25Mhz {D:/01workplace/Quartus/class27_vga/prj/ip/pll_25Mhz/pll_25Mhz.v}
vlog -vlog01compat -work work +incdir+D:/01workplace/Quartus/class27_vga/prj/db {D:/01workplace/Quartus/class27_vga/prj/db/pll_25mhz_altpll.v}

vlog -vlog01compat -work work +incdir+D:/01workplace/Quartus/class27_vga/prj/../testbench {D:/01workplace/Quartus/class27_vga/prj/../testbench/tb_my_vga.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  tb_my_vga

add wave *
view structure
view signals
run 1 us
