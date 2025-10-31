FROM shadowsocks/shadowsocks-libev:latest

# Copy entrypoint script
COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh

# Give permission to execute
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

# Set environment variables
ENV SS_METHOD="chacha20-ietf-poly1305"
ENV SS_PASSWORD="1q2w3e4r5t6y7u8i9o"
ENV SS_PORT=8388

EXPOSE 8388/tcp

ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]
