class mem_mon;
    mem_tx tx;
    virtual intf.mon_mp vif;

    function new();
        vif = mem_common::vif;
    endfunction

    task run();
        forever begin
            @(vif.mon_cb);
            if(vif.mon_cb.valid_i == 1 && vif.mon_cb.ready_o == 1) begin
                tx = new();
                tx.addr = vif.mon_cb.addr_i;
                tx.data = vif.mon_cb.wr_rd_i ? vif.mon_cb.wr_data_i : vif.mon_cb.rd_data_o;
                tx.wr_rd = vif.mon_cb.wr_rd_i;
            end
            mem_common::mon2ref.put(tx);
            mem_common::mon2cov.put(tx);
        end
    endtask

endclass