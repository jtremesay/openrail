`include "helpers.inc.v"

module LookUpTable #(parameter WIDTH=6) (
    input [WIDTH - 1:0] data_in,
    output data_out,
    input [`lut_conf(WIDTH) - 1:0] config_in
);
    // Implement the LUT with a mux
    Multiplexer #(.WIDTH(`lut_conf(WIDTH))) lut(
        .data_in(config_in),
        .data_out(data_out),
        .config_in(data_in)
    );
endmodule