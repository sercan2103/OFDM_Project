`timescale 1ns/1ps

module equalizer_tb;
`include "common_params.v"

reg clock;
reg reset;
reg enable;

reg [31:0] sample_in;
reg sample_in_strobe;
reg ht_next;
reg pkt_ht;
reg ht_smoothing;
reg disable_all_smoothing;
reg reset_dot11;

wire [31:0] phase_in_i;
wire [31:0] phase_in_q;
wire phase_in_stb;
reg [15:0] phase_out;
reg phase_out_stb;

wire [`ROTATE_LUT_LEN_SHIFT-1:0] rot_addr;
reg [31:0] rot_data;

wire [31:0] sample_out;
wire sample_out_strobe;

wire [3:0] state;

// Side channel outputs
wire [31:0] csi;
wire csi_valid;
wire o_csi_data_sbc_valid;
wire o_noiseEst_stb;
wire signed [31:0] o_noiseEst;

integer output_fd;
integer i;

// Instantiate the equalizer module
equalizer uut (
    .clock(clock),
    .enable(enable),
    .reset(reset),
    .reset_dot11(reset_dot11),
    
    .sample_in(sample_in),
    .sample_in_strobe(sample_in_strobe),
    .ht_next(ht_next),
    .pkt_ht(pkt_ht),
    .ht_smoothing(ht_smoothing),
    .disable_all_smoothing(disable_all_smoothing),
    
    .phase_in_i(phase_in_i),
    .phase_in_q(phase_in_q),
    .phase_in_stb(phase_in_stb),
    .phase_out(phase_out),
    .phase_out_stb(phase_out_stb),
    
    .rot_addr(rot_addr),
    .rot_data(rot_data),
    
    .sample_out(sample_out),
    .sample_out_strobe(sample_out_strobe),
    
    .state(state),
    
    .csi(csi),
    .csi_valid(csi_valid),
    .o_csi_data_sbc_valid(o_csi_data_sbc_valid),
    .o_noiseEst_stb(o_noiseEst_stb),
    .o_noiseEst(o_noiseEst)
);

// Clock generation
initial begin
    clock = 0;
    forever #5 clock = ~clock; // 100 MHz clock
end

// Rotation LUT simulation (simplified)
always @(posedge clock) begin
    // Simple rotation table - would need proper implementation
    rot_data <= {16'h7FFF, 16'h0000}; // Example: phase 0
end

// Phase calculation simulation (simplified)
always @(posedge clock) begin
    if (reset) begin
        phase_out <= 0;
        phase_out_stb <= 0;
    end else if (phase_in_stb) begin
        // Simplified phase calculation
        phase_out <= 16'h0000;
        phase_out_stb <= 1;
    end else begin
        phase_out_stb <= 0;
    end
end

// Test stimulus
initial begin
    // Initialize signals
    reset = 1;
    enable = 0;
    sample_in = 0;
    sample_in_strobe = 0;
    ht_next = 0;
    pkt_ht = 0;
    ht_smoothing = 0;
    disable_all_smoothing = 0;
    reset_dot11 = 0;
    phase_out = 0;
    phase_out_stb = 0;
    
    // Open output file
    output_fd = $fopen("equalizer_sim_out.txt", "w");
    
    // Wait for some time
    #100;
    
    // Release reset
    reset = 0;
    enable = 1;
    
    #50;
    
    // Send some test LTS samples (first LTS)
    for (i = 0; i < 64; i = i + 1) begin
        @(posedge clock);
        sample_in = {16'h1000, 16'h0800}; // Example I/Q values
        sample_in_strobe = 1;
        @(posedge clock);
        sample_in_strobe = 0;
    end
    
    #100;
    
    // Send second LTS
    for (i = 0; i < 64; i = i + 1) begin
        @(posedge clock);
        sample_in = {16'h1000, 16'h0800}; // Example I/Q values
        sample_in_strobe = 1;
        @(posedge clock);
        sample_in_strobe = 0;
    end
    
    // Wait for equalization to complete
    #1000;
    
    $fclose(output_fd);
    $display("Simulation completed");
    $finish;
end

// Monitor outputs
always @(posedge clock) begin
    if (sample_out_strobe) begin
        $fdisplay(output_fd, "OUT: I=%h Q=%h", sample_out[31:16], sample_out[15:0]);
        $display("[%0t] EQ OUT: I=%h Q=%h State=%d", $time, sample_out[31:16], sample_out[15:0], state);
    end
    
    if (csi_valid) begin
        $display("[%0t] CSI: %h", $time, csi);
    end
end

endmodule
