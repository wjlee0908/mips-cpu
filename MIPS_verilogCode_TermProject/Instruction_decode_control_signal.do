onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /mips_testbench/mips/CLK
add wave -noupdate -radix binary /mips_testbench/mips/Instr
add wave -noupdate /mips_testbench/mips/Opcode
add wave -noupdate /mips_testbench/mips/Funct
add wave -noupdate /mips_testbench/mips/RegDst
add wave -noupdate /mips_testbench/mips/RegWrite
add wave -noupdate /mips_testbench/mips/ALUSrc
add wave -noupdate /mips_testbench/mips/MemWrite
add wave -noupdate /mips_testbench/mips/MemRead
add wave -noupdate /mips_testbench/mips/MemToReg
add wave -noupdate /mips_testbench/mips/ALUOp
add wave -noupdate /mips_testbench/mips/JToPC
add wave -noupdate /mips_testbench/mips/Branch
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 149
configure wave -valuecolwidth 258
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
WaveRestoreZoom {0 ns} {387 ns}
