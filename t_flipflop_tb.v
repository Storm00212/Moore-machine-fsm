'timescale 1ns/1ps

module fsm_tb;
    
    reg clk;
    reg reset;
    reg x;
    wire z;


    //module

    moore_t uut(
        .clk(clk)
        .reset(reset)
        .x(x)
        .z(z)
    );

    //clock generation

    always #5 clk = ~clk;   // 10 ns clock period 
    //test sequence

    initial begin
        $dumpfile("d_ff_fsm.vcd");
        $dumpvars(0, fsm_tb);

        // Initialise

        clk=0;
        reset=1;
        x=0;

        #10 reset = 0;
         // Input sequence
        #10 x = 1;
        #10 x = 0;
        #10 x = 1;
        #10 x = 1;
        #10 x = 0;
        #10 x = 1;

        #20 $finish;
    end

endmodule