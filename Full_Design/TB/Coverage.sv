class coverage;
  
generator pkt;

covergroup cov;

  data_in : coverpoint pkt.Input;

endgroup

function new();
  cov = new();
endfunction 

task sample(generator pkt);
 this.pkt = pkt;
 cov.sample();
endtask

endclass





