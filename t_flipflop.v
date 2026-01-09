module moore_t (
    input clk,
    input reset,
    input x,
    output reg z
);
    reg q;

    always @(posedge clk or posedge reset) begin
        if (reset)
            q <= 1'b0;
        else if (x)
            q <= ~q;   // T = X
    end

    always @(*) begin
        z = q;
    end
endmodule
