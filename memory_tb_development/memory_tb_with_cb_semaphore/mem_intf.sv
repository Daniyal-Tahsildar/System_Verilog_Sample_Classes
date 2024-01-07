`define WIDTH 16
`define DEPTH 64
`define ADDR_WIDTH $clog2(`DEPTH)

interface intf(input logic clk_i, rst_i); // keep only clk and rst in the port list, everything else is inside
    logic [`WIDTH-1:0] wr_data_i;
    logic [`ADDR_WIDTH-1:0] addr_i;
    logic [`WIDTH-1:0] rd_data_o;
    logic wr_rd_i, valid_i;
    logic ready_o;

    clocking bfm_cb @(posedge clk_i);
        //default input #0 output #1 //If using this default statement, 
        //no nned to assign values to input and output skews
        output #1 addr_i;  //design input => bfm output
        output #1 wr_data_i;
        input #0 rd_data_o;
        output #1 wr_rd_i, valid_i;
        input #0 ready_o;
    endclocking

    clocking mon_cb @(posedge clk_i);
        default input #0;
        input addr_i;  //for monitor everything is an input
        input wr_data_i;
        input rd_data_o;
        input wr_rd_i, valid_i;
        input ready_o;
    endclocking

    modport bfm_mp (clocking bfm_cb);
   
    modport mon_mp (clocking mon_cb);

endinterface