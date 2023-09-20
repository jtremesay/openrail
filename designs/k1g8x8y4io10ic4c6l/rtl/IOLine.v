module IOLine(
    input [31:0] data_from_io,
    output [31:0] data_to_io,
    input [79:0] data_from_ic,
    output [79:0] data_to_ic,
    input clock,
    input config_in,
    output config_out,
    input config_enable,
    input config_nreset
);
    // Dispatch the config 
    wire c_iot0; 
    wire c_iot1; 
    wire c_iot2; 
    wire c_iot3; 
    wire c_iot4; 
    wire c_iot5; 
    wire c_iot6; 

    
    IOTile iot0(
        .data_from_io(data_from_io[3:0]),
        .data_to_io(data_to_io[3:0]),
        .data_from_ic(data_from_ic[9:0]),
        .data_to_ic(data_to_ic[9:0]),
        .clock(clock),
        .config_in(config_in),
        .config_out(c_iot0),
        .config_enable(config_enable),
        .config_nreset(config_nreset)
    );
    
    IOTile iot1(
        .data_from_io(data_from_io[7:4]),
        .data_to_io(data_to_io[7:4]),
        .data_from_ic(data_from_ic[19:10]),
        .data_to_ic(data_to_ic[19:10]),
        .clock(clock),
        .config_in(c_iot0),
        .config_out(c_iot1),
        .config_enable(config_enable),
        .config_nreset(config_nreset)
    );
    
    IOTile iot2(
        .data_from_io(data_from_io[11:8]),
        .data_to_io(data_to_io[11:8]),
        .data_from_ic(data_from_ic[29:20]),
        .data_to_ic(data_to_ic[29:20]),
        .clock(clock),
        .config_in(c_iot1),
        .config_out(c_iot2),
        .config_enable(config_enable),
        .config_nreset(config_nreset)
    );
    
    IOTile iot3(
        .data_from_io(data_from_io[15:12]),
        .data_to_io(data_to_io[15:12]),
        .data_from_ic(data_from_ic[39:30]),
        .data_to_ic(data_to_ic[39:30]),
        .clock(clock),
        .config_in(c_iot2),
        .config_out(c_iot3),
        .config_enable(config_enable),
        .config_nreset(config_nreset)
    );
    
    IOTile iot4(
        .data_from_io(data_from_io[19:16]),
        .data_to_io(data_to_io[19:16]),
        .data_from_ic(data_from_ic[49:40]),
        .data_to_ic(data_to_ic[49:40]),
        .clock(clock),
        .config_in(c_iot3),
        .config_out(c_iot4),
        .config_enable(config_enable),
        .config_nreset(config_nreset)
    );
    
    IOTile iot5(
        .data_from_io(data_from_io[23:20]),
        .data_to_io(data_to_io[23:20]),
        .data_from_ic(data_from_ic[59:50]),
        .data_to_ic(data_to_ic[59:50]),
        .clock(clock),
        .config_in(c_iot4),
        .config_out(c_iot5),
        .config_enable(config_enable),
        .config_nreset(config_nreset)
    );
    
    IOTile iot6(
        .data_from_io(data_from_io[27:24]),
        .data_to_io(data_to_io[27:24]),
        .data_from_ic(data_from_ic[69:60]),
        .data_to_ic(data_to_ic[69:60]),
        .clock(clock),
        .config_in(c_iot5),
        .config_out(c_iot6),
        .config_enable(config_enable),
        .config_nreset(config_nreset)
    );
    
    IOTile iot7(
        .data_from_io(data_from_io[31:28]),
        .data_to_io(data_to_io[31:28]),
        .data_from_ic(data_from_ic[79:70]),
        .data_to_ic(data_to_ic[79:70]),
        .clock(clock),
        .config_in(c_iot6),
        .config_out(config_out),
        .config_enable(config_enable),
        .config_nreset(config_nreset)
    );
    

endmodule