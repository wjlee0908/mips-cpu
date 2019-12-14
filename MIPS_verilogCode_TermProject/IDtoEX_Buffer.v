// pc+4, register data 1.2, immediate, control signals
module IDtoEX_Buffer(
  input CLK,
  input wire stall,
  input wire[31:0] in_Next_PC,
  input wire [31:0] in_Read_data1, in_Read_data2, in_immediate,
  input wire [31:0] in_Jump_addr,
  input wire [4:0] in_Read1, in_Read2,
  input wire [4:0] in_Reg_Write_addr,
  // control signal
  input wire in_ALUSrc, 
  input wire [3:0] in_ALUOp,
  input wire in_JToPC, in_Branch,
  input wire [5:0] in_Opcode, in_Funct,
  input wire in_MemWrite, in_MemRead, in_MemToReg, in_RegWrite,
  // output
  output reg [31:0] out_Next_PC,
  output reg [31:0] out_Read_data1, out_Read_data2, out_immediate,
  output reg [31:0] out_Jump_addr,
  output reg [4:0] out_Read1, out_Read2,
  output reg [4:0] out_Reg_Write_addr,
  // control signal
  output reg out_ALUSrc, 
  output reg [3:0] out_ALUOp,
  output reg out_JToPC, out_Branch,
  output reg [5:0] out_Opcode, out_Funct,
  output reg out_MemWrite, out_MemRead, out_MemToReg, out_RegWrite  );

always @(posedge CLK)
begin
  // 스톨이면 다음 스테이지로 nop 전송
  // 32'b000000_00000_00000_00000_00000_100000
  if (stall == 1'b1) begin
    out_Next_PC <= out_Next_PC;
    out_Read_data1 <= 32'b0;
    out_Read_data2 <= 32'b0;
    out_immediate <= 32'b0;
    out_Jump_addr <= 32'b0;
    out_Read1 <= 5'b0;
    out_Read2 <= 5'b0;
    out_Reg_Write_addr <= 5'b0;
    
    out_ALUSrc <= 1'b0;
    out_ALUOp <= 4'b0010;
    out_JToPC <= 1'b0;
    out_Branch <= 1'b0;
    out_Opcode <= 6'b000000;
    out_Funct <= 6'b100000;
    out_MemRead <= 1'b0;
    out_MemToReg <= 1'b0;
    out_MemWrite <= 1'b0;
    out_RegWrite <= 1'b0;
    end else begin
    out_Next_PC <= in_Next_PC;
    out_Read_data1 <= in_Read_data1;
    out_Read_data2 <= in_Read_data2;
    out_immediate <= in_immediate;
    out_Jump_addr <= in_Jump_addr;
    out_Read1 <= in_Read1;
    out_Read2 <= in_Read2;
    out_Reg_Write_addr <= in_Reg_Write_addr;
    
    out_ALUSrc <= in_ALUSrc;
    out_ALUOp <= in_ALUOp;
    out_JToPC <= in_JToPC;
    out_Branch <= in_Branch;
    out_Opcode <= in_Opcode;
    out_Funct <= in_Funct;
    out_MemRead <= in_MemRead;
    out_MemToReg <= in_MemToReg;
    out_MemWrite <= in_MemWrite;
    out_RegWrite <= in_RegWrite;
    end

end

endmodule
