module IFtoID_Buffer(
  input CLK, stall,
  input wire[31:0] in_Next_PC, in_Instr,
  output reg[31:0] out_Next_PC, out_Instr );

always @(posedge CLK)
begin
  if(stall == 1'b1) begin
    out_Next_PC <= out_Next_PC;
    out_Instr <= out_Instr;
  end else begin
    out_Next_PC <= in_Next_PC;
    out_Instr <= in_Instr;
    end
end

endmodule
