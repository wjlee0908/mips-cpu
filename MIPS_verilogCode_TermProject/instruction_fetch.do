onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /mips_testbench/mips/CLK
add wave -noupdate /mips_testbench/mips/PC
add wave -noupdate /mips_testbench/mips/Next_PC
add wave -noupdate -radix binary /mips_testbench/mips/Instr
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {48 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 145
configure wave -valuecolwidth 259
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
WaveRestoreZoom {0 ns} {545 ns}
