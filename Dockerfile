FROM shadowsocks/shadowsocks-libev:latest

# Copy entrypoint with exec permission directly
COPY --chmod=755 docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh

# Environment variables (normal ones only)
ENV SS_METHOD="chacha20-ietf-poly1305"
ENV SS_PASSWORD="1q2w3e4r5t6y7u8i9o"
ENV SS_PORT=8388

EXPOSE 8388/tcp

ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]
