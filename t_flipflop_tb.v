// Timescale directive: defines the time unit (1ns) and time precision (1ps) for the simulation.
// This affects how delays and timing are interpreted in the testbench.
`timescale 1ns/1ps

// Testbench module for the Moore T flip-flop FSM.
// This module simulates the behavior of the moore_t FSM by providing clock, reset, and input signals,
// and observing the output. It generates a VCD file for waveform viewing.
module fsm_tb;

    // Testbench signals:
    // clk: Clock signal, driven by the testbench to simulate timing.
    reg clk;
    // reset: Reset signal, used to initialize the FSM state.
    reg reset;
    // x: Input signal to the FSM, changed during simulation to test different scenarios.
    reg x;
    // z: Output signal from the FSM, monitored to verify correct behavior.
    wire z;

    // Instantiate the Unit Under Test (UUT): the moore_t module.
    // Connect the testbench signals to the FSM inputs and outputs.
    moore_t uut(
        .clk(clk),    // Connect clk to FSM clock input
        .reset(reset), // Connect reset to FSM reset input
        .x(x),        // Connect x to FSM input x
        .z(z)         // Connect z to FSM output z
    );

    // Clock generation block: Creates a periodic clock signal.
    // Toggles clk every 5 time units, resulting in a 10 time unit (10ns) period clock.
    // This simulates a 100MHz clock (since 1ns time unit, period 10ns = 100MHz).
    always #5 clk = ~clk;   // 10 ns clock period

    // Test sequence block: Defines the simulation timeline and input stimuli.
    // This initial block runs once at the start of simulation.
    initial begin
        // Set up waveform dumping for analysis.
        // $dumpfile: Specifies the output file for VCD (Value Change Dump) data.
        // $dumpvars: Dumps all variables in the fsm_tb module to the VCD file for viewing in a waveform viewer.
        $dumpfile("tfsm.vcd");
        $dumpvars(0, fsm_tb);

        // Initialize signals: Set initial values before starting the test.
        // clk starts at 0, reset is asserted (1), x is 0.
        clk=0;
        reset=1;
        x=0;

        // Wait 10 time units, then deassert reset to allow FSM to start operating.
        #10 reset = 0;

        // Apply input sequence: Change x at 10 time unit intervals to test FSM transitions.
        // Each #10 advances time by 10 units, allowing one clock cycle (since clock period is 10 units).
        #10 x = 1;  // Set x=1, expect state toggle on next clock
        #10 x = 0;  // Set x=0, state should hold
        #10 x = 1;  // Set x=1, toggle
        #10 x = 1;  // Set x=1, toggle
        #10 x = 0;  // Set x=0, hold
        #10 x = 1;  // Set x=1, toggle

        // Wait additional 20 time units, then finish the simulation.
        #20 $finish;
    end

endmodule