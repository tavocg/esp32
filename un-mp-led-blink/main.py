from time import sleep_ms

from machine import Pin

# The SuperMini's built-in blue LED turns on when GPIO8 is low.
led = Pin(8, Pin.OUT, value=1)

try:
    while True:
        led.value(0)
        sleep_ms(500)
        led.value(1)
        sleep_ms(500)
finally:
    led.value(1)
