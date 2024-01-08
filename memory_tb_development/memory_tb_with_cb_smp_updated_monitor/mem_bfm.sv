class mem_bfm;
    mem_tx tx;
    virtual intf.bfm_mp vif;
    int bfm_num;

    function new(int i);
        vif = mem_common::vif;
        bfm_num = i;
    endfunction

    task run();
        forever begin
            mem_common::gen2bfmDA[bfm_num].get(tx);
            mem_common::smp.get(1); //get semaphore key
            drive_tx(tx);
            mem_common::smp.put(1); //return semaphore key
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
        if(tx.wr_rd == 0) tx.data = vif.bfm_cb.rd_data_o; //only for reads
        $display("[time: %0t] BFM#%0d is %s at addr = %0h, data = %0h",$realtime,  bfm_num, tx.wr_rd ? "Writing": "Reading", tx.addr, tx.data);
        @(vif.bfm_cb);
        vif.bfm_cb.addr_i <= 0;
        vif.bfm_cb.wr_data_i <= 0;
        vif.bfm_cb.wr_rd_i <= 0;
        vif.bfm_cb.valid_i <= 0;
    endtask


endclass