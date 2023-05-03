class Driver;

    virtual _interface.tx  input_intf;
    mailbox drvr2sb;
    generator pkt;
    
    // Constructor
    function new(_interface.tx   vif,mailbox drvr2sb);
        this.input_intf = vif  ;
        if(drvr2sb == null)
        begin
            $display(" **ERROR**: drvr2sb is null");
            $finish;
        end
        else
        this.drvr2sb = drvr2sb;
        pkt = new();
    endfunction 

    task start();
        logic [7:0] TX_DATA;
        repeat(number_of_bytes)
        begin
        if ( pkt.randomize())
            begin
                $display (" %0d : Driver : Randomization Successesfull.",$time);
                pkt.display();
            end
            
            @(posedge input_intf.clock);
            
            drvr2sb.put(pkt);
        end
    endtask
endclass