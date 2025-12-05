# Admin Guide

This guide covers administrative features of EMTOOLS.

## 🔐 Accessing Admin Panel

Navigate to `/admin` after logging in with an admin account.

**Requirements:**
- Active user account
- Admin privileges (`is_admin: true`)

## 📊 Dashboard

The admin dashboard provides an overview of your EMTOOLS instance.

### Statistics Cards
- **Total Users** - All registered accounts
- **Active Users** - Users who logged in recently
- **Admin Users** - Accounts with admin privileges
- **Verified Users** - Email-verified accounts

### Health Indicators
- SMTP configuration status
- Setup completion status
- System status

### Quick Actions
- Manage Users
- Settings
- View Logs
- Return to App

### Recent Activity
Live feed of system events.

---

## 👥 User Management

Access via `/admin/users`

### Features

#### Search Users
- Search by name or email
- Filter by role (Admin/User)
- Filter by status (Active/Inactive)

#### Create User
1. Click "Nouvel utilisateur"
2. Fill in details:
   - Email (required)
   - Password (required)
   - Full Name (optional)
   - Admin role (checkbox)
3. Click "Créer"

#### Edit User
1. Find user in list
2. Click menu (⋮) → "Modifier"
3. Update details
4. Save changes

#### Delete User
1. Find user in list
2. Click menu (⋮) → "Supprimer"
3. Confirm deletion

> ⚠️ **Warning:** User deletion is permanent.

#### Toggle Admin Status
1. Find user in list
2. Click menu (⋮) → "Retirer admin" / "Rendre admin"

---

## ⚙️ Settings

Access via `/admin/settings`

### General Tab

#### Signup Mode

| Mode | Description | Use Case |
|------|-------------|----------|
| **Open** | Anyone can register | Public instances |
| **Institutional** | Domain-restricted | Hospitals, universities |
| **Closed** | Admin-only creation | Private teams |

#### Allowed Domains (Institutional Mode)
Add email domains that can register:

```
hospital.org
university.edu
clinic.com
```

### SMTP Tab

Configure email sending for:
- Email verification
- Password reset
- Notifications

#### Quick Presets
Click a preset to auto-fill settings:
- Gmail
- Outlook
- Yahoo
- SendGrid
- Mailgun

#### Manual Configuration

| Field | Description | Example |
|-------|-------------|---------|
| SMTP Host | Mail server | smtp.gmail.com |
| Port | SMTP port | 587 |
| Username | Auth user | you@gmail.com |
| Password | Auth password | app-password |
| From Email | Sender address | noreply@yourdomain.com |
| Use TLS | Enable encryption | ✓ (recommended) |

#### Provider-Specific Notes

**Gmail:**
- Enable "Less secure apps" or use App Password
- If 2FA enabled, must use App Password

**Outlook/Office 365:**
- Use full email as username
- Port 587 with TLS

**SendGrid:**
- Username: `apikey`
- Password: Your API key

### System Tab

#### Security Checklist
- ✓ SMTP configured
- ✓ Signup restricted
- ✓ Initial setup complete

#### System Status
- Setup date
- Current signup mode
- SMTP server info

---

## 📋 Activity Logs

Access via `/admin/logs`

### Viewing Logs
- Chronological list of system events
- Paginated display (20 per page)
- Click row for full details

### Filtering

#### By Action Type
- Login/Logout
- Registration
- Settings changes
- User management
- SMTP updates

#### By Search
- User email
- IP address
- Action name

### Exporting
Click export button to download CSV.

### Log Entry Details

| Field | Description |
|-------|-------------|
| Date | Event timestamp |
| Action | Event type |
| User | Associated user |
| IP Address | Client IP |
| Details | Additional data |

---

## 🔧 First-Time Setup

### Setup Wizard

When no admin exists, navigate to any page to see the setup wizard.

#### Step 1: Welcome
- Introduction
- Security recommendations

#### Step 2: Admin Account
- Email (required)
- Password (required, min 8 chars)
- Full name (optional)
- Password strength indicator

#### Step 3: Configuration
- Signup mode selection
- Domain configuration (if institutional)
- Complete setup

### Post-Setup

After completing setup:
1. Verify SMTP configuration
2. Test email sending
3. Create additional admin users (recommended)
4. Configure backup strategy

---

## 🛡️ Security Best Practices

### Account Security
- [ ] Use strong admin passwords
- [ ] Enable SMTP for email verification
- [ ] Restrict signup mode appropriately
- [ ] Regularly review user list
- [ ] Monitor activity logs

### Instance Security
- [ ] Use HTTPS in production
- [ ] Change default SECRET_KEY
- [ ] Keep Docker images updated
- [ ] Regular database backups
- [ ] Monitor server resources

### SMTP Security
- [ ] Use TLS/STARTTLS
- [ ] Use app-specific passwords
- [ ] Don't commit credentials to git

---

## 🔄 Common Tasks

### Reset User Password
1. Go to Users
2. Find user
3. Click menu → "Modifier"
4. Set new password
5. Save

### Promote User to Admin
1. Go to Users
2. Find user
3. Click menu → "Rendre admin"

### Change Signup Mode
1. Go to Settings → General
2. Select new mode
3. Configure domains if needed
4. Save

### Test Email Configuration
1. Go to Settings → SMTP
2. Configure settings
3. Save
4. Click "Tester la connexion"

---

## 🆘 Troubleshooting

### "SMTP Test Failed"
- Verify credentials
- Check firewall settings
- Try different port (587, 465, 25)
- For Gmail, use App Password

### "Cannot Create User"
- Check signup mode
- Verify email domain (institutional mode)
- Check for duplicate email

### "Activity Log Empty"
- Logs are only for specific actions
- Try performing an action (login/logout)
- Check database connection

### Need Help?
- [GitHub Issues](https://github.com/medlabib/EMtools/issues)
- [Documentation](Home)
