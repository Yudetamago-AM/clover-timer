#include <stdio.h>
#include "pico/stdlib.h"
#include "hardware/pwm.h"

#define BUZZER_PIN 0

int main(void) {
    stdio_init_all();
    sleep_ms(2000);
    printf("buzzer test\n");

    gpio_set_function(BUZZER_PIN, GPIO_FUNC_PWM);
    uint8_t buzzer_pwm_slice = pwm_gpio_to_slice_num(BUZZER_PIN);

    // clkdiv = 125*10^6 / f*(wrap+1)
#if 0
    // f=7.8kHz, wrap=255
    // duty=40/255=15%くらいで十分な音量だが、それ以前にキーンとした不快な音
    pwm_set_clkdiv(buzzer_pwm_slice, 62.6);
    pwm_set_wrap(buzzer_pwm_slice, 255);
#endif

#if 1
    // f=440Hz, wrap=2047
    // duty=100/2047=5%くらいで十分。ちゃんと「ラ」
    pwm_set_clkdiv(buzzer_pwm_slice, 138.7);
    pwm_set_wrap(buzzer_pwm_slice, 2047);
#endif
    pwm_set_chan_level(buzzer_pwm_slice, PWM_CHAN_A, 0);
    pwm_set_enabled(buzzer_pwm_slice, true);

    while (1) {
        char c;
        for (int i = 0; i < 2047; i+=4) {
            pwm_set_chan_level(buzzer_pwm_slice, PWM_CHAN_A, i);
            printf("duty: %d\n", i);
            if ((c = getchar_timeout_us(5000))=='s') {
                continue;
            } 
            sleep_ms(100);
        }
    }
    
}