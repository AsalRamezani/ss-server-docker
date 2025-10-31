# پایه رسمی shadowsocks-libev
FROM shadowsocks/shadowsocks-libev:latest

# نصب curl برای keepalive
RUN apk add --no-cache curl

# پورت Shadowsocks
EXPOSE 8388/tcp 8388/udp

# متغیرهای محیطی (قابل override در Railway Variables)
ENV SS_PASSWORD=1q2w3e4r5t6y7u8i9o
ENV SS_METHOD=chacha20-ietf-poly1305
ENV SS_PORT=8388

# کپی فایل entrypoint
COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh

# اطمینان از executable بودن فایل (روی سیستم قبل از build)
# chmod +x docker-entrypoint.sh

# دستور اجرا
ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]
