transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+D:/01workplace/Quartus/class21_hdb3_tb/rtl {D:/01workplace/Quartus/class21_hdb3_tb/rtl/hdb3_plug_v.v}
vlog -vlog01compat -work work +incdir+D:/01workplace/Quartus/class21_hdb3_tb/rtl {D:/01workplace/Quartus/class21_hdb3_tb/rtl/hdb3_plug_b.v}
vlog -vlog01compat -work work +incdir+D:/01workplace/Quartus/class21_hdb3_tb/rtl {D:/01workplace/Quartus/class21_hdb3_tb/rtl/hdb3_d2t.v}
vlog -vlog01compat -work work +incdir+D:/01workplace/Quartus/class21_hdb3_tb/rtl {D:/01workplace/Quartus/class21_hdb3_tb/rtl/hdb3_code.v}
vlog -vlog01compat -work work +incdir+D:/01workplace/Quartus/class21_hdb3_tb/rtl {D:/01workplace/Quartus/class21_hdb3_tb/rtl/hdb3_decode.v}
vlog -vlog01compat -work work +incdir+D:/01workplace/Quartus/class21_hdb3_tb/rtl {D:/01workplace/Quartus/class21_hdb3_tb/rtl/pluse.v}
vlog -vlog01compat -work work +incdir+D:/01workplace/Quartus/class21_hdb3_tb/rtl {D:/01workplace/Quartus/class21_hdb3_tb/rtl/hdb3.v}
vlog -vlog01compat -work work +incdir+D:/01workplace/Quartus/class21_hdb3_tb/prj/output_files {D:/01workplace/Quartus/class21_hdb3_tb/prj/output_files/divider.v}

vlog -vlog01compat -work work +incdir+D:/01workplace/Quartus/class21_hdb3_tb/prj/../testbench {D:/01workplace/Quartus/class21_hdb3_tb/prj/../testbench/divider_tb.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  divider_tb

add wave *
view structure
view signals
run -all
