include designs/asap7/k1g8x8y4io10ic4c6l/common.mk

export DESIGN_NAME            = LogicTileWrapper
export DESIGN_NICKNAME        = $(CORE_NAME)_$(DESIGN_NAME)

export SDC_FILE      = ./designs/$(PLATFORM)/$(CORE_NAME)/$(DESIGN_NAME)/constraint.sdc

export ABC_AREA               = 1

export CORE_UTILIZATION       = 50 
export CORE_ASPECT_RATIO      = 1
export CORE_MARGIN            = 1
export PLACE_DENSITY          = 0.90
export TNS_END_PERCENT        = 100

export IO_CONSTRAINTS         = ./designs/$(PLATFORM)/$(CORE_NAME)/$(DESIGN_NAME)/io.tcl
export PDN_TCL                = ./designs/$(PLATFORM)/$(CORE_NAME)/$(DESIGN_NAME)/pdn.tcl
export MIN_ROUTING_LAYER = M2
export MAX_ROUTING_LAYER = M5