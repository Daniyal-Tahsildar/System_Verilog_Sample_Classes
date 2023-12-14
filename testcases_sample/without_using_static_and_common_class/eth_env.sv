class eth_env;
    eth_gen gen;
    eth_bfm bfm;
    //mailbox declared in env which is wrapper for gen and bfm
    mailbox gen2bfm_mbox;

    function new();
        gen2bfm_mbox = new();
        //mbox passed in the gen and bfm 
        gen = new(gen2bfm_mbox);
        bfm = new(gen2bfm_mbox);
    endfunction

    task run(string testcase, int count); 
        fork // used to run processes parallel
        // without static all the arguments required need to be pass in,
        // these arguments need be initialized in function new() of gen and bfm class
            gen.run(testcase, count);
            bfm.run();
        join
    endtask
endclass