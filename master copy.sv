`timescale 1ns/1ps
module master1 #(parameter N = 0) (
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
       
        req = 1'b1;
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
            stage = 2'b10;
            req = 1'b1;
        end
    end
    2'b10: begin
        counter    = counter + 1'b1;
        addr  [31] = counter [1];
        addr       = addr + ((12'b110011100010)>>N);
        wdata_pre      = wdata_pre + (12'h345);
        cmd        = counter [0]; 
        req        = 1'b0;
        stage = 2'b00;
    end
    endcase
end
endmodule