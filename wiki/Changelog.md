# Changelog

All notable changes to EMTOOLS will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

---

## [2.0.0-beta.1] - 2025-12-05

### ✨ Added
- **Dark/Light Theme Toggle** - Beautiful animated sun/moon toggle switch
- **Admin Dashboard Enhancements**
  - Verified users count statistic
  - System health indicators
  - Quick actions section
  - Visual progress bars
- **Admin Settings Improvements**
  - Tabbed interface (General, SMTP, System)
  - SMTP presets for popular providers (Gmail, Outlook, SendGrid)
  - Domain management with visual badges
  - Security checklist
- **Admin Logs Improvements**
  - Search functionality
  - CSV export
  - Detailed event modal
  - Relative timestamps
- **Admin Users Improvements**
  - User search with debounce
  - Export functionality
- **Setup Wizard Enhancements**
  - Password strength indicator
  - Real-time validation
  - Security recommendations

### 🐛 Fixed
- **Button Contrast** - Fixed grey-on-white hover states for WCAG AA compliance
- **Card Truncation** - Removed unwanted text truncation in calculator and antibiotic cards
- **Medical Report**
  - Removed redundant "Contexte: Traumatique" line
  - Fixed patient intro format to "âgé(e) de X ans"
  - Removed B section prefix letters (F:, T:, etc.)
  - Fixed ECG text duplication
- **Checkbox Visibility** - Added visible borders for better contrast
- **Svelte Build Error** - Fixed dynamic type attribute with bind:value

### 🔧 Changed
- Updated version to 2.0.0-beta.1
- Improved accessibility across all button variants
- Enhanced CSS for ghost and outline buttons

---

## [1.0.0-beta.3] - 2025-12-01

### ✨ Added
- Complete Admin Panel implementation
  - Admin dashboard with statistics
  - User management (CRUD)
  - System settings management
  - Activity logs viewer
- Setup wizard for first-run configuration
- Signup modes: Open, Institutional, Closed
- Email domain restrictions
- SMTP configuration for email sending
- Activity logging system

### 🐛 Fixed
- Various UI improvements
- Authentication flow issues

---

## [1.0.0-beta.2] - 2025-11-20

### ✨ Added
- Blood Gas & Ventilation analyzer
- Antibiotic Guide with renal dosing
- Vasoactive drugs calculator
- Metabolic corrections module

### 🔧 Changed
- Improved calculator result display
- Enhanced mobile responsiveness

---

## [1.0.0-beta.1] - 2025-11-01

### ✨ Added
- Initial release
- Medical Report generator (ABCDE structure)
- Secure Pastebin feature
- Medical Calculators (41+ scores)
- User authentication system
- Multi-language support (French/English)
- Responsive design with DaisyUI

---

## Upcoming Features

### [2.1.0] - Planned
- [ ] PDF export for medical reports
- [ ] Offline mode (PWA)
- [ ] Additional calculators
- [ ] Drug interaction checker
- [ ] Team/organization support

### [3.0.0] - Future
- [ ] Real-time collaboration
- [ ] Mobile apps (iOS/Android)
- [ ] EHR integrations
- [ ] AI-assisted documentation
