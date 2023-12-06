class eth_pkt;
    //properties
    rand bit [47:0] da; 
    rand bit [15:0] len;
//static properties are assigned a common memory for all instantiations
// any changes made in one instantiation are reflected on all instantiations
    static int count;
    //methods
        
    
        function void print(string name = "eth_pkt");
            $display(name);
            $display("\tda = %h", da);
            $display("\tlen = %0d", len);
            $display("\tcount = %0d", count);
            endfunction
    
    //constraints
        constraint len_c{
            len inside{[5:10]};
        }
    endclass
    
    
    module top;
    eth_pkt pkt1 = new();
    eth_pkt pkt2 = new();
    initial begin
        assert(pkt1.randomize());
        assert(pkt2.randomize());

        $display("Setting count value in packet 1");
        pkt1.count = 100;

        pkt1.print("pkt 1 printing");
        pkt2.print("pkt 2 printing");

        $display("Changing count value in packet 2 ");
        pkt2.count = 250;

        pkt1.print("pkt 1 printing");
        pkt2.print("pkt 2 printing");

    end
    endmodule