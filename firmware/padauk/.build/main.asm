;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 4.2.0 #13081 (Linux)
;--------------------------------------------------------
	.module main
	.optsdcc -mpdk13
	

; default segment ordering in RAM for linker
	.area DATA
	.area OSEG (OVR,DATA)

;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _main
	.globl _interrupt
	.globl __sdcc_external_startup
	.globl _tonePA3ND
	.globl _noTone
	.globl __misc
	.globl __gpcs
	.globl __gpcc
	.globl __bgtr
	.globl __tm2b
	.globl __tm2s
	.globl __tm2ct
	.globl __tm2c
	.globl __t16c
	.globl __t16m
	.globl __papl
	.globl __paph
	.globl __pac
	.globl __pa
	.globl __padier
	.globl __integs
	.globl __intrq
	.globl __inten
	.globl __eoscr
	.globl __ilrcr
	.globl __ihrcr
	.globl __clkmd
	.globl __sp
	.globl __flag
	.globl _idle_cnt
	.globl _set_seconds
	.globl _seconds
	.globl _tone_cnt
	.globl _mode_now
	.globl _prev_quarter_seconds
	.globl _quarter_seconds
	.globl _tonePA3ND_PARM_1
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
	.area RSEG (ABS)
	.org 0x0000
__flag	=	0x0000
__sp	=	0x0002
__clkmd	=	0x0003
__ihrcr	=	0x000b
__ilrcr	=	0x001f
__eoscr	=	0x000a
__inten	=	0x0004
__intrq	=	0x0005
__integs	=	0x000c
__padier	=	0x000d
__pa	=	0x0010
__pac	=	0x0011
__paph	=	0x0012
__papl	=	0x0013
__t16m	=	0x0006
__t16c::
	.ds 2
__tm2c	=	0x001c
__tm2ct	=	0x001d
__tm2s	=	0x0017
__tm2b	=	0x0009
__bgtr	=	0x0019
__gpcc	=	0x001a
__gpcs	=	0x001e
__misc	=	0x001b
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area DATA
_tonePA3ND_PARM_1:
	.ds 1
_quarter_seconds::
	.ds 1
_prev_quarter_seconds::
	.ds 1
_mode_now::
	.ds 1
_tone_cnt::
	.ds 1
_seconds::
	.ds 2
_set_seconds::
	.ds 2
_idle_cnt::
	.ds 1
;--------------------------------------------------------
; overlayable items in ram
;--------------------------------------------------------
;--------------------------------------------------------
; Stack segment in internal ram
;--------------------------------------------------------
	.area	SSEG
__start__stack:
	.ds	1

;--------------------------------------------------------
; absolute external ram data
;--------------------------------------------------------
	.area DABS (ABS)
;--------------------------------------------------------
; interrupt vector
;--------------------------------------------------------
	.area HOME
__interrupt_vect:
	.area	HEADER (ABS)
	.org	 0x0020
	goto	_interrupt
;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
	.area HOME
	.area GSINIT
	.area GSFINAL
	.area GSINIT
	.area	PREG (ABS)
	.org 0x00
p::
	.ds 2
	.area	HEADER (ABS)
	.org 0x0000
	nop
	clear	p+1
	mov	a, #s_OSEG
	add	a, #l_OSEG + 1
	and	a, #0xfe
	mov.io	sp, a
	call	__sdcc_external_startup
	goto	s_GSINIT
	.area GSINIT
__sdcc_init_data:
	mov	a, #s_DATA
	mov	p, a
	goto	00002$
00001$:
	mov	a, #0x00
	idxm	p, a
	inc	p
	mov	a, #s_DATA
00002$:
	add	a, #l_DATA
	ceqsn	a, p
	goto	00001$
;	main.c: 20: uint8_t prev_quarter_seconds = 0;
	clear	_prev_quarter_seconds+0
;	main.c: 21: uint8_t mode_now = MODE_WAIT;
	clear	_mode_now+0
;	main.c: 22: uint8_t tone_cnt = 0;
	clear	_tone_cnt+0
;	main.c: 23: uint16_t seconds = 0, set_seconds = 0;
	clear	_seconds+0
	clear	_seconds+1
;	main.c: 23: uint8_t idle_cnt = IDLE_DUR; 
	clear	_set_seconds+0
	clear	_set_seconds+1
;	main.c: 24: 
	mov	a, #0x02
	mov	_idle_cnt+0, a
	.area GSFINAL
	goto	__sdcc_program_startup
;--------------------------------------------------------
; Home
;--------------------------------------------------------
	.area HOME
	.area HOME
__sdcc_program_startup:
	goto	_main
;	return from main will return to caller
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area CODE
;	./Padauk-tone/tone.h: 33: void noTone(void){
;	-----------------------------------------
;	 function noTone
;	-----------------------------------------
_noTone:
;	./Padauk-tone/tone.h: 34: TM2C = 0x00; PA |= (1<<BUZZER_BIT);
	mov	a, #0x00
	mov.io	__tm2c, a
	set1.io	__pa, #3
;	./Padauk-tone/tone.h: 35: }
	ret
;	./Padauk-tone/tone.h: 38: void tonePA3ND(uint8_t note){
;	-----------------------------------------
;	 function tonePA3ND
;	-----------------------------------------
_tonePA3ND:
;	./Padauk-tone/tone.h: 39: TM2B = 0x7F;
	mov	a, #0x7f
	mov.io	__tm2b, a
;	./Padauk-tone/tone.h: 40: switch(note){
	mov	a, #0x12
	sub	a, _tonePA3ND_PARM_1+0
	t0sn.io	f, c
	goto	00118$
	mov	a, _tonePA3ND_PARM_1+0
	add	a, #0x01
	pcadd	a
	goto	#00118$
	goto	#00101$
	goto	#00102$
	goto	#00103$
	goto	#00104$
	goto	#00105$
	goto	#00106$
	goto	#00107$
	goto	#00108$
	goto	#00118$
	goto	#00118$
	goto	#00109$
	goto	#00110$
	goto	#00111$
	goto	#00112$
	goto	#00113$
	goto	#00114$
	goto	#00115$
	goto	#00116$
;	./Padauk-tone/tone.h: 41: case 1:
00101$:
;	./Padauk-tone/tone.h: 42: TM2S = tone_c4;
	mov	a, #0x31
	mov.io	__tm2s, a
;	./Padauk-tone/tone.h: 43: break;
	goto	00118$
;	./Padauk-tone/tone.h: 44: case 2:
00102$:
;	./Padauk-tone/tone.h: 45: TM2S = tone_d4;
	mov	a, #0x2f
	mov.io	__tm2s, a
;	./Padauk-tone/tone.h: 46: break;
	goto	00118$
;	./Padauk-tone/tone.h: 47: case 3:
00103$:
;	./Padauk-tone/tone.h: 48: TM2S = tone_e4;
	mov	a, #0x2d
	mov.io	__tm2s, a
;	./Padauk-tone/tone.h: 49: break;
	goto	00118$
;	./Padauk-tone/tone.h: 50: case 4:
00104$:
;	./Padauk-tone/tone.h: 51: TM2S = tone_f4;
	mov	a, #0x2c
	mov.io	__tm2s, a
;	./Padauk-tone/tone.h: 52: break;
	goto	00118$
;	./Padauk-tone/tone.h: 53: case 5:
00105$:
;	./Padauk-tone/tone.h: 54: TM2S = tone_g4;
	mov	a, #0x2b
	mov.io	__tm2s, a
;	./Padauk-tone/tone.h: 55: break;
	goto	00118$
;	./Padauk-tone/tone.h: 56: case 6:
00106$:
;	./Padauk-tone/tone.h: 57: TM2S = tone_a4;
	mov	a, #0x2a
	mov.io	__tm2s, a
;	./Padauk-tone/tone.h: 58: break;
	goto	00118$
;	./Padauk-tone/tone.h: 59: case 7:
00107$:
;	./Padauk-tone/tone.h: 60: TM2S = tone_b4;
	mov	a, #0x29
	mov.io	__tm2s, a
;	./Padauk-tone/tone.h: 61: break;
	goto	00118$
;	./Padauk-tone/tone.h: 62: case 8:
00108$:
;	./Padauk-tone/tone.h: 63: TM2S = tone_c5;
	mov	a, #0x28
	mov.io	__tm2s, a
;	./Padauk-tone/tone.h: 64: break;
	goto	00118$
;	./Padauk-tone/tone.h: 65: case 11:
00109$:
;	./Padauk-tone/tone.h: 66: TM2S = tone_c5;
	mov	a, #0x28
	mov.io	__tm2s, a
;	./Padauk-tone/tone.h: 67: break;
	goto	00118$
;	./Padauk-tone/tone.h: 68: case 12:
00110$:
;	./Padauk-tone/tone.h: 69: TM2S = tone_d5;
	mov	a, #0x27
	mov.io	__tm2s, a
;	./Padauk-tone/tone.h: 70: break;
	goto	00118$
;	./Padauk-tone/tone.h: 71: case 13:
00111$:
;	./Padauk-tone/tone.h: 72: TM2S = tone_e5;
	mov	a, #0x1c
	mov.io	__tm2s, a
;	./Padauk-tone/tone.h: 73: break;
	goto	00118$
;	./Padauk-tone/tone.h: 74: case 14:
00112$:
;	./Padauk-tone/tone.h: 75: TM2S = tone_f5;
	mov	a, #0x1a
	mov.io	__tm2s, a
;	./Padauk-tone/tone.h: 76: break;
	goto	00118$
;	./Padauk-tone/tone.h: 77: case 15:
00113$:
;	./Padauk-tone/tone.h: 78: TM2S = tone_g5;
	mov	a, #0x17
	mov.io	__tm2s, a
;	./Padauk-tone/tone.h: 79: break;
	goto	00118$
;	./Padauk-tone/tone.h: 80: case 16:
00114$:
;	./Padauk-tone/tone.h: 81: TM2S = tone_a5;
	mov	a, #0x15
	mov.io	__tm2s, a
;	./Padauk-tone/tone.h: 82: break;
	goto	00118$
;	./Padauk-tone/tone.h: 83: case 17:
00115$:
;	./Padauk-tone/tone.h: 84: TM2S = tone_b5;
	mov	a, #0x13
	mov.io	__tm2s, a
;	./Padauk-tone/tone.h: 85: break;
	goto	00118$
;	./Padauk-tone/tone.h: 86: case 18:
00116$:
;	./Padauk-tone/tone.h: 87: TM2S = tone_c6;
	mov	a, #0x11
	mov.io	__tm2s, a
;	./Padauk-tone/tone.h: 91: }
00118$:
;	./Padauk-tone/tone.h: 92: TM2C = (uint8_t)(TM2C_INVERT_OUT | TM2C_MODE_PWM | TM2C_OUT_PA3 | TM2C_CLK_IHRC);
	mov	a, #0x2b
	mov.io	__tm2c, a
;	./Padauk-tone/tone.h: 93: }
	ret
;	main.c: 26: unsigned char _sdcc_external_startup(void) {
;	-----------------------------------------
;	 function _sdcc_external_startup
;	-----------------------------------------
__sdcc_external_startup:
;	main.c: 29: PDK_SET_SYSCLOCK(SYSCLOCK_IHRC_500KHZ);
	mov	a, #0x7c
	mov.io	__clkmd, a
;	main.c: 30: EASY_PDK_CALIBRATE_IHRC(524288, TARGET_VDD_MV);
	and	a, #'R'                       
	and	a, #'C'                       
	and	a, #(1)            
	and	a, #((524288))     
	and	a, #((524288)>>8)  
	and	a, #((524288)>>16) 
	and	a, #((524288)>>24) 
	and	a, #((3000))     
	and	a, #((3000)>>8)  
	and	a, #(0x0b)             
;	main.c: 37: return 0;
;	main.c: 38: }
	ret	#0x00
;	main.c: 40: void interrupt(void) __interrupt(0) {
;	-----------------------------------------
;	 function interrupt
;	-----------------------------------------
_interrupt:
	push	af
	mov	a, p
	push	af
;	main.c: 41: if (INTRQ & INTRQ_T16) {
	mov.io	a, __intrq
	and	a, #0x04
	ceqsn	a, #0x00
	goto	00109$
	goto	00103$
00109$:
;	main.c: 42: quarter_seconds++;
	mov	a, _quarter_seconds+0
	add	a, #0x01
	mov	_quarter_seconds+0, a
;	main.c: 43: INTRQ &= ~INTRQ_T16;
	set0.io	__intrq, #2
00103$:
;	main.c: 45: }
	pop	af
	mov	p, a
	pop	af
	reti
;	main.c: 47: int main(void) {
;	-----------------------------------------
;	 function main
;	-----------------------------------------
_main:
;	main.c: 53: T16M = 0b00111010;        // Use System (IHRC) clock source (524.288 kHz), /64, Interrupt on (rising) Bit 10
	mov	a, #0x3a
	mov.io	__t16m, a
;	main.c: 55: T16C = 0;
	clear	p
	stt16	p
;	main.c: 56: INTEN = INTEN_T16;
	mov	a, #0x04
	mov.io	__inten, a
;	main.c: 59: INTRQ = 0;
	mov	a, #0x00
	mov.io	__intrq, a
;	main.c: 60: __engint();
	engint
;	main.c: 62: while (1) {
00135$:
;	main.c: 63: if (quarter_seconds != prev_quarter_seconds) {
	mov	a, _quarter_seconds+0
	ceqsn	a, _prev_quarter_seconds+0
	goto	00216$
	goto	00135$
00216$:
;	main.c: 64: prev_quarter_seconds = quarter_seconds;
	mov	a, _quarter_seconds+0
	mov	_prev_quarter_seconds+0, a
;	main.c: 65: noTone();
	call	_noTone
;	main.c: 66: setPinPullup(UP_BTN_PIN);
	set1.io	__paph, #7
;	main.c: 67: setPinPullup(ST_BTN_PIN);
	set1.io	__paph, #6
;	main.c: 69: switch (mode_now) {
	mov	a, _mode_now+0
	ceqsn	a, #0x00
	goto	00218$
	goto	00108$
00218$:
	mov	a, _mode_now+0
	ceqsn	a, #0x01
	goto	00220$
	goto	00101$
00220$:
	mov	a, _mode_now+0
	ceqsn	a, #0x02
	goto	00222$
	goto	00127$
00222$:
	goto	00131$
;	main.c: 70: case MODE_CNT:
00101$:
;	main.c: 72: if (isPinLow(ST_BTN_PIN)) {
	mov.io	a, __pa
	and	a, #0x40
	ceqsn	a, #0x00
	goto	00103$
;	main.c: 73: mode_now = MODE_WAIT;
	clear	_mode_now+0
00103$:
;	main.c: 75: if ((quarter_seconds & 0b00000011) == 0b00000011) {
	clear	p
	mov	a, _quarter_seconds+0
	and	a, #0x03
	clear	p
	ceqsn	a, #0x03
	goto	00131$
	mov	a, p
	ceqsn	a, #0x00
	goto	00131$
;	main.c: 77: seconds++;
	inc	_seconds+0
	addc	_seconds+1
;	main.c: 78: if (seconds == set_seconds) {
	mov	a, _seconds+0
	ceqsn	a, _set_seconds+0
	goto	00131$
	mov	a, _seconds+1
	ceqsn	a, _set_seconds+1
	goto	00131$
;	main.c: 79: mode_now = MODE_END;
	mov	a, #0x02
	mov	_mode_now+0, a
;	main.c: 82: break;
	goto	00131$
;	main.c: 84: case MODE_WAIT:
00108$:
;	main.c: 85: if ((isPinLow(ST_BTN_PIN)) && (isPinLow(UP_BTN_PIN))) {
	mov.io	a, __pa
	and	a, #0x40
	ceqsn	a, #0x00
	goto	00124$
	mov.io	a, __pa
	and	a, #0x80
	ceqsn	a, #0x00
	goto	00124$
;	main.c: 87: seconds = 0;
	clear	_seconds+0
	clear	_seconds+1
;	main.c: 88: set_seconds = 0;
	clear	_set_seconds+0
	clear	_set_seconds+1
;	main.c: 89: tone_cnt = 0;            
	clear	_tone_cnt+0
;	main.c: 90: idle_cnt = IDLE_DUR;
	mov	a, #0x02
	mov	_idle_cnt+0, a
;	main.c: 91: tonePA3ND(6); // La
	mov	a, #0x06
	mov	_tonePA3ND_PARM_1+0, a
	call	_tonePA3ND
	goto	00131$
00124$:
;	main.c: 93: } else if ((isPinHigh(ST_BTN_PIN)) && (isPinLow(UP_BTN_PIN))) {
	mov.io	a, __pa
	and	a, #0x40
	ceqsn	a, #0x00
	goto	00223$
	goto	00120$
00223$:
	mov.io	a, __pa
	and	a, #0x80
	ceqsn	a, #0x00
	goto	00120$
;	main.c: 95: set_seconds+=60;
	mov	a, _set_seconds+0
	add	a, #0x3c
	mov	p, a
	mov	a, _set_seconds+1
	addc	a
	mov	_set_seconds+1, a
	mov	a, p
	mov	_set_seconds+0, a
;	main.c: 96: idle_cnt = IDLE_DUR;
	mov	a, #0x02
	mov	_idle_cnt+0, a
;	main.c: 97: tonePA3ND(tone_cnt%18+1); // 1to18
	mov	a, _tone_cnt+0
	mov	__modsint_PARM_1+0, a
	clear	__modsint_PARM_1+1
	mov	a, #0x12
	mov	__modsint_PARM_2+0, a
	clear	__modsint_PARM_2+1
	call	__modsint
	add	a, #0x01
	mov	_tonePA3ND_PARM_1+0, a
	call	_tonePA3ND
;	main.c: 98: tone_cnt++;
	inc	_tone_cnt+0
	goto	00131$
00120$:
;	main.c: 99: } else if ((isPinLow(ST_BTN_PIN)) && (isPinHigh(UP_BTN_PIN)) && (set_seconds != 0)) {
	mov.io	a, __pa
	and	a, #0x40
	ceqsn	a, #0x00
	goto	00115$
	mov.io	a, __pa
	and	a, #0x80
	ceqsn	a, #0x00
	goto	00224$
	goto	00115$
00224$:
	mov	a, _set_seconds+0
	or	a, _set_seconds+1
	ceqsn	a, #0x00
	goto	00225$
	goto	00115$
00225$:
;	main.c: 101: mode_now = MODE_CNT;
	mov	a, #0x01
	mov	_mode_now+0, a
;	main.c: 102: idle_cnt = IDLE_DUR;
	mov	a, #0x02
	mov	_idle_cnt+0, a
;	main.c: 104: tonePA3ND(8); // Do
	mov	a, #0x08
	mov	_tonePA3ND_PARM_1+0, a
	call	_tonePA3ND
	goto	00131$
00115$:
;	main.c: 107: else if ((isPinHigh(ST_BTN_PIN)) && (isPinHigh(UP_BTN_PIN))) {
	mov.io	a, __pa
	and	a, #0x40
	ceqsn	a, #0x00
	goto	00226$
	goto	00131$
00226$:
	mov.io	a, __pa
	and	a, #0x80
	ceqsn	a, #0x00
	goto	00227$
	goto	00131$
00227$:
;	main.c: 108: idle_cnt--;
	dzsn	_idle_cnt+0
	goto	00131$
;	main.c: 109: if (idle_cnt == 0) {
;	main.c: 110: PADIER = (uint8_t)((1<<UP_BTN_PIN_BIT)|(1<<ST_BTN_PIN_BIT));
	mov	a, #0xc0
	mov.io	__padier, a
;	main.c: 111: noTone(); // tone off
	call	_noTone
;	main.c: 113: __stopexe(); 
	stopexe
	nop
;	main.c: 119: break;
	goto	00131$
;	main.c: 121: case MODE_END:
00127$:
;	main.c: 123: if (isPinLow(ST_BTN_PIN)) {
	mov.io	a, __pa
	and	a, #0x40
	ceqsn	a, #0x00
	goto	00129$
;	main.c: 124: seconds = 0;
	clear	_seconds+0
	clear	_seconds+1
;	main.c: 125: noTone();
	call	_noTone
;	main.c: 126: mode_now = MODE_WAIT;
	clear	_mode_now+0
	goto	00131$
00129$:
;	main.c: 128: tonePA3ND(17); // Si 5
	mov	a, #0x11
	mov	_tonePA3ND_PARM_1+0, a
	call	_tonePA3ND
;	main.c: 133: }  
00131$:
;	main.c: 135: clearPinPullup(ST_BTN_PIN);
	set0.io	__paph, #6
;	main.c: 136: clearPinPullup(UP_BTN_PIN);
	set0.io	__paph, #7
	goto	00135$
;	main.c: 139: }
	ret
	.area CODE
	.area CONST
	.area CABS (ABS)
