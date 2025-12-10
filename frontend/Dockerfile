# ================================
# EMTOOLS Frontend (Flutter) - Production Dockerfile
# ================================
# Builds Flutter web application and serves with nginx
# Version: 2.0.0-beta.4
# ================================

# Build stage - Flutter SDK
FROM ghcr.io/cirruslabs/flutter:stable AS build

WORKDIR /app

# Copy pubspec files first for better caching
COPY pubspec.yaml pubspec.lock ./

# Get dependencies
RUN flutter pub get

# Copy source code
COPY . .

# Build for web production
RUN flutter build web --release --web-renderer html

# ================================
# Production stage - Nginx
# ================================
FROM nginx:1.27-alpine3.20 AS production

# Add labels
LABEL org.opencontainers.image.title="EMTOOLS Frontend"
LABEL org.opencontainers.image.description="Emergency Medicine Tools - Flutter Web App"
LABEL org.opencontainers.image.version="2.0.0-beta.4"
LABEL org.opencontainers.image.authors="medlabib"

# Copy built Flutter web assets
COPY --from=build /app/build/web /usr/share/nginx/html

# Copy nginx configuration
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Create non-root user and fix permissions
RUN addgroup -g 1001 -S emtools && \
    adduser -S -D -H -u 1001 -h /var/cache/nginx -s /sbin/nologin -G emtools emtools && \
    chown -R emtools:emtools /var/cache/nginx /var/log/nginx /usr/share/nginx/html && \
    chmod -R 755 /usr/share/nginx/html && \
    sed -i 's|/var/run/nginx.pid|/tmp/nginx.pid|g' /etc/nginx/nginx.conf && \
    sed -i '/^user/d' /etc/nginx/nginx.conf

# Use non-root user
USER emtools

# Expose port
EXPOSE 80

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
    CMD wget --no-verbose --tries=1 --spider http://localhost:80/ || exit 1

CMD ["nginx", "-g", "daemon off;"]
