`timescale 1ns/1ps
module master_slave ();

      logic        clk=0;       
      logic        ack  ;       
      logic        rst=0;       
      logic [31:0] rdata;       
      logic        req  ;       
      logic        cmd  ;       
      logic [31:0] wdata;       
      logic [31:0] addr ;       
      logic [ 7:0] counter=8'b0  ;
master #(.N(0)) m0 (
    .clk   (clk  ),
    .ack   (ack  ),
    .rst   (rst  ),
    .rdata (rdata),
    .req   (req  ),
    .cmd   (cmd  ),
    .wdata (wdata),
    .addr  (addr )
);
slave s0 (
    .clk   (clk  ),
    .ack   (ack  ),
    .rst   (rst  ),
    .rdata (rdata),
    .req   (req  ),
    .cmd   (cmd  ),
    .wdata (wdata),
    .addr  (addr )
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