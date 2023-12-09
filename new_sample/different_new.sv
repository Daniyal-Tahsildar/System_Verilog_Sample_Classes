//new is the default definition
class sample_1;
    bit [55:0] preamble; 
    bit [7:0] sof;
    logic [7:0] da;
endclass

//new is used to initialize certain fields
class sample_2;
    bit [55:0] preamble; 
    bit [7:0] sof;
    logic [7:0] da;
    
    function new();
        preamble = {28{2'b10}};
        sof = 8'b1010_1011;
    endfunction
endclass

//arguments are passes in new, and user can 
//assign values to fields included in new 
class sample_3;
    bit [55:0] preamble; 
    bit [7:0] sof;
    logic [7:0] da;
    
    function new(bit [55:0] preamble, bit [7:0] sof_t);
        this.preamble = preamble;
        sof = sof_t;
    endfunction
endclass

//arguments are passes in new, and user can 
//assign values to fields included in new, along
//with default values that prevent errors 
class sample_4;
    bit [55:0] preamble; 
    bit [7:0] sof;
    logic [7:0] da;
    
    function new(bit [55:0] preamble = {14{4'hC}}, bit [7:0] sof_t = 8'b1110_1011);
        this.preamble = preamble;
        sof = sof_t;
    endfunction
endclass

module top;
    sample_1 s_1 = new();
    sample_2 s_2 = new();
    sample_3 s_3 = new({14{4'hF}}, 8'hA_9);
    sample_4 s_4 = new();

    initial begin 
        $display("Sample class 1, uses default definition of new: \n\t preamble: %h, sof = %h", s_1.preamble, s_1.sof);
        $display("Sample class 2, initializes certain feilds in default definition of new: \n\t preamble: %h, sof = %h", s_2.preamble, s_2.sof);
       
        $display("*************Not assigning field values for s_3 will cause errors*************",);
        $display("Sample class 3, requires user to assign certain fields for initialization in new: \n\t preamble: %h, sof = %h", s_3.preamble, s_3.sof);
        
        $display("*************Not assigning field values for s_4 will NOT cause errors, default values are taken*************",);
        $display("Sample class 4, requires user to assign certain fields for initialization but also has default values if no input is provided:");
        $display("\t Without providing field initialization in new: \n\t\t preamble: %h, sof = %h", s_4.preamble, s_4.sof);
        #5 // delay to prevent race condition while displaying
        s_4 = new({14{4'hB}}, 8'hAC);
        $display("\t Providing field initialization in new: \n\t\t preamble: %h, sof = %h", s_4.preamble, s_4.sof);
        
    end

endmodule