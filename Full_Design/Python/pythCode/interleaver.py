from myhdl import *
N_CBPS = 48
N_COLS = 16
N_ROWS = N_CBPS / 16
@block
def interleaver( Input, Reset , Clock ,Output):

    j_col_IN = Signal(intbv(0)[4:])
    i_row_IN = Signal(intbv(0)[2:])
    MEM_IN = [Signal(intbv(0)[4:]) for i in range(3)]
    j_col_OUT = Signal(intbv(0)[4:])
    i_row_OUT = Signal(intbv(0)[2:])
    MEM_OUT = [Signal(intbv(0)[4:]) for i in range(3)]
    counter = Signal(intbv(0)[8:])

    @always(Clock.posedge , Reset.negedge)
    def control_seq():
        if not Reset:

            j_col_IN.next = 0
            i_row_IN.next = 0
            for i in range(3):
                MEM_IN[i].next = 0
            j_col_OUT.next = 0
            i_row_OUT.next = 0
            for i in range(3):
                MEM_OUT[i].next = 0
            counter.next = 1

        else :
            counter.next = counter + 1
            if counter == N_CBPS :

                for i in range(3):
                    MEM_OUT[i].next = MEM_IN[i]

                j_col_IN.next = 0
                i_row_IN.next = 0
                j_col_OUT.next = 0
                i_row_OUT.next = 0
                counter.next = 1
                MEM_OUT[i_row_IN][j_col_IN].next = Input

            else :

                MEM_IN[i_row_IN][j_col_IN].next = Input
                j_col_IN.next = j_col_IN + 1

                if j_col_IN == 0b1111 :
                    i_row_IN.next = i_row_IN + 1

                i_row_OUT.next = i_row_OUT + 1

                if (i_row_OUT + 1) == 3:
                    j_col_OUT.next = j_col_OUT + 1
                    i_row_OUT.next = 0



    @always(Clock.posedge , Reset.negedge)
    def sample_seq():
        if not Reset:

            Output.next = 0

        else:

            Output.next = MEM_OUT[i_row_OUT][j_col_OUT]



    return sample_seq , control_seq
