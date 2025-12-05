# API Documentation

EMTOOLS provides a RESTful API built with FastAPI.

## Base URL

```
Production: https://yourdomain.com/api/v1
Development: http://localhost:8000/api/v1
```

## Interactive Documentation

- **Swagger UI**: http://localhost:8000/docs
- **ReDoc**: http://localhost:8000/redoc

## Authentication

EMTOOLS uses JWT (JSON Web Tokens) for authentication.

### Obtain Token

```http
POST /api/v1/auth/login
Content-Type: application/x-www-form-urlencoded

username=email@example.com&password=yourpassword
```

**Response:**
```json
{
  "access_token": "eyJhbGciOiJIUzI1NiIs...",
  "token_type": "bearer"
}
```

### Using the Token

Include the token in the Authorization header:

```http
Authorization: Bearer eyJhbGciOiJIUzI1NiIs...
```

---

## Endpoints

### Authentication

#### Register User
```http
POST /api/v1/auth/register
```

**Request Body:**
```json
{
  "email": "user@example.com",
  "password": "securepassword",
  "full_name": "John Doe"
}
```

**Response:** `201 Created`
```json
{
  "id": "507f1f77bcf86cd799439011",
  "email": "user@example.com",
  "full_name": "John Doe",
  "is_active": true,
  "is_verified": false,
  "is_admin": false,
  "created_at": "2025-01-01T00:00:00Z"
}
```

#### Login
```http
POST /api/v1/auth/login
```

#### Get Current User
```http
GET /api/v1/auth/me
Authorization: Bearer <token>
```

---

### Pastebin

#### Create Paste
```http
POST /api/v1/paste
Authorization: Bearer <token>
```

**Request Body:**
```json
{
  "content": "Your text content here",
  "password": "optional-password",
  "expires_in": 24
}
```

**Response:** `201 Created`
```json
{
  "id": "abc123xyz",
  "short_id": "abc123",
  "content": "Your text content here",
  "has_password": true,
  "created_at": "2025-01-01T00:00:00Z",
  "expires_at": "2025-01-02T00:00:00Z"
}
```

#### Get Paste
```http
GET /api/v1/paste/{short_id}
```

**With Password:**
```http
GET /api/v1/paste/{short_id}?password=your-password
```

#### Delete Paste
```http
DELETE /api/v1/paste/{short_id}
Authorization: Bearer <token>
```

---

### Admin Endpoints

> **Note:** Admin endpoints require admin privileges.

#### Get Dashboard Stats
```http
GET /api/v1/admin/dashboard/stats/v2
Authorization: Bearer <admin-token>
```

**Response:**
```json
{
  "total_users": 150,
  "active_users": 120,
  "admin_users": 3,
  "verified_users": 100,
  "recent_activities": [...],
  "signup_mode": "institutional",
  "smtp_configured": true
}
```

#### Get Setup Status
```http
GET /api/v1/admin/setup/status
```

**Response:**
```json
{
  "is_setup_complete": true,
  "has_admin": true,
  "message": "Application is configured"
}
```

#### Initial Setup
```http
POST /api/v1/admin/setup
```

**Request Body:**
```json
{
  "admin_email": "admin@example.com",
  "admin_password": "securepassword",
  "admin_full_name": "Admin User",
  "signup_mode": "institutional",
  "allowed_email_domains": ["hospital.org", "clinic.com"]
}
```

#### Get Settings
```http
GET /api/v1/admin/settings
Authorization: Bearer <admin-token>
```

#### Update Settings
```http
PUT /api/v1/admin/settings
Authorization: Bearer <admin-token>
```

**Request Body:**
```json
{
  "signup_mode": "closed",
  "allowed_email_domains": ["hospital.org"]
}
```

#### Update SMTP Settings
```http
PUT /api/v1/admin/settings/smtp
Authorization: Bearer <admin-token>
```

**Request Body:**
```json
{
  "smtp_host": "smtp.gmail.com",
  "smtp_port": 587,
  "smtp_user": "email@gmail.com",
  "smtp_password": "app-password",
  "smtp_from_email": "noreply@example.com",
  "smtp_use_tls": true
}
```

#### Test SMTP
```http
POST /api/v1/admin/settings/smtp/test
Authorization: Bearer <admin-token>
```

---

### Users Management

#### List Users
```http
GET /api/v1/admin/users?skip=0&limit=20&search=john
Authorization: Bearer <admin-token>
```

**Response:**
```json
{
  "users": [...],
  "total": 150
}
```

#### Create User
```http
POST /api/v1/admin/users
Authorization: Bearer <admin-token>
```

**Request Body:**
```json
{
  "email": "newuser@example.com",
  "password": "temporarypassword",
  "full_name": "New User",
  "is_admin": false
}
```

#### Update User
```http
PUT /api/v1/admin/users/{user_id}
Authorization: Bearer <admin-token>
```

#### Delete User
```http
DELETE /api/v1/admin/users/{user_id}
Authorization: Bearer <admin-token>
```

---

### Activity Logs

#### Get Logs
```http
GET /api/v1/admin/logs?limit=20&skip=0&action=login
Authorization: Bearer <admin-token>
```

**Response:**
```json
{
  "logs": [
    {
      "id": "...",
      "action": "login",
      "user_email": "user@example.com",
      "ip_address": "192.168.1.1",
      "details": {},
      "created_at": "2025-01-01T00:00:00Z"
    }
  ],
  "total": 500
}
```

---

## Error Responses

All errors follow this format:

```json
{
  "detail": "Error message here"
}
```

### Common Status Codes

| Code | Description |
|------|-------------|
| 200 | Success |
| 201 | Created |
| 400 | Bad Request |
| 401 | Unauthorized |
| 403 | Forbidden |
| 404 | Not Found |
| 422 | Validation Error |
| 500 | Internal Server Error |

---

## Rate Limiting

API requests are rate-limited to prevent abuse:

- **Authenticated**: 100 requests/minute
- **Unauthenticated**: 20 requests/minute

Rate limit headers:
```http
X-RateLimit-Limit: 100
X-RateLimit-Remaining: 95
X-RateLimit-Reset: 1609459200
```

---

## WebSocket (Future)

Real-time features planned for future releases.
