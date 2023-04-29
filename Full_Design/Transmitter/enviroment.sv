
`include "generator.sv"
`include "driver.sv"
`include "monitor.sv"
`include "scoreboard.sv"

class enviroment;
  
      generator gen;
      driver drv;
      monitor mon;
      scoreboard scb;

      mailbox m1;
      mailbox m2;
  	  virtual intf vif;
  
      function new(virtual intf vif);
        this.vif = vif;
        m1 = new();
        m2 = new();
        gen = new(m1);
        drv = new(m1, vif);
        mon = new(vif, m2);
        scb = new(m2);
      endfunction
  
      task test();
        fork
          gen.write();
          drv.main();
          mon.main();
          scb.main();
        join
      endtask
  
        task run;
          test();
          $finish;
        endtask
endclass