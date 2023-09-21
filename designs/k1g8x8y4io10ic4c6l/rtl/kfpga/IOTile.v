`include "helpers.inc.v"

module IOTile #(parameter IO_PAIRS = 4, IC_PAIRS = 10) (
    input [IO_PAIRS - 1:0] data_from_io,
    output [IO_PAIRS - 1:0] data_to_io,
    input [IC_PAIRS - 1:0] data_from_ic,
    output [IC_PAIRS - 1:0] data_to_ic,
    input clock,
    input config_in,
    output config_out,
    input config_enable,
    input config_nreset
);
    genvar i;

    wire [`io_conf(IO_PAIRS, IC_PAIRS) - 1:0] config_data;
    ConfigShiftRegister #(.DEEP(`io_conf(IO_PAIRS, IC_PAIRS))) config_sr(
        .data_in(config_in),
        .data_out(config_data),
        .clock(clock),
        .enable(config_enable),
        .nreset(config_nreset)
    );
    assign config_out = config_data[`io_conf(IO_PAIRS, IC_PAIRS) - 1];


    // Dispatch the config 
    wire [`io_ic_conf(IO_PAIRS) * IC_PAIRS - 1:0] c_mux_ic = config_data[`io_ic_conf(IO_PAIRS) * IC_PAIRS - 1:0];
    wire [`io_io_conf(IC_PAIRS) * IO_PAIRS - 1:0] c_mux_io = config_data[`io_conf(IO_PAIRS, IC_PAIRS) - 1:`io_ic_conf(IO_PAIRS) * IC_PAIRS];

    // IC    
    generate
        for (i = 0; i < IC_PAIRS; i = i + 1) begin
            Multiplexer #(.WIDTH(IO_PAIRS)) mux_ic(
                .data_in(data_from_io),
                .data_out(data_to_ic[i]),
                .config_in(c_mux_ic[`io_ic_conf(IO_PAIRS) * (i + 1) - 1:`io_ic_conf(IO_PAIRS) * i])
            );            
        end
    endgenerate

    // IO    
    generate
        for (i = 0; i < IO_PAIRS; i = i + 1) begin
            Multiplexer #(.WIDTH(IC_PAIRS)) mux_ic0(
                .data_in(data_from_ic),
                .data_out(data_to_io[i]),
                .config_in(c_mux_io[`io_io_conf(IC_PAIRS) * (i + 1) - 1:`io_io_conf(IC_PAIRS) * i])
            );            
        end
    endgenerate   
endmodule