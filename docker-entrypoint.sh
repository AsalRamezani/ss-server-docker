#!/bin/sh

SS_PORT="${PORT:-${SS_PORT}}"

echo "Starting Shadowsocks on port $SS_PORT..."


ss-server -s 0.0.0.0 -p "$SS_PORT" -k "$SS_PASSWORD" -m "$SS_METHOD" -u &

sleep 3

IP=$(wget -qO- ifconfig.me 2>/dev/null || echo "RAILWAY_DOMAIN")


if [ -n "$RAILWAY_PUBLIC_DOMAIN" ]; then
    IP="$RAILWAY_PUBLIC_DOMAIN"
fi


LINK=$(echo -n "$SS_METHOD:$SS_PASSWORD@$IP:$SS_PORT" | base64 | tr -d '\n')

echo "================================="
echo "Shadowsocks Server Started!"
echo "================================="
echo "ss://$LINK"
echo ""
echo "Raw: $SS_METHOD:$SS_PASSWORD@$IP:$SS_PORT"
echo "================================="


tail -f /dev/null
