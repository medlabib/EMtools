# Getting Started with EMTOOLS

This guide will help you get EMTOOLS up and running quickly.

## Prerequisites

Before you begin, ensure you have:

- **Docker** and **Docker Compose** installed
- **Git** for cloning the repository
- A modern web browser (Chrome, Firefox, Safari, Edge)

## Quick Start

### 1. Clone the Repository

```bash
git clone https://github.com/medlabib/EMtools.git
cd EMtools
```

### 2. Start with Docker

```bash
docker compose up -d
```

This will start:
- **Frontend** at http://localhost:80
- **Backend API** at http://localhost:8000
- **MongoDB** database

### 3. Initial Setup

1. Navigate to http://localhost in your browser
2. You'll be redirected to the setup wizard
3. Create your admin account
4. Configure signup mode and SMTP (optional)

## First-Time Configuration

### Setup Wizard Steps

1. **Welcome** - Introduction and requirements
2. **Admin Account** - Create the first administrator
3. **Settings** - Configure signup mode and domains

### Signup Modes

| Mode | Description |
|------|-------------|
| **Open** | Anyone can register |
| **Institutional** | Only emails from allowed domains |
| **Closed** | Admin creates all accounts |

## Accessing the Application

After setup:

- **Home Page**: http://localhost/
- **Dashboard**: http://localhost/dashboard
- **Admin Panel**: http://localhost/admin (admin only)

## Environment Variables

Create a `.env` file for custom configuration:

```env
# MongoDB
MONGODB_URL=mongodb://mongodb:27017
MONGODB_DB_NAME=emtools

# Security
SECRET_KEY=your-secret-key-change-in-production

# SMTP (optional)
SMTP_HOST=smtp.gmail.com
SMTP_PORT=587
SMTP_USER=your-email@gmail.com
SMTP_PASSWORD=your-app-password
```

## Development Mode

For development with hot-reload:

```bash
docker compose -f docker-compose.dev.yml up
```

Frontend will be available at http://localhost:5173 with HMR enabled.

## Next Steps

- [Explore Features](Features)
- [API Documentation](API-Documentation)
- [Customize Settings](Admin-Guide)
