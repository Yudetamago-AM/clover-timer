                                      1 ;--------------------------------------------------------
                                      2 ; File Created by SDCC : free open source ANSI-C Compiler
                                      3 ; Version 4.2.0 #13081 (Linux)
                                      4 ;--------------------------------------------------------
                                      5 	.module main
                                      6 	.optsdcc -mpdk13
                                      7 	
                                      8 
                                      9 ; default segment ordering in RAM for linker
                                     10 	.area DATA
                                     11 	.area OSEG (OVR,DATA)
                                     12 
                                     13 ;--------------------------------------------------------
                                     14 ; Public variables in this module
                                     15 ;--------------------------------------------------------
                                     16 	.globl _main
                                     17 	.globl _interrupt
                                     18 	.globl __sdcc_external_startup
                                     19 	.globl _tonePA3ND
                                     20 	.globl _noTone
                                     21 	.globl __misc
                                     22 	.globl __gpcs
                                     23 	.globl __gpcc
                                     24 	.globl __bgtr
                                     25 	.globl __tm2b
                                     26 	.globl __tm2s
                                     27 	.globl __tm2ct
                                     28 	.globl __tm2c
                                     29 	.globl __t16c
                                     30 	.globl __t16m
                                     31 	.globl __papl
                                     32 	.globl __paph
                                     33 	.globl __pac
                                     34 	.globl __pa
                                     35 	.globl __padier
                                     36 	.globl __integs
                                     37 	.globl __intrq
                                     38 	.globl __inten
                                     39 	.globl __eoscr
                                     40 	.globl __ilrcr
                                     41 	.globl __ihrcr
                                     42 	.globl __clkmd
                                     43 	.globl __sp
                                     44 	.globl __flag
                                     45 	.globl _idle_cnt
                                     46 	.globl _set_seconds
                                     47 	.globl _seconds
                                     48 	.globl _tone_cnt
                                     49 	.globl _mode_now
                                     50 	.globl _prev_quarter_seconds
                                     51 	.globl _quarter_seconds
                                     52 	.globl _tonePA3ND_PARM_1
                                     53 ;--------------------------------------------------------
                                     54 ; special function registers
                                     55 ;--------------------------------------------------------
                                     56 	.area RSEG (ABS)
      000000                         57 	.org 0x0000
                           000000    58 __flag	=	0x0000
                           000002    59 __sp	=	0x0002
                           000003    60 __clkmd	=	0x0003
                           00000B    61 __ihrcr	=	0x000b
                           00001F    62 __ilrcr	=	0x001f
                           00000A    63 __eoscr	=	0x000a
                           000004    64 __inten	=	0x0004
                           000005    65 __intrq	=	0x0005
                           00000C    66 __integs	=	0x000c
                           00000D    67 __padier	=	0x000d
                           000010    68 __pa	=	0x0010
                           000011    69 __pac	=	0x0011
                           000012    70 __paph	=	0x0012
                           000013    71 __papl	=	0x0013
                           000006    72 __t16m	=	0x0006
      000000                         73 __t16c::
      000000                         74 	.ds 2
                           00001C    75 __tm2c	=	0x001c
                           00001D    76 __tm2ct	=	0x001d
                           000017    77 __tm2s	=	0x0017
                           000009    78 __tm2b	=	0x0009
                           000019    79 __bgtr	=	0x0019
                           00001A    80 __gpcc	=	0x001a
                           00001E    81 __gpcs	=	0x001e
                           00001B    82 __misc	=	0x001b
                                     83 ;--------------------------------------------------------
                                     84 ; ram data
                                     85 ;--------------------------------------------------------
                                     86 	.area DATA
      000002                         87 _tonePA3ND_PARM_1:
      000002                         88 	.ds 1
      000003                         89 _quarter_seconds::
      000003                         90 	.ds 1
      000004                         91 _prev_quarter_seconds::
      000004                         92 	.ds 1
      000005                         93 _mode_now::
      000005                         94 	.ds 1
      000006                         95 _tone_cnt::
      000006                         96 	.ds 1
      000007                         97 _seconds::
      000007                         98 	.ds 2
      000009                         99 _set_seconds::
      000009                        100 	.ds 2
      00000B                        101 _idle_cnt::
      00000B                        102 	.ds 1
                                    103 ;--------------------------------------------------------
                                    104 ; overlayable items in ram
                                    105 ;--------------------------------------------------------
                                    106 ;--------------------------------------------------------
                                    107 ; Stack segment in internal ram
                                    108 ;--------------------------------------------------------
                                    109 	.area	SSEG
      00001B                        110 __start__stack:
      00001B                        111 	.ds	1
                                    112 
                                    113 ;--------------------------------------------------------
                                    114 ; absolute external ram data
                                    115 ;--------------------------------------------------------
                                    116 	.area DABS (ABS)
                                    117 ;--------------------------------------------------------
                                    118 ; interrupt vector
                                    119 ;--------------------------------------------------------
                                    120 	.area HOME
      000022                        121 __interrupt_vect:
                                    122 	.area	HEADER (ABS)
      000020                        123 	.org	 0x0020
      000020 85 18                  124 	goto	_interrupt
                                    125 ;--------------------------------------------------------
                                    126 ; global & static initialisations
                                    127 ;--------------------------------------------------------
                                    128 	.area HOME
                                    129 	.area GSINIT
                                    130 	.area GSFINAL
                                    131 	.area GSINIT
                                    132 	.area	PREG (ABS)
      000000                        133 	.org 0x00
      000000                        134 p::
      000000                        135 	.ds 2
                                    136 	.area	HEADER (ABS)
      000000                        137 	.org 0x0000
      000000 00 00                  138 	nop
      000002 81 09                  139 	clear	p+1
      000004 19 17                  140 	mov	a, #s_OSEG
      000006 03 10                  141 	add	a, #l_OSEG + 1
      000008 FE 14                  142 	and	a, #0xfe
      00000A 82 00                  143 	mov.io	sp, a
      00000C 78 1C                  144 	call	__sdcc_external_startup
      00000E 12 18                  145 	goto	s_GSINIT
                                    146 	.area GSINIT
      000024                        147 __sdcc_init_data:
      000024 02 17                  148 	mov	a, #s_DATA
      000026 C0 05                  149 	mov	p, a
      000028 19 18                  150 	goto	00002$
      00002A                        151 00001$:
      00002A 00 17                  152 	mov	a, #0x00
      00002C E0 00                  153 	idxm	p, a
      00002E 00 09                  154 	inc	p
      000030 02 17                  155 	mov	a, #s_DATA
      000032                        156 00002$:
      000032 17 10                  157 	add	a, #l_DATA
      000034 80 0B                  158 	ceqsn	a, p
      000036 15 18                  159 	goto	00001$
                                    160 ;	main.c: 20: uint8_t prev_quarter_seconds = 0;
      000038 84 09                  161 	clear	_prev_quarter_seconds+0
                                    162 ;	main.c: 21: uint8_t mode_now = MODE_WAIT;
      00003A 85 09                  163 	clear	_mode_now+0
                                    164 ;	main.c: 22: uint8_t tone_cnt = 0;
      00003C 86 09                  165 	clear	_tone_cnt+0
                                    166 ;	main.c: 23: uint16_t seconds = 0, set_seconds = 0;
      00003E 87 09                  167 	clear	_seconds+0
      000040 88 09                  168 	clear	_seconds+1
                                    169 ;	main.c: 23: uint8_t idle_cnt = IDLE_DUR; 
      000042 89 09                  170 	clear	_set_seconds+0
      000044 8A 09                  171 	clear	_set_seconds+1
                                    172 ;	main.c: 24: 
      000046 02 17                  173 	mov	a, #0x02
      000048 CB 05                  174 	mov	_idle_cnt+0, a
                                    175 	.area GSFINAL
      00004A 11 18                  176 	goto	__sdcc_program_startup
                                    177 ;--------------------------------------------------------
                                    178 ; Home
                                    179 ;--------------------------------------------------------
                                    180 	.area HOME
                                    181 	.area HOME
      000022                        182 __sdcc_program_startup:
      000022 95 18                  183 	goto	_main
                                    184 ;	return from main will return to caller
                                    185 ;--------------------------------------------------------
                                    186 ; code
                                    187 ;--------------------------------------------------------
                                    188 	.area CODE
                                    189 ;	./Padauk-tone/tone.h: 33: void noTone(void){
                                    190 ;	-----------------------------------------
                                    191 ;	 function noTone
                                    192 ;	-----------------------------------------
      00004C                        193 _noTone:
                                    194 ;	./Padauk-tone/tone.h: 34: TM2C = 0x00; PA |= (1<<BUZZER_BIT);
      00004C 00 17                  195 	mov	a, #0x00
      00004E 9C 00                  196 	mov.io	__tm2c, a
      000050 70 0F                  197 	set1.io	__pa, #3
                                    198 ;	./Padauk-tone/tone.h: 35: }
      000052 3A 00                  199 	ret
                                    200 ;	./Padauk-tone/tone.h: 38: void tonePA3ND(uint8_t note){
                                    201 ;	-----------------------------------------
                                    202 ;	 function tonePA3ND
                                    203 ;	-----------------------------------------
      000054                        204 _tonePA3ND:
                                    205 ;	./Padauk-tone/tone.h: 39: TM2B = 0x7F;
      000054 7F 17                  206 	mov	a, #0x7f
      000056 89 00                  207 	mov.io	__tm2b, a
                                    208 ;	./Padauk-tone/tone.h: 40: switch(note){
      000058 12 17                  209 	mov	a, #0x12
      00005A 42 06                  210 	sub	a, _tonePA3ND_PARM_1+0
      00005C 20 0C                  211 	t0sn.io	f, c
      00005E 75 18                  212 	goto	00118$
      000060 C2 07                  213 	mov	a, _tonePA3ND_PARM_1+0
      000062 01 10                  214 	add	a, #0x01
      000064 17 00                  215 	pcadd	a
      000066 75 18                  216 	goto	#00118$
      000068 46 18                  217 	goto	#00101$
      00006A 49 18                  218 	goto	#00102$
      00006C 4C 18                  219 	goto	#00103$
      00006E 4F 18                  220 	goto	#00104$
      000070 52 18                  221 	goto	#00105$
      000072 55 18                  222 	goto	#00106$
      000074 58 18                  223 	goto	#00107$
      000076 5B 18                  224 	goto	#00108$
      000078 75 18                  225 	goto	#00118$
      00007A 75 18                  226 	goto	#00118$
      00007C 5E 18                  227 	goto	#00109$
      00007E 61 18                  228 	goto	#00110$
      000080 64 18                  229 	goto	#00111$
      000082 67 18                  230 	goto	#00112$
      000084 6A 18                  231 	goto	#00113$
      000086 6D 18                  232 	goto	#00114$
      000088 70 18                  233 	goto	#00115$
      00008A 73 18                  234 	goto	#00116$
                                    235 ;	./Padauk-tone/tone.h: 41: case 1:
      00008C                        236 00101$:
                                    237 ;	./Padauk-tone/tone.h: 42: TM2S = tone_c4;
      00008C 31 17                  238 	mov	a, #0x31
      00008E 97 00                  239 	mov.io	__tm2s, a
                                    240 ;	./Padauk-tone/tone.h: 43: break;
      000090 75 18                  241 	goto	00118$
                                    242 ;	./Padauk-tone/tone.h: 44: case 2:
      000092                        243 00102$:
                                    244 ;	./Padauk-tone/tone.h: 45: TM2S = tone_d4;
      000092 2F 17                  245 	mov	a, #0x2f
      000094 97 00                  246 	mov.io	__tm2s, a
                                    247 ;	./Padauk-tone/tone.h: 46: break;
      000096 75 18                  248 	goto	00118$
                                    249 ;	./Padauk-tone/tone.h: 47: case 3:
      000098                        250 00103$:
                                    251 ;	./Padauk-tone/tone.h: 48: TM2S = tone_e4;
      000098 2D 17                  252 	mov	a, #0x2d
      00009A 97 00                  253 	mov.io	__tm2s, a
                                    254 ;	./Padauk-tone/tone.h: 49: break;
      00009C 75 18                  255 	goto	00118$
                                    256 ;	./Padauk-tone/tone.h: 50: case 4:
      00009E                        257 00104$:
                                    258 ;	./Padauk-tone/tone.h: 51: TM2S = tone_f4;
      00009E 2C 17                  259 	mov	a, #0x2c
      0000A0 97 00                  260 	mov.io	__tm2s, a
                                    261 ;	./Padauk-tone/tone.h: 52: break;
      0000A2 75 18                  262 	goto	00118$
                                    263 ;	./Padauk-tone/tone.h: 53: case 5:
      0000A4                        264 00105$:
                                    265 ;	./Padauk-tone/tone.h: 54: TM2S = tone_g4;
      0000A4 2B 17                  266 	mov	a, #0x2b
      0000A6 97 00                  267 	mov.io	__tm2s, a
                                    268 ;	./Padauk-tone/tone.h: 55: break;
      0000A8 75 18                  269 	goto	00118$
                                    270 ;	./Padauk-tone/tone.h: 56: case 6:
      0000AA                        271 00106$:
                                    272 ;	./Padauk-tone/tone.h: 57: TM2S = tone_a4;
      0000AA 2A 17                  273 	mov	a, #0x2a
      0000AC 97 00                  274 	mov.io	__tm2s, a
                                    275 ;	./Padauk-tone/tone.h: 58: break;
      0000AE 75 18                  276 	goto	00118$
                                    277 ;	./Padauk-tone/tone.h: 59: case 7:
      0000B0                        278 00107$:
                                    279 ;	./Padauk-tone/tone.h: 60: TM2S = tone_b4;
      0000B0 29 17                  280 	mov	a, #0x29
      0000B2 97 00                  281 	mov.io	__tm2s, a
                                    282 ;	./Padauk-tone/tone.h: 61: break;
      0000B4 75 18                  283 	goto	00118$
                                    284 ;	./Padauk-tone/tone.h: 62: case 8:
      0000B6                        285 00108$:
                                    286 ;	./Padauk-tone/tone.h: 63: TM2S = tone_c5;
      0000B6 28 17                  287 	mov	a, #0x28
      0000B8 97 00                  288 	mov.io	__tm2s, a
                                    289 ;	./Padauk-tone/tone.h: 64: break;
      0000BA 75 18                  290 	goto	00118$
                                    291 ;	./Padauk-tone/tone.h: 65: case 11:
      0000BC                        292 00109$:
                                    293 ;	./Padauk-tone/tone.h: 66: TM2S = tone_c5;
      0000BC 28 17                  294 	mov	a, #0x28
      0000BE 97 00                  295 	mov.io	__tm2s, a
                                    296 ;	./Padauk-tone/tone.h: 67: break;
      0000C0 75 18                  297 	goto	00118$
                                    298 ;	./Padauk-tone/tone.h: 68: case 12:
      0000C2                        299 00110$:
                                    300 ;	./Padauk-tone/tone.h: 69: TM2S = tone_d5;
      0000C2 27 17                  301 	mov	a, #0x27
      0000C4 97 00                  302 	mov.io	__tm2s, a
                                    303 ;	./Padauk-tone/tone.h: 70: break;
      0000C6 75 18                  304 	goto	00118$
                                    305 ;	./Padauk-tone/tone.h: 71: case 13:
      0000C8                        306 00111$:
                                    307 ;	./Padauk-tone/tone.h: 72: TM2S = tone_e5;
      0000C8 1C 17                  308 	mov	a, #0x1c
      0000CA 97 00                  309 	mov.io	__tm2s, a
                                    310 ;	./Padauk-tone/tone.h: 73: break;
      0000CC 75 18                  311 	goto	00118$
                                    312 ;	./Padauk-tone/tone.h: 74: case 14:
      0000CE                        313 00112$:
                                    314 ;	./Padauk-tone/tone.h: 75: TM2S = tone_f5;
      0000CE 1A 17                  315 	mov	a, #0x1a
      0000D0 97 00                  316 	mov.io	__tm2s, a
                                    317 ;	./Padauk-tone/tone.h: 76: break;
      0000D2 75 18                  318 	goto	00118$
                                    319 ;	./Padauk-tone/tone.h: 77: case 15:
      0000D4                        320 00113$:
                                    321 ;	./Padauk-tone/tone.h: 78: TM2S = tone_g5;
      0000D4 17 17                  322 	mov	a, #0x17
      0000D6 97 00                  323 	mov.io	__tm2s, a
                                    324 ;	./Padauk-tone/tone.h: 79: break;
      0000D8 75 18                  325 	goto	00118$
                                    326 ;	./Padauk-tone/tone.h: 80: case 16:
      0000DA                        327 00114$:
                                    328 ;	./Padauk-tone/tone.h: 81: TM2S = tone_a5;
      0000DA 15 17                  329 	mov	a, #0x15
      0000DC 97 00                  330 	mov.io	__tm2s, a
                                    331 ;	./Padauk-tone/tone.h: 82: break;
      0000DE 75 18                  332 	goto	00118$
                                    333 ;	./Padauk-tone/tone.h: 83: case 17:
      0000E0                        334 00115$:
                                    335 ;	./Padauk-tone/tone.h: 84: TM2S = tone_b5;
      0000E0 13 17                  336 	mov	a, #0x13
      0000E2 97 00                  337 	mov.io	__tm2s, a
                                    338 ;	./Padauk-tone/tone.h: 85: break;
      0000E4 75 18                  339 	goto	00118$
                                    340 ;	./Padauk-tone/tone.h: 86: case 18:
      0000E6                        341 00116$:
                                    342 ;	./Padauk-tone/tone.h: 87: TM2S = tone_c6;
      0000E6 11 17                  343 	mov	a, #0x11
      0000E8 97 00                  344 	mov.io	__tm2s, a
                                    345 ;	./Padauk-tone/tone.h: 91: }
      0000EA                        346 00118$:
                                    347 ;	./Padauk-tone/tone.h: 92: TM2C = (uint8_t)(TM2C_INVERT_OUT | TM2C_MODE_PWM | TM2C_OUT_PA3 | TM2C_CLK_IHRC);
      0000EA 2B 17                  348 	mov	a, #0x2b
      0000EC 9C 00                  349 	mov.io	__tm2c, a
                                    350 ;	./Padauk-tone/tone.h: 93: }
      0000EE 3A 00                  351 	ret
                                    352 ;	main.c: 26: unsigned char _sdcc_external_startup(void) {
                                    353 ;	-----------------------------------------
                                    354 ;	 function _sdcc_external_startup
                                    355 ;	-----------------------------------------
      0000F0                        356 __sdcc_external_startup:
                                    357 ;	main.c: 29: PDK_SET_SYSCLOCK(SYSCLOCK_IHRC_500KHZ);
      0000F0 7C 17                  358 	mov	a, #0x7c
      0000F2 83 00                  359 	mov.io	__clkmd, a
                                    360 ;	main.c: 30: EASY_PDK_CALIBRATE_IHRC(524288, TARGET_VDD_MV);
      0000F4 52 14                  361 	and	a, #'R'                       
      0000F6 43 14                  362 	and	a, #'C'                       
      0000F8 01 14                  363 	and	a, #(1)            
      0000FA 00 14                  364 	and	a, #((524288))     
      0000FC 00 14                  365 	and	a, #((524288)>>8)  
      0000FE 08 14                  366 	and	a, #((524288)>>16) 
      000100 00 14                  367 	and	a, #((524288)>>24) 
      000102 B8 14                  368 	and	a, #((3000))     
      000104 0B 14                  369 	and	a, #((3000)>>8)  
      000106 0B 14                  370 	and	a, #(0x0b)             
                                    371 ;	main.c: 37: return 0;
                                    372 ;	main.c: 38: }
      000108 00 01                  373 	ret	#0x00
                                    374 ;	main.c: 40: void interrupt(void) __interrupt(0) {
                                    375 ;	-----------------------------------------
                                    376 ;	 function interrupt
                                    377 ;	-----------------------------------------
      00010A                        378 _interrupt:
      00010A 32 00                  379 	push	af
      00010C C0 07                  380 	mov	a, p
      00010E 32 00                  381 	push	af
                                    382 ;	main.c: 41: if (INTRQ & INTRQ_T16) {
      000110 A5 00                  383 	mov.io	a, __intrq
      000112 04 14                  384 	and	a, #0x04
      000114 00 12                  385 	ceqsn	a, #0x00
      000116 8D 18                  386 	goto	00109$
      000118 91 18                  387 	goto	00103$
      00011A                        388 00109$:
                                    389 ;	main.c: 42: quarter_seconds++;
      00011A C3 07                  390 	mov	a, _quarter_seconds+0
      00011C 01 10                  391 	add	a, #0x01
      00011E C3 05                  392 	mov	_quarter_seconds+0, a
                                    393 ;	main.c: 43: INTRQ &= ~INTRQ_T16;
      000120 45 0E                  394 	set0.io	__intrq, #2
      000122                        395 00103$:
                                    396 ;	main.c: 45: }
      000122 33 00                  397 	pop	af
      000124 C0 05                  398 	mov	p, a
      000126 33 00                  399 	pop	af
      000128 3B 00                  400 	reti
                                    401 ;	main.c: 47: int main(void) {
                                    402 ;	-----------------------------------------
                                    403 ;	 function main
                                    404 ;	-----------------------------------------
      00012A                        405 _main:
                                    406 ;	main.c: 53: T16M = 0b00111010;        // Use System (IHRC) clock source (524.288 kHz), /64, Interrupt on (rising) Bit 10
      00012A 3A 17                  407 	mov	a, #0x3a
      00012C 86 00                  408 	mov.io	__t16m, a
                                    409 ;	main.c: 55: T16C = 0;
      00012E 80 09                  410 	clear	p
      000130 C0 00                  411 	stt16	p
                                    412 ;	main.c: 56: INTEN = INTEN_T16;
      000132 04 17                  413 	mov	a, #0x04
      000134 84 00                  414 	mov.io	__inten, a
                                    415 ;	main.c: 59: INTRQ = 0;
      000136 00 17                  416 	mov	a, #0x00
      000138 85 00                  417 	mov.io	__intrq, a
                                    418 ;	main.c: 60: __engint();
      00013A 38 00                  419 	engint
                                    420 ;	main.c: 62: while (1) {
      00013C                        421 00135$:
                                    422 ;	main.c: 63: if (quarter_seconds != prev_quarter_seconds) {
      00013C C3 07                  423 	mov	a, _quarter_seconds+0
      00013E 84 0B                  424 	ceqsn	a, _prev_quarter_seconds+0
      000140 A2 18                  425 	goto	00216$
      000142 9E 18                  426 	goto	00135$
      000144                        427 00216$:
                                    428 ;	main.c: 64: prev_quarter_seconds = quarter_seconds;
      000144 C3 07                  429 	mov	a, _quarter_seconds+0
      000146 C4 05                  430 	mov	_prev_quarter_seconds+0, a
                                    431 ;	main.c: 65: noTone();
      000148 26 1C                  432 	call	_noTone
                                    433 ;	main.c: 66: setPinPullup(UP_BTN_PIN);
      00014A F2 0F                  434 	set1.io	__paph, #7
                                    435 ;	main.c: 67: setPinPullup(ST_BTN_PIN);
      00014C D2 0F                  436 	set1.io	__paph, #6
                                    437 ;	main.c: 69: switch (mode_now) {
      00014E C5 07                  438 	mov	a, _mode_now+0
      000150 00 12                  439 	ceqsn	a, #0x00
      000152 AB 18                  440 	goto	00218$
      000154 CD 18                  441 	goto	00108$
      000156                        442 00218$:
      000156 C5 07                  443 	mov	a, _mode_now+0
      000158 01 12                  444 	ceqsn	a, #0x01
      00015A AF 18                  445 	goto	00220$
      00015C B4 18                  446 	goto	00101$
      00015E                        447 00220$:
      00015E C5 07                  448 	mov	a, _mode_now+0
      000160 02 12                  449 	ceqsn	a, #0x02
      000162 B3 18                  450 	goto	00222$
      000164 27 19                  451 	goto	00127$
      000166                        452 00222$:
      000166 33 19                  453 	goto	00131$
                                    454 ;	main.c: 70: case MODE_CNT:
      000168                        455 00101$:
                                    456 ;	main.c: 72: if (isPinLow(ST_BTN_PIN)) {
      000168 B0 00                  457 	mov.io	a, __pa
      00016A 40 14                  458 	and	a, #0x40
      00016C 00 12                  459 	ceqsn	a, #0x00
      00016E B9 18                  460 	goto	00103$
                                    461 ;	main.c: 73: mode_now = MODE_WAIT;
      000170 85 09                  462 	clear	_mode_now+0
      000172                        463 00103$:
                                    464 ;	main.c: 75: if ((quarter_seconds & 0b00000011) == 0b00000011) {
      000172 80 09                  465 	clear	p
      000174 C3 07                  466 	mov	a, _quarter_seconds+0
      000176 03 14                  467 	and	a, #0x03
      000178 80 09                  468 	clear	p
      00017A 03 12                  469 	ceqsn	a, #0x03
      00017C 33 19                  470 	goto	00131$
      00017E C0 07                  471 	mov	a, p
      000180 00 12                  472 	ceqsn	a, #0x00
      000182 33 19                  473 	goto	00131$
                                    474 ;	main.c: 77: seconds++;
      000184 07 09                  475 	inc	_seconds+0
      000186 08 08                  476 	addc	_seconds+1
                                    477 ;	main.c: 78: if (seconds == set_seconds) {
      000188 C7 07                  478 	mov	a, _seconds+0
      00018A 89 0B                  479 	ceqsn	a, _set_seconds+0
      00018C 33 19                  480 	goto	00131$
      00018E C8 07                  481 	mov	a, _seconds+1
      000190 8A 0B                  482 	ceqsn	a, _set_seconds+1
      000192 33 19                  483 	goto	00131$
                                    484 ;	main.c: 79: mode_now = MODE_END;
      000194 02 17                  485 	mov	a, #0x02
      000196 C5 05                  486 	mov	_mode_now+0, a
                                    487 ;	main.c: 82: break;
      000198 33 19                  488 	goto	00131$
                                    489 ;	main.c: 84: case MODE_WAIT:
      00019A                        490 00108$:
                                    491 ;	main.c: 85: if ((isPinLow(ST_BTN_PIN)) && (isPinLow(UP_BTN_PIN))) {
      00019A B0 00                  492 	mov.io	a, __pa
      00019C 40 14                  493 	and	a, #0x40
      00019E 00 12                  494 	ceqsn	a, #0x00
      0001A0 E0 18                  495 	goto	00124$
      0001A2 B0 00                  496 	mov.io	a, __pa
      0001A4 80 14                  497 	and	a, #0x80
      0001A6 00 12                  498 	ceqsn	a, #0x00
      0001A8 E0 18                  499 	goto	00124$
                                    500 ;	main.c: 87: seconds = 0;
      0001AA 87 09                  501 	clear	_seconds+0
      0001AC 88 09                  502 	clear	_seconds+1
                                    503 ;	main.c: 88: set_seconds = 0;
      0001AE 89 09                  504 	clear	_set_seconds+0
      0001B0 8A 09                  505 	clear	_set_seconds+1
                                    506 ;	main.c: 89: tone_cnt = 0;            
      0001B2 86 09                  507 	clear	_tone_cnt+0
                                    508 ;	main.c: 90: idle_cnt = IDLE_DUR;
      0001B4 02 17                  509 	mov	a, #0x02
      0001B6 CB 05                  510 	mov	_idle_cnt+0, a
                                    511 ;	main.c: 91: tonePA3ND(6); // La
      0001B8 06 17                  512 	mov	a, #0x06
      0001BA C2 05                  513 	mov	_tonePA3ND_PARM_1+0, a
      0001BC 2A 1C                  514 	call	_tonePA3ND
      0001BE 33 19                  515 	goto	00131$
      0001C0                        516 00124$:
                                    517 ;	main.c: 93: } else if ((isPinHigh(ST_BTN_PIN)) && (isPinLow(UP_BTN_PIN))) {
      0001C0 B0 00                  518 	mov.io	a, __pa
      0001C2 40 14                  519 	and	a, #0x40
      0001C4 00 12                  520 	ceqsn	a, #0x00
      0001C6 E5 18                  521 	goto	00223$
      0001C8 FF 18                  522 	goto	00120$
      0001CA                        523 00223$:
      0001CA B0 00                  524 	mov.io	a, __pa
      0001CC 80 14                  525 	and	a, #0x80
      0001CE 00 12                  526 	ceqsn	a, #0x00
      0001D0 FF 18                  527 	goto	00120$
                                    528 ;	main.c: 95: set_seconds+=60;
      0001D2 C9 07                  529 	mov	a, _set_seconds+0
      0001D4 3C 10                  530 	add	a, #0x3c
      0001D6 C0 05                  531 	mov	p, a
      0001D8 CA 07                  532 	mov	a, _set_seconds+1
      0001DA 10 00                  533 	addc	a
      0001DC CA 05                  534 	mov	_set_seconds+1, a
      0001DE C0 07                  535 	mov	a, p
      0001E0 C9 05                  536 	mov	_set_seconds+0, a
                                    537 ;	main.c: 96: idle_cnt = IDLE_DUR;
      0001E2 02 17                  538 	mov	a, #0x02
      0001E4 CB 05                  539 	mov	_idle_cnt+0, a
                                    540 ;	main.c: 97: tonePA3ND(tone_cnt%18+1); // 1to18
      0001E6 C6 07                  541 	mov	a, _tone_cnt+0
      0001E8 CC 05                  542 	mov	__modsint_PARM_1+0, a
      0001EA 8D 09                  543 	clear	__modsint_PARM_1+1
      0001EC 12 17                  544 	mov	a, #0x12
      0001EE CE 05                  545 	mov	__modsint_PARM_2+0, a
      0001F0 8F 09                  546 	clear	__modsint_PARM_2+1
      0001F2 37 1D                  547 	call	__modsint
      0001F4 01 10                  548 	add	a, #0x01
      0001F6 C2 05                  549 	mov	_tonePA3ND_PARM_1+0, a
      0001F8 2A 1C                  550 	call	_tonePA3ND
                                    551 ;	main.c: 98: tone_cnt++;
      0001FA 06 09                  552 	inc	_tone_cnt+0
      0001FC 33 19                  553 	goto	00131$
      0001FE                        554 00120$:
                                    555 ;	main.c: 99: } else if ((isPinLow(ST_BTN_PIN)) && (isPinHigh(UP_BTN_PIN)) && (set_seconds != 0)) {
      0001FE B0 00                  556 	mov.io	a, __pa
      000200 40 14                  557 	and	a, #0x40
      000202 00 12                  558 	ceqsn	a, #0x00
      000204 15 19                  559 	goto	00115$
      000206 B0 00                  560 	mov.io	a, __pa
      000208 80 14                  561 	and	a, #0x80
      00020A 00 12                  562 	ceqsn	a, #0x00
      00020C 08 19                  563 	goto	00224$
      00020E 15 19                  564 	goto	00115$
      000210                        565 00224$:
      000210 C9 07                  566 	mov	a, _set_seconds+0
      000212 4A 07                  567 	or	a, _set_seconds+1
      000214 00 12                  568 	ceqsn	a, #0x00
      000216 0D 19                  569 	goto	00225$
      000218 15 19                  570 	goto	00115$
      00021A                        571 00225$:
                                    572 ;	main.c: 101: mode_now = MODE_CNT;
      00021A 01 17                  573 	mov	a, #0x01
      00021C C5 05                  574 	mov	_mode_now+0, a
                                    575 ;	main.c: 102: idle_cnt = IDLE_DUR;
      00021E 02 17                  576 	mov	a, #0x02
      000220 CB 05                  577 	mov	_idle_cnt+0, a
                                    578 ;	main.c: 104: tonePA3ND(8); // Do
      000222 08 17                  579 	mov	a, #0x08
      000224 C2 05                  580 	mov	_tonePA3ND_PARM_1+0, a
      000226 2A 1C                  581 	call	_tonePA3ND
      000228 33 19                  582 	goto	00131$
      00022A                        583 00115$:
                                    584 ;	main.c: 107: else if ((isPinHigh(ST_BTN_PIN)) && (isPinHigh(UP_BTN_PIN))) {
      00022A B0 00                  585 	mov.io	a, __pa
      00022C 40 14                  586 	and	a, #0x40
      00022E 00 12                  587 	ceqsn	a, #0x00
      000230 1A 19                  588 	goto	00226$
      000232 33 19                  589 	goto	00131$
      000234                        590 00226$:
      000234 B0 00                  591 	mov.io	a, __pa
      000236 80 14                  592 	and	a, #0x80
      000238 00 12                  593 	ceqsn	a, #0x00
      00023A 1F 19                  594 	goto	00227$
      00023C 33 19                  595 	goto	00131$
      00023E                        596 00227$:
                                    597 ;	main.c: 108: idle_cnt--;
      00023E CB 08                  598 	dzsn	_idle_cnt+0
      000240 33 19                  599 	goto	00131$
                                    600 ;	main.c: 109: if (idle_cnt == 0) {
                                    601 ;	main.c: 110: PADIER = (uint8_t)((1<<UP_BTN_PIN_BIT)|(1<<ST_BTN_PIN_BIT));
      000242 C0 17                  602 	mov	a, #0xc0
      000244 8D 00                  603 	mov.io	__padier, a
                                    604 ;	main.c: 111: noTone(); // tone off
      000246 26 1C                  605 	call	_noTone
                                    606 ;	main.c: 113: __stopexe(); 
      000248 37 00                  607 	stopexe
      00024A 00 00                  608 	nop
                                    609 ;	main.c: 119: break;
      00024C 33 19                  610 	goto	00131$
                                    611 ;	main.c: 121: case MODE_END:
      00024E                        612 00127$:
                                    613 ;	main.c: 123: if (isPinLow(ST_BTN_PIN)) {
      00024E B0 00                  614 	mov.io	a, __pa
      000250 40 14                  615 	and	a, #0x40
      000252 00 12                  616 	ceqsn	a, #0x00
      000254 30 19                  617 	goto	00129$
                                    618 ;	main.c: 124: seconds = 0;
      000256 87 09                  619 	clear	_seconds+0
      000258 88 09                  620 	clear	_seconds+1
                                    621 ;	main.c: 125: noTone();
      00025A 26 1C                  622 	call	_noTone
                                    623 ;	main.c: 126: mode_now = MODE_WAIT;
      00025C 85 09                  624 	clear	_mode_now+0
      00025E 33 19                  625 	goto	00131$
      000260                        626 00129$:
                                    627 ;	main.c: 128: tonePA3ND(17); // Si 5
      000260 11 17                  628 	mov	a, #0x11
      000262 C2 05                  629 	mov	_tonePA3ND_PARM_1+0, a
      000264 2A 1C                  630 	call	_tonePA3ND
                                    631 ;	main.c: 133: }  
      000266                        632 00131$:
                                    633 ;	main.c: 135: clearPinPullup(ST_BTN_PIN);
      000266 D2 0E                  634 	set0.io	__paph, #6
                                    635 ;	main.c: 136: clearPinPullup(UP_BTN_PIN);
      000268 F2 0E                  636 	set0.io	__paph, #7
      00026A 9E 18                  637 	goto	00135$
                                    638 ;	main.c: 139: }
      00026C 3A 00                  639 	ret
                                    640 	.area CODE
                                    641 	.area CONST
                                    642 	.area CABS (ABS)
