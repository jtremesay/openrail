module Multiplexer #(parameter SEL_WIDTH=1) (
    input [2 ** SEL_WIDTH - 1:0] data_in,
    output data_out,
    input [SEL_WIDTH - 1:0] config_in
);
    assign data_out = data_in[config_in];
endmodule