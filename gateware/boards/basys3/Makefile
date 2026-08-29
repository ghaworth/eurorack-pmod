# boards/basys3/Makefile
PROJ = top

DEVICE  = xc7a35tcpg236-1
PIN_DEF = ./boards/basys3/pinmap.xdc
CHIPDB  ?= $(HOME)/Documents/FPGA/fpga-tools/nextpnr-xilinx/xilinx/xc7a35t.bin
DB_ROOT ?= $(HOME)/Documents/FPGA/fpga-tools/nextpnr-xilinx/xilinx/external/prjxray-db/artix7
# UART: 500kbaud (12 MHz clk_256fs / 24, exact division)
ADD_DEFINES = -DSELECTED_DSP_CORE=$(CORE) -DDEBUG_UART_CLKDIV=24

include ./mk/common.mk
include ./mk/xilinx.mk

ADD_SRC = boards/basys3/sysmgr.v \
		  $(SRC_COMMON)

prog: $(BUILD)/$(PROJ).bit
	openFPGALoader -b basys3 $(BUILD)/$(PROJ).bit