/*
 * Stage 3 -- Multi-MCS BER vs SNR sweep over RF cable loopback.
 *
 * Tests all 8 IEEE 802.11a legacy rates (6/9/12/18/24/36/48/54 Mbps) which
 * span all modulation+coding combinations from BPSK 1/2 through 64QAM 3/4.
 * These correspond to 802.11n MCS 0-7 in terms of modulation complexity.
 *
 * HDL prerequisites (tx_packet_rom_mcs bitstream):
 *   gpio_o[2:0]  = mcs_sel  → selects 64-word ROM block per rate
 *   gpio_o[59]   = awgn_enable
 *   gpio_o[63:60] = noise_shift[3:0]
 *   All other gpio_o bits same as stage2b4.
 *
 * Test sequence:
 *   1. AD9361 init, set 40 MSPS chain.
 *   2. RF cable alignment at MCS 0 (BPSK 1/2, most robust).
 *   3. For each MCS 0..7:
 *        a. Set mcs_sel, verify decode (5 test packets).
 *        b. AWGN BER vs SNR sweep: shift 4..15, 1000 packets/point.
 *   4. Print summary waterfall table.
 *
 * Estimated runtime: 8 MCS x 12 SNR points x 1000 pkts x 25 ms = ~40 min.
 *
 * Physical setup: SMA cable TX1A → RX1A on FMCOMMS3. No BIST loopback used.
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

/* axi_ad9361 register access. */
#define ADC_BASE_ADI    (AXI_AD9361_BASE + 0x0000UL)
#define DAC_BASE_ADI    (AXI_AD9361_BASE + 0x4000UL)
#define ADC_RD(off)     Xil_In32 (ADC_BASE_ADI + (off))
#define ADC_WR(off, v)  Xil_Out32(ADC_BASE_ADI + (off), (v))
#define DAC_RD(off)     Xil_In32 (DAC_BASE_ADI + (off))
#define DAC_WR(off, v)  Xil_Out32(DAC_BASE_ADI + (off), (v))

/* ---- GPIO pin map (PS pin = 54 + EMIO bit index) ---- */

/* MCS rate selector: gpio_o[2:0]. PS pins 54-56. */
#define PIN_MCS_SEL_0   54  /* gpio_o[0] = mcs_sel[0] */
#define PIN_MCS_SEL_1   55  /* gpio_o[1] = mcs_sel[1] */
#define PIN_MCS_SEL_2   56  /* gpio_o[2] = mcs_sel[2] */

/* Core control pins (same as stage2b4). */
#define PIN_PHY_TX_START   86  /* gpio_o[32] */
#define PIN_AD9361_RESETB  87  /* gpio_o[33] */
#define PIN_AD9361_ENABLE  88  /* gpio_o[34] */
#define PIN_AD9361_TXNRX   89  /* gpio_o[35] */
#define PIN_BIST_STATUS    94  /* gpio_o[40] */
#define PIN_BIST_PATTERN   95  /* gpio_o[41] */
#define PIN_LATENCY_SEL_0 102  /* gpio_o[48] */
#define PIN_LATENCY_SEL_1 103  /* gpio_o[49] */
#define PIN_LATENCY_SEL_2 104  /* gpio_o[50] */
#define PIN_POLARITY       96  /* gpio_o[42] */
#define PIN_BYTE_VIEW      97  /* gpio_o[43] */
#define PIN_BYTE_BANK_0   105  /* gpio_o[51] */
#define PIN_BYTE_BANK_1   106  /* gpio_o[52] */
#define PIN_BYTE_BANK_2   107  /* gpio_o[53] */
#define PIN_BYTE_BANK_3   108  /* gpio_o[54] */
#define PIN_DOT11_SOFT_DEC      90  /* gpio_o[36] */
#define PIN_DOT11_FORCE_HT      91  /* gpio_o[37] */
#define PIN_DOT11_DIS_SMOOTH    92  /* gpio_o[38] */
#define PIN_DOT11_THRESH_SCALE  93  /* gpio_o[39] */
#define PIN_DOT11_FFT_WIN_0     98  /* gpio_o[44] */
#define PIN_DOT11_FFT_WIN_1     99  /* gpio_o[45] */
#define PIN_DOT11_FFT_WIN_2    100  /* gpio_o[46] */
#define PIN_DOT11_FFT_WIN_3    101  /* gpio_o[47] */
#define PIN_DOT11_PLATEAU_0    109  /* gpio_o[55] */
#define PIN_DOT11_PLATEAU_1    110  /* gpio_o[56] */
#define PIN_DOT11_PWRTHR_0     111  /* gpio_o[57] */
#define PIN_DOT11_PWRTHR_1     112  /* gpio_o[58] */

/* AWGN channel control (gpio_o[59..63]). */
#define PIN_AWGN_ENABLE        113  /* gpio_o[59] */
#define PIN_AWGN_SHIFT_0       114  /* gpio_o[60] */
#define PIN_AWGN_SHIFT_1       115  /* gpio_o[61] */
#define PIN_AWGN_SHIFT_2       116  /* gpio_o[62] */
#define PIN_AWGN_SHIFT_3       117  /* gpio_o[63] */

#define BANK_LO  2  /* gpio_i[31:0]  */
#define BANK_HI  3  /* gpio_i[63:32] */

/* ---- no-OS platform glue ---- */
static struct xil_spi_init_param  xil_spi_param  = { .type = SPI_PS,  .flags = 0 };
static struct xil_gpio_init_param xil_gpio_param  = { .type = GPIO_PS, .device_id = GPIO_DEVICE_ID };
#define GPIO_OPS   &xil_gpio_ops
#define SPI_OPS    &xil_spi_ops
#define GPIO_PARAM &xil_gpio_param
#define SPI_PARAM  &xil_spi_param

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

/* ---- MCS rate table ---- */

/*
 * 8 IEEE 802.11a legacy rates in increasing order of modulation complexity.
 * The rate_code matches the 4-bit RATE field in the L-SIG SIGNAL field and
 * is returned by the RX decoder in gpio_i[27:24] (last_pkt_rate[3:0]).
 * These span the same modulation/coding range as 802.11n HT MCS 0-7.
 */
typedef struct {
    uint8_t     rate_code;  /* 4-bit IEEE 802.11a rate field value           */
    const char *mbps;       /* data rate string                              */
    const char *mod;        /* modulation name                               */
    const char *cr;         /* code rate                                     */
} mcs_entry_t;

static const mcs_entry_t mcs_table[8] = {
    { 0x0B, " 6 Mbps", "BPSK ", "1/2" },  /* mcs_sel=0 */
    { 0x0F, " 9 Mbps", "BPSK ", "3/4" },  /* mcs_sel=1 */
    { 0x0A, "12 Mbps", "QPSK ", "1/2" },  /* mcs_sel=2 */
    { 0x0E, "18 Mbps", "QPSK ", "3/4" },  /* mcs_sel=3 */
    { 0x09, "24 Mbps", "16QAM", "1/2" },  /* mcs_sel=4 */
    { 0x0D, "36 Mbps", "16QAM", "3/4" },  /* mcs_sel=5 */
    { 0x08, "48 Mbps", "64QAM", "2/3" },  /* mcs_sel=6 */
    { 0x0C, "54 Mbps", "64QAM", "3/4" },  /* mcs_sel=7 */
};

/* ---- PSDU layout ---- */
#define PSDU_BYTES  100
#define DATA_BYTES   96
#define FCS_BYTES_N   4

static const uint8_t expected_bytes[DATA_BYTES] = {
    0x09, 0x0A, 0x0B, 0x0C, 0x0D, 0x0E, 0x0F, 0x10,
    0x11, 0x12, 0x13, 0x14, 0x15, 0x16, 0x17, 0x18,
    0x19, 0x1A, 0x1B, 0x1C, 0x1D, 0x1E, 0x1F, 0x20,
    0x21, 0x22, 0x23, 0x24, 0x25, 0x26, 0x27, 0x28,
    0x29, 0x2A, 0x2B, 0x2C, 0x2D, 0x2E, 0x2F, 0x30,
    0x31, 0x32, 0x33, 0x34, 0x35, 0x36, 0x37, 0x38,
    0x39, 0x3A, 0x3B, 0x3C, 0x3D, 0x3E, 0x3F, 0x40,
    0x41, 0x42, 0x43, 0x44, 0x45, 0x46, 0x47, 0x48,
    0x49, 0x4A, 0x4B, 0x4C, 0x4D, 0x4E, 0x4F, 0x50,
    0x51, 0x52, 0x53, 0x54, 0x55, 0x56, 0x57, 0x58,
    0x59, 0x5A, 0x5B, 0x5C, 0x5D, 0x5E, 0x5F, 0x60,
    0x61, 0x62, 0x63, 0x64, 0x65, 0x66, 0x67, 0x68
};

/* ---- Summary waterfall table (filled during the sweep) ---- */
/* Stores the first shift value where PER drops below 5% per MCS.
 * -1 = never reached (still 100% PER at shift=15 = essentially noiseless). */
static int waterfall_threshold[8];

/* ---- GPIO state ---- */
static XGpioPs ps_gpio;

/* ================================================================
 * GPIO helpers
 * ================================================================ */

static int ps_gpio_init(void)
{
    XGpioPs_Config *cfg = XGpioPs_LookupConfig(XPAR_XGPIOPS_0_DEVICE_ID);
    if (!cfg) return -1;
    if (XGpioPs_CfgInitialize(&ps_gpio, cfg, cfg->BaseAddr) != XST_SUCCESS) return -1;

    /* MCS selector: default to MCS 0 (BPSK 1/2). */
    int mcs_pins[] = { PIN_MCS_SEL_0, PIN_MCS_SEL_1, PIN_MCS_SEL_2 };
    for (int i = 0; i < 3; i++) {
        XGpioPs_SetDirectionPin   (&ps_gpio, mcs_pins[i], 1);
        XGpioPs_SetOutputEnablePin(&ps_gpio, mcs_pins[i], 1);
        XGpioPs_WritePin          (&ps_gpio, mcs_pins[i], 0);
    }

    XGpioPs_SetDirectionPin   (&ps_gpio, PIN_PHY_TX_START, 1);
    XGpioPs_SetOutputEnablePin(&ps_gpio, PIN_PHY_TX_START, 1);
    XGpioPs_WritePin          (&ps_gpio, PIN_PHY_TX_START, 0);

    XGpioPs_SetDirectionPin   (&ps_gpio, PIN_BIST_STATUS, 1);
    XGpioPs_SetOutputEnablePin(&ps_gpio, PIN_BIST_STATUS, 1);
    XGpioPs_WritePin          (&ps_gpio, PIN_BIST_STATUS, 0);
    XGpioPs_SetDirectionPin   (&ps_gpio, PIN_BIST_PATTERN, 1);
    XGpioPs_SetOutputEnablePin(&ps_gpio, PIN_BIST_PATTERN, 1);
    XGpioPs_WritePin          (&ps_gpio, PIN_BIST_PATTERN, 0);

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
    for (int i = 0; i < (int)(sizeof(lpins)/sizeof(lpins[0])); i++) {
        XGpioPs_SetDirectionPin   (&ps_gpio, lpins[i], 1);
        XGpioPs_SetOutputEnablePin(&ps_gpio, lpins[i], 1);
        XGpioPs_WritePin          (&ps_gpio, lpins[i], 0);
    }

    int awgn_pins[] = {
        PIN_AWGN_ENABLE,
        PIN_AWGN_SHIFT_0, PIN_AWGN_SHIFT_1, PIN_AWGN_SHIFT_2, PIN_AWGN_SHIFT_3
    };
    for (int i = 0; i < 5; i++) {
        XGpioPs_SetDirectionPin   (&ps_gpio, awgn_pins[i], 1);
        XGpioPs_SetOutputEnablePin(&ps_gpio, awgn_pins[i], 1);
        XGpioPs_WritePin          (&ps_gpio, awgn_pins[i], 0);
    }

    XGpioPs_SetDirectionPin   (&ps_gpio, PIN_AD9361_ENABLE, 1);
    XGpioPs_SetOutputEnablePin(&ps_gpio, PIN_AD9361_ENABLE, 1);
    XGpioPs_WritePin          (&ps_gpio, PIN_AD9361_ENABLE, 0);
    XGpioPs_SetDirectionPin   (&ps_gpio, PIN_AD9361_TXNRX, 1);
    XGpioPs_SetOutputEnablePin(&ps_gpio, PIN_AD9361_TXNRX, 1);
    XGpioPs_WritePin          (&ps_gpio, PIN_AD9361_TXNRX, 1);

    /* dot11 parameter defaults (same as stage2b4). */
    XGpioPs_WritePin(&ps_gpio, PIN_DOT11_SOFT_DEC,   1);
    XGpioPs_WritePin(&ps_gpio, PIN_DOT11_DIS_SMOOTH, 1);
    XGpioPs_WritePin(&ps_gpio, PIN_DOT11_FFT_WIN_0,  1);  /* fft_win_shift=0x1 */
    XGpioPs_WritePin(&ps_gpio, PIN_DOT11_PLATEAU_0,  1);  /* min_plateau=100   */
    return 0;
}

static void read_status(uint32_t *lo, uint32_t *hi)
{
    *lo = XGpioPs_Read(&ps_gpio, BANK_LO);
    *hi = XGpioPs_Read(&ps_gpio, BANK_HI);
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

static void set_mcs(int mcs)
{
    XGpioPs_WritePin(&ps_gpio, PIN_MCS_SEL_0, (mcs >> 0) & 1);
    XGpioPs_WritePin(&ps_gpio, PIN_MCS_SEL_1, (mcs >> 1) & 1);
    XGpioPs_WritePin(&ps_gpio, PIN_MCS_SEL_2, (mcs >> 2) & 1);
    usleep(200);  /* 200 µs: GPIO CDC settle (2-FF sync, ~2 bb_clk) */
}

static void awgn_set_enable(int en)
{
    XGpioPs_WritePin(&ps_gpio, PIN_AWGN_ENABLE, en ? 1 : 0);
}

static void awgn_set_shift(int shift)
{
    shift &= 0xF;
    XGpioPs_WritePin(&ps_gpio, PIN_AWGN_SHIFT_0, (shift >> 0) & 1);
    XGpioPs_WritePin(&ps_gpio, PIN_AWGN_SHIFT_1, (shift >> 1) & 1);
    XGpioPs_WritePin(&ps_gpio, PIN_AWGN_SHIFT_2, (shift >> 2) & 1);
    XGpioPs_WritePin(&ps_gpio, PIN_AWGN_SHIFT_3, (shift >> 3) & 1);
}

/*
 * SNR in dB for a given noise_shift, empirically calibrated from the
 * BIST waterfall (BPSK 1/2 + Viterbi transitions at shift=7→8).
 * shift=8 → +3 dB (just above BPSK 1/2 threshold on the BIST path).
 * Each +1 step halves σ_noise → +6 dB SNR.
 * The RF path has ~6-12 dB extra loss from analog impairments.
 */
static int awgn_shift_to_snr_db(int shift)
{
    return (shift - 8) * 6 + 3;
}

/* ================================================================
 * ADC/DAC core init + RX byte read (same as stage2b4)
 * ================================================================ */

static void configure_adc_dac_cores(void)
{
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

static void set_byte_bank(int bank)
{
    XGpioPs_WritePin(&ps_gpio, PIN_BYTE_BANK_0, (bank >> 0) & 1);
    XGpioPs_WritePin(&ps_gpio, PIN_BYTE_BANK_1, (bank >> 1) & 1);
    XGpioPs_WritePin(&ps_gpio, PIN_BYTE_BANK_2, (bank >> 2) & 1);
    XGpioPs_WritePin(&ps_gpio, PIN_BYTE_BANK_3, (bank >> 3) & 1);
}

static void read_rx_bytes(uint8_t out[PSDU_BYTES])
{
    uint8_t tmp[16 * 8];
    XGpioPs_WritePin(&ps_gpio, PIN_BYTE_VIEW, 1);
    int needed_banks = (PSDU_BYTES + 7) / 8;
    for (int bank = 0; bank < needed_banks; bank++) {
        set_byte_bank(bank);
        usleep(10);
        uint32_t blo = XGpioPs_Read(&ps_gpio, BANK_LO);
        uint32_t bhi = XGpioPs_Read(&ps_gpio, BANK_HI);
        tmp[bank*8 + 0] = (blo >>  0) & 0xFF;
        tmp[bank*8 + 1] = (blo >>  8) & 0xFF;
        tmp[bank*8 + 2] = (blo >> 16) & 0xFF;
        tmp[bank*8 + 3] = (blo >> 24) & 0xFF;
        tmp[bank*8 + 4] = (bhi >>  0) & 0xFF;
        tmp[bank*8 + 5] = (bhi >>  8) & 0xFF;
        tmp[bank*8 + 6] = (bhi >> 16) & 0xFF;
        tmp[bank*8 + 7] = (bhi >> 24) & 0xFF;
    }
    XGpioPs_WritePin(&ps_gpio, PIN_BYTE_VIEW, 0);
    set_byte_bank(0);
    for (int i = 0; i < PSDU_BYTES; i++) out[i] = tmp[i];
}

static uint8_t popcount8(uint8_t v)
{
    v = v - ((v >> 1) & 0x55u);
    v = (v & 0x33u) + ((v >> 2) & 0x33u);
    return (v + (v >> 4)) & 0x0Fu;
}

/* ================================================================
 * RF alignment
 *
 * Sweeps polarity (0..1) and skip_target (0..7) at MCS 0 (BPSK 1/2)
 * to find the CDC FIFO drain timing that yields a successful decode.
 * Returns 1 on success, 0 on failure.
 * Fills *skip_out and *pol_out with the working values.
 * ================================================================ */
static int rf_align(int *skip_out, int *pol_out)
{
    uint32_t base_lo, base_hi;
    read_status(&base_lo, &base_hi);
    uint8_t base_fcs = (base_lo >>  0) & 0xFF;
    uint8_t base_hdr = (base_lo >> 16) & 0xFF;

    for (int pol = 0; pol < 2; pol++) {
        XGpioPs_WritePin(&ps_gpio, PIN_POLARITY, pol);
        usleep(100);
        for (int sel = 0; sel < 8; sel++) {
            set_latency_sel(sel);
            xil_printf("[align] pol=%d sel=%d ... ", pol, sel);
            trigger_tx();
            usleep(100000);  /* 100 ms: conservative for cable round-trip */

            uint32_t slo, shi;
            read_status(&slo, &shi);
            uint8_t  s_fcs  = (slo >>  0) & 0xFF;
            uint8_t  s_hdr  = (slo >> 16) & 0xFF;
            uint8_t  s_rate = (slo >> 24) & 0xFF;
            uint16_t s_len  = (shi >>  0) & 0xFFFF;

            if (s_fcs > base_fcs &&
                (s_rate & 0x0F) == mcs_table[0].rate_code &&
                s_len == PSDU_BYTES) {
                xil_printf("GOOD  rate=0x%02x len=%d\r\n", s_rate, s_len);
                *skip_out = sel;
                *pol_out  = pol;
                return 1;
            }
            if (s_hdr > base_hdr)
                xil_printf("hdr++ (rate=0x%02x len=%d, fcs stale)\r\n", s_rate, s_len);
            else
                xil_printf("no decode\r\n");

            base_fcs = s_fcs;
            base_hdr = s_hdr;
        }
    }
    return 0;
}

/* ================================================================
 * Per-MCS decode verification
 *
 * Sends up to n_tries packets for the currently-selected MCS and
 * confirms at least one successful decode with the expected rate code.
 * Returns the number of successful decodes.
 * ================================================================ */
static int verify_mcs_decode(int mcs, int n_tries)
{
    uint32_t lo0, hi0;
    read_status(&lo0, &hi0);
    uint8_t base_fcs = (lo0 >> 0) & 0xFF;
    int ok = 0;

    for (int i = 0; i < n_tries; i++) {
        trigger_tx();
        usleep(50000);  /* 50 ms: conservative */
        uint32_t lo, hi;
        read_status(&lo, &hi);
        uint8_t s_fcs  = (lo >>  0) & 0xFF;
        uint8_t s_rate = (lo >> 24) & 0xFF;
        if (s_fcs > base_fcs && (s_rate & 0x0F) == mcs_table[mcs].rate_code)
            ok++;
        base_fcs = s_fcs;
    }
    return ok;
}

/* ================================================================
 * BER vs SNR sweep for one MCS
 *
 * shift_start..shift_end: noise_shift range (each step = +6 dB SNR).
 * n_packets: packets per shift point.
 * Records the first shift where PER < 5% into waterfall_threshold[mcs].
 * ================================================================ */
static void run_mcs_snr_sweep(int mcs, int shift_start, int shift_end,
                               int n_packets)
{
    xil_printf("\r\n-----------------------------------------------------------\r\n");
    xil_printf("  MCS %d  %s  %s %s  (rate=0x%02x)\r\n",
               mcs,
               mcs_table[mcs].mbps,
               mcs_table[mcs].mod,
               mcs_table[mcs].cr,
               mcs_table[mcs].rate_code);
    xil_printf("  SNR range: %d dB to %d dB  (shift %d..%d)\r\n",
               awgn_shift_to_snr_db(shift_start),
               awgn_shift_to_snr_db(shift_end),
               shift_start, shift_end);
    xil_printf("  Pkts/point: %d   Est. time: ~%d s\r\n",
               n_packets,
               (shift_end - shift_start + 1) * n_packets * 25 / 1000);
    xil_printf("  shift | SNR(dB) | OK pkts | Failed | PER(%%) | eff.BER(ppm)\r\n");
    xil_printf("  ------|---------|---------|--------|--------|-------------\r\n");

    waterfall_threshold[mcs] = -1;  /* updated below when PER < 5% */
    awgn_set_enable(1);

    for (int sh = shift_start; sh <= shift_end; sh++) {
        awgn_set_shift(sh);
        usleep(1000);

        int ok           = 0;
        int err          = 0;
        int total_bits   = 0;
        int total_errors = 0;

        for (int p = 0; p < n_packets; p++) {
            uint8_t fcs_pre = (XGpioPs_Read(&ps_gpio, BANK_LO) >> 0) & 0xFF;
            trigger_tx();
            usleep(25000);
            uint8_t fcs_post = (XGpioPs_Read(&ps_gpio, BANK_LO) >> 0) & 0xFF;

            if (((fcs_post - fcs_pre) & 0xFF) == 1) {
                ok++;
                uint8_t rx[PSDU_BYTES];
                read_rx_bytes(rx);
                for (int b = 0; b < DATA_BYTES; b++) {
                    uint8_t diff = rx[b] ^ expected_bytes[b];
                    if (diff) total_errors += popcount8(diff);
                }
                total_bits += DATA_BYTES * 8;
            } else {
                err++;
            }
        }

        int per_pct_x10 = (err * 1000) / n_packets;
        uint64_t ber_eff_ppm = ((uint64_t)total_errors
                                + (uint64_t)err * DATA_BYTES * 8)
                               * 1000000ULL
                               / ((uint64_t)n_packets * DATA_BYTES * 8);

        xil_printf("  %d | %d dB | %d | %d | %d.%d | %u\r\n",
                   sh,
                   awgn_shift_to_snr_db(sh),
                   ok, err,
                   per_pct_x10 / 10, per_pct_x10 % 10,
                   (unsigned)ber_eff_ppm);

        if (waterfall_threshold[mcs] < 0 && per_pct_x10 < 50)
            waterfall_threshold[mcs] = sh;
    }

    awgn_set_enable(0);
    awgn_set_shift(0);
    xil_printf("  AWGN disabled.\r\n");
}

/* ================================================================
 * main
 * ================================================================ */
int main(void)
{
    struct ad9361_rf_phy *phy = NULL;
    int ret;

    xil_printf("\r\n=============================================\r\n");
    xil_printf("  Stage 3 -- Multi-MCS RF loopback BER test\r\n");
    xil_printf("  8 rates: BPSK/QPSK/16QAM/64QAM, 1/2..3/4\r\n");
    xil_printf("=============================================\r\n\r\n");

    if (ps_gpio_init() != 0) {
        xil_printf("FATAL: PS GPIO init\r\n");
        while (1) sleep(5);
    }

    /* ---- AD9361 init ---- */
    xil_printf("[ad9361] init...\r\n");
    ret = ad9361_init(&phy, &default_init_param);
    if (ret != 0 || phy == NULL) {
        xil_printf("  *** FAIL *** ad9361_init returned %d\r\n", ret);
        while (1) sleep(5);
    }
    xil_printf("[ad9361] init OK\r\n");

    xil_printf("[ad9361] setting 40 MSPS chain...\r\n");
    ret = ad9361_set_rx_sampling_freq(phy, 40000000);
    ret |= ad9361_set_tx_sampling_freq(phy, 40000000);
    uint32_t actual_rx = 0, actual_tx = 0;
    ad9361_get_rx_sampling_freq(phy, &actual_rx);
    ad9361_get_tx_sampling_freq(phy, &actual_tx);
    xil_printf("       actual RX=%u Hz  TX=%u Hz\r\n", actual_rx, actual_tx);
    if (actual_rx != 40000000 || actual_tx != 40000000)
        xil_printf("  *** WARN *** did not land at exactly 40 MSPS\r\n");

    /* ---- RF cable gains ---- */
    ad9361_set_rx_rf_gain    (phy, 0, 30);   /* 30 dB RX gain  */
    ad9361_set_tx_attenuation(phy, 0, 10000); /* 10 dB TX atten */
    configure_adc_dac_cores();

    uint32_t lclk_count = ADC_RD(0x0054);
    uint32_t lclk_hz    = (lclk_count * 100000000ULL) / 65536ULL;
    xil_printf("[ad9361] l_clk ~%u Hz (want ~80 MHz)\r\n", lclk_hz);

    /* ---- Force FDD (no BIST loopback for RF test) ---- */
    XGpioPs_WritePin(&ps_gpio, PIN_AD9361_ENABLE, 1);
    ad9361_ensm_force_state(phy, ENSM_STATE_FDD);
    usleep(10000);
    int32_t r017 = ad9361_spi_read(phy->spi, 0x017);
    xil_printf("[ad9361] 0x017 ENSM bits[3:0]=0x%X (want 0xA=FDD)\r\n", r017 & 0xF);
    if ((r017 & 0xF) != 0xA)
        xil_printf("  *** WARN *** chip not in FDD; RF may not work.\r\n");

    /* ================================================================
     * RF alignment at MCS 0 (BPSK 1/2 -- most robust for alignment).
     * The skip_target and polarity found here are reused for all MCS.
     * ================================================================ */
    xil_printf("\r\n[align] RF cable alignment at MCS 0 (BPSK 1/2)...\r\n");
    set_mcs(0);

    int rf_skip = -1, rf_pol = -1;
    if (!rf_align(&rf_skip, &rf_pol)) {
        xil_printf("\r\n  *** FAIL *** RF alignment failed across all 16 combos.\r\n");
        xil_printf("  Check: SMA cable TX1A->RX1A, gains, FDD state.\r\n");
        while (1) sleep(5);
    }
    xil_printf("\r\n  *** RF ALIGNED *** polarity=%d skip_target=%d\r\n\r\n",
               rf_pol, rf_skip);

    /* ================================================================
     * Multi-MCS sweep.
     * For each MCS: verify decode, then run AWGN BER vs SNR sweep.
     *
     * SNR sweep: shift 4 (-21 dB) to 15 (+45 dB), 12 points.
     * At shift=4 all MCS should fail; at shift=15 all should pass.
     * This captures the complete waterfall for every rate.
     *
     * Runtime per MCS: 12 x 1000 pkts x 25 ms = 300 s (~5 min).
     * Total: 8 x 5 min = ~40 min.
     * ================================================================ */
    xil_printf("=============================================\r\n");
    xil_printf("  Multi-MCS BER vs SNR sweep  (RF loopback)\r\n");
    xil_printf("  8 rates  x  12 SNR points  x  1000 pkts\r\n");
    xil_printf("  Estimated total runtime: ~40 minutes\r\n");
    xil_printf("=============================================\r\n");

    for (int mcs = 0; mcs < 8; mcs++) {
        set_mcs(mcs);

        /* Brief decode check before starting the long sweep. */
        xil_printf("\r\n[MCS %d] %s %s %s -- verifying decode (5 pkts)... ",
                   mcs,
                   mcs_table[mcs].mbps,
                   mcs_table[mcs].mod,
                   mcs_table[mcs].cr);

        int decoded = verify_mcs_decode(mcs, 5);
        if (decoded > 0) {
            xil_printf("OK (%d/5 decoded)\r\n", decoded);
        } else {
            xil_printf("FAIL (0/5 decoded)\r\n");
            xil_printf("  WARNING: skipping SNR sweep for MCS %d.\r\n", mcs);
            xil_printf("  Higher-order modulations need higher SNR --\r\n");
            xil_printf("  if all MCS fail, check gains and cable.\r\n");
            waterfall_threshold[mcs] = -1;
            continue;
        }

        run_mcs_snr_sweep(mcs, 4, 15, 1000);
    }

    /* ================================================================
     * Summary table
     * ================================================================ */
    xil_printf("\r\n=============================================\r\n");
    xil_printf("  SUMMARY -- Waterfall threshold (first shift with PER < 5%%)\r\n");
    xil_printf("  (SNR calibrated: BPSK 1/2 threshold ~ shift=8 = +3 dB)\r\n");
    xil_printf("  MCS | Rate      | Mod   | CR  | thresh.shift | est.SNR\r\n");
    xil_printf("  ----|-----------|-------|-----|--------------|--------\r\n");

    for (int mcs = 0; mcs < 8; mcs++) {
        int thr = waterfall_threshold[mcs];
        if (thr >= 0) {
            xil_printf("   %d  | %s | %s | %s  |     %d        | %d dB\r\n",
                       mcs,
                       mcs_table[mcs].mbps,
                       mcs_table[mcs].mod,
                       mcs_table[mcs].cr,
                       thr,
                       awgn_shift_to_snr_db(thr));
        } else {
            xil_printf("   %d  | %s | %s | %s  |     N/A      | --\r\n",
                       mcs,
                       mcs_table[mcs].mbps,
                       mcs_table[mcs].mod,
                       mcs_table[mcs].cr);
        }
    }

    xil_printf("=============================================\r\n");
    xil_printf("  Multi-MCS test complete.\r\n");

    while (1) { sleep(5); xil_printf("."); }
    return 0;
}
