#!/bin/sh

# Start Shadowsocks server
ss-server -s 0.0.0.0 -p "$SS_PORT" -k "$SS_PASSWORD" -m "$SS_METHOD" &

sleep 3

# Get public IP (no curl needed)
IP=$(wget -qO- http://ifconfig.me 2>/dev/null || echo "127.0.0.1")

# Print connection info
LINK=$(echo -n "$SS_METHOD:$SS_PASSWORD@$IP:$SS_PORT" | base64 | tr -d '\n')
echo "================================="
echo "Shadowsocks link (ss://): ss://$LINK"
echo "Raw (method:password@host:port): $SS_METHOD:$SS_PASSWORD@$IP:$SS_PORT"
echo "================================="

# Keep container alive with very low resource usage
while true; do
    for host in google.com cloudflare.com example.com; do
        (echo > /dev/tcp/$host/80) >/dev/null 2>&1
    done
    sleep 300
done
