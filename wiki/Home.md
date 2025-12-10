# Bienvenue sur le Wiki EMTOOLS# Welcome to EMTOOLS Wiki



**EMTOOLS** est une suite complète d'outils numériques conçue pour les praticiens de médecine d'urgence. Construite avec Flutter, elle fournit des calculateurs cliniques, des outils de dosage de médicaments et des utilitaires de documentation.**EMTOOLS** is a comprehensive suite of digital tools designed for emergency medicine practitioners. Built with modern web technologies, it provides clinical calculators, drug dosing tools, and documentation utilities.



## 🚀 Liens Rapides## 🚀 Quick Links



- [Démarrage](Getting-Started)- [Getting Started](Getting-Started)

- [Guide d'Installation](Installation)- [Installation Guide](Installation)

- [Fonctionnalités](Features)- [Features Overview](Features)

- [Contribuer](Contributing)- [API Documentation](API-Documentation)

- [Changelog](Changelog)- [Contributing](Contributing)

- [Changelog](Changelog)

## 📋 Aperçu

## 📋 Overview

**Version actuelle**: 0.1.0

EMTOOLS provides:

EMTOOLS fournit :

| Feature | Description |

| Fonctionnalité | Description ||---------|-------------|

|----------------|-------------|| 🏥 Medical Report | ABCDE-structured medical documentation generator |

| 🏥 Rapport Médical | Générateur de documentation médicale structurée ABCDE || 📋 Secure Pastebin | Temporary text/image sharing with password protection |

| 🧮 Calculateurs Médicaux | 41+ scores cliniques (NIHSS, Wells, SOFA, Glasgow, etc.) || 🧮 Medical Calculators | 41+ clinical scores (NIHSS, Wells, SOFA, Glasgow, etc.) |

| 💉 Drogues Vasoactives | Calculs de débit PSE || 💉 Vasoactive Drugs | PSE flow rate calculations |

| 💊 Sédation & Analgésie | Protocoles ISR || 💊 Sedation & Analgesia | RSI protocols |

| ⚗️ Troubles Métaboliques | Corrections dysnatrémie, dyskaliémie || ⚗️ Metabolic Disorders | Dysnatremia, dyskalemia corrections |

| 📊 Analyse Gaz du Sang | Interprétation complète des GDS avec ratio P/F || 📊 Blood Gas Analysis | Complete ABG interpretation with P/F ratio |

| 🦠 Guide Antibiotique | Ajustements rénaux et interactions médicamenteuses || 🦠 Antibiotic Guide | Renal dosing and drug interactions |



## 🏗️ Architecture## 🏗️ Architecture



``````

EMTOOLS/EMTOOLS/

├── frontend/          # Flutter (iOS/Android/Web)├── frontend/          # Svelte + Vite + DaisyUI

│   ├── lib/├── backend/           # FastAPI + MongoDB (Beanie ODM)

│   │   ├── core/      # Thème, widgets partagés└── docker-compose.yml # Container orchestration

│   │   ├── data/      # Sources de données```

│   │   ├── domain/    # Entités, logique métier

│   │   └── presentation/ # Écrans, widgets## 🔐 Security

│   └── test/          # 256 tests unitaires

└── wiki/              # Documentation- JWT-based authentication

```- Password hashing with bcrypt

- Role-based access control (RBAC)

## 📱 Plateformes Supportées- Configurable signup modes (Open/Institutional/Closed)

- SMTP integration for email verification

- **Android**: Build APK disponible

- **iOS**: Build disponible (nécessite Xcode)## 📚 Documentation

- **Web**: Déploiement sur serveur statique

For detailed documentation, please visit the pages in the sidebar or check our [GitHub repository](https://github.com/medlabib/EMtools).

## 🌐 Localisation

---

L'application est entièrement en **français**, conçue pour les urgentistes francophones.

**Version:** 2.0.0-beta.1  

## 📚 Documentation**License:** MIT  

**Made with ❤️ for Emergency Medicine**

Pour une documentation détaillée, veuillez consulter les pages dans la barre latérale ou notre [dépôt GitHub](https://github.com/medlabib/EMtools).

---

*Développé avec ❤️ pour les professionnels de santé | Version 0.1.0*
