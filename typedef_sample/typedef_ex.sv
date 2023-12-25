class eth_pkt;
    rand bit [3:0] sof;
    rand bit [5:0] len;
endclass

//typedef is used to create user defined datatypes
typedef eth_pkt pktQ_t[$]; //queue of eth_pkt using typedef
typedef pktQ_t pktQ_FA_t[5]; // using pktQ_t type to create another datatype


module top;
    pktQ_t pktQ_FA[5];
    eth_pkt pkt;
    
    initial begin
        for (int i = 0; i < 5; i++) begin // for array
            for (int j= 0; j < 3; j++) begin //for queue
               pkt = new();
               pkt.randomize();
               pktQ_FA[i].push_back(pkt);
            end
        end
        // foreach(pktQ_FA[i]) begin
        //     foreach (pktQ_FA[i][j]) begin
            foreach (pktQ_FA[i,j]) begin //better way of using foreach
                $display("pktQ_FA[%0d][%0d] = %p", i,j, pktQ_FA[i][j]);
            end
        // end
    end

endmodule