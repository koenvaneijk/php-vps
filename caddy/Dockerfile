# Stage 1: Build the Caddy binary
FROM caddy:2-builder AS caddy-builder
RUN xcaddy build \
    --with github.com/caddy-dns/cloudflare

# Stage 2: Copy the Caddy binary to a new image
FROM caddy:2-alpine
COPY --from=caddy-builder /usr/bin/caddy /usr/bin/caddy

# Create a non-root user
RUN adduser -D -u 10000 caddy
USER caddy