module scrambler(Input, Reset, Clock, Output);

    input wire Input;
    input wire Reset;
    input wire Clock;
    output wire Output;

    parameter INITIAL_STATE = 7'b1111111;

    reg [7:1] state;
    wire feedback;

    assign feedback = state[7] ^ state[4]; 

    always @(posedge Clock, posedge Reset)
    begin
        if (Reset)
            state <= INITIAL_STATE;
        else
        begin
            state[7:5] <= state[6:4];
            state[4:1] <= {{state[3:1]}, {feedback}};
        end
    end

    assign Output = feedback ^ Input;
endmodule
