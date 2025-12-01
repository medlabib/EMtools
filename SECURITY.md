# Security Policy

## 🔒 Security Measures

### Authentication & Authorization
- **Password Hashing**: bcrypt with automatic salt generation
- **JWT Tokens**: Short-lived access tokens (30 min) + refresh tokens (7 days)
- **Role-Based Access Control**: User, Admin, Superuser roles
- **Session Management**: Token-based authentication

### Input Validation
- **Email Validation**: Pydantic EmailStr with format validation
- **Password Requirements**:
  - Minimum 8 characters
  - At least one letter
  - At least one digit
- **Paste Content**:
  - Maximum 500KB size
  - Basic XSS prevention (script tag filtering)
  - Maximum 24-hour expiry
  - Image size limit (2MB per image, max 5 images)

### API Security
- **CORS**: Configurable origins (restrict in production)
- **Rate Limiting**: Recommended to implement with `slowapi`
- **Input Sanitization**: Pydantic validation on all endpoints

## ⚠️ Production Checklist

Before deploying to production, ensure:

### Environment Variables
- [ ] `SECRET_KEY` - Generate with: `python -c "import secrets; print(secrets.token_urlsafe(64))"`
- [ ] `FIRST_SUPERUSER_PASSWORD` - Use strong password (12+ characters)
- [ ] `MONGODB_URL` - Use authenticated MongoDB connection
- [ ] `BACKEND_CORS_ORIGINS` - Set to your actual domain(s)
- [ ] `ENVIRONMENT=production`
- [ ] `DEBUG=false`

### Infrastructure
- [ ] Use HTTPS only (SSL/TLS certificates)
- [ ] Enable MongoDB authentication
- [ ] Use MongoDB Atlas or secured MongoDB instance
- [ ] Set up reverse proxy (nginx) with security headers
- [ ] Enable firewall rules
- [ ] Set up log monitoring

### Application
- [ ] Remove default admin credentials
- [ ] Enable rate limiting on authentication endpoints
- [ ] Set up error monitoring (Sentry, etc.)
- [ ] Regular dependency updates
- [ ] Database backups

## 🐛 Reporting Vulnerabilities

If you discover a security vulnerability, please:

1. **Do NOT** open a public issue
2. Email security concerns to: [your-security-email]
3. Include:
   - Description of the vulnerability
   - Steps to reproduce
   - Potential impact

We will respond within 48 hours and work on a fix.

## 🔐 Security Headers (Nginx)

Add these headers to your nginx configuration:

```nginx
# Security headers
add_header X-Frame-Options "SAMEORIGIN" always;
add_header X-Content-Type-Options "nosniff" always;
add_header X-XSS-Protection "1; mode=block" always;
add_header Referrer-Policy "strict-origin-when-cross-origin" always;
add_header Content-Security-Policy "default-src 'self'; script-src 'self' 'unsafe-inline'; style-src 'self' 'unsafe-inline';" always;
add_header Strict-Transport-Security "max-age=31536000; includeSubDomains" always;
```

## 📝 Audit Log

| Date | Version | Security Update |
|------|---------|-----------------|
| 2025-12-01 | 0.1.0 | Initial security implementation |
| 2025-12-01 | 0.1.0 | Added password validation |
| 2025-12-01 | 0.1.0 | Added input validation for pastes |
| 2025-12-01 | 0.1.0 | Migrated from passlib to direct bcrypt |

## 🔄 Dependencies Security

Run these commands regularly:

```bash
# Backend
pip install safety
safety check

# Frontend
npm audit
npm audit fix
```
