class mem_tx;
    // For any transaction class, never code handshaking signals into it
    rand bit [`ADDR_WIDTH-1:0] addr;
    rand bit [`WIDTH-1:0] data;
    rand bit wr_rd;

    //methods
    function void print(string name = "mem_tx");
        $display("Printing %s fields", name);
        $display("\taddr = %d", addr);
        $display("\tdata = %d", data);
        $display("\twr_rd = %d", wr_rd);
    endfunction

    //constraints

endclass