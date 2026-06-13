/*
 * Stage 2B-4 -- OFDM through axi_ad9361 BIST mode 1 loopback.
 *
 * Push real OFDM samples (from openofdm_tx) through the chip-internal
 * data-port loopback we proved in Stage 2B-3, and verify dot11 still
 * decodes them (fcs_ok=1, len=24 -- same payload as Stage 1C).
 *
 * HDL path (system_top.v after the 2B-4 update):
 *   openofdm_tx
 *     -> tx_cdc async FIFO (bb_clk -> l_clk)
 *     -> dac_data_i0/q0
 *     -> [chip BIST mode 1: TX data port -> RX data port]
 *     -> adc_data_i0/q0
 *     -> rx_cdc async FIFO (l_clk -> bb_clk)
 *     -> 10-cycle drain (same as Stage 1C)
 *     -> dot11
 *
 * gpio_o bit allocation:
 *   [32] phy_tx_start    -- pulse 1 -> 0 to fire one TX (1C-style trigger)
 *   [33] ad9361_resetb   -- driven by no-OS during init
 *   [34] ad9361_enable   -- driven high to take chip out of ALERT
 *   [35] ad9361_txnrx    -- TXNRX pin
 *   [40] bist_status_sel -- 0 = 1C-style decode counters on gpio_i,
 *                            1 = Stage 2B-3 BIST capture on gpio_i
 *   [41] bist_pat_mode   -- 0 = OFDM samples on dac_data (this stage),
 *                            1 = constants 0xCAFE/0xBABE (Stage 2B-3)
 *
 * Pass criterion: fcs_ok_count >= 1 AND last_pkt_len == 24, on
 * gpio_i with bist_status_sel = 0. Same as Stage 1B/1C.
 */

#include <inttypes.h>

#include "app_config.h"
#include "parameters.h"

#include "ad9361.h"
#include "ad9361_api.h"
#include "no_os_spi.h"
#include "no_os_gpio.h"
#include "no_os_delay.h"
#include "no_os_error.h"

#include "xilinx_spi.h"
#include "xilinx_gpio.h"

#include <xparameters.h>
#include "xil_io.h"
#include "xil_printf.h"
#include "xgpiops.h"
#include "sleep.h"

/* axi_ad9361 internal layout (info only). */
#define ADC_BASE_ADI    (AXI_AD9361_BASE + 0x0000UL)
#define DAC_BASE_ADI    (AXI_AD9361_BASE + 0x4000UL)
#define ADC_RD(off)     Xil_In32 (ADC_BASE_ADI + (off))
#define ADC_WR(off, v)  Xil_Out32(ADC_BASE_ADI + (off), (v))
#define DAC_RD(off)     Xil_In32 (DAC_BASE_ADI + (off))
#define DAC_WR(off, v)  Xil_Out32(DAC_BASE_ADI + (off), (v))

/* EMIO GPIO pin map (PS pin = MIO base 54 + EMIO bit). */
#define PIN_PHY_TX_START   86  /* gpio_o[32] */
#define PIN_AD9361_RESETB  87  /* gpio_o[33] -- driven by no-OS */
#define PIN_AD9361_ENABLE  88  /* gpio_o[34] */
#define PIN_AD9361_TXNRX   89  /* gpio_o[35] */
#define PIN_BIST_STATUS    94  /* gpio_o[40] -- keep 0 for 1C-style status */
#define PIN_BIST_PATTERN   95  /* gpio_o[41] -- keep 0 for OFDM-through-chip */
/* PS EMIO bit -> pin: PS pin = 54 + EMIO bit (gpio_o index). */
#define PIN_LATENCY_SEL_0 102  /* gpio_o[48] -- skip_target[0] */
#define PIN_LATENCY_SEL_1 103  /* gpio_o[49] -- skip_target[1] */
#define PIN_LATENCY_SEL_2 104  /* gpio_o[50] -- skip_target[2] */
#define PIN_POLARITY      96   /* gpio_o[42] -- TX polarity invert */
#define PIN_BYTE_VIEW     97   /* gpio_o[43] -- gpio_i = rx_byte_buf */
#define PIN_BYTE_BANK_0  105   /* gpio_o[51] -- byte read bank[0] */
#define PIN_BYTE_BANK_1  106   /* gpio_o[52] -- byte read bank[1] */
#define PIN_BYTE_BANK_2  107   /* gpio_o[53] -- byte read bank[2] */
#define PIN_BYTE_BANK_3  108   /* gpio_o[54] -- byte read bank[3] (4-bit, 16 banks) */
/* Runtime dot11 parameters (mirror system_top.v wiring): */
#define PIN_DOT11_SOFT_DEC      90  /* gpio_o[36] -- soft_decoding (default 1) */
#define PIN_DOT11_FORCE_HT      91  /* gpio_o[37] -- force_ht_smoothing (default 0) */
#define PIN_DOT11_DIS_SMOOTH    92  /* gpio_o[38] -- disable_all_smoothing (default 1) */
#define PIN_DOT11_THRESH_SCALE  93  /* gpio_o[39] -- threshold_scale (default 0) */
#define PIN_DOT11_FFT_WIN_0     98  /* gpio_o[44] -- fft_win_shift[0] */
#define PIN_DOT11_FFT_WIN_1     99  /* gpio_o[45] -- fft_win_shift[1] */
#define PIN_DOT11_FFT_WIN_2    100  /* gpio_o[46] -- fft_win_shift[2] */
#define PIN_DOT11_FFT_WIN_3    101  /* gpio_o[47] -- fft_win_shift[3] (default 0x1) */
#define PIN_DOT11_PLATEAU_0    109  /* gpio_o[55] -- min_plateau_sel[0] */
#define PIN_DOT11_PLATEAU_1    110  /* gpio_o[56] -- min_plateau_sel[1] (default 0x1 -> 100) */
#define PIN_DOT11_PWRTHR_0     111  /* gpio_o[57] -- power_thres_sel[0] */
#define PIN_DOT11_PWRTHR_1     112  /* gpio_o[58] -- power_thres_sel[1] (default 0x0 -> 0) */

/* AWGN channel control (gpio_o[59] and gpio_o[63:60]).
 * PS pin = 54 + EMIO bit index.
 * awgn_enable=0 is the default (bypass, no noise injected).
 * noise_shift: 4-bit right-shift on raw noise (σ_raw ≈ 9459).
 * SNR calibrated from measured BIST waterfall (BPSK 1/2 + Viterbi):
 *   shift=6 → σ≈ 148 → SNR≈ -9 dB  (all packets fail)
 *   shift=7 → σ≈  74 → SNR≈ -3 dB  (BIST: ~12% decode)
 *   shift=8 → σ≈  37 → SNR≈ +3 dB  (BIST: all decode; RF: near threshold)
 *   shift=9 → σ≈  18 → SNR≈ +9 dB  (RF: all decode)
 *   shift=12 → σ≈  2 → SNR≈+27 dB  (effectively noiseless)
 *   Each +1 step ≈ +6 dB SNR.
 */
#define PIN_AWGN_ENABLE        113  /* gpio_o[59] */
#define PIN_AWGN_SHIFT_0       114  /* gpio_o[60] */
#define PIN_AWGN_SHIFT_1       115  /* gpio_o[61] */
#define PIN_AWGN_SHIFT_2       116  /* gpio_o[62] */
#define PIN_AWGN_SHIFT_3       117  /* gpio_o[63] */

#define BANK_LO            2   /* gpio_i[31:0]  */
#define BANK_HI            3   /* gpio_i[63:32] */

/* ---- Platform glue for no-OS ---- */
static struct xil_spi_init_param  xil_spi_param  = { .type = SPI_PS,  .flags = 0 };
static struct xil_gpio_init_param xil_gpio_param = { .type = GPIO_PS, .device_id = GPIO_DEVICE_ID };

#define GPIO_OPS    &xil_gpio_ops
#define SPI_OPS     &xil_spi_ops
#define GPIO_PARAM  &xil_gpio_param
#define SPI_PARAM   &xil_spi_param

AD9361_InitParam default_init_param = {
    ID_AD9361, 40000000UL,
    0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    5, 6, 5, 0x28, 0x32, 0, MAX_SYNTH_FREF, 0,
    0, 0,
    2400000000UL, 2400000000UL, 1,
    {983040000, 245760000, 122880000, 61440000, 30720000, 30720000},
    {983040000, 122880000, 122880000, 61440000, 30720000, 30720000},
    18000000, 18000000,
    0, 0,
    10000, 0,
    0, {8, 5920}, CLKOUT_DISABLE,
    0, 0, 58, 4, 47, 8192, 0, 800, 704, 24, 15, 0,
    2, 2, 0, 0, 0,
    10, 2, 0, 10, 4, 3, 1000, 0, 0, 10, 1, 12, 1,
    10, 2, 10, 5, 2, 18, 2, 1, 0,
    64, 260, 0, 5, 1, 1, 5, 1, 1, 3, 0, 0, 1, 1, 5, 10,
    1, 1, 10, 8, 1, 1, 0, 0, 64, 2,
    1, 1000, 3, 0, 1,
    256, 40000000UL,
    1, 0,0,0,0,0,0, 0,0,0,0,0,0,
    256, 1000, 0xCE, 1,
    0xFF, 0,
    0,0,0,0,0,0,
    0, 0, 1, 1, 0, 0, 1, 0,
    0,0,0,0,0,0, 0, 1, 0, 0, 0, 0, 0, 0, 4, 7, 0, 150, 1, 0, 0xFF, 0x0F,
    0,0,0,0,0,0, 0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0,
    37000, 0, 24, 0, 0, 511, 8192, 2, 2, 48, 48,
    { .number = GPIO_RESET_PIN_ZED, .platform_ops = GPIO_OPS, .extra = GPIO_PARAM },
    { .number = -1, .platform_ops = NULL, .extra = NULL },
    { .number = -1, .platform_ops = NULL, .extra = NULL },
    { .number = -1, .platform_ops = NULL, .extra = NULL },
    {
        .device_id = SPI_DEVICE_ID, .mode = NO_OS_SPI_MODE_1,
        .chip_select = SPI_CS, .platform_ops = SPI_OPS, .extra = SPI_PARAM
    },
    NULL, NULL, NULL,
#ifndef AXI_ADC_NOT_PRESENT
    NULL, NULL,
#endif
};

static XGpioPs ps_gpio;

static int ps_gpio_init(void)
{
    XGpioPs_Config *cfg = XGpioPs_LookupConfig(XPAR_XGPIOPS_0_DEVICE_ID);
    if (!cfg) return -1;
    if (XGpioPs_CfgInitialize(&ps_gpio, cfg, cfg->BaseAddr) != XST_SUCCESS) return -1;

    /* phy_tx_start: drive 0 by default; pulse high to fire TX. */
    XGpioPs_SetDirectionPin   (&ps_gpio, PIN_PHY_TX_START, 1);
    XGpioPs_SetOutputEnablePin(&ps_gpio, PIN_PHY_TX_START, 1);
    XGpioPs_WritePin          (&ps_gpio, PIN_PHY_TX_START, 0);

    /* Mode selects: 0 = OFDM through chip + 1C-style status. */
    XGpioPs_SetDirectionPin   (&ps_gpio, PIN_BIST_STATUS, 1);
    XGpioPs_SetOutputEnablePin(&ps_gpio, PIN_BIST_STATUS, 1);
    XGpioPs_WritePin          (&ps_gpio, PIN_BIST_STATUS, 0);
    XGpioPs_SetDirectionPin   (&ps_gpio, PIN_BIST_PATTERN, 1);
    XGpioPs_SetOutputEnablePin(&ps_gpio, PIN_BIST_PATTERN, 1);
    XGpioPs_WritePin          (&ps_gpio, PIN_BIST_PATTERN, 0);

    /* All gpio_o EMIO outputs we drive: rate-adapter sweep, byte-view,
     * byte_bank (now 4 bits for 128 bytes), and runtime dot11 params. */
    int lpins[] = {
        PIN_LATENCY_SEL_0, PIN_LATENCY_SEL_1, PIN_LATENCY_SEL_2,
        PIN_POLARITY, PIN_BYTE_VIEW,
        PIN_BYTE_BANK_0, PIN_BYTE_BANK_1, PIN_BYTE_BANK_2, PIN_BYTE_BANK_3,
        PIN_DOT11_SOFT_DEC, PIN_DOT11_FORCE_HT, PIN_DOT11_DIS_SMOOTH,
        PIN_DOT11_THRESH_SCALE,
        PIN_DOT11_FFT_WIN_0, PIN_DOT11_FFT_WIN_1,
        PIN_DOT11_FFT_WIN_2, PIN_DOT11_FFT_WIN_3,
        PIN_DOT11_PLATEAU_0, PIN_DOT11_PLATEAU_1,
        PIN_DOT11_PWRTHR_0,  PIN_DOT11_PWRTHR_1
    };
    for (int i = 0; i < (int)(sizeof(lpins) / sizeof(lpins[0])); i++) {
        XGpioPs_SetDirectionPin   (&ps_gpio, lpins[i], 1);
        XGpioPs_SetOutputEnablePin(&ps_gpio, lpins[i], 1);
        XGpioPs_WritePin          (&ps_gpio, lpins[i], 0);
    }

    /* AWGN channel pins: default to disabled (no noise). */
    int awgn_pins[] = {
        PIN_AWGN_ENABLE,
        PIN_AWGN_SHIFT_0, PIN_AWGN_SHIFT_1, PIN_AWGN_SHIFT_2, PIN_AWGN_SHIFT_3
    };
    for (int i = 0; i < 5; i++) {
        XGpioPs_SetDirectionPin   (&ps_gpio, awgn_pins[i], 1);
        XGpioPs_SetOutputEnablePin(&ps_gpio, awgn_pins[i], 1);
        XGpioPs_WritePin          (&ps_gpio, awgn_pins[i], 0);
    }

    /* dot11 parameter defaults that reproduce the old hardcoded HDL: */
    XGpioPs_WritePin(&ps_gpio, PIN_DOT11_SOFT_DEC,    1); /* soft_decoding=1 */
    XGpioPs_WritePin(&ps_gpio, PIN_DOT11_FORCE_HT,    0);
    XGpioPs_WritePin(&ps_gpio, PIN_DOT11_DIS_SMOOTH,  1); /* disable_all_smoothing=1 */
    XGpioPs_WritePin(&ps_gpio, PIN_DOT11_THRESH_SCALE,0);
    /* fft_win_shift = 4'b0001 */
    XGpioPs_WritePin(&ps_gpio, PIN_DOT11_FFT_WIN_0, 1);
    /* min_plateau_sel = 2'b01 -> 100 */
    XGpioPs_WritePin(&ps_gpio, PIN_DOT11_PLATEAU_0, 1);
    /* power_thres_sel = 2'b00 -> 0 (already zero) */

    /* AD9361 ENABLE / TXNRX (driven high after force-FDD below). */
    XGpioPs_SetDirectionPin   (&ps_gpio, PIN_AD9361_ENABLE, 1);
    XGpioPs_SetOutputEnablePin(&ps_gpio, PIN_AD9361_ENABLE, 1);
    XGpioPs_WritePin          (&ps_gpio, PIN_AD9361_ENABLE, 0);
    XGpioPs_SetDirectionPin   (&ps_gpio, PIN_AD9361_TXNRX, 1);
    XGpioPs_SetOutputEnablePin(&ps_gpio, PIN_AD9361_TXNRX, 1);
    XGpioPs_WritePin          (&ps_gpio, PIN_AD9361_TXNRX, 1);
    return 0;
}

static void configure_adc_dac_cores(void)
{
    /* Same bring-up as Stage 2B-2 / 2B-3. */
    ADC_WR(0x0040, 0x0); ADC_WR(0x0040, 0x3); usleep(1000);
    ADC_WR(0x0044, 0x4);
    ADC_WR(0x0400, 0x51); ADC_WR(0x0440, 0x51);
    ADC_WR(0x0480, 0x51); ADC_WR(0x04C0, 0x51);
    usleep(100000);
    ADC_WR(0x0404, 0x2); ADC_WR(0x0444, 0x2);
    ADC_WR(0x0484, 0x2); ADC_WR(0x04C4, 0x2);

    DAC_WR(0x0040, 0x0); DAC_WR(0x0040, 0x3); usleep(1000);
    DAC_WR(0x0048, DAC_RD(0x0048) | (1 << 5));
    DAC_WR(0x0400, 0x0); DAC_WR(0x0404, 0x0);
    DAC_WR(0x0440, 0x0); DAC_WR(0x0444, 0x0);
    DAC_WR(0x0418, 0x2); DAC_WR(0x0458, 0x2);
    DAC_WR(0x0498, 0x2); DAC_WR(0x04D8, 0x2);
    DAC_WR(0x0044, 0x1); usleep(1000);
}

static void trigger_tx(void)
{
    XGpioPs_WritePin(&ps_gpio, PIN_PHY_TX_START, 1);
    usleep(10);
    XGpioPs_WritePin(&ps_gpio, PIN_PHY_TX_START, 0);
}

static void set_latency_sel(int sel)
{
    XGpioPs_WritePin(&ps_gpio, PIN_LATENCY_SEL_0, (sel >> 0) & 1);
    XGpioPs_WritePin(&ps_gpio, PIN_LATENCY_SEL_1, (sel >> 1) & 1);
    XGpioPs_WritePin(&ps_gpio, PIN_LATENCY_SEL_2, (sel >> 2) & 1);
    usleep(100);
}

static int skip_count_from_sel(int sel)
{
    /* HDL skip_target is the raw 3-bit gpio value: skip N adc_valids. */
    return sel & 7;
}

static void read_status(uint32_t *lo, uint32_t *hi)
{
    *lo = XGpioPs_Read(&ps_gpio, BANK_LO);
    *hi = XGpioPs_Read(&ps_gpio, BANK_HI);
}

static void print_status(const char *tag, uint32_t lo, uint32_t hi)
{
    uint8_t  fcs_ok      = (lo >>  0) & 0xFF;
    uint8_t  bad_pkt     = (lo >>  8) & 0xFF;
    uint8_t  hdr_valid   = (lo >> 16) & 0xFF;
    uint8_t  pkt_rate    = (lo >> 24) & 0xFF;
    uint16_t pkt_len     = (hi >>  0) & 0xFFFF;
    uint16_t byte_count  = (hi >> 16) & 0xFFFF;
    xil_printf("[%s] gpio_i=0x%08x_%08x\r\n", tag, hi, lo);
    xil_printf("       fcs_ok=%d  bad_pkt=%d  hdr_valid=%d\r\n",
               fcs_ok, bad_pkt, hdr_valid);
    xil_printf("       last_pkt_rate=0x%02x  last_pkt_len=%d  last_byte_count=%d\r\n",
               pkt_rate, pkt_len, byte_count);
}

/* PSDU layout for the 100-byte packet (matches tx_packet_rom.v):
 *   bytes  0..95: payload from Memory[2..13] = 0x09..0x68 (sequential)
 *   bytes 96..99: FCS (CRC-32 auto-computed by openofdm_tx)
 *
 * BER comparison uses bytes 0..95 (data). The HDL fcs_ok flag is the
 * authoritative FCS check; we don't hardcode the expected CRC-32 here.
 */
#define PSDU_BYTES   100
#define DATA_BYTES   96
#define FCS_BYTES_N    4

static const uint8_t expected_bytes[DATA_BYTES] = {
    0x09, 0x0A, 0x0B, 0x0C, 0x0D, 0x0E, 0x0F, 0x10,  /* Memory[2] */
    0x11, 0x12, 0x13, 0x14, 0x15, 0x16, 0x17, 0x18,  /* Memory[3] */
    0x19, 0x1A, 0x1B, 0x1C, 0x1D, 0x1E, 0x1F, 0x20,  /* Memory[4] */
    0x21, 0x22, 0x23, 0x24, 0x25, 0x26, 0x27, 0x28,  /* Memory[5] */
    0x29, 0x2A, 0x2B, 0x2C, 0x2D, 0x2E, 0x2F, 0x30,  /* Memory[6] */
    0x31, 0x32, 0x33, 0x34, 0x35, 0x36, 0x37, 0x38,  /* Memory[7] */
    0x39, 0x3A, 0x3B, 0x3C, 0x3D, 0x3E, 0x3F, 0x40,  /* Memory[8] */
    0x41, 0x42, 0x43, 0x44, 0x45, 0x46, 0x47, 0x48,  /* Memory[9] */
    0x49, 0x4A, 0x4B, 0x4C, 0x4D, 0x4E, 0x4F, 0x50,  /* Memory[10] */
    0x51, 0x52, 0x53, 0x54, 0x55, 0x56, 0x57, 0x58,  /* Memory[11] */
    0x59, 0x5A, 0x5B, 0x5C, 0x5D, 0x5E, 0x5F, 0x60,  /* Memory[12] */
    0x61, 0x62, 0x63, 0x64, 0x65, 0x66, 0x67, 0x68   /* Memory[13] */
};

static void set_byte_bank(int bank)
{
    XGpioPs_WritePin(&ps_gpio, PIN_BYTE_BANK_0, (bank >> 0) & 1);
    XGpioPs_WritePin(&ps_gpio, PIN_BYTE_BANK_1, (bank >> 1) & 1);
    XGpioPs_WritePin(&ps_gpio, PIN_BYTE_BANK_2, (bank >> 2) & 1);
    XGpioPs_WritePin(&ps_gpio, PIN_BYTE_BANK_3, (bank >> 3) & 1);
}

/* Read 104 bytes from rx_byte_buf via gpio_i_bytes view mode.
 * 13 banks of 8 bytes covers PSDU 0..103 (we only need first 100). */
static void read_rx_bytes(uint8_t out[PSDU_BYTES])
{
    uint8_t tmp[16 * 8];  /* worst case 128 bytes */
    XGpioPs_WritePin(&ps_gpio, PIN_BYTE_VIEW, 1);
    int needed_banks = (PSDU_BYTES + 7) / 8;  /* 13 for 100 bytes */
    for (int bank = 0; bank < needed_banks; bank++) {
        set_byte_bank(bank);
        usleep(10);
        uint32_t lo = XGpioPs_Read(&ps_gpio, BANK_LO);
        uint32_t hi = XGpioPs_Read(&ps_gpio, BANK_HI);
        tmp[bank*8 + 0] = (lo >>  0) & 0xFF;
        tmp[bank*8 + 1] = (lo >>  8) & 0xFF;
        tmp[bank*8 + 2] = (lo >> 16) & 0xFF;
        tmp[bank*8 + 3] = (lo >> 24) & 0xFF;
        tmp[bank*8 + 4] = (hi >>  0) & 0xFF;
        tmp[bank*8 + 5] = (hi >>  8) & 0xFF;
        tmp[bank*8 + 6] = (hi >> 16) & 0xFF;
        tmp[bank*8 + 7] = (hi >> 24) & 0xFF;
    }
    XGpioPs_WritePin(&ps_gpio, PIN_BYTE_VIEW, 0);
    set_byte_bank(0);
    for (int i = 0; i < PSDU_BYTES; i++) out[i] = tmp[i];
}

/* popcount8: count set bits in a byte. */
static uint8_t popcount8(uint8_t v)
{
    v = v - ((v >> 1) & 0x55);
    v = (v & 0x33) + ((v >> 2) & 0x33);
    return (v + (v >> 4)) & 0x0F;
}

/* Multi-packet stress, matching openofdm_transceiver_tb.v's NUM_PACKETS
 * loop (TB iterates STATE_IDLE -> TX -> RX -> IDLE for NUM_PACKETS).
 * Same idea here: trigger N packets back-to-back, track FCS pass/fail
 * per packet, and aggregate data-BER across all successful decodes.
 *
 * Counters in HDL (fcs_ok_count, bad_pkt_count) are 8-bit so we limit
 * NUM_PACKETS to keep the running total below 256 across an entire run
 * (BIST + RF + initial sweep triggers). 100 per stage is safe.
 *
 * Data is hardcoded ROM (vs TB's LFSR-randomized) -- same payload every
 * packet. That's fine for channel-error measurement (BER is symmetric);
 * randomization only matters for testing scrambler/interleaver paths.
 */
#define NUM_PACKETS 100

static void run_multi_packet(const char *tag, int n_packets)
{
    xil_printf("\r\n[%s multi-packet] sending %d packets...\r\n", tag, n_packets);

    /* Snapshot baseline counters. */
    uint32_t lo, hi;
    read_status(&lo, &hi);
    uint8_t fcs_baseline = (lo >>  0) & 0xFF;
    uint8_t bad_baseline = (lo >>  8) & 0xFF;

    int packets_ok        = 0;
    int packets_err       = 0;
    int total_bits_compared = 0;
    int total_bit_errors    = 0;

    for (int p = 0; p < n_packets; p++) {
        uint8_t fcs_pre = (XGpioPs_Read(&ps_gpio, BANK_LO) >> 0) & 0xFF;
        uint8_t bad_pre = (XGpioPs_Read(&ps_gpio, BANK_LO) >> 8) & 0xFF;

        trigger_tx();
        usleep(20000);  /* 20 ms -- 100-byte packet ~160 us + decode ~3 ms */

        uint8_t fcs_post = (XGpioPs_Read(&ps_gpio, BANK_LO) >> 0) & 0xFF;
        uint8_t bad_post = (XGpioPs_Read(&ps_gpio, BANK_LO) >> 8) & 0xFF;

        if (((fcs_post - fcs_pre) & 0xFF) == 1) {
            packets_ok++;
            uint8_t rx[PSDU_BYTES];
            read_rx_bytes(rx);
            for (int i = 0; i < DATA_BYTES; i++) {
                uint8_t d = rx[i] ^ expected_bytes[i];
                if (d) total_bit_errors += popcount8(d);
            }
            total_bits_compared += DATA_BYTES * 8;
        } else if (((bad_post - bad_pre) & 0xFF) == 1) {
            packets_err++;
        } else {
            packets_err++;
        }
    }

    /* Final summary, TB-style. */
    xil_printf("[%s multi-packet] results over %d packets:\r\n", tag, n_packets);
    xil_printf("       Packets decoded OK: %d\r\n", packets_ok);
    xil_printf("       Packets failed:     %d\r\n", packets_err);
    xil_printf("       PER (packet err rate): %d.%d%%\r\n",
               (packets_err * 100) / n_packets,
               ((packets_err * 1000) / n_packets) % 10);
    xil_printf("       Data bits checked:  %d\r\n", total_bits_compared);
    xil_printf("       Data bit errors:    %d\r\n", total_bit_errors);
    if (total_bits_compared > 0) {
        /* Print aggregate BER. Use 1e6 multiplier for resolution. */
        uint64_t ber_ppm = ((uint64_t)total_bit_errors * 1000000ULL) / total_bits_compared;
        xil_printf("       Aggregate data BER: %u.%04u%% (= %u ppm)\r\n",
                   (unsigned)(ber_ppm / 10000),
                   (unsigned)(ber_ppm % 10000),
                   (unsigned)ber_ppm);
    }

    /* Sanity: counter delta vs our own count. */
    read_status(&lo, &hi);
    uint8_t fcs_final = (lo >>  0) & 0xFF;
    uint8_t bad_final = (lo >>  8) & 0xFF;
    xil_printf("       HDL counter deltas: fcs_ok+%d  bad_pkt+%d\r\n",
               (fcs_final - fcs_baseline) & 0xFF,
               (bad_final - bad_baseline) & 0xFF);
}

/* Read RX bytes, compare to expected, print BER (TB-style: data only,
 * FCS verified by HDL fcs_ok). Returns # bit errors over data portion. */
static int check_ber(const char *tag)
{
    uint8_t rx[PSDU_BYTES];
    read_rx_bytes(rx);

    int data_byte_err = 0, data_bit_err = 0;

    xil_printf("[BER %s] data bytes 0..%d (FCS bytes %d..%d shown for info)\r\n",
               tag, DATA_BYTES - 1, DATA_BYTES, PSDU_BYTES - 1);

    xil_printf("       expected:");
    for (int i = 0; i < DATA_BYTES; i++) {
        if ((i & 15) == 0) xil_printf("\r\n          [%02d]:", i);
        xil_printf(" %02x", expected_bytes[i]);
    }
    xil_printf("\r\n       received:");
    for (int i = 0; i < DATA_BYTES; i++) {
        if ((i & 15) == 0) xil_printf("\r\n          [%02d]:", i);
        xil_printf(" %02x", rx[i]);
    }
    xil_printf("\r\n       diff    :");
    for (int i = 0; i < DATA_BYTES; i++) {
        if ((i & 15) == 0) xil_printf("\r\n          [%02d]:", i);
        uint8_t d = rx[i] ^ expected_bytes[i];
        xil_printf(" %02x", d);
        if (d) { data_byte_err++; data_bit_err += popcount8(d); }
    }
    xil_printf("\r\n       FCS bytes (rx): %02x %02x %02x %02x\r\n",
               rx[DATA_BYTES + 0], rx[DATA_BYTES + 1],
               rx[DATA_BYTES + 2], rx[DATA_BYTES + 3]);
    xil_printf("       Data BER: byte_err=%d/%d  bit_err=%d/%d  BER=%d.%03d%%\r\n",
               data_byte_err, DATA_BYTES, data_bit_err, DATA_BYTES * 8,
               (data_bit_err * 100) / (DATA_BYTES * 8),
               ((data_bit_err * 100000) / (DATA_BYTES * 8)) % 1000);
    return data_bit_err;
}

/* ------------------------------------------------------------------ */
/* AWGN channel control helpers                                        */
/* ------------------------------------------------------------------ */

static void awgn_set_enable(int en)
{
    XGpioPs_WritePin(&ps_gpio, PIN_AWGN_ENABLE, en ? 1 : 0);
}

/* noise_shift: 0-15.  0 = maximum noise (~-10 dB), 15 = near-zero noise. */
static void awgn_set_shift(int shift)
{
    shift &= 0xF;
    XGpioPs_WritePin(&ps_gpio, PIN_AWGN_SHIFT_0, (shift >> 0) & 1);
    XGpioPs_WritePin(&ps_gpio, PIN_AWGN_SHIFT_1, (shift >> 1) & 1);
    XGpioPs_WritePin(&ps_gpio, PIN_AWGN_SHIFT_2, (shift >> 2) & 1);
    XGpioPs_WritePin(&ps_gpio, PIN_AWGN_SHIFT_3, (shift >> 3) & 1);
}

/* Return empirically calibrated SNR in integer dB for a given shift value.
 *
 * Calibration: measured BIST waterfall (BPSK 1/2 + Viterbi) transitions at
 * shift=7 (87.9% PER) → shift=8 (0% PER). The theoretical BPSK 1/2 Viterbi
 * threshold is ~2-3 dB Eb/N0. Setting shift=8 → +3 dB anchors the scale.
 * Each +1 step in noise_shift halves σ_noise → +6 dB SNR.
 *
 * Note: the RF path has ~6 dB extra loss (analog impairments) so its
 * waterfall appears ~1 shift step higher than BIST. These values are
 * calibrated to the BIST (digital loopback) path.
 *
 * Key reference points:
 *   shift=2 → -33 dB  (all packets fail)
 *   shift=6 →  -9 dB  (all packets fail)
 *   shift=7 →  -3 dB  (near threshold: ~12% decode in BIST)
 *   shift=8 →  +3 dB  (above threshold: 100% decode in BIST)
 *   shift=9 →  +9 dB  (above threshold: ~99.9% decode in RF)
 *   shift=12 → +27 dB (effectively noiseless)
 */
static int awgn_shift_to_snr_db(int shift)
{
    return (shift - 8) * 6 + 3;
}

/* BER-vs-SNR sweep.
 *
 * Enables AWGN injection, sweeps noise_shift from shift_start to shift_end
 * (inclusive), sends n_packets at each SNR point, and prints a results table.
 *
 * Prerequisites: BIST/RF loopback alignment sweep (polarity + skip_target)
 * must have already found a working setting before calling this function.
 *
 * Timing: each packet waits 25 ms → n_packets=1000 takes ~25 s per shift
 * point. 11 points (shift 2..12) = ~275 s total ≈ 4.5 minutes.
 *
 * AWGN is automatically disabled and shift restored to 0 when the sweep ends.
 *
 * shift=2 (≈ +2 dB) is the lowest useful starting point — it is the closest
 * achievable shift value to 0 dB SNR. Packets at shift=2 are expected to
 * fail most of the time (BPSK 1/2 threshold ≈ 1.5-3 dB). This gives the
 * classic BER waterfall shape starting from 0 dB.
 */
static void run_ber_vs_snr(const char *tag, int shift_start, int shift_end,
                            int n_packets)
{
    xil_printf("\r\n=====================================================\r\n");
    xil_printf("  BER vs SNR sweep (%s)\r\n", tag);
    xil_printf("  SNR range: %d dB to %d dB  (shift %d..%d)\r\n",
               awgn_shift_to_snr_db(shift_start),
               awgn_shift_to_snr_db(shift_end),
               shift_start, shift_end);
    xil_printf("  Packets per point: %d\r\n", n_packets);
    xil_printf("  Estimated runtime: ~%d s\r\n",
               (shift_end - shift_start + 1) * n_packets * 25 / 1000);
    xil_printf("=====================================================\r\n");
    xil_printf("  shift | SNR(dB) |  OK pkts | Failed pkts |  PER   | eff.BER(ppm)\r\n");
    xil_printf("  Note: eff.BER counts failed pkts as 100%% bit loss + decoded bit errors.\r\n");
    xil_printf("  ------|---------|----------|-------------|--------|-------------\r\n");

    awgn_set_enable(1);

    for (int sh = shift_start; sh <= shift_end; sh++) {
        awgn_set_shift(sh);
        usleep(1000);  /* 1 ms: GPIO settles through CDC (2-FF sync, ~2 bb_clk) */

        int ok           = 0;
        int err          = 0;
        int total_bits   = 0;
        int total_errors = 0;

        for (int p = 0; p < n_packets; p++) {
            uint8_t fcs_pre = (XGpioPs_Read(&ps_gpio, BANK_LO) >> 0) & 0xFF;

            trigger_tx();
            usleep(25000);  /* 25 ms: packet ~160 us TX + ~3 ms decode + margin */

            uint8_t fcs_post = (XGpioPs_Read(&ps_gpio, BANK_LO) >> 0) & 0xFF;

            if (((fcs_post - fcs_pre) & 0xFF) == 1) {
                /* Packet decoded with valid FCS: read bytes and count bit errors. */
                ok++;
                uint8_t rx[PSDU_BYTES];
                read_rx_bytes(rx);
                for (int i = 0; i < DATA_BYTES; i++) {
                    uint8_t diff = rx[i] ^ expected_bytes[i];
                    if (diff) total_errors += popcount8(diff);
                }
                total_bits += DATA_BYTES * 8;
            } else {
                /* Packet lost (bad FCS or no sync): counts as all bits in error
                 * for PER but NOT added to bit-error count (BER is conditioned
                 * on successful header decode, matching openofdm_transceiver_tb). */
                err++;
            }
        }

        /* PER = failed / total, expressed as percent with one decimal place.
         * eff.BER = (bit errors in decoded pkts + DATA_BYTES*8 per failed pkt)
         *           / (DATA_BYTES*8 * n_packets).
         * Treating each failed packet as total bit loss gives the system-level
         * BER. When the Viterbi decoder succeeds it typically corrects all
         * errors (decoded BER≈0), so eff.BER tracks PER × 100% when below
         * threshold and drops to 0 (or residual errors) when above threshold. */
        int per_pct_x10 = (err * 1000) / n_packets;   /* tenths of a percent */
        uint64_t ber_eff_ppm = ((uint64_t)total_errors
                                + (uint64_t)err * DATA_BYTES * 8)
                               * 1000000ULL
                               / ((uint64_t)n_packets * DATA_BYTES * 8);

        xil_printf("  %d | %d dB | %d | %d | %d.%d%%  | %u\r\n",
                   sh,
                   awgn_shift_to_snr_db(sh),
                   ok, err,
                   per_pct_x10 / 10, per_pct_x10 % 10,
                   (unsigned)ber_eff_ppm);
    }

    awgn_set_enable(0);
    awgn_set_shift(0);
    xil_printf("  AWGN disabled (bypass restored).\r\n\r\n");
}

int main(void)
{
    struct ad9361_rf_phy *phy = NULL;
    int ret;

    xil_printf("\r\n=============================================\r\n");
    xil_printf("  Stage 2B-4 -- OFDM through axi_ad9361 (BIST mode 1)\r\n");
    xil_printf("=============================================\r\n");

    if (ps_gpio_init() != 0) {
        xil_printf("FATAL: PS GPIO init\r\n");
        while (1) sleep(5);
    }

    xil_printf("[ad9361] init...\r\n");
    ret = ad9361_init(&phy, &default_init_param);
    if (ret != 0 || phy == NULL) {
        xil_printf("\r\n  *** FAIL *** ad9361_init returned %d\r\n", ret);
        while (1) sleep(5);
    }
    xil_printf("[ad9361] init OK\r\n");

    /* ========================================================
     * Rate change to 40 MSPS (Path A precondition).
     *
     * Run 7 confirmed dot11 sees garbage at the chip's 30.72 MSPS
     * chain rate (rate=0x08, len=3902 deterministic across latency
     * sweep). dot11 expects 20 MSPS samples; 30.72/20 = 1.536x error
     * makes FFT bins land in wrong subcarriers.
     *
     * Fix path: configure chip at exactly 40 MSPS chain. Then a future
     * HDL change adds a 2:1 decimator on RX (40->20) and 1:2 zero-stuff
     * on TX (20->40), matching openwifi-hw's adc_intf.v / dac_intf.v
     * topology. This SW-only commit just verifies the chip can sit at
     * 40 MSPS with a clean l_clk lock; HDL stays unchanged for now so
     * BIST loopback will still fail (same garbage), but the diagnostic
     * counters and l_clk_hz will tell us the rate change actually took.
     *
     * ad9361_set_*_sampling_freq calls ad9361_calculate_rf_clock_chain
     * internally to derive the BBPLL/ADC/R-stage divisors -- no need
     * to hand-craft the path_clks array.
     * ======================================================== */
    xil_printf("[ad9361] requesting 40 MSPS chain (was 30.72)...\r\n");
    ret = ad9361_set_rx_sampling_freq(phy, 40000000);
    if (ret != 0) xil_printf("       set_rx_sampling_freq -> %d\r\n", ret);
    ret = ad9361_set_tx_sampling_freq(phy, 40000000);
    if (ret != 0) xil_printf("       set_tx_sampling_freq -> %d\r\n", ret);

    uint32_t actual_rx = 0, actual_tx = 0;
    ad9361_get_rx_sampling_freq(phy, &actual_rx);
    ad9361_get_tx_sampling_freq(phy, &actual_tx);
    xil_printf("       actual RX = %u Hz, TX = %u Hz\r\n",
               actual_rx, actual_tx);

    uint32_t rx_path_clks[6], tx_path_clks[6];
    ad9361_get_trx_path_clks(phy, rx_path_clks, tx_path_clks);
    xil_printf("       RX path clks = {%u, %u, %u, %u, %u, %u}\r\n",
               rx_path_clks[0], rx_path_clks[1], rx_path_clks[2],
               rx_path_clks[3], rx_path_clks[4], rx_path_clks[5]);
    xil_printf("       TX path clks = {%u, %u, %u, %u, %u, %u}\r\n",
               tx_path_clks[0], tx_path_clks[1], tx_path_clks[2],
               tx_path_clks[3], tx_path_clks[4], tx_path_clks[5]);

    if (actual_rx != 40000000 || actual_tx != 40000000) {
        xil_printf("\r\n  *** WARN *** chip did not land at exactly 40 MSPS.\r\n");
        xil_printf("              The driver picks the closest achievable rate.\r\n");
        xil_printf("              Continuing -- check l_clk_hz below.\r\n\r\n");
    } else {
        xil_printf("       OK -- chip at 40 MSPS chain.\r\n");
    }

    ad9361_set_rx_rf_gain    (phy, 0, 10);
    ad9361_set_tx_attenuation(phy, 0, 30000);
    configure_adc_dac_cores();

    /* Read l_clk frequency post-rate-change. axi_ad9361 reg 0x54 is
     * a count of l_clk pulses per ~65536 ref-clk-100MHz cycles, so
     * l_clk_hz ~= clk_count * 100e6 / 65536. Expected: 80 MHz at
     * 40 MSPS chain (was 61.44 MHz at 30.72). */
    uint32_t lclk_count = ADC_RD(0x0054);
    uint32_t lclk_hz_est = (lclk_count * 100000000ULL) / 65536ULL;
    xil_printf("[ad9361] l_clk count reg 0x54 = 0x%08x (~%u Hz, want ~80 MHz)\r\n",
               lclk_count, lclk_hz_est);

    xil_printf("[ad9361] enabling BIST mode 1 (chip data-port loopback)...\r\n");
    ret = ad9361_bist_loopback(phy, 1);
    if (ret != 0) {
        xil_printf("  *** FAIL *** ad9361_bist_loopback(1) returned %d\r\n", ret);
        while (1) sleep(5);
    }

    xil_printf("[ad9361] forcing chip into FDD...\r\n");
    XGpioPs_WritePin(&ps_gpio, PIN_AD9361_ENABLE, 1);
    ad9361_ensm_force_state(phy, ENSM_STATE_FDD);
    usleep(10000);
    int32_t r017 = ad9361_spi_read(phy->spi, 0x017);
    xil_printf("       0x017 STATE = 0x%02x  (ENSM bits[3:0] = 0x%X -- want 0xA=FDD)\r\n",
               r017 & 0xFF, r017 & 0xF);

    /* ========================================================
     * Bitstream verification probe.
     *
     * Flip gpio_o[41] (bist_pat_mode) high so the HDL mux drives
     * dac_data_i0 = 0xCAFE / dac_data_q0 = 0xBABE on the chip-side
     * LVDS bus. With chip in BIST mode 1 loopback, those should round-
     * trip to last_adc_i0 = 0xFCAF +/- a few (per the Stage 2B-3
     * result). If they don't, the bitstream is NOT the new 2B-4 one
     * (old bitstream tied dac_data_* to 0 via const_z16 -- there was
     * no mode mux to honour gpio_o[41]).
     *
     * Skip ahead past the OFDM probe if this fails -- means rebuild.
     * ======================================================== */
    xil_printf("\r\n[probe] verifying new bitstream via gpio_o[41]=1\r\n");
    XGpioPs_WritePin(&ps_gpio, PIN_BIST_PATTERN, 1);
    XGpioPs_WritePin(&ps_gpio, PIN_BIST_STATUS, 1);
    usleep(10000);
    {
        uint32_t plo, phi;
        read_status(&plo, &phi);
        uint16_t pat_i = plo & 0xFFFF;
        uint16_t pat_q = (plo >> 16) & 0xFFFF;
        xil_printf("       last_adc_i0=0x%04x (expect 0xFCAF+/-16 if NEW bitstream)\r\n", pat_i);
        xil_printf("       last_adc_q0=0x%04x (expect 0xFBAB+/-16)\r\n", pat_q);
        if (pat_i == 0x0000 && pat_q == 0x0000) {
            xil_printf("\r\n  *** STALE BITSTREAM ***\r\n");
            xil_printf("  Old bitstream still loaded. dac_data_* is tied to 0 in BD\r\n");
            xil_printf("  (const_z16 -- pre-2B-4 wiring), so the chip echoes 0 and\r\n");
            xil_printf("  the gpio_o[41] mode mux doesn't exist. Run vivado batch:\r\n");
            xil_printf("      cd v2/boards/zed_fmcs3 && vivado -mode batch -source build.tcl\r\n");
            xil_printf("  Then update Vitis platform from the new XSA, rebuild, reflash.\r\n");
            while (1) sleep(5);
        }
    }
    XGpioPs_WritePin(&ps_gpio, PIN_BIST_PATTERN, 0);
    XGpioPs_WritePin(&ps_gpio, PIN_BIST_STATUS, 0);
    usleep(1000);
    xil_printf("       OK -- new bitstream confirmed.\r\n\r\n");

    /* Sanity: read decoders BEFORE we trigger anything. Should be 0s. */
    uint32_t lo = 0, hi = 0;
    read_status(&lo, &hi);
    print_status("BEFORE", lo, hi);

    xil_printf("\r\n*** triggering TX (gpio_o[32] phy_tx_start) ***\r\n");
    trigger_tx();
    /* Packet is ~80us at L-rate; allow 50ms margin for CDC + chip
     * latency + decode pipeline. */
    usleep(50000);

    read_status(&lo, &hi);
    print_status("AFTER ", lo, hi);

    /* Debug-counter peek -- in OFDM mode (gpio_o[41]=0), gpio_o[40]=1
     * surfaces TX-pipeline counters from bb_clk domain.
     *   phy_tx_started_count -- did openofdm_tx start?
     *   phy_tx_done_count    -- did it finish?
     *   tx_iq_valid_count    -- did it produce samples?
     *   tx_cdc_wr_count      -- did samples get written to tx_cdc?
     *
     * Interpretation matrix:
     *   started=0, done=0, iq=0, wr=0   -> openofdm_tx never started
     *                                       (phy_tx_start never reached
     *                                       it OR it's gated internally)
     *   started>0, iq=0                 -> started but produced nothing
     *                                       (state machine hung early)
     *   iq>0, wr=0                      -> samples produced but tx_cdc
     *                                       rejected them (tx_active
     *                                       gate or tx_cdc_full stuck)
     *   wr>0, last_adc=0                -> writes accepted but tx_cdc
     *                                       not draining to chip OR
     *                                       chip-side rx didn't capture
     */
    XGpioPs_WritePin(&ps_gpio, PIN_BIST_STATUS, 1);
    usleep(10000);
    uint32_t lo2 = 0, hi2 = 0;
    read_status(&lo2, &hi2);
    /* New layout (gpio_o[40]=1, gpio_o[41]=0):
     *   [15: 0]  tx_cdc_wr_count
     *   [31:16]  rx_cap_nonzero_cnt
     *   [47:32]  rx_cap_first_i
     *   [63:48]  rx_cap_first_q
     */
    uint16_t tx_wr_cnt   = (lo2 >>  0) & 0xFFFF;
    uint16_t rx_cap_nz   = (lo2 >> 16) & 0xFFFF;
    int16_t  cap_first_i = (int16_t)((hi2 >>  0) & 0xFFFF);
    int16_t  cap_first_q = (int16_t)((hi2 >> 16) & 0xFFFF);
    xil_printf("[diag ] capture-content (gpio_o[40]=1, gpio_o[41]=0):\r\n");
    xil_printf("       tx_cdc_wr#       = %u\r\n", tx_wr_cnt);
    xil_printf("       rx_cap_nonzero#  = %u  (of 1200 captures; want ~1118)\r\n", rx_cap_nz);
    xil_printf("       rx_cap_first_i   = %d  (signed; want non-trivial L-STF magnitude)\r\n", cap_first_i);
    xil_printf("       rx_cap_first_q   = %d\r\n", cap_first_q);

    /* Also peek at chip-side BIST capture for last_adc / l_clk counts. */
    XGpioPs_WritePin(&ps_gpio, PIN_BIST_PATTERN, 1);
    usleep(1000);
    uint32_t lo3, hi3;
    read_status(&lo3, &hi3);
    uint16_t last_i = lo3 & 0xFFFF;
    uint16_t last_q = (lo3 >> 16) & 0xFFFF;
    uint16_t adc_count = hi3 & 0xFFFF;
    uint16_t dac_count = (hi3 >> 16) & 0xFFFF;
    XGpioPs_WritePin(&ps_gpio, PIN_BIST_PATTERN, 0);
    XGpioPs_WritePin(&ps_gpio, PIN_BIST_STATUS,  0);
    xil_printf("[diag ] chip-side capture (gpio_o[40]=1, gpio_o[41]=1):\r\n");
    xil_printf("       last_adc_i0 = 0x%04x  (with bist_pat=1, drives 0xCAFE)\r\n", last_i);
    xil_printf("       last_adc_q0 = 0x%04x\r\n", last_q);
    xil_printf("       adc_valid#  = %u\r\n", adc_count);
    xil_printf("       dac_valid#  = %u\r\n", dac_count);

    /* CHIP_LATENCY sweep. For each value, fire a TX, give 100 ms for
     * the chip + drain pipeline, read decoder counters. Best value
     * = the one where the L-SIG decodes correctly (rate=0xB, len=24)
     * and fcs_ok increments. */
    int best_sel = -1, best_pol = -1;
    uint8_t  baseline_fcs    = (lo >> 0) & 0xFF;
    uint8_t  baseline_hdr    = (lo >> 16) & 0xFF;
    for (int pol = 0; pol < 2 && best_sel < 0; pol++) {
        XGpioPs_WritePin(&ps_gpio, PIN_POLARITY, pol);
        usleep(100);
        for (int sel = 0; sel < 8; sel++) {
            set_latency_sel(sel);
            xil_printf("\r\n*** sweep pol=%d sel=%d (skip %d) ***\r\n",
                       pol, sel, skip_count_from_sel(sel));
            trigger_tx();
            usleep(100000);
            uint32_t slo, shi;
            read_status(&slo, &shi);
            print_status("SWEEP ", slo, shi);

            /* Capture-content peek for this sweep iteration. */
            XGpioPs_WritePin(&ps_gpio, PIN_BIST_STATUS, 1);
            usleep(100);
            uint32_t dlo, dhi;
            read_status(&dlo, &dhi);
            XGpioPs_WritePin(&ps_gpio, PIN_BIST_STATUS, 0);
            uint16_t s_nz = (dlo >> 16) & 0xFFFF;
            int16_t  s_fi = (int16_t)((dhi >>  0) & 0xFFFF);
            int16_t  s_fq = (int16_t)((dhi >> 16) & 0xFFFF);
            xil_printf("       pol=%d sel=%d  nonzero#=%u  first_i=%d  first_q=%d\r\n",
                       pol, sel, s_nz, s_fi, s_fq);

            uint8_t  s_fcs   = (slo >>  0) & 0xFF;
            uint8_t  s_hdr   = (slo >> 16) & 0xFF;
            uint8_t  s_rate  = (slo >> 24) & 0xFF;
            uint16_t s_len   = (shi >>  0) & 0xFFFF;
            if (s_fcs > baseline_fcs && s_rate == 0x0B && s_len == PSDU_BYTES) {
                xil_printf("       *** GOOD pol=%d sel=%d *** rate=0x%02x len=%d\r\n",
                           pol, sel, s_rate, s_len);
                best_sel = sel;
                best_pol = pol;
                break;
            }
            if (s_hdr > baseline_hdr) {
                xil_printf("       hdr_valid bumped (%d->%d) but fcs/rate/len off\r\n",
                           baseline_hdr, s_hdr);
            }
            baseline_fcs = s_fcs;
            baseline_hdr = s_hdr;
            lo = slo; hi = shi;  /* track for final pass-criterion */
        }
    }

    uint8_t  fcs_ok_count = (lo >> 0) & 0xFF;
    uint16_t pkt_len      = (hi >> 0) & 0xFFFF;

    xil_printf("\r\n");
    if (best_sel >= 0) {
        xil_printf("  *** PASS *** OFDM round-tripped through axi_ad9361.\r\n");
        xil_printf("              polarity=%d skip_target=%d (%d adc_valids skipped).\r\n",
                   best_pol, best_sel, skip_count_from_sel(best_sel));
        check_ber("BIST");
        run_multi_packet("BIST", NUM_PACKETS);
        /* BER vs SNR characterisation over the BIST loopback path.
         * shift=2 (≈+2 dB) is the closest achievable point to 0 dB SNR.
         * shift=12 (≈+62 dB) is effectively noiseless -- all pkts pass.
         * 1000 packets per point gives reliable BER down to ~1e-5.
         * Total runtime ≈ 4.5 minutes (11 points × 1000 pkts × 25 ms). */
        run_ber_vs_snr("BIST", 2, 12, 1000);
        xil_printf("  Stage 4 (RF cable loopback) is the next step.\r\n");
    } else if (fcs_ok_count == 0 && pkt_len != 0) {
        xil_printf("  *** PARTIAL *** dot11 saw something but didn't decode\r\n");
        xil_printf("              cleanly. last_pkt_len=%d, hdr_valid_count and\r\n"
                   "              bad_pkt_count above show whether the header\r\n"
                   "              parsed and how many CRC fails happened.\r\n", pkt_len);
        xil_printf("              Likely causes:\r\n");
        xil_printf("                - rate mismatch: chip 30.72 MSPS vs 1C\r\n");
        xil_printf("                  drain at 10 MSPS introduces oversampling.\r\n");
        xil_printf("                - 12-bit DP truncation drops too many LSBs\r\n");
        xil_printf("                  for the OFDM signal level.\r\n");
        xil_printf("                - tx_cdc / rx_cdc overflow during burst.\r\n");
    } else {
        xil_printf("  *** FAIL *** No decoder activity. dot11 saw nothing.\r\n");
        xil_printf("              - is gpio_o[41] low (OFDM mode, not BIST pattern)?\r\n");
        xil_printf("              - did ad9361_ensm_force_state succeed (0x017 ENSM=0xA)?\r\n");
        xil_printf("              - did the bitstream get reflashed after the HDL change?\r\n");
    }

    /* ============================================================
     * Stage 4: RF cable loopback.
     *
     * Same HDL rate adapter, same sweep. Differences from Stage 2B-4:
     *   - ad9361_bist_loopback(0)  -- chip-internal loopback DISABLED.
     *     Signal goes through the analog RF chain: DAC -> mixer -> TX
     *     output -> SMA cable -> RX input -> mixer -> ADC.
     *   - Lower TX attenuation (10 dB instead of 30 dB) so cable RX
     *     gets a real signal level.
     *   - Higher RX RF gain (30 dB) to compensate for cable loss.
     *
     * Physical setup required: SMA cable from FMCOMMS3 TX1A to RX1A.
     * Without a cable, this test will fail (no signal at RX) but that
     * doesn't invalidate the Stage 2B-4 regression above.
     * ============================================================ */
    xil_printf("\r\n========================================\r\n");
    xil_printf("  Stage 4 -- RF cable loopback\r\n");
    xil_printf("  (connect SMA cable: TX1A -> RX1A on FMCOMMS3)\r\n");
    xil_printf("========================================\r\n");

    xil_printf("[ad9361] disabling BIST loopback...\r\n");
    ret = ad9361_bist_loopback(phy, 0);
    if (ret != 0) xil_printf("       bist_loopback(0) -> %d\r\n", ret);

    xil_printf("[ad9361] tuning gains for RF cable...\r\n");
    ad9361_set_tx_attenuation(phy, 0, 10000);  /* 10 dB */
    ad9361_set_rx_rf_gain    (phy, 0, 30);

    /* Re-force FDD after mode change. */
    ad9361_ensm_force_state(phy, ENSM_STATE_FDD);
    usleep(10000);
    int32_t rf_r017 = ad9361_spi_read(phy->spi, 0x017);
    xil_printf("       0x017 STATE = 0x%02x (ENSM bits[3:0] = 0x%X)\r\n",
               rf_r017 & 0xFF, rf_r017 & 0xF);

    /* Reset polarity to 0; sweep will explore both. */
    XGpioPs_WritePin(&ps_gpio, PIN_POLARITY, 0);

    /* Re-baseline against current decoder counters (which may carry
     * Stage 2B-4 PASS). Any RF decode bumps fcs_ok above this. */
    uint32_t rf_lo, rf_hi;
    read_status(&rf_lo, &rf_hi);
    print_status("RF_BEFORE", rf_lo, rf_hi);
    uint8_t rf_baseline_fcs = (rf_lo >>  0) & 0xFF;
    uint8_t rf_baseline_hdr = (rf_lo >> 16) & 0xFF;

    int rf_best_sel = -1, rf_best_pol = -1;
    for (int pol = 0; pol < 2 && rf_best_sel < 0; pol++) {
        XGpioPs_WritePin(&ps_gpio, PIN_POLARITY, pol);
        usleep(100);
        for (int sel = 0; sel < 8; sel++) {
            set_latency_sel(sel);
            xil_printf("\r\n*** RF sweep pol=%d sel=%d ***\r\n", pol, sel);
            trigger_tx();
            usleep(100000);
            uint32_t slo, shi;
            read_status(&slo, &shi);
            print_status("RF SWP", slo, shi);

            /* Per-iter capture-content peek. */
            XGpioPs_WritePin(&ps_gpio, PIN_BIST_STATUS, 1);
            usleep(100);
            uint32_t dlo, dhi;
            read_status(&dlo, &dhi);
            XGpioPs_WritePin(&ps_gpio, PIN_BIST_STATUS, 0);
            uint16_t s_nz = (dlo >> 16) & 0xFFFF;
            int16_t  s_fi = (int16_t)((dhi >>  0) & 0xFFFF);
            int16_t  s_fq = (int16_t)((dhi >> 16) & 0xFFFF);
            xil_printf("       pol=%d sel=%d  nonzero#=%u  first_i=%d  first_q=%d\r\n",
                       pol, sel, s_nz, s_fi, s_fq);

            uint8_t  s_fcs   = (slo >>  0) & 0xFF;
            uint8_t  s_hdr   = (slo >> 16) & 0xFF;
            uint8_t  s_rate  = (slo >> 24) & 0xFF;
            uint16_t s_len   = (shi >>  0) & 0xFFFF;
            if (s_fcs > rf_baseline_fcs && s_rate == 0x0B && s_len == PSDU_BYTES) {
                xil_printf("       *** RF GOOD pol=%d sel=%d *** rate=0x%02x len=%d\r\n",
                           pol, sel, s_rate, s_len);
                rf_best_sel = sel;
                rf_best_pol = pol;
                break;
            }
            if (s_hdr > rf_baseline_hdr) {
                xil_printf("       hdr_valid bumped (%d->%d) but fcs/rate/len off\r\n",
                           rf_baseline_hdr, s_hdr);
            }
            rf_baseline_fcs = s_fcs;
            rf_baseline_hdr = s_hdr;
        }
    }

    xil_printf("\r\n");
    if (rf_best_sel >= 0) {
        xil_printf("  *** STAGE 4 PASS *** RF cable loopback decoded.\r\n");
        xil_printf("              polarity=%d skip_target=%d\r\n",
                   rf_best_pol, rf_best_sel);
        check_ber("RF");
        run_multi_packet("RF", NUM_PACKETS);
        /* BER vs SNR sweep over the RF cable path.
         * Same injection point as BIST: noise added after rx_cdc, before
         * dot11. The BER curve reflects AWGN on top of the real RF channel.
         * At high shift (low noise), the floor is set by real RF impairments. */
        run_ber_vs_snr("RF", 2, 12, 1000);
        xil_printf("  Hardware OFDM TX/RX loopback complete.\r\n");
    } else {
        xil_printf("  *** STAGE 4 FAIL *** No RF decode across 16 combos.\r\n");
        xil_printf("              Things to check:\r\n");
        xil_printf("                - SMA cable connected TX1A <-> RX1A?\r\n");
        xil_printf("                - TX attenuation may need lowering (currently 10 dB).\r\n");
        xil_printf("                - RX RF gain may need raising (currently 30 dB).\r\n");
        xil_printf("                - DC offset / IQ imbalance may need calibration.\r\n");
        xil_printf("                  (Prior project ported dc_rm from openwifi-hw for this.)\r\n");
    }

    /* Idle so user can poke ILA / re-trigger via reset. */
    while (1) { sleep(5); xil_printf("."); }
    return 0;
}
