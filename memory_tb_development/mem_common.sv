class mem_common; //anything shared by atleast two components is added here as static
    static virtual intf vif; // virtual interface 
    static mailbox gen2bfm = new();
    static string testcase = "n_wr_n_rd_test";
    static int count = 5;
    static int total_driven_tx = 0;

endclass