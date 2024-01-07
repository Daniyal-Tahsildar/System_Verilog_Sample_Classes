class mem_bfm;
    mem_tx tx;
    virtual intf.bfm_mp vif;

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
        @(vif.bfm_cb);
        vif.bfm_cb.addr_i <= tx.addr;
        if(tx.wr_rd == 1) vif.bfm_cb.wr_data_i <= tx.data;
        vif.bfm_cb.wr_rd_i <= tx.wr_rd;
        vif.bfm_cb.valid_i <= 1;
        wait(vif.bfm_cb.ready_o == 1);
        @(vif.bfm_cb);
        vif.bfm_cb.addr_i <= 0;
        vif.bfm_cb.wr_data_i <= 0;
        vif.bfm_cb.wr_rd_i <= 0;
        vif.bfm_cb.valid_i <= 0;
    endtask


endclass