MPREMOTE = mpremote $(if $(PORT),connect "$(PORT)")

.PHONY: run install uninstall
run:
	$(MPREMOTE) run main.py

install:
	$(MPREMOTE) fs cp main.py :main.py

uninstall:
	$(MPREMOTE) fs rm :main.py
