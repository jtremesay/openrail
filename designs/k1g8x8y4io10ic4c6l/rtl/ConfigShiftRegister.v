module ConfigShiftRegister #(parameter DEEP=8) (
    input data_in,
    output [DEEP - 1:0] data_out,
    input clock,
    input enable,
    input nreset
);
    reg [DEEP - 1:0] r_data;
    genvar deep;
    generate for (deep = 0; deep < DEEP; deep = deep + 1) begin
        always @(posedge clock) begin
            if (!nreset) begin
                r_data[deep] <= 0;
            end else if (enable) begin
                r_data[deep] <= deep == 0 ? data_in : r_data[deep - 1];
            end
        end
    end endgenerate
    assign data_out = r_data;   
endmodule