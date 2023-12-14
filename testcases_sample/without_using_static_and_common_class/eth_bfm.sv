class eth_bfm;
    eth_good_pkt good_pkt;
    eth_bad_pkt bad_pkt;
    eth_ill_pkt ill_pkt;
    mailbox mbox;

    function new (mailbox mbox);
        this.mbox = mbox;
    endfunction
    
    //get any pkt (good, bad, ill) as eth_pkt
    //this works due to polymorphism 
    eth_pkt pkt;    
    task run();
        //repeat (eth_common::count_tests) begin
        forever begin  // this makes sure the bfm runs forever irrespective of the 
                       // number of transactions, simulations stops when $finish is reached
            mbox.get(pkt);
            case(pkt.pkt_t)
                GOOD: begin
                    $cast(good_pkt, pkt);
                    good_pkt.print();
                end
                BAD: begin
                    $cast(bad_pkt, pkt);
                    bad_pkt.print();
                end
                ILL: begin
                    $cast(ill_pkt, pkt);
                    ill_pkt.print();
                end
            endcase
        end

    endtask
endclass