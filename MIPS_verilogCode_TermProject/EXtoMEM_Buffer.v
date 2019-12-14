module EXtoMEM_Buffer(
  input CLK,
  input wire [31:0] in_ALU_result, in_Read_data,
  input wire [31:0] in_Next_PC, in_Branch_addr, in_Jump_addr,
  input wire [4:0] in_Reg_Write_addr,
  // contorl signal
  input wire in_MemWrite, in_MemRead, in_MemToReg,
  input wire in_PCSrc, in_JToPC,
  input wire in_RegWrite,
  // output
  output reg [31:0] out_ALU_result, out_Read_data,
  output reg [31:0] out_Next_PC, out_Branch_addr, out_Jump_addr,
  output reg [4:0] out_Reg_Write_addr,
  // contorl signal
  output reg out_MemWrite, out_MemRead, out_MemToReg,
  output reg out_PCSrc, out_JToPC,
  output reg out_RegWrite );

always @(posedge CLK)
begin
  out_ALU_result <= in_ALU_result;
  out_Read_data <= in_Read_data;
  out_Next_PC <= in_Next_PC;
  out_Branch_addr <= in_Branch_addr;
  out_Jump_addr <= in_Jump_addr;
  out_Reg_Write_addr <= in_Reg_Write_addr;

  out_MemWrite <= in_MemWrite;
  out_MemRead <= in_MemRead;
  out_MemToReg <= in_MemToReg;
  out_PCSrc <= in_PCSrc;
  out_JToPC <= in_JToPC;
  out_RegWrite <= in_RegWrite;
end

endmodule
