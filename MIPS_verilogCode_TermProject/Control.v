module Control(
		input wire [5:0] Opcode, Funct,
		output reg RegDst, RegWrite, ALUSrc, MemWrite, MemRead, MemToReg, JToPC, Branch,
		output reg [3:0] ALUOp );

always @(*)
begin
	case (Opcode)
		6'b000000 : begin // R Type - add, sub, and, or, slt
			RegDst = 1; RegWrite = 1; ALUSrc = 0; MemWrite = 0; MemRead = 0; MemToReg = 0; JToPC = 0; Branch = 0;
			if(Funct == 6'b100000)	ALUOp = 4'b0010; // add
			else if(Funct == 6'b100010) ALUOp = 4'b0110; // sub
			else if(Funct == 6'b100100) ALUOp = 4'b0000; // and
			else if(Funct == 6'b100101) ALUOp = 4'b0001; // or
			else if(Funct == 6'b101010) ALUOp = 4'b0111; // slt
			else if(Funct == 6'b011000) ALUOp = 4'b1000; // mult
			else if(Funct == 6'b100110) ALUOp = 4'b1101; // xor 
			else if(Funct == 6'b100111) ALUOp = 4'b1100; // nor
			else ALUOp = 4'b0000; // To avoid creating a latch
		end
		6'b100011 : begin // Load Word
			RegDst = 0; RegWrite = 1; ALUSrc = 1; MemWrite = 0; MemRead = 1; MemToReg = 1; JToPC = 0; Branch = 0;
			ALUOp = 4'b0010; // add for lw
		end
		6'b101011 : begin // Store Word
			            RegWrite = 0; ALUSrc = 1; MemWrite = 1; MemRead = 0; 	       JToPC = 0; Branch = 0;
			ALUOp = 4'b0010; // add for sw
			RegDst = 0; MemToReg = 0; // To avoid creating a latch
		end
		6'b000100 : begin // Beq
				    RegWrite = 0; ALUSrc = 0; MemWrite = 0; MemRead = 0;	       JToPC = 0; Branch = 1;
			ALUOp = 4'b0110; // sub for beq
			RegDst = 0; MemToReg = 0; // To avoid creating a latch
		end
		6'b000010 : begin// Jump
				    RegWrite = 0;             MemWrite = 0; MemRead = 0;	       JToPC = 1; Branch = 0;
					ALUOp = 4'b1111;
			RegDst = 0; ALUSrc = 0; MemToReg = 0;  // To avoid creating a latch
		end
		default : begin // To avoid creating a latch
			RegDst = 0; RegWrite = 0; ALUSrc = 0; MemWrite = 0; MemRead = 0; MemToReg = 0; JToPC = 0; Branch = 0;
			ALUOp = 4'b0000; 
		end
	endcase
end

initial
begin
	RegDst = 0; RegWrite = 0; ALUSrc = 0; MemWrite = 0; MemRead = 0; MemToReg = 0; JToPC = 0; Branch = 0;
	ALUOp = 4'b0000;
end
endmodule
