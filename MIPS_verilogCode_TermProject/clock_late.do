onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /mips_testbench/mips/CLK
add wave -noupdate -radix decimal /mips_testbench/mips/PC
add wave -noupdate -radix binary /mips_testbench/mips/Instr
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
add wave -noupdate {/mips_testbench/mips/Reg/mem[8]}
add wave -noupdate {/mips_testbench/mips/Reg/mem[9]}
add wave -noupdate {/mips_testbench/mips/Reg/mem[10]}
add wave -noupdate {/mips_testbench/mips/Reg/mem[11]}
add wave -noupdate {/mips_testbench/mips/Reg/mem[12]}
add wave -noupdate {/mips_testbench/mips/Reg/mem[13]}
add wave -noupdate {/mips_testbench/mips/Reg/mem[14]}
add wave -noupdate {/mips_testbench/mips/Reg/mem[15]}
add wave -noupdate {/mips_testbench/mips/Reg/mem[16]}
add wave -noupdate {/mips_testbench/mips/Reg/mem[17]}
add wave -noupdate {/mips_testbench/mips/Reg/mem[18]}
add wave -noupdate {/mips_testbench/mips/Reg/mem[19]}
add wave -noupdate {/mips_testbench/mips/Reg/mem[20]}
add wave -noupdate {/mips_testbench/mips/Reg/mem[21]}
add wave -noupdate {/mips_testbench/mips/Reg/mem[22]}
add wave -noupdate {/mips_testbench/mips/Reg/mem[23]}
add wave -noupdate {/mips_testbench/mips/Reg/mem[24]}
add wave -noupdate {/mips_testbench/mips/Reg/mem[25]}
add wave -noupdate {/mips_testbench/mips/Reg/mem[26]}
add wave -noupdate {/mips_testbench/mips/Reg/mem[27]}
add wave -noupdate {/mips_testbench/mips/Reg/mem[28]}
add wave -noupdate {/mips_testbench/mips/Reg/mem[29]}
add wave -noupdate {/mips_testbench/mips/Reg/mem[30]}
add wave -noupdate {/mips_testbench/mips/Reg/mem[31]}
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {2441 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 341
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
WaveRestoreZoom {2241 ns} {2917 ns}
