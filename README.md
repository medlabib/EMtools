# EMTOOLS

A full-stack application with FastAPI backend, Svelte frontend, MongoDB database, i18n support, authentication, and admin dashboard.

## 🚀 Features

- **Backend**: FastAPI with async MongoDB (Motor + Beanie ODM)
- **Frontend**: Svelte with TypeScript
- **Database**: MongoDB (NoSQL)
- **Authentication**: JWT-based auth with access and refresh tokens
- **i18n**: Multi-language support (English, French)
- **Admin Dashboard**: User management with statistics
- **Docker**: Full containerization with docker-compose

## 📁 Project Structure

```
EMTOOLS/
├── backend/
│   ├── app/
│   │   ├── api/
│   │   │   ├── v1/
│   │   │   │   ├── endpoints/
│   │   │   │   │   ├── auth.py
│   │   │   │   │   ├── users.py
│   │   │   │   │   └── admin.py
│   │   │   │   └── router.py
│   │   │   └── deps.py
│   │   ├── core/
│   │   │   ├── config.py
│   │   │   └── security.py
│   │   ├── db/
│   │   │   └── mongodb.py
│   │   ├── models/
│   │   │   └── user.py
│   │   ├── schemas/
│   │   │   ├── user.py
│   │   │   └── token.py
│   │   └── main.py
│   ├── Dockerfile
│   └── requirements.txt
├── frontend/
│   ├── src/
│   │   ├── lib/
│   │   │   ├── components/
│   │   │   ├── pages/
│   │   │   ├── stores/
│   │   │   ├── locales/
│   │   │   ├── api.ts
│   │   │   └── i18n.ts
│   │   ├── App.svelte
│   │   └── main.ts
│   ├── Dockerfile
│   └── package.json
├── docker-compose.yml
├── docker-compose.dev.yml
└── README.md
```

## 🛠️ Setup & Installation

### Prerequisites

- Docker & Docker Compose
- Node.js 18+ (for local frontend development)
- Python 3.11+ (for local backend development)

### Quick Start with Docker

```bash
# Clone the repository
git clone <repository-url>
cd EMTOOLS

# Start all services
docker-compose up -d

# Access the application
# Frontend: http://localhost
# Backend API: http://localhost:8000
# API Docs: http://localhost:8000/docs
```

### Development Setup

#### Backend

```bash
cd backend

# Create virtual environment
python -m venv venv

# Activate virtual environment
# Windows:
.\venv\Scripts\activate
# Linux/Mac:
source venv/bin/activate

# Install dependencies
pip install -r requirements.txt

# Copy environment file
cp .env.example .env

# Run the server
uvicorn app.main:app --reload
```

#### Frontend

```bash
cd frontend

# Install dependencies
npm install

# Run development server
npm run dev
```

### Development with Docker

```bash
# Start MongoDB and backend with hot reload
docker-compose -f docker-compose.dev.yml up -d

# Run frontend locally
cd frontend && npm run dev
```

## 🔐 Default Admin Account

- **Email**: admin@emtools.com
- **Password**: admin123

⚠️ **Important**: Change the default credentials in production!

## 🌐 API Endpoints

### Authentication
- `POST /api/v1/auth/register` - Register new user
- `POST /api/v1/auth/login` - Login (OAuth2 form)
- `POST /api/v1/auth/refresh` - Refresh access token

### Users
- `GET /api/v1/users/me` - Get current user
- `PUT /api/v1/users/me` - Update current user

### Admin
- `GET /api/v1/admin/users` - List all users
- `GET /api/v1/admin/users/{id}` - Get user by ID
- `PUT /api/v1/admin/users/{id}` - Update user
- `DELETE /api/v1/admin/users/{id}` - Delete user
- `GET /api/v1/admin/dashboard/stats` - Get dashboard statistics

## 🌍 Internationalization

Supported languages:
- English (en)
- French (fr)

Add new translations in `frontend/src/lib/locales/`.

## 📝 Environment Variables

### Backend (.env)
```env
MONGODB_URL=mongodb://localhost:27017
MONGODB_DB_NAME=emtools
SECRET_KEY=your-secret-key
FIRST_SUPERUSER_EMAIL=admin@emtools.com
FIRST_SUPERUSER_PASSWORD=admin123
```

## 🐳 Docker Commands

```bash
# Build and start
docker-compose up -d --build

# View logs
docker-compose logs -f

# Stop services
docker-compose down

# Stop and remove volumes
docker-compose down -v
```

## 📄 License

MIT License
