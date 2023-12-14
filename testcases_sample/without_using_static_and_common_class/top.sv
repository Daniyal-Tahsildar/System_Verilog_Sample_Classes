//******Cast done in eth_bfm.sv******

//forward declaration
typedef class eth_pkt;
typedef class eth_good_pkt;
typedef class eth_bad_pkt;
typedef class eth_ill_pkt;
typedef class eth_gen;
typedef class eth_bfm;
typedef class eth_env;
//typedef class eth_common;

// if forward declaration is done, no need to put include files in order
`include "eth_common.sv"
`include "eth_env.sv"
`include "eth_pkt_i_p.sv"
`include "eth_gen.sv"
`include "eth_bfm.sv"

module top;
    //common class properties declared in module
    string testcase;
    int count_tests;

    eth_env env;
    
    initial begin
    //get the testcase type and count from the command line / run.do file
        $value$plusargs("count_tests=%d", count_tests);
        $value$plusargs("testcase=%s", testcase);
        env = new();
        env.run(testcase, count_tests);
    //give the env some time to finish
        #100;
        $finish;
    end
endmodule