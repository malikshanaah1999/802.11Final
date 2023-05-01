from myhdl import *


@block
def encoder(Clock, Reset, Input, Output):
    state = Signal(intbv(0)[7:])
    is_odd = Signal(bool(0))
    @always_comb
    def comb_logic():

        Output.next = state[1] ^ state[3] ^ state[4] ^ state[6] ^ state[7] if is_odd else state[1] ^ state[2] ^ state[3] ^ state[4] ^ state[7]

    @always(Clock.posedge, Reset.negedge)
    def seq():

        if not Reset:

            state.next = 0
            is_odd.next = 0
        else:

            state[6:0].next = state[6:0]
            state[6].next = Input

            is_odd.next = 1

    return seq, comb_logic

