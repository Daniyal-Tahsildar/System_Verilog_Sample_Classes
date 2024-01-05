class mem_bfm;
    mem_tx tx;
    virtual intf vif;

    function new();
        vif = mem_common::vif;
    endfunction

    task run();
        forever begin
            mem_common::gen2bfm.get(tx);
            drive_tx(tx);
            mem_common::total_driven_tx++;
        end
    endtask

    task drive_tx(mem_tx tx);
        @(posedge vif.clk_i);
        vif.addr_i <= tx.addr;
        if(tx.wr_rd == 1) vif.wr_data_i <= tx.data;
        vif.wr_rd_i <= tx.wr_rd;
        vif.valid_i <= 1;
        wait(vif.ready_o == 1);
        @(posedge vif.clk_i);
        vif.addr_i <= 0;
        vif.wr_data_i <= 0;
        vif.wr_rd_i <= 0;
        vif.valid_i <= 0;
    endtask


endclass