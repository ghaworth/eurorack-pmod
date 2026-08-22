`default_nettype none
module sysmgr (
    input  wire clk_in,     // 100 MHz Basys 3 oscillator
    input  wire rst_in,
    output wire clk_256fs,
    output wire rst_out
);

// divide clk_in by 8 to get ~12.5 MHz
// (same bit-slicing idea as clkdiv in ak4619.sv, just off clk_in this time)
logic [2:0] clkdiv;
logic clkdiv_256;
assign clkdiv_256 = clkdiv[2];

always_ff @(posedge clk_in) begin
    if (rst_in) begin
        clkdiv <= 0;
    end else begin
        clkdiv <= clkdiv + 1;
    end 

end

// put the divided clock onto the global clock network via BUFG
`ifndef VERILATOR_LINT_ONLY
BUFG clk_gbuf_I (
    .I(clkdiv_256),
    .O(clk_256fs)
);
`endif

logic [7:0] rst_cnt = 0;
assign rst_out = ~rst_cnt[7];

always @(posedge clk_256fs) begin
    if (rst_in)
        rst_cnt <= 8'h0;
    else if (~rst_cnt[7])
        rst_cnt <= rst_cnt + 1;

end

endmodule
