onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /mips_testbench/mips/CLK
add wave -noupdate -radix decimal /mips_testbench/mips/PC
add wave -noupdate /mips_testbench/mips/Instr
add wave -noupdate /mips_testbench/mips/Read_data1
add wave -noupdate /mips_testbench/mips/Read_data2
add wave -noupdate /mips_testbench/mips/Lw_Sw_offset
add wave -noupdate /mips_testbench/mips/Branch_or_offset
add wave -noupdate /mips_testbench/mips/ALUSrc
add wave -noupdate /mips_testbench/mips/Opcode
add wave -noupdate /mips_testbench/mips/ALUOp
add wave -noupdate /mips_testbench/mips/Lw_Sw_offset
add wave -noupdate /mips_testbench/mips/ALU_B
add wave -noupdate /mips_testbench/mips/ALU_result
add wave -noupdate /mips_testbench/mips/zero
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1078 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 173
configure wave -valuecolwidth 132
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
WaveRestoreZoom {0 ns} {3150 ns}
