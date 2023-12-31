class eth_pkt;
    //properties
    bit [55:0] preamble;
    bit [7:0] sof;
    rand bit [47:0] da; 
    rand bit [47:0] sa;
    rand bit [15:0] len;
    rand bit [7:0] payload[$]; //queue of octets
    bit [31:0] crc;
    //methods
        function new();
            preamble = {28{2'b10}};
            sof = 8'b1010_1011;
        endfunction
    
        function void print(string name = "eth_pkt");
            $display(name);
            $display("\tpreamble = %h", preamble);
            $display("\tsof = %h", sof);
            $display("\tda = %h", da);
            $display("\tsa = %h", sa);
            $display("\tlen = %0d", len);
            //$display("\tpayload = %p", payload);
            foreach(payload[i])
                $display("\tpayload[%0d] = %h", i, payload[i] );
            $display("\tcrc = %h\n", crc);
            endfunction
    
    //constraints
        constraint len_c{
            len inside{[5:10]};
        }
    
        constraint payload_c{
            payload.size() == len;
        }
    
    endclass
    
    
    module top;
    eth_pkt pkt = new();
    initial begin
        pkt = new();
        assert(pkt.randomize());
        pkt.print("eth_pkt");
    end
    endmodule