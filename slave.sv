`timescale 1ns/1ps
module slave #(parameter N=0) (
    input             clk,
    input             rst,
    output reg        ack,
    output reg [31:0] rdata,
    input             req,
    input             cmd,
    input      [31:0] wdata,
    input      [31:0] addr
);
reg [ 1:0] stage;
reg [ 3:0] counter;
reg [31:0] rdata_pre;
integer i=0 ;
int fd;
initial begin
    if (N ==0) begin
        fd=$fopen ("Slave_0_log.txt", "w");
     end
     else begin
         fd=$fopen ("Slave_1_log.txt", "w");
     i=0;
     end
    #5;
ack       = 1'b0;
rdata_pre = 32'b0;
rdata     = 32'b0;
stage     =  2'b0;
counter   =  3'b0;
   
end

always @ (posedge clk or negedge rst) begin
    if(rst == 1'b1) begin
        ack       <= 1'b0;
        rdata_pre <= 32'b0;
        rdata     <= 32'b0;
    end
    case (stage)
    2'b00: begin
        ack = 1'b0;
        if (req == 1'b1) begin
            stage = 2'b01;
        end
    end
    2'b01: begin
        ack =1'b1;
        rdata = (cmd == 1'b0) ? rdata_pre : 32'b0;
        #3;
        $fdisplay (fd, " Number of request: %d\n addr: %b\n cmd: %b\n wdata: %b\n rdata: %b\n\n\n\n", i, addr, cmd, wdata, rdata );
        stage = 2'b10;
    end
    2'b10: begin
        ack = 1'b0;
        rdata_pre      = rdata_pre + (1);
        #1;
        stage = 2'b00;
        if (i==5) begin
            $fclose(fd);
        end
        i=i+1;
    end
    endcase
end
endmodule