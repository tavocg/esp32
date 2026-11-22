MPREMOTE = mpremote $(if $(PORT),connect "$(PORT)")

.PHONY: run install
run:
	$(MPREMOTE) run main.py

install:
	$(MPREMOTE) fs cp main.py :main.py
