

interface _interface(input bit clock);

  logic    Input;
  logic    Reset; 
  logic    Output; 

  clocking cb@(posedge clock);
     default input #1 output #1;
     output    Start;
     output    Input;
     input     Output;
  endclocking
  
  modport tx(clocking cb,output Reset,input clock);
  modport rx(input Start,input Reset,input clock);
  
endinterface

