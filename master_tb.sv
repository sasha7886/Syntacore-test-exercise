`timescale 1ns/1ps
module master_tb ();
logic clk =0; 
logic ack =0;
logic rst =0; 
logic [31:0] rdata =0;
logic req  ;
logic cmd  ;
logic [31:0] wdata;
logic [31:0] addr;
master #(.N(1)) uud (
     .clk   (clk),
     .ack   (ack),
     .rst   (rst),
     .rdata (rdata),
     .req   (req),
     .cmd   (cmd),
     .wdata (wdata),
     .addr  (addr)

);


always #1 clk =~clk;
initial begin
    #3;
    rst=1;
    #2;
    rst=0;
    ack=1;
    #2;
    ack=0;
    #2;
    ack=1;
    #3;
    #2;
    ack=0;
    #2;
    ack=1;
    #2;
    ack=1;
    #3;
    #2;
    ack=0;
    #2;
    #2;
    ack=1;
    #3;
    #2;
    ack=0;
    #2;
    #2;
    ack=1;
    #3;
    #2;
    ack=0;
    #2;
    $stop;
end
endmodule