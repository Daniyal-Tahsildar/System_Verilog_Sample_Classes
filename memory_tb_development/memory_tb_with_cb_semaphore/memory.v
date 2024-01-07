module mem #(
    parameter WIDTH = 16,
    parameter DEPTH = 64,
    parameter ADDR_WIDTH = $clog2(DEPTH)
)
(
    input clk,rst,
    input [WIDTH-1:0] wr_data_i,
    input [ADDR_WIDTH-1:0] addr_i,
    output reg [WIDTH-1:0] rd_data_o,
    input wr_rd_i, valid_i,
    output reg ready_o

);

reg [WIDTH-1:0] mem [DEPTH-1:0];

always @(posedge clk or posedge rst) begin
    if(rst) begin
        for (int i = 0; i < DEPTH-1; i++) mem[i] <= 0; 
        rd_data_o <= 0;
        ready_o <= 0;

    end
    else begin
        if (valid_i) begin // Handshake
            ready_o <= 1;  // Completion, checks if there is a valid request to the memory
            if(wr_rd_i) begin
                mem[addr_i] <= wr_data_i;
            end
            else begin
                rd_data_o <= mem[addr_i];
            end
        end
        else begin
            ready_o <= 0;
        end

    end
    
end



endmodule