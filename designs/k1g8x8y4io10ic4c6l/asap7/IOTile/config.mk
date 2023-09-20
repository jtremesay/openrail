export PLATFORM               = asap7


DESIGN_PARENT = k1g8x8y4io10ic4c6l
export DESIGN_NAME            = IOTile
export DESIGN_NICKNAME        = $(DESIGN_PARENT)_$(DESIGN_NAME)

export VERILOG_FILES = $(sort $(wildcard ./designs/src/$(DESIGN_PARENT)/*.v))
export SDC_FILE      = ./designs/$(PLATFORM)/$(DESIGN_PARENT)/$(DESIGN_NAME)/constraint.sdc

export ABC_AREA               = 1

export CORE_UTILIZATION       = 50 
export CORE_ASPECT_RATIO      = 1
export CORE_MARGIN            = 1
export PLACE_DENSITY          = 0.90
export TNS_END_PERCENT        = 100

export IO_CONSTRAINTS         = ./designs/$(PLATFORM)/$(DESIGN_PARENT)/$(DESIGN_NAME)/io.tcl
export PDN_TCL                = ./designs/$(PLATFORM)/$(DESIGN_PARENT)/$(DESIGN_NAME)/pdn.tcl
export MIN_ROUTING_LAYER = M2
export MAX_ROUTING_LAYER = M5