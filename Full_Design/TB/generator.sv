
class generator;

    rand logic Input;
    int compare;

    virtual function void display();
        $display("Data_TX = %h",TX_DATA );
    endfunction

    constraint ones_more{ Input dist{1 :=50 , 0 :=20};}; 
    constraint zeros_more{ Input dist{0 :=50 , 1 :=20};};

    virtual function bit compare(generator pkt);
    compare = 1;
    if(pkt == null)
    begin
        $display(" ** ERROR ** : pkt : received a null object ");
        compare = 0;
    end
    else
      begin
         if(pkt.Input !== this.Input)
         begin
            $display(" ** ERROR ** Data field did not match");
            compare = 0;
         end
      end
    endfunction


endclass