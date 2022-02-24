`timescale 1ns/1ps
module mux_master
(
    input             req_in  ,
    input      [31:0] addr_in ,
    input             cmd_in  ,
    input      [31:0] wdata_in,
    output reg        ack_in  ,
    output reg [31:0] rdata_in,
    
    
    
    output reg [31:0] addr_out_first ,
    output reg [31:0] wdata_out_first,
    output reg        cmd_out_first  ,
    output reg        req_out_first  ,
    input             ack_out_first  ,
    input      [31:0] rdata_out_first,
    
    
    output reg [31:0] addr_out_second ,
    output reg [31:0] wdata_out_second,
    output reg        cmd_out_second  ,
    output reg        req_out_second  ,
    input             ack_out_second  ,
    input      [31:0] rdata_out_second,
    input             rst

);

    always @* begin
        if (rst) begin
         addr_out_first  = 32'b0;
         wdata_out_first = 32'b0;
         cmd_out_first   =  1'b0;
         req_out_first   =  1'b0;
         addr_out_second = 32'b0;
         wdata_out_second= 32'b0;
         cmd_out_second  =  1'b0;
         req_out_second  =  1'b0;
         ack_in          =  1'b0;
         rdata_in        = 32'b0;
        end
        case (addr_in [31])
            1'b0: begin
                addr_out_first  = addr_in;
                wdata_out_first = wdata_in;
                cmd_out_first   = cmd_in;
                req_out_first   = req_in;
                addr_out_second = 32'b0;
                wdata_out_second= 32'b0;
                cmd_out_second  =  1'b0;
                req_out_second  =  1'b0;
                ack_in          = ack_out_first;
                rdata_in        = rdata_out_first;
        end
        1'b1: begin
            addr_out_first  = 32'b0;
            wdata_out_first = 32'b0;
            cmd_out_first   =  1'b0;
            req_out_first   =  1'b0;
            addr_out_second = addr_in; 
            wdata_out_second= wdata_in;
            cmd_out_second  = cmd_in;  
            req_out_second  = req_in;  
            ack_in          = ack_out_second;
            rdata_in        = rdata_out_second;
    end
        endcase
        
    end
endmodule

