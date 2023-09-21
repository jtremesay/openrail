
IMAGE ?= killruana/openroad:latest
DESIGN_PARENT ?= k1g8x8y4io10ic4c6l
DESIGN ?= IOTileWrapper
PLATFORM ?= asap7

CURRENT_DIR ?= $(PWD)
ROOT_DIR ?= $(CURRENT_DIR)/../..
RTL_DIR ?= $(ROOT_DIR)/rtl
OUT_DIR ?= $(ROOT_DIR)/out
LOGS_DIR ?= $(OUT_DIR)/logs
REPORTS_DIR ?= $(OUT_DIR)/reports
RESULTS_DIR ?= $(OUT_DIR)/results

all: top

.PHONY: top
top: $(OUT_DIR)
	docker run \
		-v $(RTL_DIR):/OpenROAD-flow-scripts/flow/designs/src/$(DESIGN_PARENT) \
		-v $(CURRENT_DIR)/:/OpenROAD-flow-scripts/flow/designs/$(PLATFORM)/$(DESIGN_PARENT)/$(DESIGN) \
		-v $(LOGS_DIR)/:/OpenROAD-flow-scripts/flow/logs/$(PLATFORM) \
		-v $(REPORTS_DIR)/:/OpenROAD-flow-scripts/flow/reports/$(PLATFORM) \
		-v $(RESULTS_DIR)/:/OpenROAD-flow-scripts/flow/results/$(PLATFORM) \
		$(IMAGE) bash -c "source env.sh && cd flow && make DESIGN_CONFIG=./designs/$(PLATFORM)/$(DESIGN_PARENT)/$(DESIGN)/config.mk generate_abstract"

.PHONY: shell
shell:
	docker run -it \
		-v $(RTL_DIR):/OpenROAD-flow-scripts/flow/designs/src/$(DESIGN_PARENT) \
		-v $(CURRENT_DIR)/:/OpenROAD-flow-scripts/flow/designs/$(PLATFORM)/$(DESIGN_PARENT)/$(DESIGN) \
		-v $(LOGS_DIR)/:/OpenROAD-flow-scripts/flow/logs/$(PLATFORM) \
		-v $(REPORTS_DIR)/:/OpenROAD-flow-scripts/flow/reports/$(PLATFORM) \
		-v $(RESULTS_DIR)/:/OpenROAD-flow-scripts/flow/results/$(PLATFORM) \
		$(IMAGE) bash -c "source env.sh && cd flow && export DESIGN_CONFIG=./designs/$(PLATFORM)/$(DESIGN_PARENT)/$(DESIGN)/config.mk && bash"

$(OUT_DIR):
	mkdir -p $@