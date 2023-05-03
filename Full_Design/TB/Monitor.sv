class Monitor;

virtual _interface.rx output_intf;
mailbox rcvr2sb;


function new(virtual _interface.rx  vif,mailbox rcvr2sb);
   this.vif  = vif  ;
   if(rcvr2sb == null)
   begin
     $display(" **ERROR**: rcvr2sb is null");
     $finish;
   end
   else
   this.rcvr2sb = rcvr2sb;
endfunction 

task start;
    
    generator pkt;

    forever
    begin
        
        repeat(2) @(posedge output_intf.clock);
        
    end
endtask
endclass