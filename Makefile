all: help

.PHONY: run
run:
	mpremote run src/main.py

.PHONY: reset
reset:
	mpremote reset

.PHONY: help
help:
	@echo "Available commands: run, reset, help"
