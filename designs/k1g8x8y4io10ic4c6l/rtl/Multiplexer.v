`include "helpers.inc.v"

module Multiplexer #(parameter WIDTH=2) (
    input [WIDTH - 1:0] data_in,
    output data_out,
    input [`mux_conf(WIDTH) - 1:0] config_in
);
    assign data_out = config_in < WIDTH ? data_in[config_in] : 0;
endmodule