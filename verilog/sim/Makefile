# 使用方法：
#   make run TEST=control_tb
#   make clean

RTL_DIR := ../rtl
TB_DIR  := ../tb
OUT     := build.out

IVERILOG_FLAGS := -g2012   # 使用 SystemVerilog 2012 功能

run:
	@echo ">> Building testbench: $(TEST)"
	iverilog $(IVERILOG_FLAGS) $(RTL_DIR)/*.v $(TB_DIR)/$(TEST).v -o $(OUT)
	@echo ">> Running simulation..."
	vvp $(OUT)

clean:
	rm -f $(OUT) *.vcd
