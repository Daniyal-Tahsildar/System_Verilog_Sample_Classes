module sample_Q;
    int intQ[$: 29];
    int intDA[];
    int intQ_2[$:9];
    int number, data;

    initial begin
        intDA = new[10];
        foreach(intDA[i]) begin
            intDA[i] = $urandom_range(100, 200);
        end

        for(int i = 0; i < 30;) begin
            number = $urandom_range(100, 129);
            if(!(number inside {intQ})) begin
                intQ.push_back(number);
            //$display("number = %d" , number);
                i = i+1;
            end
        end
    //assigning intDA to intQ_2
        intQ_2 = intDA;
      
      $display("intQ = %p" , intQ);
      $display("intDA = %p" , intDA);
      $display("intQ_2 = %p" , intQ_2);
      $display("reversing intQ_2");
      
      intQ_2.reverse();
      
      $display("intQ_2 after reverse = %p" , intQ_2);
      
//poping at specific location
      $display("Poping at specific location");
      data = intQ_2[5];
      intQ_2.delete(5);

      	$display("data that was poped = %0d" , data);
       	$display("intQ_2 after poping = %p" , intQ_2);

    end
endmodule