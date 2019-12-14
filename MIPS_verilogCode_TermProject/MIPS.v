module MIPS(
	input CLK
	 );

	/*****************************
	*    variable declaration   *
	*****************************/
	// [Stage 1: Instruction Fetch stage]
	// IM
	wire [31:0] Next_PC_s1, Instr_s1, Instr_fetched_s1;
	reg [31:0] PC_s1;
	reg stall_s1;    // to delay instruction

	// [Stage 2: Instruction Decode stage]
	// from stage 1
	wire [31:0] Next_PC_s2, Instr_s2;

	// Control
	wire RegDst_s2, RegWrite_s2; // control signal
	wire ALUSrc_s2, MemWrite_s2, MemRead_s2, MemToReg_s2; // control signal
	wire [3:0] ALUOp_s2;
	wire JToPC_s2, Branch_s2; // mux control signal
	wire [5:0] Opcode_s2, Funct_s2;

	// forward control
	// 0: no forward, 1: from s4, 2: from s5
	reg [1:0] forwarded_data1_source_s2;
	reg [1:0] forwarded_data2_source_s2;

	// Register
	wire [31:0] Jump_addr_s2;
	wire [4:0] Read1_s2, Read2_s2, Reg_Write_addr_s2;
	wire [31:0] Read_data1_s2, Read_data2_s2;
	wire [31:0] immediate_s2;
	reg [31:0] data1_s2, data2_s2;

	// [Stage 3: ALU Execution stage]
	// from stage 2
	wire [31:0] Next_PC_s3;
	wire [31:0] Read_data1_s3, Read_data2_s3;
	reg [31:0] data1_s3, data2_s3;    // data after forwarding
	wire [31:0] immediate_s3;
	wire [31:0] Jump_addr_s3;
	wire [4:0] Read1_s3, Read2_s3;    // for forward checking
	wire [4:0] Reg_Write_addr_s3;
	// control signal
	wire RegWrite_s3; 
	wire ALUSrc_s3, MemWrite_s3, MemRead_s3, MemToReg_s3; 
	wire [3:0] ALUOp_s3;
	wire JToPC_s3, Branch_s3;
	wire [5:0] Opcode_s3, Funct_s3;

	// forward control
	// 0: no forward, 1: from s4, 2: from s5
	reg [1:0] forwarded_data1_source_s3;
	reg [1:0] forwarded_data2_source_s3;

	// ALU
	wire [31:0] ALU_B_s3, ALU_result_s3, Lw_Sw_offset_s3;
	wire PCSrc_s3;
	wire zero_s3;

	wire [31:0] Branch_addr_s3;

	// [Stage 4: Memory Access stage]
	// from stage 3
	wire [31:0] ALU_result_s4, Read_data2_s4;
	wire [31:0] Next_PC_s4, Branch_addr_s4, Jump_addr_s4;
	wire [4:0] Reg_Write_addr_s4;
	// control signal
	wire MemWrite_s4, MemRead_s4, MemToReg_s4;
	wire PCSrc_s4, JToPC_s4;
	wire RegWrite_s4;
	// forwarding control
	reg forward_data1_s4, forward_data2_s4;

	// DM
	wire [31:0] DM_addr_s4;
	wire [31:0] DM_Write_data_s4, DM_Read_data_s4;

	// [Stage 5: Write Back stage]
	// from stage 4
	wire [31:0] DM_Read_data_s5, ALU_result_s5;
	wire [4:0] Reg_Write_addr_s5;
	// control signal
	wire MemToReg_s5;
	wire RegWrite_s5;
	// forwarding control
	reg forward_data1_s5, forward_data2_s5;

	wire [31:0] Reg_Write_data_s5;




	/*****************************
	*         execution         *
	*****************************/
	// [Stage 1: Instruction Fetch stage]
	initial
	begin
		//PC_s1 = 32'd0;
		PC_s1 = -32'd4;
		stall_s1 = 1'b0;
	end

	assign Next_PC_s1 = PC_s1 + 32'd4;

	always @(posedge CLK)
	begin
		if (stall_s1 == 1'b1)
			PC_s1 <= PC_s1;    // No change. delay.
		else if (PCSrc_s4 == 1'b1) 
			PC_s1 <= Branch_addr_s4;
		else if (JToPC_s4 == 1'b1)
			PC_s1 <= Jump_addr_s4;
		else
			PC_s1 <= Next_PC_s1;
	end

	Instruction_Mem Instr_mem(PC_s1[8:2], Instr_fetched_s1); // Asynchronous module.
	// if stall, do nothing operation.
	// assign Instr_s1 = (stall_s1) ? 32'b000000_00000_00000_00000_00000_100000 : Instr_fetched_s1;
	assign Instr_s1 = Instr_fetched_s1;

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
	IFtoID_Buffer IFtoID(CLK, stall_s1, Next_PC_s1, Instr_s1, Next_PC_s2, Instr_s2);

	// [Stage 2: Instruction Decode stage]

	assign Opcode_s2 = Instr_s2[31:26];
	assign Funct_s2 = Instr_s2[5:0];

	Control control(Opcode_s2, Funct_s2, RegDst_s2, RegWrite_s2, ALUSrc_s2, MemWrite_s2, MemRead_s2, MemToReg_s2, JToPC_s2, Branch_s2, ALUOp_s2); // Asynchronous module.

	assign Jump_addr_s2 = {Next_PC_s2[31:28], {Instr_s2[25:0], 2'b00}};
	assign Read1_s2 = Instr_s2[25:21];
	assign Read2_s2 = Instr_s2[20:16];
	assign Reg_Write_addr_s2 = (RegDst_s2) ? Instr_s2[15:11] : Instr_s2[20:16];
	assign immediate_s2 = (Instr_s2[15] == 1) ? {16'hFFFF, Instr_s2[15:0]} : {16'h0000, Instr_s2[15:0]}; // sign extend.

	Register Reg(CLK, RegWrite_s5, Read1_s2, Read2_s2, Reg_Write_addr_s5, Reg_Write_data_s5, Read_data1_s2, Read_data2_s2); // Synchronous module.

	// *** forwarding control ***
	// get forwarded data
	always @(*)
	begin
		case(forwarded_data1_source_s2)
			2'd1: data1_s2 = ALU_result_s4;
			2'd2: data1_s2 = Reg_Write_data_s5;
			default: data1_s2 = Read_data1_s2;
		endcase
		case(forwarded_data2_source_s2)
			2'd1: data2_s2 = ALU_result_s4;
			2'd2: data2_s2 = Reg_Write_data_s5;
			default: data2_s2 = Read_data2_s2;
		endcase
	end

	// Pipeline stage buffer
	// pc+4, register data 1.2, immediate, control signals
	IDtoEX_Buffer IDtoEX(CLK, stall_s1, Next_PC_s2, data1_s2, data2_s2, immediate_s2, Jump_addr_s2, Read1_s2, Read2_s2, Reg_Write_addr_s2, 
	ALUSrc_s2, ALUOp_s2, JToPC_s2, Branch_s2, Opcode_s2, Funct_s2, MemWrite_s2, MemRead_s2, MemToReg_s2, RegWrite_s2,
	Next_PC_s3, Read_data1_s3, Read_data2_s3, immediate_s3, Jump_addr_s3, Read1_s3, Read2_s3, Reg_Write_addr_s3,
	ALUSrc_s3, ALUOp_s3, JToPC_s3, Branch_s3, Opcode_s3, Funct_s3, MemWrite_s3, MemRead_s3, MemToReg_s3, RegWrite_s3);

	// [Stage 3: ALU Execution stage]

	// *** forwarding control ***
	// get forwarded data
	always @(*)
	begin
		case(forwarded_data1_source_s2)
			2'd1: data1_s3 = ALU_result_s4;
			2'd2: data1_s3 = Reg_Write_data_s5;
			default: data1_s3 = Read_data1_s3;
		endcase
		case(forwarded_data2_source_s2)
			2'd1: data2_s3 = ALU_result_s4;
			2'd2: data2_s3 = Reg_Write_data_s5;
			default: data2_s3 = Read_data2_s3;
		endcase
	end

	assign Lw_Sw_offset_s3 = (immediate_s3[31] == 1) ? {2'b11, immediate_s3[31:2]} : {2'b00, immediate_s3[31:2]};
	// if instruction is lw or sw, divide the offset by 4.
	assign ALU_B_s3 = (Opcode_s3 == 6'b100011 || Opcode_s3 == 6'b101011) ? Lw_Sw_offset_s3 : ((ALUSrc_s3) ? immediate_s3 : data2_s3);
	// if instruction is lw or sw, ALU_B is Lw_Sw_offset.

	assign PCSrc_s3 = (Branch_s3 && zero_s3);
	assign Branch_addr_s3 = {immediate_s3[29:0], 2'b00} + Next_PC_s3;

	ALU alu(ALUOp_s3, data1_s3, ALU_B_s3, ALU_result_s3, zero_s3); // Asynchronous module.

	// Pipeline stage buffer
	// next addr(branch or pc+4), control signals, alu result, data2 
	EXtoMEM_Buffer EXtoMEM(CLK, ALU_result_s3, data2_s3, Next_PC_s3, Branch_addr_s3, Jump_addr_s3, Reg_Write_addr_s3,
	MemWrite_s3, MemRead_s3, MemToReg_s3, PCSrc_s3, JToPC_s3, RegWrite_s3,
	ALU_result_s4, Read_data2_s4, Next_PC_s4, Branch_addr_s4, Jump_addr_s4, Reg_Write_addr_s4,
	MemWrite_s4, MemRead_s4, MemToReg_s4, PCSrc_s4, JToPC_s4, RegWrite_s4 );

	

	// *** Stall Control ***
	always @(*)
	begin
	// load 명령이고 앞선 명령의 쓰기 레지스터와 뒤 명령의 읽기 레지스터가 같으면 stall
		if(MemRead_s3 == 1'b1 && (Reg_Write_addr_s3 == Read1_s2 || Reg_Write_addr_s3 == Read2_s2)) begin
			stall_s1 = 1'b1;
		end else
			stall_s1 = 1'b0;
	end

	// [Stage 4: Memory Access stage]
	assign DM_Write_data_s4 = Read_data2_s4;
	assign DM_addr_s4 = ALU_result_s4;

	Data_Mem DM(CLK, MemWrite_s4, MemRead_s4, DM_addr_s4[6:0], DM_Write_data_s4, DM_Read_data_s4); // Synchronous module.

	// Pipeline stage buffer
	// memory data, alu result, regwrite control signal
	MEMtoWB_Buffer MemtoWB(CLK, DM_Read_data_s4, ALU_result_s4, Reg_Write_addr_s4,
	MemToReg_s4, RegWrite_s4,
	DM_Read_data_s5, ALU_result_s5, Reg_Write_addr_s5,
	MemToReg_s5, RegWrite_s5 );

	// [Stage 5: Write Back stage]
	assign Reg_Write_data_s5 = (MemToReg_s5) ? DM_Read_data_s5 : ALU_result_s5;
	// Register write
	// pass reg_write data to second stage

	// *** forwarding control ***
	// pass forwarding data
	always @(*)
	begin
	// 메모리에서 읽은 값을 이후 읽는 레지스터와 같은 레지스터에 쓰면 포워딩
	// 2: from s5
	// forward to stage 3
		if ((RegWrite_s5 == 1'b1) && (MemToReg_s5 == 1'b1) && (Reg_Write_addr_s5 == Read1_s3))
			forwarded_data1_source_s3 = 2'd2;
		else if ((RegWrite_s4 == 1'b1) && (MemToReg_s4 == 1'b0) && (Reg_Write_addr_s4 == Read1_s3))
			forwarded_data1_source_s3 <= 2'b1; 
		else
			forwarded_data1_source_s3 <= 2'b0;

		if ((RegWrite_s5 == 1'b1) && (MemToReg_s5 == 1'b1) && (Reg_Write_addr_s5 == Read2_s3))
			forwarded_data2_source_s3 = 2'd2;
		else if ((RegWrite_s4 == 1'b1) && (MemToReg_s4 == 1'b0) && (Reg_Write_addr_s4 == Read2_s3))
			forwarded_data2_source_s3 <= 2'b1;
		else 
			forwarded_data2_source_s3 <= 2'b0;
	

		// forward to stage 2
		if ((RegWrite_s5 == 1'b1) && (MemToReg_s5 == 1'b1) && (Reg_Write_addr_s5 == Read1_s2))
			forwarded_data1_source_s2 = 2'd2;
		else if ((RegWrite_s4 == 1'b1) && (MemToReg_s4 == 1'b0) && (Reg_Write_addr_s4 == Read1_s2))
			forwarded_data1_source_s2 <= 2'b1;
		else
			forwarded_data1_source_s2 <= 2'b0;
	

		if ((RegWrite_s5 == 1'b1) && (MemToReg_s5 == 1'b1) && (Reg_Write_addr_s5 == Read2_s2))
			forwarded_data2_source_s2 = 2'd2;
		else if ((RegWrite_s4 == 1'b1) && (MemToReg_s4 == 1'b0) && (Reg_Write_addr_s4 == Read2_s2)) 
			forwarded_data2_source_s2 <= 2'b1;
		else
			forwarded_data2_source_s2 <= 2'b0;
	
	end

endmodule