`define WIDTH 16
`define DEPTH 64
`define ADDR_WIDTH $clog2(`DEPTH)

interface intf(input logic clk_i, rst_i); // keep only clk and rst in the port list, everything else is inside
    logic [`WIDTH-1:0] wr_data_i;
    logic [`ADDR_WIDTH-1:0] addr_i;
    logic [`WIDTH-1:0] rd_data_o;
    logic wr_rd_i, valid_i;
    logic ready_o;

endinterface