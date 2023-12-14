
class eth_gen;
    eth_good_pkt good_pkt;
    eth_bad_pkt bad_pkt;
    eth_ill_pkt ill_pkt;
    bit [1:0] pkt_b; 

    mailbox mbox = new();

    function new (mailbox mbox);
        this.mbox = mbox;
    endfunction

    task run(string testcase, int count);
        repeat (count) begin
        //different testcases are run based on the testcase argument passed in the run.do file 
            case (testcase)
                "good_tests" : begin
                    good_pkt = new();
                    assert(good_pkt.randomize());
                    mbox.put(good_pkt);   
                end

                "bad_tests" : begin
                    bad_pkt = new();
                    assert(bad_pkt.randomize());
                    mbox.put(bad_pkt);
                end

                "ill_tests" : begin
                    ill_pkt = new();
                    assert(ill_pkt.randomize());
                    mbox.put(ill_pkt);    
                end

                "rand_tests" : begin
                    pkt_b = $urandom_range(0, 2);   
                    case (pkt_b) 
                        0: begin
                            good_pkt = new();
                            assert(good_pkt.randomize()); 
                            mbox.put(good_pkt);
                        end
                        1: begin
                            bad_pkt = new();
                            assert(bad_pkt.randomize());
                            mbox.put(bad_pkt);
                        end
                        2: begin
                            ill_pkt = new();
                            assert(ill_pkt.randomize());
                            mbox.put(ill_pkt);
                        end
                    endcase
                end
            endcase
        end

    endtask
    

endclass