`define WIDTH 16
`define DEPTH 64
`define ADDR_WIDTH $clog2(`DEPTH)

class mem_common; //anything shared by atleast two components is added here as static
    static virtual intf vif; // virtual interface 
    
    //static mailbox gen2bfm = new();
    static mailbox gen2bfmDA[]; //DA for multiple agents
    static mailbox mon2ref = new();
    static mailbox mon2cov = new();
    
    static string testcase = "n_wr_n_rd_test";
    static int count = 5;
    static int total_driven_tx = 0;
    static int num_agents = 3;
    static semaphore smp = new(1); // since only one interface is used

    function new();
        gen2bfmDA = new[num_agents];
        foreach (gen2bfmDA[i]) begin
            gen2bfmDA[i] = new();
        end
    endfunction

endclass