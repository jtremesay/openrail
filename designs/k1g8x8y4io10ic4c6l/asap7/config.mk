export PLATFORM               = asap7

export DESIGN_NAME            = kFPGACore
export DESIGN_NICKNAME        = k1g8x8y4io10ic4c6l

export VERILOG_FILES_BLACKBOX = ./designs/src/$(DESIGN_NICKNAME)/LogicTile.v ./designs/src/$(DESIGN_NICKNAME)/IOTile.v
export VERILOG_FILES = $(sort $(wildcard ./designs/src/$(DESIGN_NICKNAME)/*.v))
export SDC_FILE      = ./designs/$(PLATFORM)/$(DESIGN_NICKNAME)/constraint.sdc

export ABC_AREA               = 1

export CORE_UTILIZATION       = 1 
export CORE_ASPECT_RATIO      = 1
export CORE_MARGIN            = 1
export PLACE_DENSITY          = 0.10
export TNS_END_PERCENT        = 100

export BLOCKS                       = LogicTile IOTile
export GDS_ALLOW_EMPTY              = LogicTile IOTile

export IO_CONSTRAINTS         = ./designs/$(PLATFORM)/k1g8x8y4io10ic4c6l/io.tcl
export PDN_TCL                = ./designs/$(PLATFORM)/k1g8x8y4io10ic4c6l/pdn.tcl
export MIN_ROUTING_LAYER = M2
export MAX_ROUTING_LAYER = M7


# ensure we have some rows, so we don't get a bad clock skew.
export MACRO_HALO_X            = 0.5
export MACRO_HALO_Y            = 0.5
