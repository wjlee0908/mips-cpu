module MIPS(
	input CLK
	 );


// [Instruction Fetch stage]
// IM
wire [31:0] Next_PC, Instr, Branch_addr;
wire [31:0] Branch_or_offset;
reg [31:0] PC;

initial
begin
	//PC = 32'd0;
	PC = -32'd4;
end

assign Next_PC = PC + 32'd4;
assign Branch_addr = {Branch_or_offset[29:0], 2'b00};
assign PCSrc = (Branch && zero);
wire PCSrc;

always @(posedge CLK)
begin
	PC <= (JToPC) ? Jump_addr : ((PCSrc) ? (Branch_addr + Next_PC) : Next_PC);
end

Instruction_Mem Instr_mem(PC[8:2], Instr); // Asynchronous module.
/*
	[8:0]         [8:2]
0	000 0000 00   000 0000 => 0
4	000 0001 00   000 0001 => 1
8	000 0010 00   000 0010 => 2
12	000 0011 00   000 0011 => 3
16	000 0100 00   000 0100 => 4
20	000 0101 00   000 0101 => 5
24	000 0110 00   000 0110 => 6
28	000 0111 00   000 0111 => 7

*/

// Pipeline stage buffer
// pc+4, instruction

// [Instruction decode stage]
// Control
wire RegDst, RegWrite; // control signal
wire ALUSrc, MemWrite, MemRead, MemToReg; // control signal
wire [3:0] ALUOp;
wire PCSrc, JToPC, Branch; // mux control signal
wire [5:0] Opcode, Funct;

assign Opcode = Instr[31:26];
assign Funct = Instr[5:0];

Control control(Opcode, Funct, RegDst, RegWrite, ALUSrc, MemWrite, MemRead, MemToReg, JToPC, Branch, ALUOp); // Asynchronous module.

// Register
wire [31:0] Jump_addr;
wire [4:0] Read1, Read2, Reg_Write_addr;

wire [31:0] Reg_Write_data, Read_data1, Read_data2;

assign Jump_addr = {Next_PC[31:28], {Instr[25:0], 2'b00}};
assign Read1 = Instr[25:21];
assign Read2 = Instr[20:16];
assign Reg_Write_addr = (RegDst) ? Instr[15:11] : Instr[20:16];
assign Branch_or_offset = (Instr[15] == 1) ? {16'hFFFF, Instr[15:0]} : {16'h0000, Instr[15:0]}; // sign extend.

Register Reg(CLK, RegWrite, Read1, Read2, Reg_Write_addr, Reg_Write_data, Read_data1, Read_data2); // Synchronous module.

// Pipeline stage buffer
// pc+4, register data 1.2, immediate, control signals

// [ALU Execution stage]
// ALU
wire [31:0] ALU_B, ALU_result, Lw_Sw_offset;
wire zero;

assign Lw_Sw_offset = (Branch_or_offset[31] == 1) ? {2'b11, Branch_or_offset[31:2]} : {2'b00, Branch_or_offset[31:2]};
// if instruction is lw or sw, divide the offset by 4.
assign ALU_B = (Opcode == 6'b100011 || Opcode == 6'b101011) ? Lw_Sw_offset : ((ALUSrc) ? Branch_or_offset : Read_data2);
// if instruction is lw or sw, ALU_B is Lw_Sw_offset.

ALU alu(ALUOp, Read_data1, ALU_B, ALU_result, zero); // Asynchronous module.

// Pipeline stage buffer
// next addr(branch or pc+4), control signals, alu result, zero flag, data2 

// [Memory Access stage]
// DM
wire [31:0] Read_or_Write_addr;
wire [31:0] DM_Write_data, DM_Read_data;

assign DM_Write_data = Read_data2;
assign Read_or_Write_addr = ALU_result;

Data_Mem DM(CLK, MemWrite, MemRead, Read_or_Write_addr[6:0], DM_Write_data, DM_Read_data); // Synchronous module.

// Pipeline stage buffer
// memory data, alu result, regwrite control signal

// [Write Back stage]
assign Reg_Write_data = (MemToReg) ? DM_Read_data : ALU_result;
// Register write
// pass reg_write data to second stage

endmodule
