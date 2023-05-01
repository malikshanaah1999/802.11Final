from myhdl import *
from encoder import encoder
def convert_encoder(hdl):

    Clock = Signal(bool(0))
    Reset = ResetSignal(0,active = 0,isasync =True)
    Input = Signal(bool(0))
    Output = Signal(bool(0))

    encd = encoder(Clock, Reset, Input, Output)
    encd.convert(hdl=hdl)

convert_encoder(hdl ='Verilog')