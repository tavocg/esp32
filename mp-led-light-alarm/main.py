from time import sleep_ms

from machine import Pin, PWM

# The SuperMini's built-in blue LED turns on when GPIO8 is low.
# PWM duty is inverted: 1023 = LED off, 0 = full brightness.
led = PWM(Pin(8))
led.freq(1000)
led.duty(1023)

MAX = 1023


def brightness(level):
    led.duty(MAX - level)


def ramp(start, end, steps, delay_ms):
    for i in range(steps + 1):
        brightness(start + (end - start) * i // steps)
        sleep_ms(delay_ms)


def chirp(times, level, on_ms, off_ms):
    for _ in range(times):
        brightness(level)
        sleep_ms(on_ms)
        brightness(0)
        sleep_ms(off_ms)


try:
    while True:
        # Two short chirps, as when the alarm is triggered.
        chirp(2, 400, 80, 150)
        sleep_ms(200)

        # Siren wail: brightness rises and falls three times.
        for _ in range(3):
            ramp(0, MAX, 20, 20)
            ramp(MAX, 0, 20, 20)
            sleep_ms(100)

        sleep_ms(1000)
finally:
    brightness(0)
