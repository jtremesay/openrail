`include "helpers.inc.v"

module LogicTile #(parameter IC_PAIRS=10, CLUSTER=4, LUT_SIZE=6)  (
    input [IC_PAIRS - 1:0] data_north_in,
    output [IC_PAIRS - 1:0] data_north_out,
    input [IC_PAIRS - 1:0] data_east_in,
    output [IC_PAIRS - 1:0] data_east_out,
    input [IC_PAIRS - 1:0] data_south_in,
    output [IC_PAIRS - 1:0] data_south_out,
    input [IC_PAIRS - 1:0] data_west_in,
    output [IC_PAIRS - 1:0] data_west_out,
    input clock,
    input nreset,
    input config_in,
    input config_enable,
    input config_nreset,
    output config_out
);
    wire [`lt_conf(IC_PAIRS, CLUSTER, LUT_SIZE) - 1:0] config_data;
    ConfigShiftRegister #(.DEEP(`lt_conf(IC_PAIRS, CLUSTER, LUT_SIZE))) config_sr(
        .data_in(config_in),
        .data_out(config_data),
        .clock(clock),
        .enable(config_enable),
        .nreset(config_nreset)
    );
    assign config_out = config_data[`lt_conf(IC_PAIRS, CLUSTER, LUT_SIZE) - 1];

    // Dispatch the config 
    wire [`le_conf(LUT_SIZE) * CLUSTER - 1:0] c_les = config_data[`le_conf(LUT_SIZE) * CLUSTER - 1:0];
    wire [`sb_conf(IC_PAIRS, CLUSTER, LUT_SIZE) - 1:0] c_switchbox = config_data[`lt_conf(IC_PAIRS, CLUSTER, LUT_SIZE) - 1:`le_conf(LUT_SIZE) * CLUSTER];

    // Connection used between the logic element and the switchbox
    wire [LUT_SIZE * CLUSTER - 1:0] w_to_les;
    wire [CLUSTER - 1:0] w_from_les;

    // Instantiate the switchbox
    SwitchBox #(.IC_PAIRS(IC_PAIRS), .CLUSTER(CLUSTER), .LUT_SIZE(LUT_SIZE)) sb(
        .data_north_in(data_north_in),
        .data_north_out(data_north_out),
        .data_east_in(data_east_in),
        .data_east_out(data_east_out),
        .data_south_in(data_south_in),
        .data_south_out(data_south_out),
        .data_west_in(data_west_in),
        .data_west_out(data_west_out),
        .data_from_les(w_from_les),
        .data_to_les(w_to_les),
        .config_in(c_switchbox)
    );

    genvar i;
    generate
    for (i = 0; i < CLUSTER; i = i + 1) begin : cluster
        LogicElement #(.WIDTH(LUT_SIZE)) le(
            .data_in(w_to_les[LUT_SIZE * (i + 1) -1:LUT_SIZE * i]),
            .data_out(w_from_les[i]),
            .clock(clock),
            .nreset(nreset),
            .config_in(c_les[`le_conf(LUT_SIZE) * (i + 1) - 1:`le_conf(LUT_SIZE) * i])
        );
    end
    endgenerate
endmodule