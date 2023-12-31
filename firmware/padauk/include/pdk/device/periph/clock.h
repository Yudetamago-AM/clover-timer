/*
  clock.h: Definitions for the System Clock register (CLKMD) used by Padauk microcontrollers.

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

#ifndef __PDK_DEVICE_PERIPH_CLOCK_H__
#define __PDK_DEVICE_PERIPH_CLOCK_H__

#if !defined(__PDK_DEVICE_H__)
	#error "You must #include "pdk/device.h" instead of "pdk/device/periph/clock.h" by itself."
#endif

// __sfr definitions
__sfr __at(CLKMD_ADDR)        _clkmd;
__sfr __at(IHRCR_ADDR)        _ihrcr;

#define CLKMD                 _clkmd
#define IHRCR                 _ihrcr

// PMS131 doesn't seem to have ILRCR for some reason
#if defined(ILRCR_ADDR)
  __sfr __at(ILRCR_ADDR)        _ilrcr;
  #define ILRCR                 _ilrcr
#endif

// CLKMD (Clock Mode) register definitions
#define CLKMD_PA5_PRSTB_BIT          0
#define CLKMD_WATCHDOG_ENABLE_BIT    1
#define CLKMD_ILRC_ENABLE_BIT        2
#define CLKMD_CLOCKTYPE_BIT          3
#define CLKMD_IHRC_ENABLE_BIT        4
#define CLKMD_SYSCLK_BIT0            5

#define CLKMD_ENABLE_PRSTB           (1 << CLKMD_PA5_PRSTB_BIT)
#define CLKMD_ENABLE_WATCHDOG        (1 << CLKMD_WATCHDOG_ENABLE_BIT)
#define CLKMD_ENABLE_ILRC            (1 << CLKMD_ILRC_ENABLE_BIT)
#define CLKMD_ENABLE_IHRC            (1 << CLKMD_IHRC_ENABLE_BIT)

#define CLKMD_MODE0(s)               (s << CLKMD_SYSCLK_BIT0)
#define CLKMD_IHRC_DIV4              CLKMD_MODE0(0)
#define CLKMD_IHRC_DIV2              CLKMD_MODE0(1)
#define CLKMD_IHRC                   CLKMD_MODE0(2)
#if defined(__PDK_HAS_EOSC)
  #define CLKMD_EOSC_DIV4              CLKMD_MODE0(3)
  #define CLKMD_EOSC_DIV2              CLKMD_MODE0(4)
  #define CLKMD_EOSC                   CLKMD_MODE0(5)
#endif
#define CLKMD_ILRC_DIV4              CLKMD_MODE0(6)
#define CLKMD_ILRC                   CLKMD_MODE0(7)

#define CLKMD_MODE1(s)               ((s << CLKMD_SYSCLK_BIT0) | (1 << CLKMD_CLOCKTYPE_BIT))
#define CLKMD_IHRC_DIV16             CLKMD_MODE1(0)
#define CLKMD_IHRC_DIV8              CLKMD_MODE1(1)
#define CLKMD_ILRC_DIV16             CLKMD_MODE1(2)
#define CLKMD_IHRC_DIV32             CLKMD_MODE1(3)
#define CLKMD_IHRC_DIV64             CLKMD_MODE1(4)
#if defined(__PDK_HAS_EOSC)
  #define CLKMD_EOSC_DIV8              CLKMD_MODE1(5)
#endif
#if defined(__PDK_HAS_ILRC_DIV2)
  #define CLKMD_ILRC_DIV2              CLKMD_MODE1(6)
#endif
//0x07 reserved

#endif //__PDK_DEVICE_PERIPH_CLOCK_H__
