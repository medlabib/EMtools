# ================================
# EMTOOLS Frontend - Production Dockerfile
# ================================

# Build stage
FROM node:22-alpine3.20 AS build

WORKDIR /app

# Copy package files
COPY package*.json ./

# Install dependencies
RUN npm ci --only=production=false

# Copy source code
COPY . .

# Build for production
RUN npm run build

# ================================
# Production stage
# ================================
FROM nginx:1.27-alpine3.20 AS production

# Add labels
LABEL org.opencontainers.image.title="EMTOOLS Frontend"
LABEL org.opencontainers.image.description="Emergency Medicine Tools - Frontend"
LABEL org.opencontainers.image.version="1.0.0-alpha"

# Copy built assets from build stage
COPY --from=build /app/dist /usr/share/nginx/html

# Copy nginx configuration
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Create non-root user
RUN addgroup -g 1001 -S emtools && \
    adduser -S -D -H -u 1001 -h /var/cache/nginx -s /sbin/nologin -G emtools emtools && \
    chown -R emtools:emtools /var/cache/nginx /var/run /var/log/nginx /usr/share/nginx/html && \
    chmod -R 755 /usr/share/nginx/html

# Security: Remove default nginx files
RUN rm -rf /usr/share/nginx/html/index.html 2>/dev/null || true

# Use non-root user
USER emtools

# Expose port
EXPOSE 80

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
    CMD wget --no-verbose --tries=1 --spider http://localhost:80/ || exit 1

CMD ["nginx", "-g", "daemon off;"]
