transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+D:/TEC/VIII\ Semestre/Arquitectura\ de\ Computadores\ I/Proyecto2-Arquitectura {D:/TEC/VIII Semestre/Arquitectura de Computadores I/Proyecto2-Arquitectura/instruction_memory.v}
vlog -sv -work work +incdir+D:/TEC/VIII\ Semestre/Arquitectura\ de\ Computadores\ I/Proyecto2-Arquitectura {D:/TEC/VIII Semestre/Arquitectura de Computadores I/Proyecto2-Arquitectura/fetch_cycle.sv}

vlog -sv -work work +incdir+D:/TEC/VIII\ Semestre/Arquitectura\ de\ Computadores\ I/Proyecto2-Arquitectura {D:/TEC/VIII Semestre/Arquitectura de Computadores I/Proyecto2-Arquitectura/fetch_cycle_tb.sv}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cyclonev_ver -L cyclonev_hssi_ver -L cyclonev_pcie_hip_ver -L rtl_work -L work -voptargs="+acc"  fetch_cycle_tb

add wave *
view structure
view signals
run -all
