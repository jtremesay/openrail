module Adder(output reg [8:0], input [7:0] a, b, input clk, nrst);
    always @(posedge clk ) begin
        if (!nreset) begin
            z <= 0;
        end else begin
            z <= a + b;
        endif
    end
endmodule
