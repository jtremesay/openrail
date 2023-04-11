# OpenRAIL: OpenROAD flows automation

```bash
# Create the design
openrail design new \
    --verilog-files Adder.v \
    --top Adder \
    adder

# Create the different implementations
cd adder
openrail impl add asap7
openrail impl add nangate45
openrail impl add sky130hd
openrail impl add sky130hs

# Run the differents implementations (go drink a tea or two…)
openrail run all

# Generate HTML reports
openrail report all
```
