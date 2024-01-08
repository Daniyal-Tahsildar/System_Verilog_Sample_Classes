`include "list.svh"

module top;

    logic clk,rst;
    
    intf pif(.clk_i(clk), .rst_i(rst));

    mem #(.WIDTH(`WIDTH), .DEPTH(`DEPTH), .ADDR_WIDTH(`ADDR_WIDTH)) DUT( .clk(pif.clk_i),
        .rst(pif.rst_i),
        .wr_data_i(pif.wr_data_i), 
        .addr_i(pif.addr_i),
        .rd_data_o(pif.rd_data_o), 
        .wr_rd_i(pif.wr_rd_i), 
        .valid_i(pif.valid_i), 
        .ready_o(pif.ready_o)); 

    mem_env env;
    mem_common common = new();

    initial begin
        clk = 0;
        forever begin
            #5 clk = ~clk;
        end
    end

    initial begin
        mem_common::vif = pif; //assigning physical interface handle to the virtual interface 
    end
    task reset_inputs();
        pif.wr_data_i = 0; 
        pif.addr_i = 0;
        pif.wr_rd_i = 0; 
        pif.valid_i = 0; 
    endtask

    initial begin
        rst = 1;
        //$value$plusargs("testcase=%s", mem_common::testcase);
        //reset all design inputs also
        reset_inputs();
        repeat(2) @(posedge clk);
        rst = 0;
    // run env
        env = new();
        env.run();
    end

    final begin //to see coverage
        $display("Coverage after tx %0d = %0.2f", mem_common::total_driven_tx, env.cov.mem_cg.get_inst_coverage());    
      end

    initial begin
        //#1000;
        wait(mem_common::count*2*mem_common::num_agents == mem_common::total_driven_tx); //count required for 3 agents
        @(posedge clk); //time for last tx to complete
        $finish;
    end

endmodule