CHIP ?= esp32c3
PIO_RUN = pio run -e "$(CHIP)"
SERIAL_PORT = $(if $(PORT),--port "$(PORT)")

.PHONY: build flash run
build:
	$(PIO_RUN)

flash:
	$(PIO_RUN) $(SERIAL_PORT) -t upload

run:
	$(PIO_RUN) $(SERIAL_PORT) -t upload -t monitor
