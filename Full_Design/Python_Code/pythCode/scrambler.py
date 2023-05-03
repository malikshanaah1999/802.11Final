 
from myhdl import *

@block
def scrambler( Clock,  Reset, Input, Output):
    
    feedback = Signal(bool(0))
    state = Signal(intbv(0b1111111)[7:])

    @always_comb
    def comb_logic_feedback():

        feedback.next = state[6] ^ state[3]

    @always_comb
    def comb_logic_scramble_bit():

        Output.next = Input ^ feedback

    
    @always(Clock.posedge , Reset.negedge)
    def seq():

        if not Reset:
            state.next = 0b1111111
            
        else:
            state[7:5].next = state[6:4]
            state[4:1].next = state[3:1]
            state[0].next = feedback
            
            
    return seq , comb_logic_feedback , comb_logic_scramble_bit

    