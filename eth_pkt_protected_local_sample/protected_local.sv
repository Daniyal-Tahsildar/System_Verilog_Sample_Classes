class eth_pkt;
    //properties
        local bit [55:0] preamble; //local can only be accessed by this class
        local bit [7:0] sof;
        
        protected rand bit [47:0] da; // protected can be accessed by this class and its child classes
        protected rand bit [47:0] sa;

        rand bit [15:0] len;
        rand bit [8:0] payload[$]; //queue of octets
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

    //functions to cheange protected properties
        function void set_da( bit [47:0] da_t, string scope = "");
            da = da_t;
            $display("da changed to %h by %s", da, scope);
        endfunction

        function void get_da( output bit [47:0] da_g, input string scope = "");
            da_g = da;
            $display("da assigned in %s", scope);
        endfunction


    
    //constraints
        constraint len_c{
            len inside{[10:30]};
        }
    
        constraint payload_c{
            payload.size() == len;
        }
    
    endclass
    
//inherited class
    class eth_pkt_child extends eth_pkt;
       rand bit [3:0] count;
    
        function void print(string s = "eth_pkt_child");
        // inherites the print function from parent class and can add more as well
            super.print(s);
            $display("\tcount = %0d", count);
        endfunction
// other parent class functions (methods) can be declared here using super keyword
// since we do not need to add/change functionality of the base class methods
// they are not declared here. Inherited classes alredy have access to base class methods

    endclass
    
    
    module top;
        // to store value of da
        bit [47:0] da_val;

        //instantiating inherited class    
        eth_pkt_child pkt = new();
        initial begin
            pkt = new();
            assert(pkt.randomize());
            pkt.print("eth_pkt_child");
    /*
            pkt.preamble = 200; // illegal
            pkt.print("eth_pkt_child"); //this will give error now
    */
            pkt.set_da($random, "top");

// Accessing protected property outside class using a function
            pkt.get_da(da_val, "top");
            pkt.print("eth_pkt_child");

        end
    endmodule