#include <stdio.h>
#include "pico/stdlib.h"
#include "hardware/pwm.h"

#define BUZZER_PIN 0
#define UP_BTN_PIN 1
#define ST_BTN_PIN 2

enum {
    MODE_WAIT,
    MODE_CNT,
    MODE_END,
};

volatile uint8_t quarter_seconds;
uint8_t prev_quarter_seconds = 0;
uint8_t mode_now = MODE_WAIT;
uint16_t seconds = 0, set_seconds = 0;

void buzzer(uint8_t slice, bool ison) {
    if (ison) pwm_set_chan_level(slice, PWM_CHAN_A, 100);
    else pwm_set_chan_level(slice, PWM_CHAN_A, 0);
}

bool every_quarter_seconds(repeating_timer_t *rt) {
    quarter_seconds++;
    return true;
}

int main(void) {
    stdio_init_all();
    sleep_ms(1000);
    printf("Clover Timer Pico Version\n");

    gpio_set_function(BUZZER_PIN, GPIO_FUNC_PWM);
    uint8_t buzzer_pwm_slice = pwm_gpio_to_slice_num(BUZZER_PIN);
    pwm_set_clkdiv(buzzer_pwm_slice, 138.7);
    pwm_set_wrap(buzzer_pwm_slice, 2047);
    pwm_set_chan_level(buzzer_pwm_slice, PWM_CHAN_A, 0);
    pwm_set_enabled(buzzer_pwm_slice, true);

    gpio_init(UP_BTN_PIN);
    gpio_set_dir(UP_BTN_PIN, GPIO_IN);
    gpio_pull_up(UP_BTN_PIN);

    gpio_init(ST_BTN_PIN);
    gpio_set_dir(ST_BTN_PIN, GPIO_IN);
    gpio_pull_up(ST_BTN_PIN);

    repeating_timer_t rt;
    add_repeating_timer_ms(-250, every_quarter_seconds, NULL, &rt);

    while (1) {
        if (quarter_seconds != prev_quarter_seconds) {
            prev_quarter_seconds = quarter_seconds;
            buzzer(buzzer_pwm_slice, false);

            switch (mode_now) {
            case MODE_CNT:

            if (gpio_get(ST_BTN_PIN)==0) {
                mode_now = MODE_WAIT;
            }
            if ((quarter_seconds & 0b00000011) == 0b00000011) {
                // once a second
                seconds++;
                printf("sec: %d, set: %d\n", seconds, set_seconds);
                if (seconds == set_seconds) {
                    mode_now = MODE_END;
                }
            }
            
            break;

            case MODE_WAIT:

            if (gpio_get(ST_BTN_PIN)==0 && gpio_get(UP_BTN_PIN)==0) {
                // reset count
                seconds = 0;
                set_seconds = 0;
                printf("reset count. sec: %d, set: %d\n", seconds, set_seconds);

                buzzer(buzzer_pwm_slice, true);
                
            } else if (gpio_get(ST_BTN_PIN)==1 && gpio_get(UP_BTN_PIN)==0) {
                set_seconds+=60;
                printf("set_seconds: %d\n", set_seconds);

                buzzer(buzzer_pwm_slice, true);
                
            } else if (gpio_get(ST_BTN_PIN)==0 && gpio_get(UP_BTN_PIN)==1 && set_seconds != 0) {
                printf("start!\n");
                mode_now = MODE_CNT;

                buzzer(buzzer_pwm_slice, true);
                
            }
            break;

            case MODE_END:
            
            if (gpio_get(ST_BTN_PIN)==0) {
                printf("stop buzzer\n");
                seconds = 0;
                buzzer(buzzer_pwm_slice, false);
                mode_now = MODE_WAIT;
            } else {
                buzzer(buzzer_pwm_slice, true);
            }

            break;

            }
                
        }
        
    }
}