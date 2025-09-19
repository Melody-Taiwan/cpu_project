// control.v — RV32I subset：R-type(ADD/SUB)、LW、SW、BEQ
module control(
  input  [6:0] opcode,
  input  [2:0] funct3,
  input        funct7_5,      // R-type add/sub 用；本模組先不使用
  output reg   RegWrite,
  output reg   ALUSrc,
  output reg   MemRead,
  output reg   MemWrite,
  output reg   MemtoReg,
  output reg   Branch,
  output reg [1:0] ALUOp      // 00=add(位址/預設) 01=branch比較 10=R-type
);

  localparam OP_R  = 7'b0110011;  // R-type
  localparam OP_LW = 7'b0000011;  // I-type (funct3=010)
  localparam OP_SW = 7'b0100011;  // S-type (funct3=010)
  localparam OP_BR = 7'b1100011;  // B-type (beq funct3=000)

  always @* begin
    // default
    RegWrite=0; ALUSrc=0; MemRead=0; MemWrite=0; MemtoReg=0; Branch=0; ALUOp=2'b00;

    case (opcode)
      OP_R: begin
        RegWrite=1; ALUSrc=0; MemtoReg=0; ALUOp=2'b10; // 交給 ALUControl
      end
      OP_LW: begin
        RegWrite=1; ALUSrc=1; MemRead=1; MemtoReg=1; ALUOp=2'b00;
      end
      OP_SW: begin
        ALUSrc=1; MemWrite=1; ALUOp=2'b00;
      end
      OP_BR: begin
        Branch=(funct3==3'b000); ALUSrc=0; ALUOp=2'b01; // beq
      end
      default: ; // 保持預設
    endcase
  end
endmodule
