include designs/asap7/k1g8x8y4io10ic4c6l/common.mk

export DESIGN_NAME            = kFPGACore
export DESIGN_NICKNAME        = $(CORE_NAME)

export VERILOG_FILES_BLACKBOX = ./designs/src/$(CORE_NAME)/LogicTileWrapper.v
export SDC_FILE      = ./designs/$(PLATFORM)/$(CORE_NAME)/constraint.sdc

export ABC_AREA               = 1

export CORE_UTILIZATION       = 1 
export CORE_ASPECT_RATIO      = 1
export CORE_MARGIN            = 1
export PLACE_DENSITY          = 0.10
export TNS_END_PERCENT        = 100

export BLOCKS                       = LogicTileWrapper
export GDS_ALLOW_EMPTY              = LogicTileWrapper

export IO_CONSTRAINTS         = ./designs/$(PLATFORM)/$(CORE_NAME)/io.tcl
export PDN_TCL                = ./designs/$(PLATFORM)/$(CORE_NAME)/pdn.tcl
export MIN_ROUTING_LAYER = M2
export MAX_ROUTING_LAYER = M7


# ensure we have some rows, so we don't get a bad clock skew.
export MACRO_HALO_X            = 0.5
export MACRO_HALO_Y            = 0.5
