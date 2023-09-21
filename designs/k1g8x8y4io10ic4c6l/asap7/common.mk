PLATFORM = asap7
CORE_NAME = k1g8x8y4io10ic4c6l

export VERILOG_FILES = $(sort $(wildcard ./designs/src/$(CORE_NAME)/*.v) $(wildcard ./designs/src/$(CORE_NAME)/kfpga/*.v))
