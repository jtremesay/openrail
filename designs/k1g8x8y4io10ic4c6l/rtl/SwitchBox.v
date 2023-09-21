`include "helpers.inc.v"

module SwitchBox #(parameter IC_PAIRS=10, CLUSTER=4, LUT_SIZE=6) (
    input [IC_PAIRS - 1:0] data_north_in,
    output [IC_PAIRS - 1:0] data_north_out,
    input [IC_PAIRS - 1:0] data_east_in,
    output [IC_PAIRS - 1:0] data_east_out,
    input [IC_PAIRS - 1:0] data_south_in,
    output [IC_PAIRS - 1:0] data_south_out,
    input [IC_PAIRS - 1:0] data_west_in,
    output [IC_PAIRS - 1:0] data_west_out,
    input [CLUSTER - 1:0] data_from_les,
    output [CLUSTER * LUT_SIZE - 1:0] data_to_les,
    input [`sb_conf(IC_PAIRS, CLUSTER, LUT_SIZE) - 1:0] config_in
);
    genvar i, j;

    // Dispatch the config 
    wire [`sb_ics_conf(IC_PAIRS, CLUSTER):0] c_mux_north = config_in[`sb_ics_conf(IC_PAIRS, CLUSTER) - 1:0];
    wire [`sb_ics_conf(IC_PAIRS, CLUSTER):0] c_mux_east  = config_in[`sb_ics_conf(IC_PAIRS, CLUSTER) * 2 - 1:`sb_ics_conf(IC_PAIRS, CLUSTER)];
    wire [`sb_ics_conf(IC_PAIRS, CLUSTER):0] c_mux_south = config_in[`sb_ics_conf(IC_PAIRS, CLUSTER) * 3 - 1:`sb_ics_conf(IC_PAIRS, CLUSTER) * 2];
    wire [`sb_ics_conf(IC_PAIRS, CLUSTER):0] c_mux_west  = config_in[`sb_ics_conf(IC_PAIRS, CLUSTER) * 4 - 1:`sb_ics_conf(IC_PAIRS, CLUSTER) * 3];
    wire [`sb_les_conf(IC_PAIRS, CLUSTER, LUT_SIZE):0] c_mux_les   = config_in[`sb_conf(IC_PAIRS, CLUSTER, LUT_SIZE) - 1:`sb_ics_conf(IC_PAIRS, CLUSTER) * 4];

    // Side north
    for (i = 0; i < IC_PAIRS; i = i + 1) begin
        Multiplexer #(.WIDTH(3 + CLUSTER)) mux_north(
            .data_in({
                data_west_in[(i + 1) % IC_PAIRS],
                data_south_in[i], 
                data_east_in[(IC_PAIRS - i) % IC_PAIRS],
                data_from_les
            }),
            .data_out(data_north_out[i]),
            .config_in(c_mux_north[`sb_ic_conf(CLUSTER) * (i + 1) - 1:`sb_ic_conf(CLUSTER) * i])
        );    
    end

    // Side east
    for (i = 0; i < IC_PAIRS; i = i + 1) begin
        Multiplexer #(.WIDTH(3 + CLUSTER)) mux_east(
            .data_in({
                data_north_in[(IC_PAIRS - i) % IC_PAIRS],
                data_west_in[i], 
                data_south_in[(i + 1) % IC_PAIRS],
                data_from_les
            }),
            .data_out(data_east_out[i]),
            .config_in(c_mux_east[`sb_ic_conf(CLUSTER) * (i + 1) - 1:`sb_ic_conf(CLUSTER) * i])
        );    
    end
    
    // Side south
    for (i = 0; i < IC_PAIRS; i = i + 1) begin
        Multiplexer #(.WIDTH(3 + CLUSTER)) mux_south(
            .data_in({
                data_east_in[(i + 1) % IC_PAIRS],
                data_north_in[i], 
                data_west_in[(2 * IC_PAIRS - 2 - i) % IC_PAIRS],
                data_from_les
            }),
            .data_out(data_south_out[i]),
            .config_in(c_mux_south[`sb_ic_conf(CLUSTER) * (i + 1) - 1:`sb_ic_conf(CLUSTER) * i])
        );    
    end
    
    // Side west
    for (i = 0; i < IC_PAIRS; i = i + 1) begin
        Multiplexer #(.WIDTH(3 + CLUSTER)) mux_west(
            .data_in({
                data_south_in[(2 * IC_PAIRS - 2 - i) % IC_PAIRS],
                data_east_in[i], 
                data_north_in[(i + 1) % IC_PAIRS],
                data_from_les
            }),
            .data_out(data_west_out[i]),
            .config_in(c_mux_west[`sb_ic_conf(CLUSTER) * (i + 1) - 1:`sb_ic_conf(CLUSTER) * i])
        );    
    end

    // Le 
    generate
        for (i = 0; i < CLUSTER; i = i + 1) begin
            for (j = 0; j < LUT_SIZE; j = j + 1) begin
                Multiplexer #(.WIDTH(4 * IC_PAIRS + CLUSTER)) mux_le(
                    .data_in({data_north_in, data_east_in, data_south_in, data_west_in, data_from_les}),
                    .data_out(data_to_les[i * LUT_SIZE + j]),
                    .config_in(c_mux_les[`sb_le_conf(IC_PAIRS, CLUSTER) * (i * LUT_SIZE + j + 1) - 1:`sb_le_conf(IC_PAIRS, CLUSTER) * (i * LUT_SIZE + j)])
                );
            end
        end
    endgenerate   
endmodule