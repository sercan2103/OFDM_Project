/*
 * OFDM Transceiver UART CLI  -- ZedBoard + FMCOMMS3 (AD9361)
 *
 * Five operational modes selected from a terminal menu:
 *   1. Transmit   -- fire N packets at chosen MCS, display TX data + RX result
 *   2. Receive    -- listen for incoming packets, display data (Phase 1: needs
 *                    manual TX trigger; Phase 2 HDL adds force_rx for true standalone)
 *   3. Transceiver-- receive, display, then retransmit (Phase 1: ROM data retransmit;
 *                    Phase 3 HDL adds AXI BRAM for true data relay)
 *   4. Loopback   -- BER/PER sweep; fixed SNR point or full adaptive sweep
 *   5. (i)        -- system info and diagnostics
 *
 * HDL prerequisites (current bitstream):
 *   gpio_o[2:0]   = mcs_sel        (PS pins 54-56)
 *   gpio_o[3]     = ht_mode        (PS pin 57)
 *   gpio_o[59]    = awgn_enable
 *   gpio_o[63:60] = noise_shift[3:0]
 *   All other gpio_o bits: see pin map below.
 *
 * Phase 2 HDL additions (not yet implemented -- stubs in this file):
 *   gpio_o[4]     = force_rx_start (PS pin 58)
 *   gpio_o[5]     = iq_view_en     (PS pin 59)
 *   gpio_o[6]     = iq_sel_tx      (PS pin 60)
 *   gpio_o[11:7]  = iq_idx[4:0]   (PS pins 61-65)
 *
 * Physical setup: SMA cable TX1A -> RX1A on FMCOMMS3.
 */

#include <inttypes.h>
#include <stdio.h>
#include <string.h>

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

/* ======================================================================
 * AXI AD9361 register access
 * ====================================================================== */
#define ADC_BASE_ADI    (AXI_AD9361_BASE + 0x0000UL)
#define DAC_BASE_ADI    (AXI_AD9361_BASE + 0x4000UL)
#define ADC_RD(off)     Xil_In32 (ADC_BASE_ADI + (off))
#define ADC_WR(off, v)  Xil_Out32(ADC_BASE_ADI + (off), (v))
#define DAC_RD(off)     Xil_In32 (DAC_BASE_ADI + (off))
#define DAC_WR(off, v)  Xil_Out32(DAC_BASE_ADI + (off), (v))

/* ======================================================================
 * GPIO pin map  (PS pin = 54 + EMIO bit index)
 * ====================================================================== */

/* MCS / HT mode selector */
#define PIN_MCS_SEL_0   54   /* gpio_o[0]  */
#define PIN_MCS_SEL_1   55   /* gpio_o[1]  */
#define PIN_MCS_SEL_2   56   /* gpio_o[2]  */
#define PIN_HT_MODE     57   /* gpio_o[3]  0=legacy 802.11a  1=HT-MF */

/* Phase 2 pins */
#define PIN_FORCE_RX    58   /* gpio_o[4]  force rx_started without TX */
#define PIN_IQ_VIEW_EN  59   /* gpio_o[5]  redirect gpio_i to IQ sample */
#define PIN_IQ_SEL_TX   60   /* gpio_o[6]  0=RX IQ  1=TX IQ            */
#define PIN_IQ_IDX_0    61   /* gpio_o[7]  \                            */
#define PIN_IQ_IDX_1    62   /* gpio_o[8]   |                           */
#define PIN_IQ_IDX_2    63   /* gpio_o[9]   |                           */
#define PIN_IQ_IDX_3    64   /* gpio_o[10]  | 12-bit sample index       */
#define PIN_IQ_IDX_4    65   /* gpio_o[11]  | (supports 0..4095)        */
#define PIN_IQ_IDX_5    66   /* gpio_o[12]  |                           */
#define PIN_IQ_IDX_6    67   /* gpio_o[13]  |                           */
#define PIN_IQ_IDX_7    68   /* gpio_o[14]  |                           */
#define PIN_IQ_IDX_8    69   /* gpio_o[15]  |                           */
#define PIN_IQ_IDX_9    70   /* gpio_o[16]  |                           */
#define PIN_IQ_IDX_10   71   /* gpio_o[17]  |                           */
#define PIN_IQ_IDX_11   72   /* gpio_o[18] /                            */

/* Phase 3 pin */
#define PIN_XCVR_BRAM_SEL  78  /* gpio_o[24] 1=relay via AXI BRAM, 0=ROM */

/* Core control */
#define PIN_PHY_TX_START   86   /* gpio_o[32] */
#define PIN_AD9361_RESETB  87   /* gpio_o[33] */
#define PIN_AD9361_ENABLE  88   /* gpio_o[34] */
#define PIN_AD9361_TXNRX   89   /* gpio_o[35] */

/* dot11 tuning */
#define PIN_DOT11_SOFT_DEC      90   /* gpio_o[36] */
#define PIN_DOT11_FORCE_HT      91   /* gpio_o[37] */
#define PIN_DOT11_DIS_SMOOTH    92   /* gpio_o[38] */
#define PIN_DOT11_THRESH_SCALE  93   /* gpio_o[39] */

/* Mode / debug selects */
#define PIN_BIST_STATUS    94   /* gpio_o[40] */
#define PIN_BIST_PATTERN   95   /* gpio_o[41] */
#define PIN_POLARITY       96   /* gpio_o[42] */
#define PIN_BYTE_VIEW      97   /* gpio_o[43] */

/* dot11 FFT window shift */
#define PIN_DOT11_FFT_WIN_0    98   /* gpio_o[44] */
#define PIN_DOT11_FFT_WIN_1    99   /* gpio_o[45] */
#define PIN_DOT11_FFT_WIN_2   100   /* gpio_o[46] */
#define PIN_DOT11_FFT_WIN_3   101   /* gpio_o[47] */

/* Skip / latency sweep */
#define PIN_LATENCY_SEL_0 102   /* gpio_o[48] */
#define PIN_LATENCY_SEL_1 103   /* gpio_o[49] */
#define PIN_LATENCY_SEL_2 104   /* gpio_o[50] */

/* Byte-bank select (4-bit) */
#define PIN_BYTE_BANK_0   105   /* gpio_o[51] */
#define PIN_BYTE_BANK_1   106   /* gpio_o[52] */
#define PIN_BYTE_BANK_2   107   /* gpio_o[53] */
#define PIN_BYTE_BANK_3   108   /* gpio_o[54] */

/* dot11 plateau / power threshold */
#define PIN_DOT11_PLATEAU_0   109   /* gpio_o[55] */
#define PIN_DOT11_PLATEAU_1   110   /* gpio_o[56] */
#define PIN_DOT11_PWRTHR_0    111   /* gpio_o[57] */
#define PIN_DOT11_PWRTHR_1    112   /* gpio_o[58] */

/* AWGN control */
#define PIN_AWGN_ENABLE       113   /* gpio_o[59] */
#define PIN_AWGN_SHIFT_0      114   /* gpio_o[60] */
#define PIN_AWGN_SHIFT_1      115   /* gpio_o[61] */
#define PIN_AWGN_SHIFT_2      116   /* gpio_o[62] */
#define PIN_AWGN_SHIFT_3      117   /* gpio_o[63] */

/* gpio_i banks */
#define BANK_LO  2   /* gpio_i[31:0]  */
#define BANK_HI  3   /* gpio_i[63:32] */

/* ======================================================================
 * UART register offsets (Zynq PS UART -- no extra include needed)
 * SR bit 1 = RXEMPTY; FIFO offset 0x30 gives received byte.
 * ====================================================================== */
#define UART_SR_OFF    0x2C
#define UART_FIFO_OFF  0x30
#define UART_RXEMPTY   (1U << 1)

/* ======================================================================
 * no-OS platform glue
 * ====================================================================== */
static struct xil_spi_init_param  xil_spi_param  = { .type = SPI_PS,  .flags = 0 };
static struct xil_gpio_init_param xil_gpio_param  = { .type = GPIO_PS, .device_id = GPIO_DEVICE_ID };
#define GPIO_OPS   &xil_gpio_ops
#define SPI_OPS    &xil_spi_ops
#define GPIO_PARAM &xil_gpio_param
#define SPI_PARAM  &xil_spi_param

/* ======================================================================
 * AD9361 init params (unchanged from prior stage)
 * ====================================================================== */
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

/* ======================================================================
 * MCS rate tables
 * ====================================================================== */
typedef struct {
    uint8_t     rate_code;
    const char *mbps;
    const char *mod;
    const char *cr;
} mcs_entry_t;

/* Legacy 802.11a: rate_code = 4-bit L-SIG RATE field */
static const mcs_entry_t mcs_table[8] = {
    { 0x0B, " 6.0 Mbps", "BPSK ", "1/2" },
    { 0x0F, " 9.0 Mbps", "BPSK ", "3/4" },
    { 0x0A, "12.0 Mbps", "QPSK ", "1/2" },
    { 0x0E, "18.0 Mbps", "QPSK ", "3/4" },
    { 0x09, "24.0 Mbps", "16QAM", "1/2" },
    { 0x0D, "36.0 Mbps", "16QAM", "3/4" },
    { 0x08, "48.0 Mbps", "64QAM", "2/3" },
    { 0x0C, "54.0 Mbps", "64QAM", "3/4" },
};

/* 802.11n HT-MF: rate_code = {1'b1, mcs[6:0]} = 0x80|mcs */
static const mcs_entry_t ht_mcs_table[8] = {
    { 0x80, " 6.5 Mbps", "BPSK ", "1/2" },
    { 0x81, "13.0 Mbps", "QPSK ", "1/2" },
    { 0x82, "19.5 Mbps", "QPSK ", "3/4" },
    { 0x83, "26.0 Mbps", "16QAM", "1/2" },
    { 0x84, "39.0 Mbps", "16QAM", "3/4" },
    { 0x85, "52.0 Mbps", "64QAM", "2/3" },
    { 0x86, "58.5 Mbps", "64QAM", "3/4" },
    { 0x87, "65.0 Mbps", "64QAM", "5/6" },
};

/* ======================================================================
 * PSDU constants and test pattern
 * ====================================================================== */
#define PSDU_BYTES   100
#define DATA_BYTES    96
#define FCS_BYTES_N    4

/* Known TX data pattern: bytes 0x09..0x68 at ROM words 2..13 */
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

/* ======================================================================
 * Phase 3: xcvr relay BRAM
 *
 * XPAR_AXI_BRAM_CTRL_XCVR_S_AXI_BASEADDR is auto-generated by Vitis in
 * xparameters.h after the BD rebuild + XSA update.  If the symbol is missing,
 * you need to (a) rebuild with the Phase 3 TCL, (b) update the platform in
 * Vitis, (c) rebuild the BSP.
 *
 * BRAM layout (matches openofdm_tx ROM convention):
 *   Word 0 (bytes 0..7)  : L-SIG header (lo=L-SIG value, hi=PKT_TYPE flag)
 *   Word 1 (bytes 8..15) : HT-SIG bits (HT) or W_SVC placeholder (legacy)
 *   Words 2..13 (bytes 16..111): PSDU data, 8 bytes each, little-endian
 *   Word 14 onwards: unused (FCS computed by openofdm_tx internally)
 *
 * The xcvr BRAM holds exactly 1 packet block (64 words × 8 bytes = 512 B).
 * openofdm_tx reads it via Port B using bram_addr[5:0] (within-block offset).
 * ====================================================================== */
#define XCVR_BRAM_BASE  XPAR_AXI_BRAM_CTRL_XCVR_S_AXI_BASEADDR

/* Legacy L-SIG lower-32 values (rate+length+parity fields, upper 32 = 0). */
static const uint32_t legacy_lsig_lo[8] = {
    0x00000C8B,  /* MCS 0  6 Mbps  BPSK 1/2  parity=0 */
    0x00020C8F,  /* MCS 1  9 Mbps  BPSK 3/4  parity=1 */
    0x00020C8A,  /* MCS 2 12 Mbps  QPSK 1/2  parity=1 */
    0x00000C8E,  /* MCS 3 18 Mbps  QPSK 3/4  parity=0 */
    0x00020C89,  /* MCS 4 24 Mbps  16QAM 1/2 parity=1 */
    0x00000C8D,  /* MCS 5 36 Mbps  16QAM 3/4 parity=0 */
    0x00000C88,  /* MCS 6 48 Mbps  64QAM 2/3 parity=0 */
    0x00020C8C,  /* MCS 7 54 Mbps  64QAM 3/4 parity=1 */
};

/* HT word-1 lo/hi (HT-SIG with pre-computed CRC8, see tx_packet_rom_ht_mcs.v). */
static const uint32_t ht_word1_lo[8] = {
    0x07006400, 0x07006401, 0x07006402, 0x07006403,
    0x07006404, 0x07006405, 0x07006406, 0x07006407,
};
static const uint32_t ht_word1_hi[8] = {
    0x000000FC, 0x00000070, 0x000001E4, 0x00000168,
    0x000002CC, 0x00000240, 0x000003D4, 0x00000358,
};

/* ======================================================================
 * Adaptive sweep parameters
 * ====================================================================== */
#define SHIFT_START         7
#define SHIFT_END          15
#define ADAPT_ERROR_TARGET 100
#define ADAPT_MAX_PKTS   10000

/* ======================================================================
 * Global state
 * ====================================================================== */
static XGpioPs           ps_gpio;
static struct ad9361_rf_phy *g_phy    = NULL;
static int               g_rf_skip   = 3;   /* last known alignment values */
static int               g_rf_pol    = 0;

static int waterfall_threshold[8];
static int ht_waterfall_threshold[8];

/* ======================================================================
 * GUI protocol control
 * ##-prefixed lines are parsed by ofdm_gui.py for metrics/state.
 * All other output goes to the log as plain text.
 * g_stop is set when the Python sends any character during an operation.
 * ====================================================================== */
static volatile int g_stop = 0;

/* Emit a structured marker line (Python parser looks for ##). */
#define EMIT(fmt, ...) xil_printf("##" fmt "\r\n", ##__VA_ARGS__)

/* ======================================================================
 * SECTION 5: UART HELPERS
 * ====================================================================== */

/* Non-blocking: returns char (0-255) if data ready, else -1. */
static int uart_peek(void)
{
    if (!(Xil_In32(STDIN_BASEADDRESS + UART_SR_OFF) & UART_RXEMPTY))
        return (int)(Xil_In32(STDIN_BASEADDRESS + UART_FIFO_OFF) & 0xFF);
    return -1;
}

/* Blocking single-character read with echo. */
static char uart_getc(void)
{
    char c = (char)inbyte();
    outbyte(c);
    if (c == '\r') outbyte('\n');
    return c;
}

/*
 * Blocking integer read with echo, backspace, and bounds check.
 * def_val >= 0: pressing Enter alone uses default.
 * Returns -1 if user types 'q'.
 */
static int uart_getint(const char *prompt, int min, int max, int def_val)
{
    char buf[12];
    int  pos = 0;
    memset(buf, 0, sizeof(buf));

    if (def_val >= 0)
        xil_printf("%s (%d-%d, Enter=%d): ", prompt, min, max, def_val);
    else
        xil_printf("%s (%d-%d): ", prompt, min, max);

    while (1) {
        char c = (char)inbyte();

        if (c == 'q' || c == 'Q') {
            xil_printf("[cancelled]\r\n");
            return -1;
        }
        if (c == '\r' || c == '\n') {
            if (pos == 0 && def_val >= 0) {
                xil_printf("%d\r\n", def_val);
                return def_val;
            }
            if (pos == 0) continue;

            buf[pos] = '\0';
            /* manual atoi */
            int val = 0;
            int ok  = 1;
            for (int i = 0; buf[i]; i++) {
                if (buf[i] < '0' || buf[i] > '9') { ok = 0; break; }
                val = val * 10 + (buf[i] - '0');
            }
            if (!ok || val < min || val > max) {
                xil_printf("\r\n  Out of range -- enter %d-%d: ", min, max);
                pos = 0;
                memset(buf, 0, sizeof(buf));
                continue;
            }
            xil_printf("\r\n");
            return val;
        }
        if ((c == '\b' || c == 127) && pos > 0) {
            pos--;
            xil_printf("\b \b");
            continue;
        }
        if (c >= '0' && c <= '9' && pos < 10) {
            buf[pos++] = c;
            outbyte(c);
        }
    }
}

/* ======================================================================
 * SECTION 6: DISPLAY HELPERS
 * ====================================================================== */

static void print_separator(void)
{
    xil_printf("  ------------------------------------------------------------\r\n");
}

static void print_hex_dump(const uint8_t *data, int len)
{
    for (int i = 0; i < len; i++) {
        if (i % 16 == 0) xil_printf("  %04X: ", i);
        xil_printf("%02X ", data[i]);
        if (i % 16 == 7)  xil_printf(" ");
        if (i % 16 == 15 || i == len - 1) xil_printf("\r\n");
    }
}

/* Forward declarations: IQ helpers are defined in Section 7b below. */
static void print_iq_table(int is_tx, int n);
static void print_iq_power_plot(int is_tx, int n);

/* TX IQ display -- 16 samples + ASCII power plot. */
static void print_tx_iq_info(int mcs, int is_ht)
{
    const mcs_entry_t *tbl = is_ht ? ht_mcs_table : mcs_table;
    xil_printf("  TX: %s MCS %d  %s %s  %s Mbps\r\n",
               is_ht ? "HT" : "Legacy", mcs,
               tbl[mcs].mod, tbl[mcs].cr, tbl[mcs].mbps);
    print_iq_table(1, 16);
    print_iq_power_plot(1, 16);
}

/* RX IQ display -- 16 samples + ASCII power plot. */
static void print_rx_iq_info(void)
{
    print_iq_table(0, 16);
    print_iq_power_plot(0, 16);
}

static void print_system_info(void)
{
    uint32_t lclk_count = ADC_RD(0x0054);
    uint32_t lclk_hz    = (uint32_t)((uint64_t)lclk_count * 100000000ULL / 65536ULL);

    uint32_t lo = XGpioPs_Read(&ps_gpio, BANK_LO);
    uint32_t hi = XGpioPs_Read(&ps_gpio, BANK_HI);

    uint8_t  s_fcs  = (lo >>  0) & 0xFF;
    uint8_t  s_bad  = (lo >>  8) & 0xFF;
    uint8_t  s_hdr  = (lo >> 16) & 0xFF;
    uint8_t  s_rate = (lo >> 24) & 0xFF;
    uint16_t s_len  = (hi >>  0) & 0xFFFF;

    int32_t r017 = (g_phy != NULL) ? ad9361_spi_read(g_phy->spi, 0x017) : -1;

    xil_printf("\r\n=== System Status ===\r\n");
    xil_printf("  RF align : skip=%d  pol=%d\r\n", g_rf_skip, g_rf_pol);
    xil_printf("  l_clk    : ~%u Hz  (want ~80 MHz)\r\n", lclk_hz);
    if (r017 >= 0)
        xil_printf("  ENSM     : 0x%X  (%s)\r\n", r017 & 0xF,
                   (r017 & 0xF) == 0xA ? "FDD OK" : "WARN");
    xil_printf("  Counters : fcs_ok=%u  bad=%u  hdr=%u\r\n", s_fcs, s_bad, s_hdr);
    xil_printf("  Last pkt : rate=0x%02X  len=%u\r\n", s_rate, s_len);
    xil_printf("  AWGN     : disabled\r\n");
    xil_printf("  Phase 2  : force_rx / IQ capture (HDL rebuilt)\r\n");
    xil_printf("  Phase 3  : xcvr AXI BRAM relay (BD + HDL rebuilt)\r\n");
    xil_printf("=====================\r\n");
}

/* ======================================================================
 * SECTION 7: GPIO / CONTROL HELPERS
 * ====================================================================== */

static int ps_gpio_init(void)
{
    XGpioPs_Config *cfg = XGpioPs_LookupConfig(XPAR_XGPIOPS_0_DEVICE_ID);
    if (!cfg) return -1;
    if (XGpioPs_CfgInitialize(&ps_gpio, cfg, cfg->BaseAddr) != XST_SUCCESS) return -1;

    /* MCS selector + HT mode: default MCS 0, legacy */
    int mcs_pins[] = { PIN_MCS_SEL_0, PIN_MCS_SEL_1, PIN_MCS_SEL_2 };
    for (int i = 0; i < 3; i++) {
        XGpioPs_SetDirectionPin   (&ps_gpio, mcs_pins[i], 1);
        XGpioPs_SetOutputEnablePin(&ps_gpio, mcs_pins[i], 1);
        XGpioPs_WritePin          (&ps_gpio, mcs_pins[i], 0);
    }
    XGpioPs_SetDirectionPin   (&ps_gpio, PIN_HT_MODE, 1);
    XGpioPs_SetOutputEnablePin(&ps_gpio, PIN_HT_MODE, 1);
    XGpioPs_WritePin          (&ps_gpio, PIN_HT_MODE, 0);

    /* Phase 2 + Phase 3 GPIO pins */
    int phase23_pins[] = {
        PIN_FORCE_RX, PIN_IQ_VIEW_EN, PIN_IQ_SEL_TX,
        PIN_IQ_IDX_0, PIN_IQ_IDX_1, PIN_IQ_IDX_2, PIN_IQ_IDX_3, PIN_IQ_IDX_4,
        PIN_XCVR_BRAM_SEL   /* Phase 3: default 0 = ROM path */
    };
    for (int i = 0; i < 9; i++) {
        XGpioPs_SetDirectionPin   (&ps_gpio, phase23_pins[i], 1);
        XGpioPs_SetOutputEnablePin(&ps_gpio, phase23_pins[i], 1);
        XGpioPs_WritePin          (&ps_gpio, phase23_pins[i], 0);
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

    XGpioPs_WritePin(&ps_gpio, PIN_DOT11_SOFT_DEC,   1);
    XGpioPs_WritePin(&ps_gpio, PIN_DOT11_DIS_SMOOTH, 1);
    XGpioPs_WritePin(&ps_gpio, PIN_DOT11_FFT_WIN_0,  1);
    XGpioPs_WritePin(&ps_gpio, PIN_DOT11_PLATEAU_0,  1);
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
    usleep(200);
}

static void set_ht_mode(int ht)
{
    XGpioPs_WritePin(&ps_gpio, PIN_HT_MODE, ht ? 1 : 0);
    usleep(200);
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

/* Force RX start -- Phase 2: HDL now uses this bit. */
static void set_force_rx(int en)
{
    XGpioPs_WritePin(&ps_gpio, PIN_FORCE_RX, en ? 1 : 0);
    usleep(200);   /* 200 µs: 2-FF CDC settle */
}

/* ======================================================================
 * SECTION 7a: XCVR RELAY BRAM  (Phase 3)
 *
 * PS writes the packet header (words 0-1) and PSDU (words 2-13) to the
 * AXI-accessible xcvr BRAM before asserting xcvr_bram_sel.  openofdm_tx
 * then reads from this BRAM instead of the static ROMs.
 *
 * Word layout (same as tx_packet_rom_mcs / tx_packet_rom_ht_mcs):
 *   Word 0: L-SIG (lo=rate field value, hi=PKT_TYPE for HT)
 *   Word 1: HT-SIG bits (HT) or W_SVC placeholder (legacy)
 *   Words 2..13: PSDU data, little-endian, 8 bytes each
 *
 * AXI BRAM is byte-addressed.  Each 64-bit word = two 32-bit AXI writes:
 *   Xil_Out32(XCVR_BRAM_BASE + word_idx*8 + 0, lo32)  -- bits [31:0]
 *   Xil_Out32(XCVR_BRAM_BASE + word_idx*8 + 4, hi32)  -- bits [63:32]
 * ====================================================================== */

static void set_xcvr_bram(int en)
{
    XGpioPs_WritePin(&ps_gpio, PIN_XCVR_BRAM_SEL, en ? 1 : 0);
    usleep(200);   /* 2-FF CDC settle */
}

static void xcvr_bram_write64(int word_idx, uint32_t lo32, uint32_t hi32)
{
    uint32_t base = (uint32_t)XCVR_BRAM_BASE + (uint32_t)(word_idx * 8);
    Xil_Out32(base,     lo32);
    Xil_Out32(base + 4, hi32);
}

/*
 * Write a complete relay packet to the xcvr BRAM.
 * Header words are rebuilt from the MCS/HT tables (same values as the ROM).
 * PSDU data is taken from rx_psdu[0..DATA_BYTES-1] (received data, 96 bytes).
 * Word 1 for legacy carries W_SVC (0x01..0x08 placeholder; openofdm_tx does
 * not read it for PSDU -- SERVICE bits are auto-generated by the scrambler).
 */
static void xcvr_bram_write_packet(const uint8_t *rx_psdu, int mcs, int is_ht)
{
    /* Word 0: L-SIG */
    uint32_t w0_lo = is_ht ? 0x01000C8B : legacy_lsig_lo[mcs];
    xcvr_bram_write64(0, w0_lo, 0x00000000);

    /* Word 1: HT-SIG (HT) or W_SVC placeholder (legacy) */
    if (is_ht) {
        xcvr_bram_write64(1, ht_word1_lo[mcs], ht_word1_hi[mcs]);
    } else {
        xcvr_bram_write64(1, 0x04030201, 0x08070605);  /* W_SVC: bytes 1..8 */
    }

    /* Words 2..13: received PSDU bytes, little-endian packing. */
    for (int w = 0; w < 12; w++) {
        const uint8_t *b = rx_psdu + w * 8;
        uint32_t lo = (uint32_t)b[0]        | ((uint32_t)b[1] <<  8)
                    | ((uint32_t)b[2] << 16) | ((uint32_t)b[3] << 24);
        uint32_t hi = (uint32_t)b[4]        | ((uint32_t)b[5] <<  8)
                    | ((uint32_t)b[6] << 16) | ((uint32_t)b[7] << 24);
        xcvr_bram_write64(2 + w, lo, hi);
    }
}

/* ======================================================================
 * SECTION 7b: IQ SAMPLE READBACK  (Phase 2)
 *
 * Reads one 16-bit signed I/Q sample from the capture buffer via gpio_i.
 * The HDL mux: gpio_i[31:16] = I,  gpio_i[15:0] = Q.
 * PS must wait >= 2 bb_clk cycles (>> 20 ns) after setting the index
 * before reading.  usleep(10) >> 1 µs is far more than enough.
 *
 * is_tx=1 -> TX capture buffer (bb_clk domain, direct)
 * is_tx=0 -> RX capture buffer (l_clk domain, 2-FF synced to bb_clk)
 * ====================================================================== */

static void set_iq_idx(int is_tx, int idx)
{
    XGpioPs_WritePin(&ps_gpio, PIN_IQ_VIEW_EN, 1);
    XGpioPs_WritePin(&ps_gpio, PIN_IQ_SEL_TX,  is_tx ? 1 : 0);
    XGpioPs_WritePin(&ps_gpio, PIN_IQ_IDX_0,   (idx >>  0) & 1);
    XGpioPs_WritePin(&ps_gpio, PIN_IQ_IDX_1,   (idx >>  1) & 1);
    XGpioPs_WritePin(&ps_gpio, PIN_IQ_IDX_2,   (idx >>  2) & 1);
    XGpioPs_WritePin(&ps_gpio, PIN_IQ_IDX_3,   (idx >>  3) & 1);
    XGpioPs_WritePin(&ps_gpio, PIN_IQ_IDX_4,   (idx >>  4) & 1);
    XGpioPs_WritePin(&ps_gpio, PIN_IQ_IDX_5,   (idx >>  5) & 1);
    XGpioPs_WritePin(&ps_gpio, PIN_IQ_IDX_6,   (idx >>  6) & 1);
    XGpioPs_WritePin(&ps_gpio, PIN_IQ_IDX_7,   (idx >>  7) & 1);
    XGpioPs_WritePin(&ps_gpio, PIN_IQ_IDX_8,   (idx >>  8) & 1);
    XGpioPs_WritePin(&ps_gpio, PIN_IQ_IDX_9,   (idx >>  9) & 1);
    XGpioPs_WritePin(&ps_gpio, PIN_IQ_IDX_10,  (idx >> 10) & 1);
    XGpioPs_WritePin(&ps_gpio, PIN_IQ_IDX_11,  (idx >> 11) & 1);
    usleep(10);   /* settle >> 3 clk cycles at 80/100 MHz */
}

static void read_iq_sample(int is_tx, int idx, int16_t *i_out, int16_t *q_out)
{
    set_iq_idx(is_tx, idx);
    uint32_t lo = XGpioPs_Read(&ps_gpio, BANK_LO);
    /* gpio_i = {32'h0, iq_i[15:0], iq_q[15:0]}  -> BANK_LO = gpio_i[31:0] */
    *i_out = (int16_t)((lo >> 16) & 0xFFFF);
    *q_out = (int16_t)((lo >>  0) & 0xFFFF);
    XGpioPs_WritePin(&ps_gpio, PIN_IQ_VIEW_EN, 0);
}

/* Read n samples (n up to 4096) into caller-supplied buffers. */
static void read_iq_burst(int is_tx, int n, int16_t *i_buf, int16_t *q_buf)
{
    if (n > 4096) n = 4096;
    XGpioPs_WritePin(&ps_gpio, PIN_IQ_VIEW_EN, 1);
    XGpioPs_WritePin(&ps_gpio, PIN_IQ_SEL_TX,  is_tx ? 1 : 0);
    for (int k = 0; k < n; k++) {
        XGpioPs_WritePin(&ps_gpio, PIN_IQ_IDX_0,  (k >>  0) & 1);
        XGpioPs_WritePin(&ps_gpio, PIN_IQ_IDX_1,  (k >>  1) & 1);
        XGpioPs_WritePin(&ps_gpio, PIN_IQ_IDX_2,  (k >>  2) & 1);
        XGpioPs_WritePin(&ps_gpio, PIN_IQ_IDX_3,  (k >>  3) & 1);
        XGpioPs_WritePin(&ps_gpio, PIN_IQ_IDX_4,  (k >>  4) & 1);
        XGpioPs_WritePin(&ps_gpio, PIN_IQ_IDX_5,  (k >>  5) & 1);
        XGpioPs_WritePin(&ps_gpio, PIN_IQ_IDX_6,  (k >>  6) & 1);
        XGpioPs_WritePin(&ps_gpio, PIN_IQ_IDX_7,  (k >>  7) & 1);
        XGpioPs_WritePin(&ps_gpio, PIN_IQ_IDX_8,  (k >>  8) & 1);
        XGpioPs_WritePin(&ps_gpio, PIN_IQ_IDX_9,  (k >>  9) & 1);
        XGpioPs_WritePin(&ps_gpio, PIN_IQ_IDX_10, (k >> 10) & 1);
        XGpioPs_WritePin(&ps_gpio, PIN_IQ_IDX_11, (k >> 11) & 1);
        usleep(10);
        uint32_t lo = XGpioPs_Read(&ps_gpio, BANK_LO);
        i_buf[k] = (int16_t)((lo >> 16) & 0xFFFF);
        q_buf[k] = (int16_t)((lo >>  0) & 0xFFFF);
    }
    XGpioPs_WritePin(&ps_gpio, PIN_IQ_VIEW_EN, 0);
}

/* Integer square-root approximation (Newton, good enough for display). */
static uint32_t isqrt32(uint32_t n)
{
    if (n == 0) return 0;
    uint32_t x = n, x1;
    do { x1 = x; x = (x + n / x) / 2; } while (x < x1);
    return x1;
}

static void print_iq_table(int is_tx, int n)
{
    int16_t ibuf[32], qbuf[32];
    if (n > 32) n = 32;
    read_iq_burst(is_tx, n, ibuf, qbuf);

    xil_printf("  %s IQ (first %d samples):\r\n", is_tx ? "TX" : "RX", n);
    xil_printf("  idx |      I      |      Q      | |IQ|\r\n");
    xil_printf("  ----|-------------|-------------|-----\r\n");
    for (int k = 0; k < n; k++) {
        uint32_t mag = isqrt32((uint32_t)((int32_t)ibuf[k]*ibuf[k]
                                         + (int32_t)qbuf[k]*qbuf[k]));
        xil_printf("  %3d | %+7d     | %+7d     | %u\r\n",
                   k, (int)ibuf[k], (int)qbuf[k], mag);
    }
}

static void print_iq_power_plot(int is_tx, int n)
{
    int16_t ibuf[32], qbuf[32];
    if (n > 32) n = 32;
    read_iq_burst(is_tx, n, ibuf, qbuf);

    /* Find max power for normalisation. */
    uint32_t max_p = 1;
    for (int k = 0; k < n; k++) {
        uint32_t p = (uint32_t)((int32_t)ibuf[k]*ibuf[k]
                               +(int32_t)qbuf[k]*qbuf[k]);
        if (p > max_p) max_p = p;
    }

    xil_printf("  %s power plot (%d samples, 20-char scale):\r\n",
               is_tx ? "TX" : "RX", n);
    for (int k = 0; k < n; k++) {
        uint32_t p    = (uint32_t)((int32_t)ibuf[k]*ibuf[k]
                                  +(int32_t)qbuf[k]*qbuf[k]);
        int      bars = (int)((p * 20UL) / max_p);
        uint32_t mag  = isqrt32(p);
        xil_printf("  [%2d] |", k);
        for (int b = 0; b < 20; b++) outbyte(b < bars ? '#' : '.');
        xil_printf("| %u\r\n", mag);
    }
}

/* ======================================================================
 * SECTION 7c: GUI IQ / PACKET DATA EMITTERS
 * ====================================================================== */

/* Auto-emit: always 32 samples (fast, backward-compatible with old bitstream). */
static void emit_iq_burst_gui(int is_tx, int n)
{
    static int16_t ibuf[4096], qbuf[4096];
    if (n > 4096) n = 4096;
    read_iq_burst(is_tx, n, ibuf, qbuf);
    xil_printf("##IQ_BURST is_tx=%d n=%d data=", is_tx, n);
    for (int k = 0; k < n; k++) {
        if (k) outbyte(',');
        xil_printf("%d,%d", (int)ibuf[k], (int)qbuf[k]);
    }
    xil_printf("\r\n");
}

/* On-demand full-packet capture. Emits one TX + one RX burst of n samples.
 * n up to 4096 (TX); RX valid indices are 0..(CAPTURE_LIMIT-1) ~ 0..3499.
 * At 115200 baud each 1024-sample burst takes ~0.8 s to transmit. */
static void cmd_capiq(int n)
{
    if (n < 1 || n > 4096) {
        EMIT("ERR CAPIQ n must be 1..4096");
        return;
    }
    xil_printf("[capiq] capturing %d samples TX+RX...\r\n", n);
    emit_iq_burst_gui(1, n);
    emit_iq_burst_gui(0, n);
    EMIT("CAPIQ_DONE n=%d", n);
}

static void emit_pkt_data_buf(int pkt_num, int fcs_ok, int hdr_ok,
                               const uint8_t *rx_bytes, int n)
{
    xil_printf("##PKT_DATA pkt=%d fcs=%d hdr=%d n=%d hex=",
               pkt_num, fcs_ok, hdr_ok, n);
    for (int b = 0; b < n; b++) {
        if (b) outbyte(' ');
        xil_printf("%02X", (unsigned)rx_bytes[b]);
    }
    xil_printf("\r\n");
}

static void emit_tx_ref(void)
{
    xil_printf("##TX_REF n=%d hex=", DATA_BYTES);
    for (int b = 0; b < DATA_BYTES; b++) {
        if (b) outbyte(' ');
        xil_printf("%02X", (unsigned)expected_bytes[b]);
    }
    xil_printf("\r\n");
}

/* ======================================================================
 * SECTION 8: ADC/DAC & MEASUREMENT HELPERS
 * ====================================================================== */

static int awgn_shift_to_snr_db(int shift)
{
    return (shift - 8) * 6 + 3;
}

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
        tmp[bank*8+0] = (blo >>  0) & 0xFF;
        tmp[bank*8+1] = (blo >>  8) & 0xFF;
        tmp[bank*8+2] = (blo >> 16) & 0xFF;
        tmp[bank*8+3] = (blo >> 24) & 0xFF;
        tmp[bank*8+4] = (bhi >>  0) & 0xFF;
        tmp[bank*8+5] = (bhi >>  8) & 0xFF;
        tmp[bank*8+6] = (bhi >> 16) & 0xFF;
        tmp[bank*8+7] = (bhi >> 24) & 0xFF;
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

static int count_rx_bit_errors(void)
{
    uint8_t rx[PSDU_BYTES];
    read_rx_bytes(rx);
    int errs = 0;
    for (int b = 0; b < DATA_BYTES; b++)
        errs += popcount8(rx[b] ^ expected_bytes[b]);
    return errs;
}

static int count_rx_bit_errors_buf(uint8_t rx[PSDU_BYTES])
{
    read_rx_bytes(rx);
    int errs = 0;
    for (int b = 0; b < DATA_BYTES; b++)
        errs += popcount8(rx[b] ^ expected_bytes[b]);
    return errs;
}

/* ======================================================================
 * SECTION 9: RF ALIGNMENT & PACKET VERIFY
 * ====================================================================== */

static int rf_align(int *skip_out, int *pol_out, int is_ht)
{
    uint32_t base_lo, base_hi;
    read_status(&base_lo, &base_hi);
    uint8_t base_fcs = (base_lo >>  0) & 0xFF;
    uint8_t base_hdr = (base_lo >> 16) & 0xFF;
    uint8_t expected_rate = is_ht ? ht_mcs_table[0].rate_code
                                  : mcs_table[0].rate_code;

    for (int pol = 0; pol < 2; pol++) {
        XGpioPs_WritePin(&ps_gpio, PIN_POLARITY, pol);
        usleep(100);
        for (int sel = 0; sel < 8; sel++) {
            set_latency_sel(sel);
            xil_printf("  [align] pol=%d sel=%d ... ", pol, sel);
            trigger_tx();
            usleep(100000);

            uint32_t slo, shi;
            read_status(&slo, &shi);
            uint8_t  s_fcs  = (slo >>  0) & 0xFF;
            uint8_t  s_hdr  = (slo >> 16) & 0xFF;
            uint8_t  s_rate = (slo >> 24) & 0xFF;
            uint16_t s_len  = (shi >>  0) & 0xFFFF;

            int rate_ok = is_ht ? (s_rate == expected_rate)
                                : ((s_rate & 0x0F) == expected_rate);
            if (s_fcs > base_fcs && rate_ok && s_len == PSDU_BYTES) {
                xil_printf("GOOD  rate=0x%02X len=%d\r\n", s_rate, s_len);
                *skip_out = sel;
                *pol_out  = pol;
                return 1;
            }
            if (s_hdr > base_hdr)
                xil_printf("hdr++ (rate=0x%02X len=%d, no FCS)\r\n", s_rate, s_len);
            else
                xil_printf("no decode\r\n");

            base_fcs = s_fcs;
            base_hdr = s_hdr;
        }
    }
    return 0;
}

static int verify_mcs_decode(int mcs, int n_tries, int is_ht)
{
    uint32_t lo0, hi0;
    read_status(&lo0, &hi0);
    uint8_t base_fcs = (lo0 >> 0) & 0xFF;
    int ok = 0;

    for (int i = 0; i < n_tries; i++) {
        trigger_tx();
        usleep(50000);
        uint32_t lo, hi;
        read_status(&lo, &hi);
        uint8_t s_fcs  = (lo >>  0) & 0xFF;
        uint8_t s_rate = (lo >> 24) & 0xFF;
        int rate_match = is_ht ? (s_rate == ht_mcs_table[mcs].rate_code)
                               : ((s_rate & 0x0F) == mcs_table[mcs].rate_code);
        if (s_fcs > base_fcs && rate_match) ok++;
        base_fcs = s_fcs;
    }
    return ok;
}

/* ======================================================================
 * SECTION 10: BER SWEEP FUNCTIONS
 * ====================================================================== */

/*
 * Adaptive sweep (existing logic, unchanged behaviour).
 * wf[] = waterfall threshold array (per-mode pointer).
 */
static void run_mcs_snr_sweep(int mcs, int shift_start, int shift_end, int is_ht)
{
    const mcs_entry_t *tbl = is_ht ? ht_mcs_table : mcs_table;
    int *wf = is_ht ? ht_waterfall_threshold : waterfall_threshold;

    xil_printf("\r\n");
    print_separator();
    xil_printf("  %s MCS %d  %s  %s %s  (pkt_rate=0x%02X)\r\n",
               is_ht ? "HT" : "Legacy", mcs,
               tbl[mcs].mbps, tbl[mcs].mod, tbl[mcs].cr,
               tbl[mcs].rate_code);
    xil_printf("  SNR range: %d dB .. %d dB  (shift %d..%d)\r\n",
               awgn_shift_to_snr_db(shift_start),
               awgn_shift_to_snr_db(shift_end),
               shift_start, shift_end);
    xil_printf("  Stop per point: %d errors OR %d pkts\r\n",
               ADAPT_ERROR_TARGET, ADAPT_MAX_PKTS);
    xil_printf("  shift | SNR(dB) | sent  | ok    | part  | miss  | PER(%%) | BER(ppm) | why\r\n");
    xil_printf("  ------|---------|-------|-------|-------|-------|--------|----------|----\r\n");

    wf[mcs] = -1;
    awgn_set_enable(1);

    for (int sh = shift_start; sh <= shift_end; sh++) {
        awgn_set_shift(sh);
        usleep(1000);

        int ok = 0, partial = 0, miss = 0;
        int total_bits = 0, total_errors_bits = 0;
        int pkt_errors = 0, n_sent = 0;
        char stop_why = 'M';

        uint8_t last_rx_buf[PSDU_BYTES];
        int last_rx_fcs = 0, last_rx_hdr = 0;

        while (1) {
            uint32_t lo_pre = XGpioPs_Read(&ps_gpio, BANK_LO);
            uint8_t fcs_pre = (lo_pre >>  0) & 0xFF;
            uint8_t hdr_pre = (lo_pre >> 16) & 0xFF;

            trigger_tx();
            usleep(4000);

            uint32_t lo_post = XGpioPs_Read(&ps_gpio, BANK_LO);
            int fcs_d = (((lo_post >>  0) & 0xFF) - fcs_pre) & 0xFF;
            int hdr_d = (((lo_post >> 16) & 0xFF) - hdr_pre) & 0xFF;

            n_sent++;
            if (fcs_d) {
                ok++;
                total_errors_bits += count_rx_bit_errors_buf(last_rx_buf);
                last_rx_fcs = 1; last_rx_hdr = 0;
            } else if (hdr_d) {
                partial++;
                pkt_errors++;
                total_errors_bits += count_rx_bit_errors_buf(last_rx_buf);
                last_rx_fcs = 0; last_rx_hdr = 1;
            } else {
                miss++;
                pkt_errors++;
                total_errors_bits += DATA_BYTES * 8;
            }
            total_bits += DATA_BYTES * 8;

            if (pkt_errors >= ADAPT_ERROR_TARGET) { stop_why = 'E'; break; }
            if (n_sent >= ADAPT_MAX_PKTS) break;
            /* Check for STOP from Python (non-blocking) */
            if (uart_peek() >= 0) { g_stop = 1; stop_why = 'S'; break; }
        }

        /* IQ snapshot + last received packet for GUI */
        emit_iq_burst_gui(1, 32);
        emit_iq_burst_gui(0, 32);
        if (last_rx_fcs || last_rx_hdr)
            emit_pkt_data_buf(n_sent, last_rx_fcs, last_rx_hdr,
                              last_rx_buf, DATA_BYTES);

        int per_pct_x10 = (pkt_errors * 1000) / n_sent;
        uint32_t ber_ppm = (uint32_t)((uint64_t)total_errors_bits * 1000000ULL
                           / (uint64_t)total_bits);

        xil_printf("  %5d | %7d | %5d | %5d | %5d | %5d | %3d.%d  | %8u | %c\r\n",
                   sh, awgn_shift_to_snr_db(sh),
                   n_sent, ok, partial, miss,
                   per_pct_x10 / 10, per_pct_x10 % 10,
                   ber_ppm, stop_why);

        /* Structured marker for Python GUI plot update */
        EMIT("SWEEP_PT mcs=%d ht=%d shift=%d snr=%d sent=%d ok=%d part=%d miss=%d per_x10=%d ber_ppm=%u why=%c",
             mcs, is_ht, sh, awgn_shift_to_snr_db(sh),
             n_sent, ok, partial, miss, per_pct_x10, ber_ppm, stop_why);

        if (wf[mcs] < 0 && per_pct_x10 < 50)
            wf[mcs] = sh;

        if (g_stop) break;
    }

    awgn_set_enable(0);
    awgn_set_shift(0);
    xil_printf("  AWGN off. (E=error limit, M=pkt cap, S=stop cmd)\r\n");
}

/*
 * Single SNR point -- for Loopback fixed-SNR mode.
 * Sends exactly n_pkts; no early-exit.
 */
static void run_single_snr_point(int mcs, int is_ht, int shift, int n_pkts)
{
    const mcs_entry_t *tbl = is_ht ? ht_mcs_table : mcs_table;

    xil_printf("  Running %d pkts at shift=%d (%d dB)...\r\n",
               n_pkts, shift, awgn_shift_to_snr_db(shift));

    awgn_set_enable(1);
    awgn_set_shift(shift);
    usleep(1000);

    int ok = 0, partial = 0, miss = 0;
    int total_bits = 0, total_errors_bits = 0;
    uint8_t last_rx_buf[PSDU_BYTES];
    int last_rx_fcs = 0, last_rx_hdr = 0;

    for (int p = 0; p < n_pkts; p++) {
        uint32_t lo_pre = XGpioPs_Read(&ps_gpio, BANK_LO);
        uint8_t fcs_pre = (lo_pre >>  0) & 0xFF;
        uint8_t hdr_pre = (lo_pre >> 16) & 0xFF;

        trigger_tx();
        usleep(4000);

        uint32_t lo_post = XGpioPs_Read(&ps_gpio, BANK_LO);
        int fcs_d = (((lo_post >>  0) & 0xFF) - fcs_pre) & 0xFF;
        int hdr_d = (((lo_post >> 16) & 0xFF) - hdr_pre) & 0xFF;

        if (fcs_d) {
            ok++;
            total_errors_bits += count_rx_bit_errors_buf(last_rx_buf);
            last_rx_fcs = 1; last_rx_hdr = 0;
        } else if (hdr_d) {
            partial++;
            total_errors_bits += count_rx_bit_errors_buf(last_rx_buf);
            last_rx_fcs = 0; last_rx_hdr = 1;
        } else {
            miss++;
            total_errors_bits += DATA_BYTES * 8;
        }
        total_bits += DATA_BYTES * 8;

        /* progress every 500 packets */
        if ((p + 1) % 500 == 0)
            xil_printf("  ... %d/%d  ok=%d miss=%d\r\n", p+1, n_pkts, ok, miss);
    }

    /* IQ snapshot + last received packet for GUI */
    emit_iq_burst_gui(1, 32);
    emit_iq_burst_gui(0, 32);
    if (last_rx_fcs || last_rx_hdr)
        emit_pkt_data_buf(n_pkts, last_rx_fcs, last_rx_hdr,
                          last_rx_buf, DATA_BYTES);

    awgn_set_enable(0);
    awgn_set_shift(0);

    int pkt_err   = partial + miss;
    int per_x10   = (pkt_err * 1000) / n_pkts;
    uint32_t ber  = (uint32_t)((uint64_t)total_errors_bits * 1000000ULL
                    / (uint64_t)total_bits);

    xil_printf("\r\n");
    print_separator();
    xil_printf("  %s MCS %d  %s  shift=%d  SNR=%d dB\r\n",
               is_ht ? "HT" : "Legacy", mcs, tbl[mcs].mbps,
               shift, awgn_shift_to_snr_db(shift));
    xil_printf("  Pkts: %d total | %d ok | %d partial | %d miss\r\n",
               n_pkts, ok, partial, miss);
    xil_printf("  PER : %d.%d%%\r\n", per_x10 / 10, per_x10 % 10);
    xil_printf("  BER : %u ppm\r\n", ber);
    print_separator();
}

/* ======================================================================
 * SECTION 11: BIST VERIFY (chip loopback, no RF)
 * ====================================================================== */

static void run_bist_verify(void)
{
    xil_printf("\r\n===========================================\r\n");
    xil_printf("  BIST chip data-port loopback verify\r\n");
    xil_printf("  (no RF -- purely digital path, no AWGN)\r\n");
    xil_printf("  20 pkts per legacy MCS\r\n");
    xil_printf("===========================================\r\n");

    if (g_phy == NULL) {
        xil_printf("  SKIP: AD9361 not initialised.\r\n");
        return;
    }

    ad9361_bist_loopback(g_phy, 1);
    usleep(10000);

    xil_printf("  Alignment at legacy MCS 0...\r\n");
    set_ht_mode(0);
    set_mcs(0);
    int bist_skip = -1, bist_pol = -1;
    if (!rf_align(&bist_skip, &bist_pol, 0)) {
        xil_printf("  Alignment FAILED -- skipping BIST.\r\n");
        ad9361_bist_loopback(g_phy, 0);
        return;
    }
    xil_printf("  Aligned: pol=%d skip=%d\r\n", bist_pol, bist_skip);

    xil_printf("  MCS | Rate      | Mod   | CR  | ok | part | miss | BER(ppm) | result\r\n");
    xil_printf("  ----|-----------|-------|-----|----|------|------|----------|-------\r\n");

    for (int mcs = 0; mcs < 8; mcs++) {
        set_mcs(mcs);

        uint32_t lo_base = XGpioPs_Read(&ps_gpio, BANK_LO);
        uint8_t fcs_base = (lo_base >>  0) & 0xFF;
        uint8_t hdr_base = (lo_base >> 16) & 0xFF;

        int ok = 0, partial = 0, miss = 0, total_errors = 0;
        const int n = 20;

        for (int i = 0; i < n; i++) {
            uint32_t lo_pre  = XGpioPs_Read(&ps_gpio, BANK_LO);
            uint8_t fcs_pre  = (lo_pre >>  0) & 0xFF;
            uint8_t hdr_pre  = (lo_pre >> 16) & 0xFF;

            trigger_tx();
            usleep(50000);

            uint32_t lo_post = XGpioPs_Read(&ps_gpio, BANK_LO);
            int fcs_d = (((lo_post >>  0) & 0xFF) - fcs_pre) & 0xFF;
            int hdr_d = (((lo_post >> 16) & 0xFF) - hdr_pre) & 0xFF;

            if (fcs_d)      { ok++;      total_errors += count_rx_bit_errors(); }
            else if (hdr_d) { partial++; total_errors += count_rx_bit_errors(); }
            else            { miss++;    total_errors += DATA_BYTES * 8; }
        }

        uint32_t ber_ppm = (uint32_t)((uint64_t)total_errors * 1000000ULL
                           / ((uint64_t)n * DATA_BYTES * 8));
        const char *verdict = (ok >= 18) ? "PASS"
                            : (ok > 0 || partial > 0) ? "MARGINAL" : "FAIL";
        xil_printf("   %d  | %s | %s | %s  | %2d |  %2d  |  %2d  | %8u | %s\r\n",
                   mcs, mcs_table[mcs].mbps, mcs_table[mcs].mod,
                   mcs_table[mcs].cr, ok, partial, miss, ber_ppm, verdict);
        EMIT("BIST_MCS mcs=%d ok=%d part=%d miss=%d ber_ppm=%u verdict=%s",
             mcs, ok, partial, miss, ber_ppm, verdict);
    }

    EMIT("BIST_DONE");
    ad9361_bist_loopback(g_phy, 0);
    set_mcs(0);
    xil_printf("  BIST done, RF mode restored.\r\n");
}

/* ======================================================================
 * SECTION 12: PYTHON GUI COMMAND PROCESSOR
 *
 * Protocol (newline-terminated ASCII):
 *   Python → C  : STATUS | ALIGN | BIST | STOP
 *                 TX <ht> <mcs> <n>
 *                 RX <ht> <mcs>
 *                 XCVR <ht> <mcs>
 *                 LOOP <ht> <mcs_or_-1_all> <sweep> <ss> <se> <fs> <fn>
 *
 *   C → Python  : plain text (goes to log)
 *                 ##-prefixed lines (parsed by GUI):
 *                   ##READY
 *                   ##STATUS fcs_ok=N bad=N hdr=N rate=0xXX len=N
 *                            lclk=N skip=N pol=N ensm=0xN
 *                   ##ALIGNED skip=N pol=N  |  ##ALIGN_FAILED
 *                   ##BIST_MCS mcs=N ok=N part=N miss=N ber_ppm=N verdict=X
 *                   ##BIST_DONE
 *                   ##SWEEP_PT mcs=N ht=N shift=N snr=N sent=N ok=N
 *                              part=N miss=N per_x10=N ber_ppm=N why=C
 *                   ##SWEEP_DONE
 *                   ##PKT fcs=N hdr=N rate=0xXX len=N ber_ppm=N
 *                   ##TX_DONE sent=N ok=N hdr=N miss=N
 *                   ##DONE  |  ##ERR <msg>
 *
 * g_stop is set when any byte arrives during an operation.
 * The Python sends a single byte (any char) to stop; cmd_readline drains
 * the FIFO before the next command so nothing spills into the next parse.
 * ====================================================================== */

/* Drain UART RX FIFO -- call after g_stop to flush the "STOP\n" bytes. */
static void drain_uart(void)
{
    usleep(5000);           /* let any in-flight bytes arrive */
    while (uart_peek() >= 0);
    g_stop = 0;
}

/* Read one newline-terminated command from UART. Blocks until '\n'. */
static int cmd_readline(char *buf, int max)
{
    int len = 0;
    while (len < max - 1) {
        char c = (char)inbyte();
        if (c == '\r' || c == '\n') break;
        buf[len++] = c;
    }
    buf[len] = '\0';
    return len;
}

/* ------------------------------------------------------------------ */

static void cmd_status(void)
{
    uint32_t lclk_count = ADC_RD(0x0054);
    uint32_t lclk_hz    = (uint32_t)((uint64_t)lclk_count * 100000000ULL / 65536ULL);
    uint32_t lo = XGpioPs_Read(&ps_gpio, BANK_LO);
    uint32_t hi = XGpioPs_Read(&ps_gpio, BANK_HI);
    int32_t ensm = (g_phy != NULL) ? ad9361_spi_read(g_phy->spi, 0x017) : -1;
    EMIT("STATUS fcs_ok=%u bad=%u hdr=%u rate=0x%02X len=%u lclk=%u skip=%d pol=%d ensm=0x%X",
         (lo >>  0) & 0xFF,  /* fcs_ok */
         (lo >>  8) & 0xFF,  /* bad_pkt */
         (lo >> 16) & 0xFF,  /* hdr */
         (lo >> 24) & 0xFF,  /* last rate */
         (hi >>  0) & 0xFFFF,/* last len */
         lclk_hz, g_rf_skip, g_rf_pol,
         ensm >= 0 ? (ensm & 0xF) : 0xF);
}

static void cmd_align(void)
{
    xil_printf("[align] Aligning at legacy MCS 0...\r\n");
    set_ht_mode(0);
    set_mcs(0);
    if (rf_align(&g_rf_skip, &g_rf_pol, 0)) {
        xil_printf("  Aligned: pol=%d skip=%d\r\n", g_rf_pol, g_rf_skip);
        EMIT("ALIGNED skip=%d pol=%d", g_rf_skip, g_rf_pol);
    } else {
        xil_printf("  FAILED -- check SMA cable and gains.\r\n");
        EMIT("ALIGN_FAILED");
    }
    EMIT("DONE");
}

static void cmd_bist(void)
{
    run_bist_verify();
    EMIT("DONE");
}

static void cmd_tx(int is_ht, int mcs, int n_pkts)
{
    xil_printf("[tx] %s MCS %d  n=%d\r\n",
               is_ht ? "HT" : "Legacy", mcs, n_pkts);
    set_ht_mode(is_ht);
    set_mcs(mcs);
    awgn_set_enable(0);
    set_xcvr_bram(0);

    const mcs_entry_t *tbl = is_ht ? ht_mcs_table : mcs_table;
    xil_printf("  Rate: %s  %s  %s  pkt_rate=0x%02X\r\n",
               tbl[mcs].mbps, tbl[mcs].mod, tbl[mcs].cr, tbl[mcs].rate_code);

    emit_tx_ref();

    int sent = 0, ok = 0, hdr_cnt = 0, miss = 0;
    for (int p = 0; p < n_pkts && !g_stop; p++) {
        uint32_t lo_pre = XGpioPs_Read(&ps_gpio, BANK_LO);
        uint8_t fcs_pre = (lo_pre >>  0) & 0xFF;
        uint8_t hdr_pre = (lo_pre >> 16) & 0xFF;

        trigger_tx();
        usleep(50000);

        uint32_t lo_post = XGpioPs_Read(&ps_gpio, BANK_LO);
        uint32_t hi_post = XGpioPs_Read(&ps_gpio, BANK_HI);
        int fcs_d = (((lo_post >>  0) & 0xFF) - fcs_pre) & 0xFF;
        int hdr_d = (((lo_post >> 16) & 0xFF) - hdr_pre) & 0xFF;
        uint8_t s_rate = (lo_post >> 24) & 0xFF;
        uint16_t s_len = (hi_post >>  0) & 0xFFFF;
        sent++;

        uint8_t rx_buf[PSDU_BYTES];
        int ber_ppm = 0, got_bytes = 0;
        if (fcs_d) {
            ok++;
            int errs = count_rx_bit_errors_buf(rx_buf);
            ber_ppm = errs * 1000000 / (DATA_BYTES * 8);
            got_bytes = 1;
        } else if (hdr_d) {
            hdr_cnt++;
            read_rx_bytes(rx_buf);
            got_bytes = 1;
        } else {
            miss++;
        }

        EMIT("TX_PKT n=%d fcs=%d hdr=%d miss=%d rate=0x%02X len=%u ber_ppm=%d",
             sent, fcs_d > 0 ? 1 : 0, hdr_d > 0 && !fcs_d ? 1 : 0,
             !fcs_d && !hdr_d ? 1 : 0, s_rate, s_len, ber_ppm);

        emit_iq_burst_gui(1, 32);
        emit_iq_burst_gui(0, 32);
        if (got_bytes)
            emit_pkt_data_buf(sent, fcs_d > 0 ? 1 : 0,
                              hdr_d > 0 && !fcs_d ? 1 : 0, rx_buf, DATA_BYTES);

        if (uart_peek() >= 0) g_stop = 1;
    }

    EMIT("TX_DONE sent=%d ok=%d hdr=%d miss=%d", sent, ok, hdr_cnt, miss);
    EMIT("DONE");
    if (g_stop) drain_uart();
}

static void cmd_rx(int is_ht, int mcs)
{
    xil_printf("[rx] %s MCS %d  (send any char to stop)\r\n",
               is_ht ? "HT" : "Legacy", mcs);
    set_ht_mode(is_ht);
    set_mcs(mcs);
    set_force_rx(1);
    awgn_set_enable(0);

    emit_tx_ref();

    uint32_t lo0 = XGpioPs_Read(&ps_gpio, BANK_LO);
    uint8_t fcs_base = (lo0 >>  0) & 0xFF;
    uint8_t hdr_base = (lo0 >> 16) & 0xFF;
    int pkt_cnt = 0;

    while (!g_stop) {
        if (uart_peek() >= 0) { g_stop = 1; break; }
        usleep(5000);

        uint32_t lo = XGpioPs_Read(&ps_gpio, BANK_LO);
        uint32_t hi = XGpioPs_Read(&ps_gpio, BANK_HI);
        int fcs_new = ((uint8_t)((lo >>  0) & 0xFF) - fcs_base) & 0xFF;
        int hdr_new = ((uint8_t)((lo >> 16) & 0xFF) - hdr_base) & 0xFF;
        uint8_t s_rate = (lo >> 24) & 0xFF;
        uint16_t s_len = (hi >>  0) & 0xFFFF;

        if (fcs_new || hdr_new) {
            pkt_cnt++;
            uint8_t rx[PSDU_BYTES];
            read_rx_bytes(rx);
            int ber_ppm = 0;
            if (fcs_new) {
                int errs = 0;
                for (int b = 0; b < DATA_BYTES; b++)
                    errs += popcount8(rx[b] ^ expected_bytes[b]);
                ber_ppm = errs * 1000000 / (DATA_BYTES * 8);
            }
            xil_printf("  [RX #%d] rate=0x%02X len=%u %s\r\n",
                       pkt_cnt, s_rate, s_len,
                       fcs_new ? "FCS=OK" : "FCS=FAIL");
            EMIT("PKT fcs=%d hdr=%d rate=0x%02X len=%u ber_ppm=%d",
                 fcs_new > 0 ? 1 : 0, hdr_new > 0 && !fcs_new ? 1 : 0,
                 s_rate, s_len, ber_ppm);
            emit_iq_burst_gui(0, 32);
            emit_pkt_data_buf(pkt_cnt, fcs_new > 0 ? 1 : 0,
                              hdr_new > 0 && !fcs_new ? 1 : 0, rx, DATA_BYTES);
            fcs_base = (lo >>  0) & 0xFF;
            hdr_base = (lo >> 16) & 0xFF;
        }
    }

    set_force_rx(0);
    EMIT("DONE");
    drain_uart();
}

static void cmd_xcvr(int is_ht, int mcs)
{
    xil_printf("[xcvr] %s MCS %d  (send any char to stop)\r\n",
               is_ht ? "HT" : "Legacy", mcs);
    set_ht_mode(is_ht);
    set_mcs(mcs);
    awgn_set_enable(0);
    set_xcvr_bram(0);

    int relay = 0;
    while (!g_stop) {
        if (uart_peek() >= 0) { g_stop = 1; break; }

        relay++;
        /* Step 1: ROM seed TX -> receive echo */
        uint32_t lo_pre = XGpioPs_Read(&ps_gpio, BANK_LO);
        uint8_t fcs_pre = (lo_pre >>  0) & 0xFF;
        uint8_t hdr_pre = (lo_pre >> 16) & 0xFF;
        trigger_tx();
        usleep(50000);

        uint32_t lo_p = XGpioPs_Read(&ps_gpio, BANK_LO);
        int fcs_d = (((lo_p >>  0) & 0xFF) - fcs_pre) & 0xFF;
        int hdr_d = (((lo_p >> 16) & 0xFF) - hdr_pre) & 0xFF;

        if (!fcs_d && !hdr_d) {
            xil_printf("  [relay #%d] seed TX: no decode\r\n", relay);
            EMIT("RELAY relay=%d seed=miss relay_ok=0", relay);
            usleep(200000);
            if (uart_peek() >= 0) g_stop = 1;
            continue;
        }

        /* Step 2: read RX bytes */
        uint8_t rx_buf[PSDU_BYTES];
        read_rx_bytes(rx_buf);

        /* Step 3: write to xcvr BRAM */
        xcvr_bram_write_packet(rx_buf, mcs, is_ht);
        set_xcvr_bram(1);

        /* Step 4: relay TX */
        uint32_t lo_pre2 = XGpioPs_Read(&ps_gpio, BANK_LO);
        uint8_t fcs_pre2 = (lo_pre2 >>  0) & 0xFF;
        trigger_tx();
        usleep(50000);

        uint32_t lo_r = XGpioPs_Read(&ps_gpio, BANK_LO);
        int fcs_r = (((lo_r >>  0) & 0xFF) - fcs_pre2) & 0xFF;
        int errs = 0;
        if (fcs_r) {
            uint8_t relay_rx[PSDU_BYTES];
            read_rx_bytes(relay_rx);
            for (int b = 0; b < DATA_BYTES; b++)
                errs += popcount8(relay_rx[b] ^ rx_buf[b]);
        }
        uint32_t ber_ppm = fcs_r ? (uint32_t)((uint64_t)errs * 1000000ULL
                                   / (DATA_BYTES * 8)) : 999999;

        xil_printf("  [relay #%d] %s  ber_ppm=%u\r\n",
                   relay, fcs_r ? "relay FCS=OK" : "relay no-decode", ber_ppm);
        EMIT("RELAY relay=%d seed=%s relay_ok=%d ber_ppm=%u",
             relay, fcs_d ? "ok" : "hdr", fcs_r ? 1 : 0, ber_ppm);

        set_xcvr_bram(0);
        usleep(200000);
        if (uart_peek() >= 0) g_stop = 1;
    }

    set_xcvr_bram(0);
    EMIT("DONE");
    drain_uart();
}

static void cmd_loop(int is_ht, int mcs_in, int sweep,
                     int ss, int se, int fs, int fn)
{
    int mcs_lo = (mcs_in < 0) ? 0 : mcs_in;
    int mcs_hi = (mcs_in < 0) ? 7 : mcs_in;

    set_ht_mode(is_ht);
    awgn_set_enable(0);
    emit_tx_ref();

    const mcs_entry_t *tbl = is_ht ? ht_mcs_table : mcs_table;

    for (int mcs = mcs_lo; mcs <= mcs_hi && !g_stop; mcs++) {
        set_mcs(mcs);
        xil_printf("\r\n[loop] %s MCS %d  %s  %s  %s\r\n",
                   is_ht ? "HT" : "Legacy", mcs,
                   tbl[mcs].mbps, tbl[mcs].mod, tbl[mcs].cr);

        if (sweep) {
            run_mcs_snr_sweep(mcs, ss, se, is_ht);
            int thr = is_ht ? ht_waterfall_threshold[mcs] : waterfall_threshold[mcs];
            EMIT("SWEEP_DONE mcs=%d ht=%d thresh_shift=%d thresh_snr=%d",
                 mcs, is_ht, thr, thr >= 0 ? awgn_shift_to_snr_db(thr) : -99);
        } else {
            run_single_snr_point(mcs, is_ht, fs, fn);
            int per_x10 = 0; uint32_t ber = 0;
            /* run_single_snr_point already prints results; emit marker */
            EMIT("FIXED_DONE mcs=%d ht=%d shift=%d snr=%d",
                 mcs, is_ht, fs, awgn_shift_to_snr_db(fs));
        }
    }

    awgn_set_enable(0);
    EMIT("DONE");
    if (g_stop) drain_uart();
}

/* ------------------------------------------------------------------ */

static void process_command(const char *cmd)
{
    int ht, mcs, n, sweep, ss, se, fs, fn;

    if (cmd[0] == '\0') return;   /* empty line */

    if (strcmp(cmd, "STATUS") == 0) {
        cmd_status();
    } else if (strcmp(cmd, "ALIGN") == 0) {
        cmd_align();
    } else if (strcmp(cmd, "BIST") == 0) {
        cmd_bist();
    } else if (strcmp(cmd, "STOP") == 0) {
        g_stop = 1;   /* acknowledged; no DONE -- already idle */
        drain_uart();
    } else if (sscanf(cmd, "TX %d %d %d", &ht, &mcs, &n) == 3) {
        if (ht < 0 || ht > 1 || mcs < 0 || mcs > 7 || n < 1 || n > 9999)
            EMIT("ERR TX params out of range");
        else
            cmd_tx(ht, mcs, n);
    } else if (sscanf(cmd, "RX %d %d", &ht, &mcs) == 2) {
        if (ht < 0 || ht > 1 || mcs < 0 || mcs > 7)
            EMIT("ERR RX params out of range");
        else
            cmd_rx(ht, mcs);
    } else if (sscanf(cmd, "XCVR %d %d", &ht, &mcs) == 2) {
        if (ht < 0 || ht > 1 || mcs < 0 || mcs > 7)
            EMIT("ERR XCVR params out of range");
        else
            cmd_xcvr(ht, mcs);
    } else if (sscanf(cmd, "LOOP %d %d %d %d %d %d %d",
                      &ht, &mcs, &sweep, &ss, &se, &fs, &fn) == 7) {
        if (ht < 0 || ht > 1 || mcs < -1 || mcs > 7)
            EMIT("ERR LOOP params out of range");
        else
            cmd_loop(ht, mcs, sweep, ss, se, fs, fn);
    } else if (sscanf(cmd, "CAPIQ %d", &n) == 1) {
        cmd_capiq(n);
    } else {
        EMIT("ERR unknown: %.64s", cmd);
    }
}

/* ======================================================================
 * SECTION 13: MAIN  (command-processor mode for Python GUI)
 * ====================================================================== */

int main(void)
{
    xil_printf("\r\n");
    xil_printf("  =====================================================\r\n");
    xil_printf("    OFDM Transceiver -- ZedBoard + FMCOMMS3 (AD9361)\r\n");
    xil_printf("    Python GUI mode  (protocol: ##-prefixed lines)\r\n");
    xil_printf("  =====================================================\r\n\r\n");

    /* ---- GPIO init ---- */
    if (ps_gpio_init() != 0) {
        xil_printf("FATAL: PS GPIO init failed.\r\n");
        while (1) sleep(5);
    }
    xil_printf("[init] GPIO OK\r\n");

    /* ---- AD9361 init ---- */
    xil_printf("[init] AD9361...\r\n");
    int ret = ad9361_init(&g_phy, &default_init_param);
    if (ret != 0 || g_phy == NULL) {
        xil_printf("FATAL: ad9361_init returned %d\r\n", ret);
        while (1) sleep(5);
    }
    xil_printf("[init] AD9361 OK\r\n");

    /* ---- 40 MSPS ---- */
    ad9361_set_rx_sampling_freq(g_phy, 40000000);
    ad9361_set_tx_sampling_freq(g_phy, 40000000);
    uint32_t actual_rx = 0, actual_tx = 0;
    ad9361_get_rx_sampling_freq(g_phy, &actual_rx);
    ad9361_get_tx_sampling_freq(g_phy, &actual_tx);
    xil_printf("[init] RX=%u Hz  TX=%u Hz\r\n", actual_rx, actual_tx);

    /* ---- RF gains + ADC/DAC cores ---- */
    ad9361_set_rx_rf_gain    (g_phy, 0, 30);
    ad9361_set_tx_attenuation(g_phy, 0, 10000);
    configure_adc_dac_cores();

    uint32_t lclk_count = ADC_RD(0x0054);
    uint32_t lclk_hz    = (uint32_t)((uint64_t)lclk_count * 100000000ULL / 65536ULL);
    xil_printf("[init] l_clk ~%u Hz  (want ~80 MHz)\r\n", lclk_hz);

    /* ---- Force FDD ---- */
    XGpioPs_WritePin(&ps_gpio, PIN_AD9361_ENABLE, 1);
    ad9361_ensm_force_state(g_phy, ENSM_STATE_FDD);
    usleep(10000);
    int32_t r017 = ad9361_spi_read(g_phy->spi, 0x017);
    xil_printf("[init] ENSM 0x017[3:0]=0x%X  (%s)\r\n",
               r017 & 0xF, (r017 & 0xF) == 0xA ? "FDD OK" : "WARN");

    /* ---- Calibrations ---- */
    xil_printf("[init] Calibrations...\r\n");
    int32_t cr;
    cr = ad9361_do_calib(g_phy, BBDC_CAL,    -1);
    xil_printf("  BBDC:    %s\r\n", cr == 0 ? "OK" : "WARN");
    cr = ad9361_do_calib(g_phy, RFDC_CAL,    -1);
    xil_printf("  RFDC:    %s\r\n", cr == 0 ? "OK" : "WARN");
    cr = ad9361_do_calib(g_phy, RX_QUAD_CAL, -1);
    xil_printf("  RX_QUAD: %s\r\n", cr == 0 ? "OK" : "WARN");
    cr = ad9361_do_calib(g_phy, TX_QUAD_CAL, -1);
    xil_printf("  TX_QUAD: %s\r\n", cr == 0 ? "OK" : "WARN");
    ad9361_set_rx_quad_track_en_dis(g_phy, 1);
    xil_printf("[init] RX quad tracking enabled\r\n");
    usleep(50000);

    /* ---- BIST verify (auto-runs at startup, results in log) ---- */
    run_bist_verify();

    /* ---- Initial RF alignment at legacy MCS 0 ---- */
    xil_printf("\r\n[align] Initial RF alignment (legacy MCS 0)...\r\n");
    set_ht_mode(0);
    set_mcs(0);
    if (!rf_align(&g_rf_skip, &g_rf_pol, 0)) {
        xil_printf("  WARN: alignment failed -- use ALIGN command to retry.\r\n");
        g_rf_skip = 3; g_rf_pol = 0;
        EMIT("ALIGN_FAILED");
    } else {
        xil_printf("  Aligned: pol=%d skip=%d\r\n", g_rf_pol, g_rf_skip);
        EMIT("ALIGNED skip=%d pol=%d", g_rf_skip, g_rf_pol);
    }

    /* ---- Send READY + initial status ---- */
    EMIT("READY");
    cmd_status();

    /* ---- Command loop ---- */
    char buf[128];
    while (1) {
        if (cmd_readline(buf, sizeof(buf)) > 0)
            process_command(buf);
    }

    return 0;
}

