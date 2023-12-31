/*
  pms150g.h: FUSE and Register Definitions for the Padauk PMS150G device.

  Copyright (C) 2020  serisman  <github@serisman.com>
  Copyright (C) 2019-2020  freepdk  https://free-pdk.github.io

  This library is free software; you can redistribute it and/or modify it
  under the terms of the GNU General Public License as published by the
  Free Software Foundation; either version 2, or (at your option) any later version.

  This library is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  GNU General Public License for more details.

  You should have received a copy of the GNU General Public License
  along with this library. If not, see <http://www.gnu.org/licenses/>.

  As a special exception, if you link this library with other files,
  some of which are compiled with SDCC, to produce an executable,
  this library does not by itself cause the resulting executable to
  be covered by the GNU General Public License. This exception does
  not however invalidate any other reasons why the executable file
  might be covered by the GNU General Public License.
*/

#ifndef __PDK_DEVICE_PMS150G_H__
#define __PDK_DEVICE_PMS150G_H__

#if !defined(__PDK_DEVICE_XXX_H__)
	#define __PDK_DEVICE_XXX_H__ "pms150g.h"
#else
	#error "Attempt to include more than one "pdk/device/XXX.h" file."
#endif

#if !defined(__SDCC_pdk13)
	#error "PMS150G/PMS15B needs the PDK13 backend. You must compile with the -mpdk13 option."
#endif

#define ILRC_FREQ           57000

// Factory Calibration address locations
#define FACTORY_BGTR_ADDR   0x03f6


// FUSE definitions
#define FUSE_WORD_ADDR      0x03ff
#define FUSE_RES_BITS_HIGH  0x0080    // - - - 0   B B D 0   1 B B L   L L 0 S
// Blank IC Values          0x0FFD    // - - - 0   1 1 1 1   1 1 1 1   1 1 0 1 (Security Off, 1.8V LVR, PA5 Open Drain, Fast Boot-up)
#define FUSE_SECURITY_ON    0x0000    //(S)
#define FUSE_SECURITY_OFF   (1 << 0)
#define FUSE_LVR_4V         0x0000    //(L)
#define FUSE_LVR_3V5        (1 << 2)
#define FUSE_LVR_3V         (2 << 2)
#define FUSE_LVR_2V75       (3 << 2)
#define FUSE_LVR_2V5        (4 << 2)
#define FUSE_LVR_2V         (5 << 2)
#define FUSE_LVR_2V2        (6 << 2)
#define FUSE_LVR_1V8        (7 << 2)
#define FUSE_PA5_NORMAL     0x0000    //(D)
#define FUSE_PA5_OPEN_DRAIN (1 << 9)
#define FUSE_BOOTUP_SLOW    (0x0000 | (3 << 5))  //(B)
#define FUSE_BOOTUP_FAST    ((3 << 10) | (3 << 5))
#define FUSE_BOOTUP_SUPER   ((3 << 10) | (1 << 5))


// Register address definitions
#define FLAG_ADDR           0x00
//0x01
#define SP_ADDR             0x02
#define CLKMD_ADDR          0x03
#define INTEN_ADDR          0x04
#define INTRQ_ADDR          0x05
#define T16M_ADDR           0x06
//0x07
//0x08
#define TM2B_ADDR           0x09
#define EOSCR_ADDR          0x0a
#define IHRCR_ADDR          0x0b
#define INTEGS_ADDR         0x0c
#define PADIER_ADDR         0x0d
//0x0e
//0x0f
#define PA_ADDR             0x10
#define PAC_ADDR            0x11
#define PAPH_ADDR           0x12
#define PAPL_ADDR           0x13
//0x14
//...
//0x16
#define TM2S_ADDR           0x17
//0x18
#define BGTR_ADDR           0x19
#define GPCC_ADDR           0x1a
#define MISC_ADDR           0x1b
#define TM2C_ADDR           0x1c
#define TM2CT_ADDR          0x1d
#define GPCS_ADDR           0x1e
#define ILRCR_ADDR          0x1f


// Peripheral definitions
#define __PDK_HAS_COMP
#define __PDK_HAS_COMP_WAKEUP
#define __PDK_HAS_COMP_INT_EDGE

#include "periph/accumulator.h"
#include "periph/stack.h"
#include "periph/clock.h"
#include "periph/external_oscillator.h"
#include "periph/interrupt.h"
#include "periph/port_a.h"
#include "periph/timer_16.h"
#include "periph/timer_2.h"
#include "periph/bandgap.h"
#include "periph/comparator.h"
#include "periph/misc.h"

#endif //__PDK_DEVICE_PMS150G_H__
