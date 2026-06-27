module decoder_8_to_256 (
    input  [7:0] in,
    input        enable, 
    output [255:0] out
);
    // If enable is high, shift a single '1' to the position indicated by the input.
    // If enable is low, output all zeros.
    // This single line generates a massive, perfect 256-output logic tree in hardware.
    assign out = enable ? (256'b1 << in) : 256'b0;

endmodule
