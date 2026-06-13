/*
 * parameters.h -- Stage 2B-2 (v2 clean rebuild)
 *
 * Minimal substitute for the upstream no-OS parameters.h. We define only
 * what main.c and the AD9361 driver actually consume, and we override the
 * default ZedBoard reset pin to match our v2 BD topology.
 *
 * Stage 2A proved that AD9361 RESETB sits at EMIO bit 33 (PS pin 87 =
 * MIO base 54 + EMIO 33). The upstream parameters.h hardcodes
 * GPIO_RESET_PIN_ZED = 100 for the reference design's axi_gpio_reset core,
 * which doesn't apply to us -- we drive RESETB directly via PS GPIO EMIO.
 */
#ifndef __PARAMETERS_H__
#define __PARAMETERS_H__

#include <xparameters.h>

#define GPIO_DEVICE_ID      XPAR_PS7_GPIO_0_DEVICE_ID
#define SPI_DEVICE_ID       XPAR_PS7_SPI_0_DEVICE_ID

/* Match Stage 2A wiring: EMIO bit 33 -> PS pin 54+33 = 87. */
#define GPIO_RESET_PIN_ZED  87
#define GPIO_RESET_PIN      GPIO_RESET_PIN_ZED

/* AD9361 driver expects these macros even when unused. */
#define GPIO_SYNC_PIN       (-1)
#define GPIO_CAL_SW1_PIN    (-1)
#define GPIO_CAL_SW2_PIN    (-1)
#define GPIO_ENABLE_PIN     (-1)
#define GPIO_TXNRX_PIN      (-1)

#define SPI_CS              0

/* axi_ad9361 core base in v2 BD (Stage 2B-1 verified). */
#define AXI_AD9361_BASE     0x40010000UL

#endif /* __PARAMETERS_H__ */
