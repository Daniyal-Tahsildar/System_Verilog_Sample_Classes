class mem_gen;
    mem_tx tx;
    bit [`ADDR_WIDTH-1:0] addr_used_for_write;
    bit [`ADDR_WIDTH-1:0] addr_used_for_writeQ[$];

    task run();
        case(mem_common::testcase)
        "wr_rd_test": begin
            //write to a location
            tx = new();
            tx.randomize() with {wr_rd == 1;};
            addr_used_for_write = tx.addr;
            mem_common::gen2bfm.put(tx);
            //read from a location
            tx = new();
            tx.randomize() with {wr_rd == 0; addr == addr_used_for_write;};
            mem_common::gen2bfm.put(tx);
        end
        "n_wr_n_rd_test": begin
            //write to a location
            repeat(mem_common::count) begin
                tx = new();
                tx.randomize() with {wr_rd == 1;};
                addr_used_for_writeQ.push_back(tx.addr);
                mem_common::gen2bfm.put(tx);
            end
            //read from a location
            repeat(mem_common::count) begin
                tx = new();
                tx.randomize() with {wr_rd == 0; addr == addr_used_for_writeQ.pop_front();};
                mem_common::gen2bfm.put(tx);
            end
        end

        endcase

    endtask

endclass