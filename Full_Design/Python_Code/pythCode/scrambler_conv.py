from myhdl import Signal, ResetSignal
from scrambler import scrambler

def convert_inc(hdl):

    Clock = Signal(bool(0))
    Reset = ResetSignal(1,active=0,isasync=True)
    Input = Signal(bool(0))
    Output = Signal(bool(0))

    inc_1 = scrambler(Clock,  Reset, Input, Output)

    inc_1.convert(hdl=hdl)


convert_inc(hdl='Verilog')



