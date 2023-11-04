#Set the mimum required version of CMake
cmake_minimum_required(VERSION 3.12)

#Pull in SDK (must be before project)
include(pico_sdk_import.cmake)

#Set the project name, the programming language
project(SOIL_FIRM C CXX ASM)
set(CMAKE_C_STANDARD 11)
set(CMAKE_CXX_STANDARD 17)

#Initialize the SDK
pico_sdk_init()

add_executable(timer timer.c)

target_link_libraries(timer pico_stdlib hardware_pwm)

pico_enable_stdio_usb(timer 1)
pico_enable_stdio_uart(timer 0)

pico_add_extra_outputs(timer)

add_executable(buzzer buzzer.c)

target_link_libraries(buzzer pico_stdlib hardware_pwm)

pico_enable_stdio_usb(buzzer 1)
pico_enable_stdio_uart(buzzer 0)

pico_add_extra_outputs(buzzer)