# Welcome to EMTOOLS Wiki

**EMTOOLS** is a comprehensive suite of digital tools designed for emergency medicine practitioners. Built with modern web technologies, it provides clinical calculators, drug dosing tools, and documentation utilities.

## 🚀 Quick Links

- [Getting Started](Getting-Started)
- [Installation Guide](Installation)
- [Features Overview](Features)
- [API Documentation](API-Documentation)
- [Contributing](Contributing)
- [Changelog](Changelog)

## 📋 Overview

EMTOOLS provides:

| Feature | Description |
|---------|-------------|
| 🏥 Medical Report | ABCDE-structured medical documentation generator |
| 📋 Secure Pastebin | Temporary text/image sharing with password protection |
| 🧮 Medical Calculators | 41+ clinical scores (NIHSS, Wells, SOFA, Glasgow, etc.) |
| 💉 Vasoactive Drugs | PSE flow rate calculations |
| 💊 Sedation & Analgesia | RSI protocols |
| ⚗️ Metabolic Disorders | Dysnatremia, dyskalemia corrections |
| 📊 Blood Gas Analysis | Complete ABG interpretation with P/F ratio |
| 🦠 Antibiotic Guide | Renal dosing and drug interactions |

## 🏗️ Architecture

```
EMTOOLS/
├── frontend/          # Svelte + Vite + DaisyUI
├── backend/           # FastAPI + MongoDB (Beanie ODM)
└── docker-compose.yml # Container orchestration
```

## 🔐 Security

- JWT-based authentication
- Password hashing with bcrypt
- Role-based access control (RBAC)
- Configurable signup modes (Open/Institutional/Closed)
- SMTP integration for email verification

## 📚 Documentation

For detailed documentation, please visit the pages in the sidebar or check our [GitHub repository](https://github.com/medlabib/EMtools).

---

**Version:** 2.0.0-beta.1  
**License:** MIT  
**Made with ❤️ for Emergency Medicine**
