onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /mips_testbench/mips/CLK
add wave -noupdate /mips_testbench/mips/Read_data2
add wave -noupdate /mips_testbench/mips/DM_Write_data
add wave -noupdate /mips_testbench/mips/ALU_result
add wave -noupdate /mips_testbench/mips/Read_or_Write_addr
add wave -noupdate /mips_testbench/mips/MemWrite
add wave -noupdate /mips_testbench/mips/MemRead
add wave -noupdate /mips_testbench/mips/DM_Read_data
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {83 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 201
configure wave -valuecolwidth 144
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ns} {528 ns}
