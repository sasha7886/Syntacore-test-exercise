module top
(
    input         rst,


    input         master_0_req,
    input  [31:0] master_0_addr,
    input  [31:0] master_0_wdata,
    input         master_0_cmd,
    output [31:0] master_0_rdata,
    output        master_0_ack,


    input         master_1_req,
    input  [31:0] master_1_addr,
    input  [31:0] master_1_wdata,
    input         master_1_cmd,
    output [31:0] master_1_rdata,
    output        master_1_ack,

    output         slave_0_req,
    output  [31:0] slave_0_addr,
    output  [31:0] slave_0_wdata,
    output         slave_0_cmd,
    input   [31:0] slave_0_rdata,
    input          slave_0_ack,


    output         slave_1_req,
    output  [31:0] slave_1_addr,
    output  [31:0] slave_1_wdata,
    output         slave_1_cmd,
    input   [31:0] slave_1_rdata,
    input          slave_1_ack
);

wire [31:0] mux_arb_00_wdata, mux_arb_00_rdata, mux_arb_00_addr;
wire [31:0] mux_arb_01_wdata, mux_arb_01_rdata, mux_arb_01_addr;
wire [31:0] mux_arb_10_wdata, mux_arb_10_rdata, mux_arb_10_addr;
wire [31:0] mux_arb_11_wdata, mux_arb_11_rdata, mux_arb_11_addr;

wire mux_arb_00_req, mux_arb_00_cmd, mux_arb_00_ack; 
wire mux_arb_01_req, mux_arb_01_cmd, mux_arb_01_ack;
wire mux_arb_10_req, mux_arb_10_cmd, mux_arb_10_ack;
wire mux_arb_11_req, mux_arb_11_cmd, mux_arb_11_ack;


mux_master m0 (
    .rst (rst),
    .req_in(master_0_req),
    .addr_in(master_0_addr),
    .cmd_in(master_0_cmd),
    .wdata_in(master_0_wdata),
    .ack_in(master_0_ack),
    .rdata_in(master_0_rdata),

    .req_out_first(mux_arb_00_req),
    .wdata_out_first(mux_arb_00_wdata),
    .addr_out_first(mux_arb_00_addr),
    .cmd_out_first(mux_arb_00_cmd),
    .ack_out_first(mux_arb_00_ack),
    .rdata_out_first(mux_arb_00_rdata),

    .req_out_second(mux_arb_01_req),
    .wdata_out_second(mux_arb_01_wdata),
    .addr_out_second(mux_arb_01_addr),
    .cmd_out_second(mux_arb_01_cmd),
    .ack_out_second(mux_arb_01_ack),
    .rdata_out_second(mux_arb_01_rdata)

);

mux_master m1 (
    .rst(rst),
    .req_in(master_1_req),
    .addr_in(master_1_addr),
    .cmd_in(master_1_cmd),
    .wdata_in(master_1_wdata),
    .ack_in(master_1_ack),
    .rdata_in(master_1_rdata),

    .req_out_first(mux_arb_10_req),
    .wdata_out_first(mux_arb_10_wdata),
    .addr_out_first(mux_arb_10_addr),
    .cmd_out_first(mux_arb_10_cmd),
    .ack_out_first(mux_arb_10_ack),
    .rdata_out_first(mux_arb_10_rdata),

    .req_out_second(mux_arb_11_req),
    .wdata_out_second(mux_arb_11_wdata),
    .addr_out_second(mux_arb_11_addr),
    .cmd_out_second(mux_arb_11_cmd),
    .ack_out_second(mux_arb_11_ack),
    .rdata_out_second(mux_arb_11_rdata)

);


wire [1:0] grant_0, grant_1;

arbiter_v2 #( .N(2)) a0
(
    .rst(rst),
    .req({mux_arb_00_req,mux_arb_10_req}),
    .grant(grant_0),
    .ack_in(slave_0_ack)

);


arbiter_v2 #( .N(2)) a1
(
    .rst(rst),
    .req({mux_arb_01_req,mux_arb_11_req}),
    .grant(grant_1),
    .ack_in(slave_1_ack)

);

mux_slave ms0
(
.rst             (rst          )   ,
.req_out         (slave_0_req  )   ,
.addr_out        (slave_0_addr )   ,
.cmd_out         (slave_0_cmd  )   ,
.wdata_out       (slave_0_wdata)   ,
.ack_out         (slave_0_ack  )   ,
.rdata_out       (slave_0_rdata)   ,
.addr_in_first   (mux_arb_00_addr) ,
.wdata_in_first  (mux_arb_00_wdata),
.cmd_in_first    (mux_arb_00_cmd)  ,
.req_in_first    (mux_arb_00_req)  ,
.ack_in_first    (mux_arb_00_ack)  ,
.rdata_in_first  (mux_arb_00_rdata),
.addr_in_second  (mux_arb_10_addr) ,
.wdata_in_second (mux_arb_10_wdata),
.cmd_in_second   (mux_arb_10_cmd)  ,
.req_in_second   (mux_arb_10_req)  ,
.ack_in_second   (mux_arb_10_ack)  ,
.rdata_in_second (mux_arb_10_rdata),
.grant           (grant_0)         
);

mux_slave ms1
(   .rst             (rst          )   ,
    .req_out         (slave_1_req  )   ,
    .addr_out        (slave_1_addr )   ,
    .cmd_out         (slave_1_cmd  )   ,
    .wdata_out       (slave_1_wdata)   ,
    .ack_out         (slave_1_ack  )   ,
    .rdata_out       (slave_1_rdata)   ,
    .addr_in_first   (mux_arb_01_addr) ,
    .wdata_in_first  (mux_arb_01_wdata),
    .cmd_in_first    (mux_arb_01_cmd)  ,
    .req_in_first    (mux_arb_01_req)  ,
    .ack_in_first    (mux_arb_01_ack)  ,
    .rdata_in_first  (mux_arb_01_rdata),
    .addr_in_second  (mux_arb_11_addr) ,
    .wdata_in_second (mux_arb_11_wdata),
    .cmd_in_second   (mux_arb_11_cmd)  ,
    .req_in_second   (mux_arb_11_req)  ,
    .ack_in_second   (mux_arb_11_ack)  ,
    .rdata_in_second (mux_arb_11_rdata),
    .grant           (grant_1)         
);

endmodule
