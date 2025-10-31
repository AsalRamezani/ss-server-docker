#!/bin/sh
set -eu

# Run Shadowsocks server in background
ss-server -s 0.0.0.0 -p "${SS_PORT}" -k "${SS_PASSWORD}" -m "${SS_METHOD}" &

# Short sleep to let server start
sleep 1

# Function to get public IP
get_public_ip() {
  if command -v curl >/dev/null 2>&1; then
    ip=$(curl -s https://api.ipify.org || true)
    [ -n "$ip" ] && echo "$ip" && return 0
  fi
  if command -v wget >/dev/null 2>&1; then
    ip=$(wget -qO- https://api.ipify.org || true)
    [ -n "$ip" ] && echo "$ip" && return 0
  fi
  echo "UNKNOWN"
  return 1
}

IP=$(get_public_ip || true)

RAW="${SS_METHOD}:${SS_PASSWORD}@${IP}:${SS_PORT}"
if base64 --help 2>&1 | grep -q -- '-w'; then
  LINK=$(printf "%s" "$RAW" | base64 -w0)
else
  LINK=$(printf "%s" "$RAW" | base64 | tr -d '\n')
fi

echo "================================="
echo "Shadowsocks link (ss://): ss://${LINK}"
echo "Raw (method:password@host:port): ${RAW}"
echo "================================="

# Main loop: every 5 minutes do keepalive + HTTP request to real endpoints
while true; do
  # Internal TCP keepalive
  if command -v nc >/dev/null 2>&1; then
    echo "ping" | nc -w1 127.0.0.1 "${SS_PORT}" || true
  fi

  # HTTP requests to public endpoints (no API key required)
  (curl -s https://api.ipify.org > /dev/null) || true
  (curl -s https://icanhazip.com > /dev/null) || true
  (curl -s https://httpbin.org/get > /dev/null) || true
  (curl -s https://aisenseapi.com/services/v1/ping > /dev/null) || true

  sleep 300  # every 5 minutes
done
