#include <pdk/device.h>
#include <easy-pdk/calibrate.h>
#include "util.h"
#include "./Padauk-tone/tone.h"

#define UP_BTN_PIN_BIT 7
#define ST_BTN_PIN_BIT 6

#define UP_BTN_PIN PA,7
#define ST_BTN_PIN PA,6
#define BUZZER_PIN PA,3

#define MODE_WAIT 0
#define MODE_CNT  1
#define MODE_END  2

#define IDLE_DUR 2 // 0.25*2=0.5sec

volatile uint8_t quarter_seconds;
uint8_t prev_quarter_seconds = 0;
uint8_t mode_now = MODE_WAIT;
uint8_t tone_cnt = 0;
uint16_t seconds = 0, set_seconds = 0;
uint8_t idle_cnt = IDLE_DUR; 

unsigned char _sdcc_external_startup(void) {
    
#if (F_CPU == 524288)
  PDK_SET_SYSCLOCK(SYSCLOCK_IHRC_500KHZ);
  EASY_PDK_CALIBRATE_IHRC(524288, TARGET_VDD_MV);
#elif (F_CPU == 65536)
  PDK_SET_SYSCLOCK(SYSCLOCK_ILRC);
  EASY_PDK_CALIBRATE_ILRC(65536, TARGET_VDD_MV);
#else
  #error "Unknown F_CPU"
#endif
    return 0;
}

void interrupt(void) __interrupt(0) {
    if (INTRQ & INTRQ_T16) {
        quarter_seconds++;
        INTRQ &= ~INTRQ_T16;
    }
}

int main(void) {
    

    #if (F_CPU == 65536)
		T16M = 0b11010001;        // Use ILRC clock source (65.536 kHz), /16, Interrupt on (rising) Bit 9
	#elif (F_CPU == 524288)
		T16M = 0b00111010;        // Use System (IHRC) clock source (524.288 kHz), /64, Interrupt on (rising) Bit 10
	#endif
    T16C = 0;
	INTEN = INTEN_T16;

    // Enable Global Interrupt
    INTRQ = 0;
	__engint();

    while (1) {
        if (quarter_seconds != prev_quarter_seconds) {
            prev_quarter_seconds = quarter_seconds;
            noTone();
            setPinPullup(UP_BTN_PIN);
            setPinPullup(ST_BTN_PIN);

            switch (mode_now) {
            case MODE_CNT:

            if (isPinLow(ST_BTN_PIN)) {
                mode_now = MODE_WAIT;
            }
            if ((quarter_seconds & 0b00000011) == 0b00000011) {
                // once a second
                seconds++;
                if (seconds == set_seconds) {
                    mode_now = MODE_END;
                }
            }
            break;

            case MODE_WAIT:
            if ((isPinLow(ST_BTN_PIN)) && (isPinLow(UP_BTN_PIN))) {
                // reset counters
                seconds = 0;
                set_seconds = 0;
                tone_cnt = 0;            
                idle_cnt = IDLE_DUR;
                tonePA3ND(6); // La
                
            } else if ((isPinHigh(ST_BTN_PIN)) && (isPinLow(UP_BTN_PIN))) {
                // set seconds
                set_seconds+=60;
                idle_cnt = IDLE_DUR;
                tonePA3ND(tone_cnt%18+1); // 1to18
                tone_cnt++;
            } else if ((isPinLow(ST_BTN_PIN)) && (isPinHigh(UP_BTN_PIN)) && (set_seconds != 0)) {
                //start
                mode_now = MODE_CNT;
                idle_cnt = IDLE_DUR;
                //tone_cnt = 0;
                tonePA3ND(8); // Do
            } 
            #if 1
            else if ((isPinHigh(ST_BTN_PIN)) && (isPinHigh(UP_BTN_PIN))) {
                idle_cnt--;
                if (idle_cnt == 0) {
                    PADIER = (uint8_t)((1<<UP_BTN_PIN_BIT)|(1<<ST_BTN_PIN_BIT));
                    noTone(); // tone off

                    __stopexe(); 
                    // datasheet says PAC should be '1' but '1' means output.
                    // result: PAC should be '0'. datasheet was wrong.
                }
            }
            #endif
            break;

            case MODE_END:
            
            if (isPinLow(ST_BTN_PIN)) {
                seconds = 0;
                noTone();
                mode_now = MODE_WAIT;
            } else {
                tonePA3ND(17); // Si 5

            }
            break;

            }  

            clearPinPullup(ST_BTN_PIN);
            clearPinPullup(UP_BTN_PIN);
        }
    }
}