`timescale 1ns/100ps
module arbiter_v2
  #(
    parameter N = 2 
  )(
    input wire		    rst,
    input wire  [N-1:0] req,
    output wire [N-1:0]	grant,
    input wire         ack_in
  );

  reg  [N-1:0] pointer_req;
  

  wire [2*N-1:0] double_req = {req,req};
  wire [2*N-1:0] double_grant = double_req & ~(double_req - pointer_req);
  
  
  assign grant = double_grant[N-1:0] | double_grant[2*N-1:N];

  
  wire [N-1:0]   new_req = req ^ grant;
  wire [2*N-1:0] new_double_req = {new_req,new_req};
  wire [2*N-1:0] new_double_grant  = new_double_req & ~(new_double_req - pointer_req);
  wire [N-1:0]	 async_pointer_req =  new_double_grant[N-1:0] | new_double_grant[2*N-1:N];
  
  always @ (negedge ack_in)
    if (rst || async_pointer_req == 0)
      pointer_req <= #1 1;
    else	 
      pointer_req <= #1 async_pointer_req;


endmodule