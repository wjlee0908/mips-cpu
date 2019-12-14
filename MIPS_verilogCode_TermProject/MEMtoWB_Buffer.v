module MEMtoWB_Buffer(
  input CLK,
  input wire[31:0] in_DM_Read_data, in_ALU_result,
  input wire [4:0] in_Reg_Write_addr,
  // contorl signal
  input wire in_MemToReg,
  input wire in_RegWrite,
  // output
  output reg[31:0] out_DM_Read_data, out_ALU_result,
  output reg [4:0] out_Reg_Write_addr,
  // contorl signal
  output reg out_MemToReg, 
  output reg out_RegWrite );

always @(posedge CLK)
begin
  out_DM_Read_data <= in_DM_Read_data;
  out_ALU_result <= in_ALU_result;
  out_Reg_Write_addr <= in_Reg_Write_addr;
  
  out_MemToReg <= in_MemToReg;
  out_RegWrite <= in_RegWrite;
end

endmodule
