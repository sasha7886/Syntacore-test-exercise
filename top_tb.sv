`timescale 1ns/10ps
module top_tb();

logic         rst=0;
logic         master_0_req;  
logic  [31:0] master_0_addr; 
logic  [31:0] master_0_wdata;
logic         master_0_cmd;  
logic [31:0]  master_0_rdata; 
logic         master_0_ack;  



logic         master_1_req;  
logic  [31:0] master_1_addr; 
logic  [31:0] master_1_wdata;
logic         master_1_cmd;  
logic [31:0]  master_1_rdata; 
logic         master_1_ack;  



logic         slave_0_req;  
logic  [31:0] slave_0_addr;  
logic  [31:0] slave_0_wdata; 
logic         slave_0_cmd;  
logic  [31:0] slave_0_rdata; 
logic         slave_0_ack;  



logic         slave_1_req;    
logic  [31:0] slave_1_addr;   
logic  [31:0] slave_1_wdata;  
logic         slave_1_cmd;    
logic  [31:0] slave_1_rdata;   
logic         slave_1_ack;  

logic         clk=0;
logic  [16:0] counter =17'b0;

/*logic  [31:0] slave_0_req_exp   ;
logic  [31:0] slave_0_addr_exp  ;
logic  [31:0] slave_0_wdata_exp ;
logic  [31:0] slave_0_cmd_exp   ;

logic  [31:0] slave_1_req_exp   ;
logic  [31:0] slave_1_addr_exp  ;
logic  [31:0] slave_1_wdata_exp ;
logic         slave_1_cmd_exp   ;

logic  [31:0] master_0_rdata_exp;
logic         master_0_ack_exp  ;
logic  [31:0] master_1_rdata_exp;
logic         master_1_ack_exp  ;*/





top uud (
.rst            (rst           ),
.master_0_req   (master_0_req  ),
.master_0_addr  (master_0_addr ),
.master_0_wdata (master_0_wdata),
.master_0_cmd   (master_0_cmd  ),
.master_0_rdata (master_0_rdata),
.master_0_ack   (master_0_ack  ),  


.master_1_req   (master_1_req  ),
.master_1_addr  (master_1_addr ),
.master_1_wdata (master_1_wdata),
.master_1_cmd   (master_1_cmd  ),
.master_1_rdata (master_1_rdata),
.master_1_ack   (master_1_ack  ), 



.slave_0_req    (slave_0_req   ),
.slave_0_addr   (slave_0_addr  ),
.slave_0_wdata  (slave_0_wdata ),
.slave_0_cmd    (slave_0_cmd   ),
.slave_0_rdata  (slave_0_rdata     ),
.slave_0_ack    (slave_0_ack       ), 


.slave_1_req    (slave_1_req  ),
.slave_1_addr   (slave_1_addr ),
.slave_1_wdata  (slave_1_wdata),
.slave_1_cmd    (slave_1_cmd  ),
.slave_1_rdata  (slave_1_rdata     ),
.slave_1_ack    (slave_1_ack       )
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
    if (counter[4] == 1) begin
        $stop;
    end
end

    master #(.N(0)) mas0
    (
      .clk   (clk), 
      .ack   (master_0_ack),
      .rst   (rst),
      .rdata (master_0_rdata),
      .req   (master_0_req),
      .cmd   (master_0_cmd),
      .wdata (master_0_wdata),
      .addr  (master_0_addr)

    );

    master #(.N(2)) mas1
    (
       .clk   (clk),  
       .ack   (master_1_ack),
       .rst   (rst),
       .rdata (master_1_rdata),
       .req   (master_1_req),
       .cmd   (master_1_cmd),
       .wdata (master_1_wdata),
       .addr  (master_1_addr)

    );

    slave s0(
       .clk   (clk),
       .rst   (rst),
       .ack   (slave_0_ack),
       .rdata (slave_0_rdata),
       .req   (slave_0_req),
       .cmd   (slave_0_cmd),
       .wdata (slave_0_wdata),
       .addr  (slave_0_addr)
    );

    slave s1(
       .clk   (clk),
       .rst   (rst),
       .ack   (slave_1_ack),
       .rdata (slave_1_rdata),
       .req   (slave_1_req),
       .cmd   (slave_1_cmd),
       .wdata (slave_1_wdata),
       .addr  (slave_1_addr)
    );

endmodule 
