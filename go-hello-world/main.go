package main

import (
	"machine"
	"time"
)

func main() {
	// The SuperMini's built-in blue LED is active-low on GPIO8.
	led := machine.GPIO8
	led.Configure(machine.PinConfig{Mode: machine.PinOutput})
	led.High() // off

	println("Hello, world! from TinyGo on ESP32-C3")

	for {
		led.Low() // on
		time.Sleep(50 * time.Millisecond)
		led.High() // off
		time.Sleep(1000 * time.Millisecond)
	}
}
