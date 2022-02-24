`timescale 1ns/1ps
module mux_slave_tb();
   logic        req_out        ;
   logic [31:0] addr_out       ;
   logic        cmd_out        ;
   logic [31:0] wdata_out      ;
   logic        ack_out        ;
   logic [31:0] rdata_out      ;
   logic [31:0] addr_in_first  ;
   logic [31:0] wdata_in_first ;
   logic        cmd_in_first   ;
   logic        req_in_first   ;
   logic        ack_in_first   ;
   logic [31:0] rdata_in_first ;
   logic [31:0] addr_in_second ;
   logic [31:0] wdata_in_second;
   logic        cmd_in_second  ;
   logic        req_in_second  ;
   logic        ack_in_second  ;
   logic [31:0] rdata_in_second;
   logic  [1:0]      grant     ;     ;
   logic        rst;

mux_slave uut (
    .req_out         (req_out        ),
    .addr_out        (addr_out       ),
    .cmd_out         (cmd_out        ),
    .wdata_out       (wdata_out      ),
    .ack_out         (ack_out        ),
    .rdata_out       (rdata_out      ),
    .addr_in_first   (addr_in_first  ),
    .wdata_in_first  (wdata_in_first ),
    .cmd_in_first    (cmd_in_first   ),
    .req_in_first    (req_in_first   ),
    .ack_in_first    (ack_in_first   ),
    .rdata_in_first  (rdata_in_first ),
    .addr_in_second  (addr_in_second ),
    .wdata_in_second (wdata_in_second),
    .cmd_in_second   (cmd_in_second  ),
    .req_in_second   (req_in_second  ),
    .ack_in_second   (ack_in_second  ),
    .rdata_in_second (rdata_in_second),
    .grant           (grant          ),
    .rst             (rst)       
    
);
task test
    (
       input         t_master_0_req  ,
       input  [31:0] t_master_0_addr ,
       input  [31:0] t_master_0_wdata,
       input         t_master_0_cmd  ,
       input         t_master_1_req  ,
       input  [31:0] t_master_1_addr ,
       input  [31:0] t_master_1_wdata,
       input         t_master_1_cmd,
       input  [31:0] t_rdata_out,
       input         t_ack_out  
    );

            req_in_first = t_master_0_req  ;
            addr_in_first= t_master_0_addr ;
            wdata_in_first= t_master_0_wdata;
            cmd_in_first= t_master_0_cmd  ;
            req_in_second= t_master_1_req  ;
            addr_in_second= t_master_1_addr ;
            wdata_in_second= t_master_1_wdata;
            cmd_in_second= t_master_1_cmd  ;
            ack_out = t_ack_out;
            rdata_out = t_ack_out;
endtask

initial begin
    #1;
    rst =0;
    #1;
    rst =1;
    #1;
    rst =0;
    test (1, {4{8'b11001100}}, {4{8'b10101010}}, 0,  1, {4{8'b00110011}}, {4{8'b01010101}}, 1, 1, {4{8'b01110101}});
    #2;
    grant = 2'b01;
    #2;
    grant = 2'b10;
    #2;
    grant = 2'b01;
#3;
$stop;
end
endmodule