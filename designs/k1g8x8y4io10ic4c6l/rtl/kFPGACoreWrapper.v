module kFPGACoreWrapper(
    input [31:0] data_north_in,
    output [31:0] data_north_out,
    input [31:0] data_east_in,
    output [31:0] data_east_out,
    input [31:0] data_south_in,
    output [31:0] data_south_out,
    input [31:0] data_west_in,
    output [31:0] data_west_out,
    input clock,
    input nreset,
    input config_in,
    output config_out,
    input config_enable,
    input config_nreset
);
    kFPGACore #(
        .WIDTH(8),
        .HEIGHT(8),
        .IO_PAIRS(4),
        .IC_PAIRS(10),
        .CLUSTER(4),
        .LUT_SIZE(6)
    ) core (
        .data_north_in(data_north_in),
        .data_north_out(data_north_out),
        .data_east_in(data_east_in),
        .data_east_out(data_east_out),
        .data_south_in(data_south_in),
        .data_south_out(data_south_out),
        .data_west_in(data_west_in),
        .data_west_out(data_west_out),
        .clock(clock),
        .nreset(nreset),
        .config_in(config_in),
        .config_out(config_out),
        .config_enable(config_enable),
        .config_nreset(config_nreset)
    );
endmodule