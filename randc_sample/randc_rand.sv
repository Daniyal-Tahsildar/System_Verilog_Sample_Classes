class rand_check;
    randc bit [2:0] a;
    rand bit [2:0] b;

endclass

module top;
    rand_check check = new();

    initial begin
        repeat(10) begin
            // check = new();  doing this here will assign a new memory everytime. 
            // This will cause randc not to take effect
            assert(check.randomize());
            $display("%p", check);
        end
    end
endmodule