`timescale 1ns/1ps
module mux_master_tb();
    logic        rst;
    logic        req_in;         
    logic [31:0] addr_in;        
    logic        cmd_in;         
    logic [31:0] wdata_in;        
    logic        ack_in;          
    logic [31:0] rdata_in;      
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
    logic [31:0] rdata_out_second;
    logic [31:0] addr1 = {1'b1,{6{5'b11001}}, 1'b1};
    logic [31:0] addr2 = {1'b0, {6{5'b10101}}, 1'b1};

mux_master uut (
    
      .req_in          (req_in          ),
      .addr_in         (addr_in         ),
      .cmd_in          (cmd_in          ),
      .wdata_in        (wdata_in        ),
      .ack_in          (ack_in          ),
      .rdata_in        (rdata_in        ),
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
      .rdata_out_second(rdata_out_second),
      .rst             (rst             )
);
initial begin
    #5;
    rst =0;
    #3;
    rst=1;
    #3;
    rst=0;
    #5;
    
    #5;
req_in           = 1'b1;
addr_in          = addr1;
cmd_in           = 1'b1;
wdata_in         = {32{1'b1}};
ack_out_first    = 1'b0;
ack_out_second   = 1'b1;
rdata_out_first  =  {32{1'b1}};
rdata_out_second = {32{1'b0}};
#3;
addr_in          = addr2;
#5;
    $stop;
end
endmodule