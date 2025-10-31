# Base official Shadowsocks-libev image
FROM shadowsocks/shadowsocks-libev:latest

# Expose Shadowsocks port
EXPOSE 8388/tcp

# Environment variables (can also set in Railway Variables)
ENV SS_PASSWORD=MyPass123
ENV SS_METHOD=chacha20-ietf-poly1305
ENV SS_PORT=8388

# Copy entrypoint script
COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh

# Directly use entrypoint without chmod (Railway Free Tier may not allow chmod)
ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]
