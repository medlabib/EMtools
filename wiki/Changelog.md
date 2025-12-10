# Changelog# Changelog



Toutes les modifications notables de EMTOOLS seront documentées dans ce fichier.All notable changes to EMTOOLS will be documented in this file.



Le format est basé sur [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),

et ce projet adhère au [Semantic Versioning](https://semver.org/spec/v2.0.0.html).and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).



**Convention de versionnement**: Chaque mise à jour incrémente la version de 0.0.1---



---## [2.0.0-beta.2] - 2025-12-05



## [0.1.0] - 2025-01-XX### 🔧 Fixed

- **DaisyUI 5.x Theme Compatibility** - Proper CSS variables for custom themes using oklch colors

### 🆕 Première Version Publique- **Button Contrast Issues** - WCAG AA compliant hover states for all buttons

- **Ghost Button Visibility** - Enhanced hover states with proper backgrounds

Cette version marque le lancement de EMTOOLS en tant qu'application Flutter autonome.- **Theme Toggle Animation** - Smooth transitions between dark and light modes



### ✨ Ajouté### ✨ Changed

- **Application autonome**: Fonctionne entièrement hors ligne, sans backend- Migrated to CSS-based theme definitions for DaisyUI 5.x compatibility

- **Interface française**: Application entièrement traduite en français- Improved button styling across all variants (ghost, outline, primary, secondary, etc.)

- **Mode sombre accessible**: Thème sombre avec contraste amélioré pour l'accessibilité- Theme now respects system preference on first load

- **Tableau de bord des favoris**: Accès rapide aux outils les plus utilisés

- **41+ calculateurs médicaux**: ---

  - Trauma: GCS, RTS, Indice de Choc, FOUR Score

  - Cardiologie: HEART, CHADS-VASc, HAS-BLED, QTc## [2.0.0-beta.1] - 2025-12-05

  - Neurologie: NIHSS, ABCD², ICH Score, Hunt-Hess

  - EP/TVP: Wells EP, Wells TVP, PERC, Genève, sPESI### ✨ Added

  - Sepsis: qSOFA, NEWS2, CURB-65, LRINEC, Centor- **Dark/Light Theme Toggle** - Beautiful animated sun/moon toggle switch

  - Pédiatrie: PECARN, Westley, PAS- **Admin Dashboard Enhancements**

  - Et plus...  - Verified users count statistic

- **Évaluation ABCDE**: Rapport médical structuré avec détection de gravité  - System health indicators

- **Drogues vasoactives**: Calculateur de débit PSE  - Quick actions section

- **Sédation et analgésie**: Protocoles ISR  - Visual progress bars

- **Troubles métaboliques**: Corrections de dysnatrémie, dyskaliémie, dyscalcémie- **Admin Settings Improvements**

- **Analyse des gaz du sang**: Interprétation complète avec ratio P/F  - Tabbed interface (General, SMTP, System)

- **Guide antibiotique**: Posologies avec ajustements rénaux  - SMTP presets for popular providers (Gmail, Outlook, SendGrid)

  - Domain management with visual badges

### 🔧 Changements Techniques  - Security checklist

- Migration vers Flutter pur (suppression du backend FastAPI/MongoDB)- **Admin Logs Improvements**

- 256 tests unitaires passent  - Search functionality

- Support multi-plateformes: Android, iOS, Web  - CSV export

  - Detailed event modal

### 🗑️ Supprimé  - Relative timestamps

- Backend FastAPI et MongoDB (l'application est maintenant autonome)- **Admin Users Improvements**

- Système d'authentification (plus nécessaire sans backend)  - User search with debounce

- Pastebin sécurisé (nécessitait un backend)  - Export functionality

- Panneau d'administration (nécessitait un backend)- **Setup Wizard Enhancements**

  - Password strength indicator

---  - Real-time validation

  - Security recommendations

## Versions Antérieures (Bêta avec Backend)

### 🐛 Fixed

Les versions 1.x et 2.0.0-beta.x utilisaient une architecture full-stack avec FastAPI et MongoDB.- **Button Contrast** - Fixed grey-on-white hover states for WCAG AA compliance

Ces versions ne sont plus maintenues. L'application a été simplifiée pour fonctionner de manière autonome.- **Card Truncation** - Removed unwanted text truncation in calculator and antibiotic cards

- **Medical Report**

---  - Removed redundant "Contexte: Traumatique" line

  - Fixed patient intro format to "âgé(e) de X ans"

*Pour toute question, consultez le [README](../README.md) ou ouvrez une issue sur GitHub.*  - Removed B section prefix letters (F:, T:, etc.)

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
