TARGET ?= esp32c3-supermini
PORT   ?=

FLASH_PORT = $(if $(PORT),-port=$(PORT))

.PHONY: build flash
build:
	tinygo build -target=$(TARGET) -o firmware.bin .

flash:
	tinygo flash -target=$(TARGET) $(FLASH_PORT) .
