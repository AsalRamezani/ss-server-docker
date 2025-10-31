#!/bin/sh

# Start Shadowsocks server in background
ss-server -s 0.0.0.0 -p "$SS_PORT" -k "$SS_PASSWORD" -m "$SS_METHOD" &

# Short sleep to allow server startup
sleep 2

# Get container's public IP
IP=$(wget -qO- https://api.ipify.org 2>/dev/null || echo "127.0.0.1")

# Build ss:// link
LINK=$(echo -n "$SS_METHOD:$SS_PASSWORD@$IP:$SS_PORT" | base64 | tr -d '\n')

echo "================================="
echo "Shadowsocks link (ss://): ss://$LINK"
echo "Raw (method:password@host:port): $SS_METHOD:$SS_PASSWORD@$IP:$SS_PORT"
echo "================================="

# Simple keepalive loop using /dev/tcp (no extra packages needed)
while true; do
    # try to connect to port 80 of a few sites
    for host in example.com google.com cloudflare.com; do
        (echo > /dev/tcp/$host/80) >/dev/null 2>&1
    done
    sleep 300
done
