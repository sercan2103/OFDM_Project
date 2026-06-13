// iq_sample_fifo.v
//
// Single-pass write-then-read FIFO. Captures TX samples in write mode,
// then on rising tx_done switches to read mode for the receiver to
// drain. Lifted unchanged from the simulation testbench
// (ofdmTxRx.srcs/sources_1/new/iq_sample_fifo.v) so the proven
// behaviour is reused on hardware.
//
// One-shot per reset: cannot be re-armed without asserting reset.

module iq_sample_fifo #(
    parameter DATA_WIDTH = 32,
    parameter FIFO_DEPTH = 4096
) (
    input wire clk,
    input wire reset,

    // Write interface (connected to transmitter)
    input wire [DATA_WIDTH-1:0] wr_data,
    input wire wr_valid,
    output wire wr_ready,

    // Control interface
    input wire tx_done,
    output wire fifo_empty,
    output wire fifo_full,
    output reg [31:0] sample_count,

    // Read interface (connected to receiver)
    output reg [DATA_WIDTH-1:0] rd_data,
    input wire rd_ready,
    output reg rd_valid
);

    localparam ADDR_WIDTH = $clog2(FIFO_DEPTH);

    (* ram_style = "block" *) reg [DATA_WIDTH-1:0] memory [0:FIFO_DEPTH-1];

    reg [ADDR_WIDTH-1:0] wr_ptr;
    reg [ADDR_WIDTH-1:0] rd_ptr;
    reg write_mode;
    reg tx_done_reg;

    assign fifo_empty = (sample_count == 0);
    assign fifo_full  = (sample_count >= FIFO_DEPTH);
    assign wr_ready   = write_mode && !fifo_full;

    always @(posedge clk) begin
        if (reset) begin
            wr_ptr       <= 0;
            rd_ptr       <= 0;
            write_mode   <= 1;
            rd_valid     <= 0;
            sample_count <= 0;
            rd_data      <= 0;
            tx_done_reg  <= 0;
        end else begin
            tx_done_reg <= tx_done;

            if (tx_done && !tx_done_reg && write_mode) begin
                write_mode <= 0;
            end

            if (write_mode && wr_valid && !fifo_full) begin
                memory[wr_ptr] <= wr_data;
                wr_ptr         <= wr_ptr + 1;
                sample_count   <= sample_count + 1;
            end

            if (!write_mode && !fifo_empty) begin
                if (!rd_valid) begin
                    rd_data  <= memory[rd_ptr];
                    rd_valid <= 1;
                end else if (rd_ready) begin
                    rd_valid     <= 0;
                    rd_ptr       <= rd_ptr + 1;
                    sample_count <= sample_count - 1;
                end
            end else if (!write_mode && fifo_empty) begin
                rd_valid <= 0;
            end
        end
    end
endmodule
