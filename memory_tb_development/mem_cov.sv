class mem_cov;
    mem_tx tx;
    event mem_cg_e;

    covergroup mem_cg @(mem_cg_e); //only triggers at an event named mem_cg_e
        ADDR_CP: coverpoint tx.addr{
            option.auto_bin_max = 5; // automatically divides all the possible values into 5 bins
        }
        WR_RD_CP: coverpoint tx.wr_rd; //no bins since only 1 bit 
        cross ADDR_CP, WR_RD_CP{  //will create 10 bins (5x2)
            option.weight = 3; // default weight is 1, makes this cp more impactfull compared to other cps
        }  
    endgroup;

    task run();
        forever begin
            mem_common::mon2cov.get(tx);
            //following two ways can be used for triggering CG
            ->mem_cg_e; //trigger event for sampling
            mem_cg.sample(); //sample the CG
        end
    endtask
endclass