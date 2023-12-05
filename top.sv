`include "apb_tx.sv"

module top;
    apb_tx tx1 = new();
    apb_tx tx2 = new();
    bit compare_bit;

    initial begin
         repeat(2) begin
            tx1 = new();
            assert(tx1.randomize());
            tx1.print("tx1");
         end
        
         tx2 = new();
         assert(tx2.randomize());
         tx2.print("tx2");
         compare_bit = tx1.compare(tx2);
         if (compare_bit) begin
            $display("transactions matched");
         end
         else begin
            $display("transactions mismatched");
            tx1.print("tx1 before copying");
            tx2.print("tx2 before copying");

            $display("copying tx1 to tx2");
            tx2 = tx1.copy();
            tx1.print("tx1 after copying");
            tx2.print("tx2 after copying");

         end


    end
endmodule