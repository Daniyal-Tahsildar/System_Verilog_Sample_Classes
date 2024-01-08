class mem_agent;
    mem_gen gen ;
    mem_bfm bfm ;

    function new(int i);
        gen = new(i);
        bfm = new(i);
    endfunction

    task run();
        fork
            gen.run();
            bfm.run();
        join
    endtask

endclass