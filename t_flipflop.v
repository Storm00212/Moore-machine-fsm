// This module implements a Moore machine finite state machine using T flip-flop logic.
// It uses a single state bit 'q' to represent the state.
// The output 'z' is directly equal to the current state (characteristic of Moore machines).
// State transitions occur on the rising edge of the clock or asynchronously on reset.
// If reset is asserted, the state resets to 0.
// Otherwise, if the input x is 1, the state toggles (q = ~q); if x is 0, the state holds.
module moore_t (
    // clk: Clock input signal. State changes are synchronized to the positive edge of this clock.
    input clk,
    // reset: Asynchronous reset input. When high, immediately sets the state to 0, regardless of clock.
    input reset,
    // x: Primary input signal. Acts as the toggle enable: if x=1, state toggles on clock edge; if x=0, state holds.
    input x,
    // z: Output signal. In Moore machine, output depends only on current state, so z = q.
    output reg z
);
    // q: Internal state register. Holds the current state of the FSM (1-bit, so two possible states: 0 or 1).
    reg q;

    // State transition logic block. Sensitive to positive edge of clk or positive edge of reset.
    // This implements asynchronous reset and synchronous state update based on T flip-flop behavior.
    always @(posedge clk or posedge reset) begin
        if (reset)
            q <= 1'b0;  // Asynchronous reset: force state to 0
        else if (x)
            q <= ~q;    // Synchronous toggle: if x=1, invert q (T flip-flop action); if x=0, q remains unchanged
    end

    // Output logic block. Combinational, triggered whenever inputs change (but here, only depends on q).
    // In Moore machines, outputs are a function of the current state only.
    always @(*) begin
        z = q;  // Assign the output z to the current state value q
    end
endmodule
