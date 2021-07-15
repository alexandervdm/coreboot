/* SPDX-License-Identifier: GPL-2.0-only */

#include <assert.h>
#include <bootblock_common.h>
#include <superio/aspeed/ast2400/ast2400.h>
#include <superio/aspeed/common/aspeed.h>
#include "gpio.h"

#define ASPEED_SIO_PORT 0x4E

static uint8_t com_to_ast_sio(void)
{
	switch (CONFIG_UART_FOR_CONSOLE) {
	case 0:
		return AST2400_SUART1;
	case 1:
		return AST2400_SUART2;
	default:
		return dead_code_t(uint8_t);
	}
}

void bootblock_mainboard_early_init(void)
{
	mainboard_configure_early_gpios();
	/* Configure appropriate physical port of SuperIO chip off BMC */
	const pnp_devfn_t serial_dev = PNP_DEV(ASPEED_SIO_PORT, com_to_ast_sio());
	aspeed_enable_serial(serial_dev, CONFIG_TTYS0_BASE);
}
