class mem_env;
    //mem_agent agent = new();
    //for multiple agents
    mem_agent agentDA[];

    function new();
        agentDA = new[mem_common::num_agents]; // allocating memory to DA
        foreach(agentDA[i]) begin
            agentDA[i] = new(i); // allocating memory to each agent in DA
        end

    endfunction

    task run();
        for (int i =0; i < mem_common::num_agents; i++) begin
        fork
            agentDA[i].run();
        join_none // it starts the above run method, without waiting for it,
        // we come out of fork join
        #0; //delta delay to prevent overwriting on i value
        end
        wait fork; //wait for all fork join to complete
    //inefficient way of doing the above code
    // fork
    //     agentDA[0].run();
    //     agentDA[1].run();
    //     agentDA[2].run();
    // join
    endtask

endclass