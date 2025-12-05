# Installation Guide

## System Requirements

### Minimum Requirements
- **CPU**: 2 cores
- **RAM**: 4 GB
- **Storage**: 10 GB
- **OS**: Windows 10+, macOS 10.15+, Ubuntu 20.04+

### Recommended
- **CPU**: 4+ cores
- **RAM**: 8 GB
- **Storage**: 20 GB SSD

## Installation Methods

### Method 1: Docker (Recommended)

#### Prerequisites
- Docker Engine 20.10+
- Docker Compose 2.0+

#### Steps

```bash
# Clone repository
git clone https://github.com/medlabib/EMtools.git
cd EMtools

# Start all services
docker compose up -d

# View logs
docker compose logs -f
```

#### Verify Installation

```bash
# Check running containers
docker ps

# Expected output:
# emtools-frontend  - Port 80
# emtools-backend   - Port 8000
# emtools-mongodb   - Port 27017
```

### Method 2: Manual Installation

#### Backend Setup

```bash
cd backend

# Create virtual environment
python -m venv venv
source venv/bin/activate  # Linux/macOS
# or
.\venv\Scripts\activate   # Windows

# Install dependencies
pip install -r requirements.txt

# Start server
uvicorn app.main:app --reload --host 0.0.0.0 --port 8000
```

#### Frontend Setup

```bash
cd frontend

# Install dependencies
npm install

# Development server
npm run dev

# Production build
npm run build
```

#### MongoDB Setup

```bash
# Using Docker
docker run -d --name mongodb -p 27017:27017 mongo:7

# Or install locally
# See: https://docs.mongodb.com/manual/installation/
```

## Production Deployment

### Using Docker Compose (Production)

```bash
docker compose -f docker-compose.prod.yml up -d
```

### Environment Configuration

Create `.env` file:

```env
# Required
SECRET_KEY=generate-a-secure-64-char-key
MONGODB_URL=mongodb://mongodb:27017
MONGODB_DB_NAME=emtools

# Optional - SMTP
SMTP_HOST=smtp.gmail.com
SMTP_PORT=587
SMTP_USER=your-email@gmail.com
SMTP_PASSWORD=app-specific-password
SMTP_FROM_EMAIL=noreply@yourdomain.com

# Optional - CORS
BACKEND_CORS_ORIGINS=["https://yourdomain.com"]
```

### SSL/TLS Setup

For production, use a reverse proxy with SSL:

#### Nginx Configuration

```nginx
server {
    listen 443 ssl http2;
    server_name yourdomain.com;

    ssl_certificate /path/to/cert.pem;
    ssl_certificate_key /path/to/key.pem;

    location / {
        proxy_pass http://localhost:80;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
    }

    location /api {
        proxy_pass http://localhost:8000;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
    }
}
```

## Troubleshooting

### Common Issues

#### Port Already in Use

```bash
# Find process using port
lsof -i :8000  # Linux/macOS
netstat -ano | findstr :8000  # Windows

# Kill process or change port in docker-compose.yml
```

#### MongoDB Connection Failed

```bash
# Check MongoDB is running
docker logs emtools-mongodb

# Verify connection string
docker exec -it emtools-mongodb mongosh --eval "db.adminCommand('ping')"
```

#### Frontend Build Errors

```bash
# Clear cache and reinstall
rm -rf node_modules package-lock.json
npm install
npm run build
```

### Getting Help

- [GitHub Issues](https://github.com/medlabib/EMtools/issues)
- [Discussions](https://github.com/medlabib/EMtools/discussions)

## Updating

```bash
# Pull latest changes
git pull origin master

# Rebuild containers
docker compose up --build -d
```
