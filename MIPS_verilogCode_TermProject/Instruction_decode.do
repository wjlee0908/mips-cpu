onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /mips_testbench/mips/CLK
add wave -noupdate -radix binary /mips_testbench/mips/Instr
add wave -noupdate /mips_testbench/mips/Jump_addr
add wave -noupdate -radix binary /mips_testbench/mips/Read1
add wave -noupdate -radix binary /mips_testbench/mips/Read2
add wave -noupdate /mips_testbench/mips/RegDst
add wave -noupdate -radix binary /mips_testbench/mips/Reg_Write_addr
add wave -noupdate /mips_testbench/mips/Branch_or_offset
add wave -noupdate /mips_testbench/mips/RegWrite
add wave -noupdate -radix decimal /mips_testbench/mips/Read_data1
add wave -noupdate -radix decimal /mips_testbench/mips/Read_data2
add wave -noupdate -radix decimal /mips_testbench/mips/Reg_Write_data
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {163 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 149
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
WaveRestoreZoom {161 ns} {269 ns}
