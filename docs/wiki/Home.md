# EMtools<p align="center"># Bienvenue sur le Wiki EMTOOLS# Welcome to EMTOOLS Wiki



Application Flutter pour la médecine d'urgence.  <img src="https://raw.githubusercontent.com/medlabib/EMtools/master/logo.svg" alt="EMTOOLS Logo" width="350">



## Modules</p>



- **Évaluation ABCDE** - Rapports médicaux structurés

- **Drogues Vasoactives** - Calcul des doses

- **Sédation** - Protocoles de sédation-analgésie# Bienvenue sur le Wiki EMTOOLS**EMTOOLS** est une suite complète d'outils numériques conçue pour les praticiens de médecine d'urgence. Construite avec Flutter, elle fournit des calculateurs cliniques, des outils de dosage de médicaments et des utilitaires de documentation.**EMTOOLS** is a comprehensive suite of digital tools designed for emergency medicine practitioners. Built with modern web technologies, it provides clinical calculators, drug dosing tools, and documentation utilities.

- **Gazométrie** - Interprétation des gaz du sang

- **Métabolique** - Correction des troubles électrolytiques

- **Antibiotiques** - Guide de prescription

- **Calculateurs** - Scores cliniques**EMTOOLS** est une suite complète d'outils numériques conçue pour les praticiens de médecine d'urgence. Construite avec Flutter, elle fournit des calculateurs cliniques, des outils de dosage de médicaments et des utilitaires de documentation.



## Liens



- [Installation](Installation.md)## 🚀 Liens Rapides## 🚀 Liens Rapides## 🚀 Quick Links

- [Fonctionnalités](Features.md)



- [Démarrage Rapide](Getting-Started)

- [Guide d'Installation](Installation)

- [Fonctionnalités](Features)- [Démarrage](Getting-Started)- [Getting Started](Getting-Started)

- [Contribuer](Contributing)

- [Changelog](Changelog)- [Guide d'Installation](Installation)- [Installation Guide](Installation)



## 📋 Aperçu- [Fonctionnalités](Features)- [Features Overview](Features)



**Version actuelle** : 0.1.0- [Contribuer](Contributing)- [API Documentation](API-Documentation)



### Architecture- [Changelog](Changelog)- [Contributing](Contributing)



```- [Changelog](Changelog)

┌─────────────────────────────────────────────┐

│              Application Flutter             │## 📋 Aperçu

│  ┌─────────────────────────────────────────┐│

│  │          Presentation Layer              ││## 📋 Overview

│  │   (Screens, Widgets, Providers)          ││

│  ├─────────────────────────────────────────┤│**Version actuelle**: 0.1.0

│  │           Domain Layer                   ││

│  │         (Entities, Logic)                ││EMTOOLS provides:

│  ├─────────────────────────────────────────┤│

│  │            Data Layer                    ││EMTOOLS fournit :

│  │   (DataSources, Models, Repositories)    ││

│  └─────────────────────────────────────────┘│| Feature | Description |

│                                              │

│  📱 Android | iOS | Web | Windows | macOS    │| Fonctionnalité | Description ||---------|-------------|

└─────────────────────────────────────────────┘

```|----------------|-------------|| 🏥 Medical Report | ABCDE-structured medical documentation generator |



## ✨ Fonctionnalités Principales| 🏥 Rapport Médical | Générateur de documentation médicale structurée ABCDE || 📋 Secure Pastebin | Temporary text/image sharing with password protection |



| Outil | Description || 🧮 Calculateurs Médicaux | 41+ scores cliniques (NIHSS, Wells, SOFA, Glasgow, etc.) || 🧮 Medical Calculators | 41+ clinical scores (NIHSS, Wells, SOFA, Glasgow, etc.) |

|-------|-------------|

| 🧮 **Calculateurs** | 41+ scores médicaux validés (HEART, NIHSS, qSOFA...) || 💉 Drogues Vasoactives | Calculs de débit PSE || 💉 Vasoactive Drugs | PSE flow rate calculations |

| 🫁 **Gaz du Sang** | Interprétation automatique des troubles acido-basiques |

| 💊 **Vasoactifs** | Calcul de débit des catécholamines || 💊 Sédation & Analgésie | Protocoles ISR || 💊 Sedation & Analgesia | RSI protocols |

| 😴 **Sédation** | Doses pour ISR et sédation continue |

| ⚗️ **Métabolique** | Corrections dyskaliémie, dysnatrémie, dyscalcémie || ⚗️ Troubles Métaboliques | Corrections dysnatrémie, dyskaliémie || ⚗️ Metabolic Disorders | Dysnatremia, dyskalemia corrections |

| 💉 **Antibiotiques** | Guide par pathologie avec posologies |

| 📋 **ABCDE** | Évaluation structurée des urgences vitales || 📊 Analyse Gaz du Sang | Interprétation complète des GDS avec ratio P/F || 📊 Blood Gas Analysis | Complete ABG interpretation with P/F ratio |



## 🔧 Stack Technique| 🦠 Guide Antibiotique | Ajustements rénaux et interactions médicamenteuses || 🦠 Antibiotic Guide | Renal dosing and drug interactions |



- **Frontend** : Flutter 3.x / Dart

- **State Management** : Riverpod

- **Architecture** : Clean Architecture## 🏗️ Architecture## 🏗️ Architecture

- **Tests** : 256 tests unitaires



## 📱 Plateformes

``````

L'application fonctionne sur :

- ✅ AndroidEMTOOLS/EMTOOLS/

- ✅ iOS

- ✅ Web├── frontend/          # Flutter (iOS/Android/Web)├── frontend/          # Svelte + Vite + DaisyUI

- ✅ Windows

- ✅ macOS│   ├── lib/├── backend/           # FastAPI + MongoDB (Beanie ODM)

- ✅ Linux

│   │   ├── core/      # Thème, widgets partagés└── docker-compose.yml # Container orchestration

## 🔗 Liens Utiles

│   │   ├── data/      # Sources de données```

- [Dépôt GitHub](https://github.com/medlabib/EMtools)

- [Signaler un Bug](https://github.com/medlabib/EMtools/issues)│   │   ├── domain/    # Entités, logique métier

- [Demander une Fonctionnalité](https://github.com/medlabib/EMtools/issues)

│   │   └── presentation/ # Écrans, widgets## 🔐 Security

## ⚠️ Avertissement

│   └── test/          # 256 tests unitaires

Cette application est un **outil d'aide à la décision** et ne remplace pas le jugement clinique. Toujours vérifier les calculs critiques et se référer aux protocoles locaux.

└── wiki/              # Documentation- JWT-based authentication

---

```- Password hashing with bcrypt

<p align="center">

  <em>Fait avec ❤️ pour les urgentistes francophones</em>- Role-based access control (RBAC)

</p>

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
