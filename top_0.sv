`timescale 1ns/1ps
module top_0 ();
    logic clk =0; 
    logic ack   ;
    logic rst =0; 
    logic [31:0] rdata;
    logic req  ;
    logic cmd  ;
    logic [31:0] wdata;
    logic [31:0] addr;
    logic [31:0] addr_out_first;
    logic [31:0] wdata_out_first;
    logic        cmd_out_first;
    logic        req_out_first;
    logic        ack_out_first;
    logic [31:0] rdata_out_first;
    logic [31:0] addr_out_second;
    logic [31:0] wdata_out_second;
    logic        cmd_out_second;
    logic        req_out_second;
    logic        ack_out_second;
    logic [31:0] rdata_out_second ;
    logic  [7:0] counter = 8'b0;
master #(.N(1)) m0 (
     .clk   (clk),
     .ack   (ack),
     .rst   (rst),
     .rdata (rdata),
     .req   (req),
     .cmd   (cmd),
     .wdata (wdata),
     .addr  (addr)
);
mux_master mm0 (
    
    .req_in          (req          ),
    .addr_in         (addr         ),
    .cmd_in          (cmd          ),
    .wdata_in        (wdata        ),
    .ack_in          (ack          ),
    .rdata_in        (rdata        ),
    .addr_out_first  (addr_out_first  ),
    .wdata_out_first (wdata_out_first ),
    .cmd_out_first   (cmd_out_first   ),
    .req_out_first   (req_out_first   ),
    .ack_out_first   (ack_out_first   ),
    .rdata_out_first (rdata_out_first ),
    .addr_out_second (addr_out_second ),
    .wdata_out_second(wdata_out_second),
    .cmd_out_second  (cmd_out_second  ),
    .req_out_second  (req_out_second  ),
    .ack_out_second  (ack_out_second  ),
    .rdata_out_second(rdata_out_second)
);
slave s0 (
   .clk  (clk),
   .rst  (rst),
   .ack  (ack_out_first),
   .rdata(rdata_out_first),
   .req  (req_out_first),
   .cmd  (cmd_out_first),
   .wdata(wdata_out_first),
   .addr (addr_out_first)
);
slave s1 (
   .clk  (clk),
   .rst  (rst),
   .ack  (ack_out_second),
   .rdata(rdata_out_second),
   .req  (req_out_second),
   .cmd  (cmd_out_second),
   .wdata(wdata_out_second),
   .addr (addr_out_second)
);
initial begin
    #1;
    rst=0;
    #1;
    rst=1;
    #1;
    rst=0;
    #1;
end
always #2 clk = ~clk;
always @ (posedge clk or negedge rst) begin
    if (counter[7] == 1) begin
        $stop;
    end
end
endmodule