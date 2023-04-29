// File: interleaver.v
// Generated by MyHDL 0.11
// Date: Tue Mar 28 13:51:24 2023


`timescale 1ns/10ps

module interleaver (
    Input,
    Reset,
    Clock,
    Output
);


input Input;
input Reset;
input Clock;
output Output;
reg Output;

reg [7:0] counter;
reg [1:0] i_row_IN;
reg [1:0] i_row_OUT;
reg [3:0] j_col_IN;
reg [3:0] j_col_OUT;
reg [3:0] MEM_IN [0:3-1];
reg [3:0] MEM_OUT [0:3-1];



always @(posedge Clock, negedge Reset) begin: INTERLEAVER_SAMPLE_SEQ
    if ((!Reset)) begin
        Output <= 0;
    end
    else begin
        Output <= MEM_OUT[i_row_OUT][j_col_OUT];
    end
end


always @(posedge Clock, negedge Reset) begin: INTERLEAVER_CONTROL_SEQ
    integer i;
    if ((!Reset)) begin
        j_col_IN <= 0;
        i_row_IN <= 0;
        for (i=0; i<3; i=i+1) begin
            MEM_IN[i] <= 0;
        end
        j_col_OUT <= 0;
        i_row_OUT <= 0;
        for (i=0; i<3; i=i+1) begin
            MEM_OUT[i] <= 0;
        end
        counter <= 1;
    end
    else begin
        counter <= (counter + 1);
        if ((counter == 48)) begin
            for (i=0; i<3; i=i+1) begin
                MEM_OUT[i] <= MEM_IN[i];
            end
            j_col_IN <= 0;
            i_row_IN <= 0;
            j_col_OUT <= 0;
            i_row_OUT <= 0;
            counter <= 1;
            MEM_OUT[i_row_IN][j_col_IN] <= Input;
        end
        else begin
            MEM_IN[i_row_IN][j_col_IN] <= Input;
            j_col_IN <= (j_col_IN + 1);
            if ((j_col_IN == 15)) begin
                i_row_IN <= (i_row_IN + 1);
            end
            i_row_OUT <= (i_row_OUT + 1);
            if (((i_row_OUT + 1) == 3)) begin
                j_col_OUT <= (j_col_OUT + 1);
                i_row_OUT <= 0;
            end
        end
    end
end

endmodule
