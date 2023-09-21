module IOTileWrapper (
    input [3:0] data_from_io,
    output [3:0] data_to_io,
    input [9:0] data_from_ic,
    output [9:0] data_to_ic,
    input clock,
    input config_in,
    output config_out,
    input config_enable,
    input config_nreset
);
    IOTile #(.IO_PAIRS(4), .IC_PAIRS(10)) iot(
        .data_from_io(data_from_io),
        .data_to_io(data_to_io),
        .data_from_ic(data_from_ic),
        .data_to_ic(data_to_ic),
        .clock(clock),
        .config_in(config_in),
        .config_out(config_out),
        .config_enable(config_enable),
        .config_nreset(config_nreset)
    );
endmodule