module IOTile(
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
    wire [35:0] config_data;
    ConfigShiftRegister #(.DEEP(36)) config_sr(
        .data_in(config_in),
        .data_out(config_data),
        .clock(clock),
        .enable(config_enable),
        .nreset(config_nreset)
    );
    assign config_out = config_data[35];


    // Dispatch the config 
    wire [1:0] c_mux_ic0 = config_data[1:0]; 
    wire [1:0] c_mux_ic1 = config_data[3:2]; 
    wire [1:0] c_mux_ic2 = config_data[5:4]; 
    wire [1:0] c_mux_ic3 = config_data[7:6]; 
    wire [1:0] c_mux_ic4 = config_data[9:8]; 
    wire [1:0] c_mux_ic5 = config_data[11:10]; 
    wire [1:0] c_mux_ic6 = config_data[13:12]; 
    wire [1:0] c_mux_ic7 = config_data[15:14]; 
    wire [1:0] c_mux_ic8 = config_data[17:16]; 
    wire [1:0] c_mux_ic9 = config_data[19:18]; 
    wire [3:0] c_mux_io0 = config_data[23:20]; 
    wire [3:0] c_mux_io1 = config_data[27:24]; 
    wire [3:0] c_mux_io2 = config_data[31:28]; 
    wire [3:0] c_mux_io3 = config_data[35:32];

    // IC
    
    MultiplexerIOIC mux_ic0(
        .data_in(data_from_io),
        .data_out(data_to_ic[0]),
        .config_in(c_mux_ic0)
    );
    
    MultiplexerIOIC mux_ic1(
        .data_in(data_from_io),
        .data_out(data_to_ic[1]),
        .config_in(c_mux_ic1)
    );
    
    MultiplexerIOIC mux_ic2(
        .data_in(data_from_io),
        .data_out(data_to_ic[2]),
        .config_in(c_mux_ic2)
    );
    
    MultiplexerIOIC mux_ic3(
        .data_in(data_from_io),
        .data_out(data_to_ic[3]),
        .config_in(c_mux_ic3)
    );
    
    MultiplexerIOIC mux_ic4(
        .data_in(data_from_io),
        .data_out(data_to_ic[4]),
        .config_in(c_mux_ic4)
    );
    
    MultiplexerIOIC mux_ic5(
        .data_in(data_from_io),
        .data_out(data_to_ic[5]),
        .config_in(c_mux_ic5)
    );
    
    MultiplexerIOIC mux_ic6(
        .data_in(data_from_io),
        .data_out(data_to_ic[6]),
        .config_in(c_mux_ic6)
    );
    
    MultiplexerIOIC mux_ic7(
        .data_in(data_from_io),
        .data_out(data_to_ic[7]),
        .config_in(c_mux_ic7)
    );
    
    MultiplexerIOIC mux_ic8(
        .data_in(data_from_io),
        .data_out(data_to_ic[8]),
        .config_in(c_mux_ic8)
    );
    
    MultiplexerIOIC mux_ic9(
        .data_in(data_from_io),
        .data_out(data_to_ic[9]),
        .config_in(c_mux_ic9)
    );
    

    // IO
    
    MultiplexerIOIO mux_io0(
        .data_in(data_from_ic),
        .data_out(data_to_io[0]),
        .config_in(c_mux_io0)
    );
    
    MultiplexerIOIO mux_io1(
        .data_in(data_from_ic),
        .data_out(data_to_io[1]),
        .config_in(c_mux_io1)
    );
    
    MultiplexerIOIO mux_io2(
        .data_in(data_from_ic),
        .data_out(data_to_io[2]),
        .config_in(c_mux_io2)
    );
    
    MultiplexerIOIO mux_io3(
        .data_in(data_from_ic),
        .data_out(data_to_io[3]),
        .config_in(c_mux_io3)
    );
    

endmodule