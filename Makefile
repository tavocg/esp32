CHIP ?= esp32c3
MP_RELEASE ?= 20260824-v1.29.0

# MicroPython board name and flash offset for the full .bin image.
MP_IMAGE_esp32   := ESP32_GENERIC    0x1000
MP_IMAGE_esp32c2 := ESP32_GENERIC_C2 0x0
MP_IMAGE_esp32c3 := ESP32_GENERIC_C3 0x0
MP_IMAGE_esp32c5 := ESP32_GENERIC_C5 0x2000
MP_IMAGE_esp32c6 := ESP32_GENERIC_C6 0x0
MP_IMAGE_esp32s2 := ESP32_GENERIC_S2 0x1000
MP_IMAGE_esp32s3 := ESP32_GENERIC_S3 0x0

MP_IMAGE := $(MP_IMAGE_$(CHIP))
MP_FIRMWARE ?= $(word 1,$(MP_IMAGE))-$(MP_RELEASE).bin
MP_OFFSET := $(word 2,$(MP_IMAGE))
ESPTOOL = esptool --chip "$(CHIP)" $(if $(PORT),--port "$(PORT)")
WRITE_FLASH = $(ESPTOOL) write-flash $(if $(filter 1,$(ERASE)),--erase-all)

.PHONY: help reset flash-mp flash
help:
	@echo "make reset | make flash-mp | make flash BIN=file.bin OFFSET=address"
	@echo "CHIP selects the target chip (currently $(CHIP)). Try make flash-mp CHIP=esp32s3."
	@echo "MP_RELEASE selects the MicroPython release date and version (currently $(MP_RELEASE))."
	@echo "Set MP_FIRMWARE to the .bin filename from the MicroPython downloads page."
	@echo "PORT=/dev/ttyACM0 selects the board's serial port. ERASE=1 erases the entire flash before writing."

reset:
	$(ESPTOOL) run

flash-mp:
ifeq ($(MP_IMAGE),)
	$(error No MicroPython image is configured for CHIP=$(CHIP). Use make flash with BIN and OFFSET)
endif
	@set -eu; firmware=$$(mktemp); trap 'rm -f "$$firmware"' EXIT; \
	curl -fsSL -o "$$firmware" \
		"https://micropython.org/resources/firmware/$(MP_FIRMWARE)"; \
	$(WRITE_FLASH) $(MP_OFFSET) "$$firmware"

flash:
	@test -n "$(BIN)" && test -n "$(OFFSET)" || { echo "Usage: make flash BIN=file.bin OFFSET=address" >&2; exit 2; }
	$(WRITE_FLASH) "$(OFFSET)" "$(BIN)"
