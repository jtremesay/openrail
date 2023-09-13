IMAGE ?= killruana/openroad:ubuntu22.04

all: nangate45 sky130hd sky130hs

nangate45 sky130hd sky130hs:
	docker run \
		-v $(PWD)/designs/:/OpenROAD-flow-scripts/flow/designs/ \
		-v $(PWD)/out/logs/:/OpenROAD-flow-scripts/flow/logs/ \
		-v $(PWD)/out/reports/:/OpenROAD-flow-scripts/flow/reports/ \
		-v $(PWD)/out/results/:/OpenROAD-flow-scripts/flow/results/ \
		$(IMAGE) bash -c "source env.sh && cd flow && make DESIGN_CONFIG=./designs/$@/raven-picorv32/config.mk"

shell:
	docker run \
		-it \
		-v $(PWD)/designs/:/OpenROAD-flow-scripts/flow/designs/ \
		-v $(PWD)/out/logs/:/OpenROAD-flow-scripts/flow/logs/ \
		-v $(PWD)/out/reports/:/OpenROAD-flow-scripts/flow/reports/ \
		-v $(PWD)/out/results/:/OpenROAD-flow-scripts/flow/results/ \
		$(IMAGE) bash -c "source env.sh && cd flow && bash"

help:
	echo "help       print this message"
	echo "nangate45  implement with nangate45 PDK"
	echo "sky130hd   implement with sky130hd PDK"
	echo "sky130hs   implement with sky130hs PDK"

.PHONY: shell nangate45 sky130hd sky130hs help
