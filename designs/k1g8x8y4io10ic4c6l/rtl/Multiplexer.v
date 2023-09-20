module Multiplexer #(parameter WIDTH=1) (
    input [WIDTH - 1:0] data_in,
    output data_out,
    input [$clog2(WIDTH) - 1:0] config_in
);
    assign data_out = config_in < WIDTH ? data_in[config_in] : 0;
endmodule