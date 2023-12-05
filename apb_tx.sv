class apb_tx;
    rand bit[31:0] addr;
    rand bit[31:0] data;
    rand bit wr_rd;
    rand bit[3:0] sel;

    function void print(string s = "apb_tx");
        $display(s);
        $display("\taddr = %h", addr);
        $display("\tdata = %h", data);
        $display("\twr_rd = %h", wr_rd);
        $display("\tsel = %b\n", sel);
    endfunction

    function bit compare(apb_tx tx);
        if (addr == tx.addr 
        && data == tx.data 
        && wr_rd == tx.wr_rd 
        && sel == tx.sel) begin
            return 1;
        end
        else begin
            return 0; 
        end
    endfunction

    function apb_tx copy();
        apb_tx tx = new();
        tx.addr = addr;
        tx.data = data;
        tx.wr_rd = wr_rd;
        tx.sel = sel;
        return tx; 
    endfunction

    constraint sel_c{
        $onehot0(sel) == 1;
    }

endclass


