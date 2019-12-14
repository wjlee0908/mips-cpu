onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /mips_testbench/mips/CLK
add wave -noupdate -expand -group stage1 -radix decimal /mips_testbench/mips/Next_PC_s1
add wave -noupdate -expand -group stage1 /mips_testbench/mips/stall_s1
add wave -noupdate -expand -group stage2 -radix decimal /mips_testbench/mips/Next_PC_s2
add wave -noupdate -expand -group stage2 /mips_testbench/mips/Reg_Write_addr_s2
add wave -noupdate -expand -group stage2 /mips_testbench/mips/Read_data1_s2
add wave -noupdate -expand -group stage2 /mips_testbench/mips/Read_data2_s2
add wave -noupdate -expand -group stage2 /mips_testbench/mips/Read1_s2
add wave -noupdate -expand -group stage2 /mips_testbench/mips/Read2_s2
add wave -noupdate -expand -group stage2 /mips_testbench/mips/forwarded_data1_source_s2
add wave -noupdate -expand -group stage2 /mips_testbench/mips/forwarded_data2_source_s2
add wave -noupdate -expand -group stage3 -radix decimal /mips_testbench/mips/Next_PC_s3
add wave -noupdate -expand -group stage3 /mips_testbench/mips/Read_data1_s3
add wave -noupdate -expand -group stage3 /mips_testbench/mips/Read_data2_s3
add wave -noupdate -expand -group stage3 /mips_testbench/mips/data1_s3
add wave -noupdate -expand -group stage3 /mips_testbench/mips/data2_s3
add wave -noupdate -expand -group stage3 /mips_testbench/mips/Read1_s3
add wave -noupdate -expand -group stage3 /mips_testbench/mips/Read2_s3
add wave -noupdate -expand -group stage3 /mips_testbench/mips/Reg_Write_addr_s3
add wave -noupdate -expand -group stage3 /mips_testbench/mips/ALU_result_s3
add wave -noupdate -expand -group stage3 /mips_testbench/mips/ALU_B_s3
add wave -noupdate -expand -group stage3 /mips_testbench/mips/Lw_Sw_offset_s3
add wave -noupdate -expand -group stage3 /mips_testbench/mips/forwarded_data1_source_s3
add wave -noupdate -expand -group stage3 /mips_testbench/mips/forwarded_data2_source_s3
add wave -noupdate -expand -group stage4 -radix decimal /mips_testbench/mips/Next_PC_s4
add wave -noupdate -expand -group stage4 -radix decimal /mips_testbench/mips/ALU_result_s4
add wave -noupdate -expand -group stage4 /mips_testbench/mips/Read_data2_s4
add wave -noupdate -expand -group stage4 /mips_testbench/mips/Reg_Write_addr_s4
add wave -noupdate -expand -group stage5 /mips_testbench/mips/ALU_result_s5
add wave -noupdate -expand -group stage5 /mips_testbench/mips/Reg_Write_addr_s5
add wave -noupdate -expand -group stage5 /mips_testbench/mips/RegWrite_s5
add wave -noupdate -expand -group stage5 /mips_testbench/mips/Reg_Write_data_s5
add wave -noupdate -expand -group stage5 /mips_testbench/mips/Reg_Write_addr_s5
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {101 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 199
configure wave -valuecolwidth 100
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
WaveRestoreZoom {0 ns} {242 ns}
