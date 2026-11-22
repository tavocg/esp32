MPREMOTE = mpremote $(if $(PORT),connect "$(PORT)")

.PHONY: run install install-env uninstall
run:
	$(MPREMOTE) run main.py

install:
	$(MPREMOTE) fs cp main.py :main.py
	@if [ -f .env ]; then $(MPREMOTE) fs cp .env :.env; fi

install-env:
	@test -f .env || { echo "Falta .env: copia .env.example" >&2; exit 2; }
	$(MPREMOTE) fs cp .env :.env

uninstall:
	$(MPREMOTE) fs rm :main.py
	@$(MPREMOTE) fs rm :.env 2>/dev/null || true
