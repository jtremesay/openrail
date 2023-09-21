`include "helpers.inc.v"

module kFPGACore #(parameter WIDTH = 8, HEIGHT = 8, IO_PAIRS = 4, IC_PAIRS = 10, CLUSTER = 4, LUT_SIZE = 6) (
    input [WIDTH * IO_PAIRS - 1:0] data_north_in,
    output [WIDTH * IO_PAIRS - 1:0] data_north_out,
    input [HEIGHT * IO_PAIRS - 1:0] data_east_in,
    output [HEIGHT * IO_PAIRS - 1:0] data_east_out,
    input [WIDTH * IO_PAIRS - 1:0] data_south_in,
    output [WIDTH * IO_PAIRS - 1:0] data_south_out,
    input [HEIGHT * IO_PAIRS - 1:0] data_west_in,
    output [HEIGHT * IO_PAIRS - 1:0] data_west_out,
    input clock,
    input nreset,
    input config_in,
    output config_out,
    input config_enable,
    input config_nreset
);
    genvar i;

    wire [WIDTH - 1:0] c_io_north, c_io_south;
    wire [HEIGHT - 1:0] c_io_east, c_io_west;
    wire [WIDTH * HEIGHT - 1:0] c_lt;

    // North & South IO
    wire [IC_PAIRS * WIDTH - 1:0] from_north_ic, to_north_ic, from_south_ic, to_south_ic;
    generate
    for (i = 0; i < WIDTH; i = i + 1) begin
        IONorthTileWrapper iot_north(
            .data_from_io(data_north_in[IO_PAIRS * (i + 1) - 1: IO_PAIRS * i]),
            .data_to_io(data_north_out[IO_PAIRS * (i + 1) - 1: IO_PAIRS * i]),
            .data_from_ic(from_north_ic[IC_PAIRS * (i + 1) - 1:IC_PAIRS * i]),
            .data_to_ic(to_north_ic[IC_PAIRS * (i + 1) - 1:IC_PAIRS * i]),
            .clock(clock),
            .config_in(c_io_south[i]),
            .config_out(c_io_north[i]),
            .config_enable(config_enable),
            .config_nreset(config_nreset)
        );

        IOSouthTileWrapper iot_south(
            .data_from_io(data_south_in[IO_PAIRS * (i + 1) - 1: IO_PAIRS * i]),
            .data_to_io(data_south_out[IO_PAIRS * (i + 1) - 1: IO_PAIRS * i]),
            .data_from_ic(from_south_ic[IC_PAIRS * (i + 1) - 1:IC_PAIRS * i]),
            .data_to_ic(to_south_ic[IC_PAIRS * (i + 1) - 1:IC_PAIRS * i]),
            .clock(clock),
            .config_in(i == 0 ? c_io_west[HEIGHT - 1] : c_io_north[i - 1]),
            .config_out(c_io_south[i]),
            .config_enable(config_enable),
            .config_nreset(config_nreset)
        );
    end
    endgenerate   

    // East & West IO
    wire [IC_PAIRS * HEIGHT - 1:0] from_east_ic, to_east_ic, from_west_ic, to_west_ic;
    generate
    for (i = 0; i < HEIGHT; i = i + 1) begin
        IOEastTileWrapper iot_east(
            .data_from_io(data_east_in[IO_PAIRS * (i + 1) - 1: IO_PAIRS * i]),
            .data_to_io(data_east_out[IO_PAIRS * (i + 1) - 1: IO_PAIRS * i]),
            .data_from_ic(from_east_ic[IC_PAIRS * (i + 1) - 1:IC_PAIRS * i]),
            .data_to_ic(to_east_ic[IC_PAIRS * (i + 1) - 1:IC_PAIRS * i]),
            .clock(clock),
            .config_in(i == 0 ? c_io_north[WIDTH - 1] : c_io_east[i - 1]),
            .config_out(c_io_east[i]),
            .config_enable(config_enable),
            .config_nreset(config_nreset)
        );

        IOWestTileWrapper iot_west(
            .data_from_io(data_west_in[IO_PAIRS * (i + 1) - 1: IO_PAIRS * i]),
            .data_to_io(data_west_out[IO_PAIRS * (i + 1) - 1: IO_PAIRS * i]),
            .data_from_ic(from_west_ic[IC_PAIRS * (i + 1) - 1:IC_PAIRS * i]),
            .data_to_ic(to_west_ic[IC_PAIRS * (i + 1) - 1:IC_PAIRS * i]),
            .clock(clock),
            .config_in(i == 0 ? config_in : c_io_west[i - 1]),
            .config_out(c_io_west[i]),
            .config_enable(config_enable),
            .config_nreset(config_nreset)
        );
    end
    endgenerate    

    assign config_out = c_io_east[HEIGHT - 1];
    assign from_north_ic = to_south_ic;
    assign from_south_ic = to_north_ic;
    assign from_east_ic = to_west_ic;
    assign from_west_ic = to_east_ic;
endmodule