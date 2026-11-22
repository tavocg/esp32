import socket
from time import sleep_ms

import network


def load_env(filename):
    """Lee KEY=VALUE de un archivo .env; devuelve {} si no existe."""
    values = {}
    try:
        with open(filename) as env_file:
            for line in env_file:
                line = line.strip()
                if not line or line.startswith("#") or "=" not in line:
                    continue
                key, value = line.split("=", 1)
                values[key.strip()] = value.strip().strip('"').strip("'")
    except OSError:
        pass
    return values


env = load_env(".env")
SSID = env.get("SSID", "")
PASSWORD = env.get("PASSWORD", "")
PORT = int(env.get("PORT", "80"))

HTML = """<!doctype html>
<html lang="es">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Hello World</title>
<link rel="stylesheet" href="https://tavocg.github.io/semantic/semantic.css">
</head>
<body>
<header><strong>ESP32-C3</strong></header>
<main>
<article>
<h1 class="primary">Hello World</h1>
<p>Hola desde MicroPython en el ESP32.</p>
</article>
</main>
<footer>Servido por MicroPython</footer>
</body>
</html>
"""

BODY = HTML.encode("utf-8")
RESPONSE = (
    b"HTTP/1.0 200 OK\r\n"
    b"Content-Type: text/html; charset=utf-8\r\n"
    b"Connection: close\r\n"
    b"\r\n"
) + BODY

wifi = network.WLAN(network.STA_IF)
wifi.active(True)
if not wifi.isconnected():
    wifi.connect(SSID, PASSWORD)
    for _ in range(50):
        if wifi.isconnected():
            break
        sleep_ms(100)

if not wifi.isconnected():
    raise RuntimeError("No se pudo conectar a Wi-Fi: %s" % SSID)

addr = socket.getaddrinfo("0.0.0.0", PORT)[0][-1]
server = socket.socket()
server.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
server.bind(addr)
server.listen(5)

print("Conectado a:", SSID)
print("Abre http://%s/" % wifi.ifconfig()[0])

try:
    while True:
        conn, client = server.accept()
        try:
            conn.recv(1024)
            conn.sendall(RESPONSE)
        finally:
            conn.close()
finally:
    server.close()
