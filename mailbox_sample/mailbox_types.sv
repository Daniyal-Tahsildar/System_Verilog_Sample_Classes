module top;
    mailbox mbox_1 = new(); // can store infinite number of elements of different types (non-parameterized)
    mailbox mbox_2 = new(5); // can store limited number (5) of elements of different types (non-parameterized)
    mailbox #(int) mbox_3 = new(5); // can store limited number (5) of elements of int type (parameterized)

    int a;
    string s;
    real r;
    initial begin
    // Example_1
        $display("Putting data in mailbox_1");
        mbox_1.put(12);
        mbox_1.put("Sample");
        mbox_1.put(11.3);
        mbox_1.put(123);
        mbox_1.put("sample_2");
        $display("\tmailbox_1 data = %p", mbox_1);
        $display("\tNumber of elements in the mailbox_1 = %0d", mbox_1.num());

    // for non-parameterized mailboxes, type of the data being retrieved must be known
        $display("Getting data from mailbox_1");
        mbox_1.get(a); 
        mbox_1.get(s);
        mbox_1.get(r);
        mbox_1.get(a);
        mbox_1.get(s);
        $display("\tmailbox_1 data = %p", mbox_1);
        $display("\tNumber of elements in the mailbox_1 = %0d", mbox_1.num());

    // Example_2
        // try_get and try_put are functions and will not lead to errors if mailbox is full and additional data
        // is put in, data is unavailable, putting and getting data from mailbox exceeds assigned limit (5 in this case)
        $display("Putting data in mailbox_2");
        mbox_2.try_put(12);
        mbox_2.try_put("Sample");
        mbox_2.try_put(11.3);
        mbox_2.try_put(123);
        mbox_2.try_put("sample_2");
        $display("\tmailbox_2 data = %p", mbox_2);
        $display("\tNumber of elements in the mailbox_2 = %0d", mbox_2.num());

        // try_get is non blocking in nature, it doesnt wait for all the elements in the mailbox to be retrived, hence only one
        // element gets taken out. 
        $display("Getting data from mailbox_2");
        mbox_2.try_get(a); 
        mbox_2.try_get(s);
        mbox_2.try_get(r);
        mbox_2.try_get(a);
        mbox_2.try_get(s);
        $display("\tmailbox_2 data = %p", mbox_2);
        $display("\ts = %s", s); // elements do get values assigned even if they are not taken out of the mailbox
        $display("\tNumber of elements in the mailbox_2 = %0d", mbox_2.num()); 

    // Example_3
        //peek gets the first element put in mailbox without deleting it
        $display("Putting data in mailbox_3");
        mbox_3.put(12);
        mbox_3.put(15);
        $display("\tmailbox_3 data = %p", mbox_2);
        $display("\tNumber of elements in the mailbox_3 = %0d", mbox_3.num());

        $display("Getting data from mailbox_3 using peak");
        mbox_3.peek(a); 
        $display("\tdata retrieved from mailbox_3 = %0d", a);
        $display("\tmailbox_3 data = %p", mbox_3);
        $display("\tNumber of elements in the mailbox_3 = %0d", mbox_3.num());

    end
endmodule