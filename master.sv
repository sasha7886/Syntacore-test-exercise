`timescale 1ns/1ps
module master #(parameter N = 0) (
    input             clk  ,
    input             ack  ,
    input             rst  ,
    input      [31:0] rdata,
    output reg        req  ,
    output reg        cmd  ,
    output reg [31:0] wdata,
    output reg [31:0] addr
);
reg [ 1:0] stage;
reg [ 3:0] counter;
reg [31:0] wdata_pre;
logic [65:0] testvectors [5:0];
integer i=0;
int fd;
initial begin
$readmemb ("top_testvectors.tv", testvectors);
if (N ==0) begin
   fd=$fopen ("Master_0_log.txt", "w");
end
else begin
    fd=$fopen ("Master_1_log.txt", "w");
i=0;
end
end
always @ (posedge clk or negedge rst) begin
    if(rst == 1'b1) begin
        wdata     <= 32'b0;
        wdata_pre <= 32'b0;
        addr      <= 32'b0;
        stage     <=  2'b0;
        req       <=  1'b0;
        counter   <=  3'b0;
        cmd       <=  1'b0;
    end
    case (stage)
    2'b00: begin
       
        req       = testvectors[i][65]   ;
        addr      = testvectors[i][64:33];
        cmd       = testvectors[i][32]   ;
        wdata_pre = testvectors[i][31:0] ;
        #1;
        if (cmd == 1'b1) begin
            wdata = wdata_pre;
        end
        else begin
            wdata = 32'b0;
        end 
        if (ack == 1'b1) begin
            
            stage = 2'b01;
            req = 1'b1;
            
        end
    end
    2'b01: begin
       
        if(ack == 1'b0) begin
            $fdisplay (fd, " Number of request: %d\n addr: %b\n cmd: %b\n wdata: %b\n rdata: %b\n\n\n\n", i, addr, cmd, wdata, rdata );
            stage = 2'b10;
            req = 1'b1;
        end
    end
    2'b10: begin
        if (i == 5) begin
            $fclose(fd);
        end
        i = i + 1;
        req        = 1'b0;
        stage = 2'b00;
    end
    endcase
end
endmodule