#compilation
vlog testbench.sv

#elaboration
vsim top -sv_seed 369569

#there are no waveforms to add

#simulation
run -all