transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+D:/01workplace/Quartus/class29_Rs232/rtl {D:/01workplace/Quartus/class29_Rs232/rtl/Rs232.v}
vlog -vlog01compat -work work +incdir+D:/01workplace/Quartus/class29_Rs232/rtl {D:/01workplace/Quartus/class29_Rs232/rtl/Rs232_tx.v}
vlog -vlog01compat -work work +incdir+D:/01workplace/Quartus/class29_Rs232/rtl {D:/01workplace/Quartus/class29_Rs232/rtl/Rs232_rx.v}

vlog -vlog01compat -work work +incdir+D:/01workplace/Quartus/class29_Rs232/prj/../testbench {D:/01workplace/Quartus/class29_Rs232/prj/../testbench/Rs232_tb.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  Rs232_tb

add wave *
view structure
view signals
run 1 us
