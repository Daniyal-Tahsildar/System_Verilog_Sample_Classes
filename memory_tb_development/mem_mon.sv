class mem_mon;
    mem_tx tx;
    virtual intf vif;

    function new();
        vif = mem_common::vif;
    endfunction

    task run();
        forever begin
            @(posedge vif.clk_i);
            if(vif.valid_i == 1 && vif.ready_o == 1) begin
                tx = new();
                tx.addr = vif.addr_i;
                tx.data = vif.wr_rd_i ? vif.wr_data_i : vif.rd_data_o;
                tx.wr_rd = vif.wr_rd_i;
            end
            mem_common::mon2ref.put(tx);
            mem_common::mon2cov.put(tx);
        end
    endtask

endclass