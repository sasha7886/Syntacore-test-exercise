module mux_slave
(
    output reg         req_out        ,
    output reg  [31:0] addr_out       ,
    output reg         cmd_out        ,
    output reg  [31:0] wdata_out      ,
    input           ack_out        ,
    input    [31:0] rdata_out      ,
    input    [31:0] addr_in_first  ,
    input    [31:0] wdata_in_first ,
    input           cmd_in_first   ,
    input           req_in_first   ,
    output reg         ack_in_first   ,
    output reg  [31:0] rdata_in_first ,
    input    [31:0] addr_in_second ,
    input    [31:0] wdata_in_second,
    input           cmd_in_second  ,
    input           req_in_second  ,
    output reg         ack_in_second  ,
    output reg  [31:0] rdata_in_second,
    input    [ 1:0] grant,
    input           rst          
);
 
// data_out_X  = {req|addr|cmd|wdata}
// data_in_X = {ack,rdata}
 
   always @* begin
       if (rst) begin
        req_out         =1'b0;
        addr_out        =32'b0;
        cmd_out         =1'b0;
        wdata_out       =32'b0;
        ack_in_first    = 1'b0;
        rdata_in_first  = 32'b0;
        ack_in_second   = 1'b0;
        rdata_in_second = 32'b0;
       end
       else begin
   case (grant)
   2'b10: begin
   req_out         = req_in_first;
   addr_out        = addr_in_first;
   cmd_out         = cmd_in_first;
   wdata_out       = wdata_in_first;
   rdata_in_first  = rdata_out;
   ack_in_first    = ack_out;
   //rdata_in_second = 32'b0;
   //ack_in_second   = 1'b0;
   
   end
   2'b01: begin
    req_out         = req_in_second;
    addr_out        = addr_in_second;
    cmd_out         = cmd_in_second;
    wdata_out       = wdata_in_second;
    rdata_in_second = rdata_out;
    ack_in_second   = ack_out;
    //rdata_in_first = 32'b0;
    //ack_in_first   = 1'b0;
    
   end
   endcase 
   end
end

endmodule