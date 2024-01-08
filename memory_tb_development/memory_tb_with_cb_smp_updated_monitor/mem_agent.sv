class mem_agent;
    mem_gen gen ;
    mem_bfm bfm ;
    mem_mon mon = new();
    mem_cov cov = new();

    function new(int i);
        gen = new(i);
        bfm = new(i);
    endfunction

    task run();
        fork
            gen.run();
            bfm.run();
            mon.run();
            cov.run();
        join
    endtask

endclass