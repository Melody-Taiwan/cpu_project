`timescale 1ns/1ps
module control_tb;
  reg  [6:0] opcode; reg [2:0] funct3; reg funct7_5;
  wire RegWrite, ALUSrc, MemRead, MemWrite, MemtoReg, Branch;
  wire [1:0] ALUOp;

  control dut(opcode, funct3, funct7_5,
              RegWrite, ALUSrc, MemRead, MemWrite, MemtoReg, Branch, ALUOp);

  task show(input [15*8-1:0] name);
    $display("%s => RW=%0d AS=%0d MR=%0d MW=%0d M2R=%0d BR=%0d ALUOp=%b",
             name, RegWrite,ALUSrc,MemRead,MemWrite,MemtoReg,Branch,ALUOp);
  endtask

  initial begin
    $dumpfile("control.vcd"); $dumpvars(0, control_tb);

    // R-type ADD
    opcode=7'b0110011; funct3=3'b000; funct7_5=1'b0; #1; show("ADD");
    // LW
    opcode=7'b0000011; funct3=3'b010; funct7_5=1'bx; #1; show("LW ");
    // BEQ
    opcode=7'b1100011; funct3=3'b000; funct7_5=1'bx; #1; show("BEQ");
    // SW
    opcode=7'b0100011; funct3=3'b010; funct7_5=1'bx; #1; show("SW ");

    #1 $finish;
  end
endmodule
