# EMTOOLS# EMTOOLS 



> **Version 0.1.0** | *Outils Numériques pour la Médecine d'Urgence*> **Version 2.0.0-beta.4** | *Emergency Medicine Digital Tools*



**Application mobile et web pour les urgentistes francophones****Outils numériques pour la médecine d'urgence**



[![AI Generated](https://img.shields.io/badge/AI%20Generated-Claude%20Sonnet%204-blueviolet?logo=anthropic)](https://www.anthropic.com)[![AI Generated](https://img.shields.io/badge/AI%20Generated-Claude%20Sonnet%204-blueviolet?logo=anthropic)](https://www.anthropic.com)

[![Version](https://img.shields.io/badge/Version-0.1.0-orange)](https://github.com/medlabib/EMtools/releases)[![Version](https://img.shields.io/badge/Version-2.0.0--beta.4-orange)](https://github.com/medlabib/EMtools/releases)

[![Flutter](https://img.shields.io/badge/Flutter-3.x-02569B?logo=flutter)](https://flutter.dev)[![Docker Hub](https://img.shields.io/docker/v/medlabib/emtools-frontend?label=Docker%20Hub&logo=docker&color=2496ED)](https://hub.docker.com/r/medlabib/emtools-frontend)

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)[![Flutter](https://img.shields.io/badge/Flutter-3.x-02569B?logo=flutter)](https://flutter.dev)

[![FastAPI](https://img.shields.io/badge/FastAPI-0.104.1-009688?logo=fastapi)](https://fastapi.tiangolo.com)

Application Flutter autonome pour les urgentistes francophones : calculateurs médicaux, évaluation ABCDE, drogues vasoactives, corrections métaboliques, analyse des gaz du sang et plus.[![MongoDB](https://img.shields.io/badge/MongoDB-7.0-47A248?logo=mongodb)](https://www.mongodb.com)

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

## 🆕 Nouveautés v0.1.0

Application full-stack pour les urgentistes francophones : calculateurs médicaux, protocoles de sédation, drogues vasoactives, corrections métaboliques et plus.

- **Application autonome**: Fonctionne entièrement hors ligne, sans backend

- **Interface française**: Entièrement traduite en français##  What's New in Beta 4

- **Mode sombre accessible**: Thème sombre avec contraste amélioré

- **Favoris personnalisés**: Accès rapide aux outils les plus utilisés- **Flutter Frontend**: Native mobile experience (iOS/Android) + Web

- **41+ calculateurs médicaux**: Scores cliniques validés- **Tool Favorites**: Star your most-used tools for quick access

- **Évaluation ABCDE**: Rapport médical structuré- **QR Code Sharing**: Share pastes via QR code

- **Expiration Countdown**: Visual countdown for paste expiration

## 🚀 Démarrage rapide- **Reference Sources**: Scientific references in Blood Gas analysis

- **Correction Rates**: Display correction rate recommendations in Metabolic disorders

### Prérequis

##  Quick Start with Docker

- Flutter SDK 3.x

- Android Studio / Xcode (pour mobile)`ash

- Chrome (pour le web)# Pull and run with Docker Compose

git clone https://github.com/medlabib/EMtools.git

### Installationcd EMtools

docker-compose up -d

```bash

# Cloner le repository# Or pull images directly from Docker Hub

git clone https://github.com/medlabib/EMtools.gitdocker pull medlabib/emtools-frontend:2.0.0-beta.4

cd EMtools/frontenddocker pull medlabib/emtools-backend:2.0.0-beta.4

`

# Installer les dépendances

flutter pub get**Access the application:**

-  Frontend: http://localhost

# Lancer en mode développement-  Backend API: http://localhost:8000

flutter run -d chrome          # Web-  API Docs: http://localhost:8000/docs

flutter run -d android          # Android

flutter run -d ios              # iOS##  Features



# Build pour production###  Clinical Tools

flutter build web --release     # Web

flutter build apk --release     # Android| Tool | Description |

flutter build ios --release     # iOS|------|-------------|

```|  **Medical Report** | ABCDE structured assessment with severity detection |

|  **Secure Pastebin** | Temporary sharing (max 24h) with QR codes |

## 📱 Fonctionnalités|  **Medical Calculators** | 41+ clinical scores (NIHSS, Wells, SOFA, Glasgow, HEART, PERC...) |

|  **Vasoactive Drugs** | PSE flow rate calculator (Noradrenaline, Adrenaline, Dobutamine...) |

### Outils Cliniques|  **Sedation & Analgesia** | RSI protocols (Etomidate, Ketamine, Propofol, Rocuronium...) |

|  **Metabolic Disorders** | Dysnatremia (Adrogué-Madias), Dyskalemia, Dyscalcemia |

| Outil | Description ||  **Blood Gas & Ventilation** | ABG analysis, P/F ratio, ventilator mechanics |

|-------|-------------||  **Antibiotic Guide** | Dosing, renal adjustments, drug interactions |

| 📋 **Rapport Médical** | Évaluation structurée ABCDE avec détection de gravité |

| 🧮 **Calculateurs Médicaux** | 41+ scores cliniques (NIHSS, Wells, SOFA, Glasgow, HEART, PERC...) |###  Medical Calculators (41+ scores)

| 💊 **Drogues Vasoactives** | Calculateur de débit PSE (Noradrénaline, Adrénaline, Dobutamine...) |

| 💉 **Sédation & Analgésie** | Protocoles ISR (Étomidate, Kétamine, Propofol, Rocuronium...) |- **Trauma**: GCS, RTS, Shock Index, FOUR Score

| ⚗️ **Troubles Métaboliques** | Dysnatrémie (Adrogué-Madias), Dyskaliémie, Dyscalcémie |- **Cardiology**: HEART, CHADS-VASc, HAS-BLED, QTc

| 🫁 **Gaz du Sang** | Analyse des GDS, ratio P/F, mécanique ventilatoire |- **Neurology**: NIHSS, ABCD², ICH Score, Hunt-Hess

| 💊 **Guide Antibiotique** | Posologies, ajustements rénaux, interactions |- **PE/DVT**: Wells PE, Wells DVT, PERC, Geneva, sPESI

- **Sepsis**: qSOFA, NEWS2, CURB-65, LRINEC, Centor

### Calculateurs Médicaux (41+ scores)- **Pediatrics**: PECARN, Westley (Croup), PAS

- **Toxicology**: CIWA-Ar, COWS

- **Trauma**: GCS, RTS, Indice de Choc, FOUR Score- **Gastro**: Alvarado, BISAP, Glasgow-Blatchford, MELD

- **Cardiologie**: HEART, CHADS-VASc, HAS-BLED, QTc- **MSK**: Ottawa (ankle, knee), NEXUS, Canadian C-Spine

- **Neurologie**: NIHSS, ABCD², ICH Score, Hunt-Hess- **Lab**: ClCr (Cockcroft-Gault), Corrected Calcium, A-a Gradient

- **EP/TVP**: Wells EP, Wells TVP, PERC, Genève, sPESI

- **Sepsis**: qSOFA, NEWS2, CURB-65, LRINEC, Centor##  Project Structure

- **Pédiatrie**: PECARN, Westley (Croup), PAS

- **Toxicologie**: CIWA-Ar, COWS`

- **Gastro**: Alvarado, BISAP, Glasgow-Blatchford, MELDEMTOOLS/

- **MSK**: Ottawa (cheville, genou), NEXUS, Canadian C-Spine backend/

- **Biologie**: ClCr (Cockcroft-Gault), Calcium Corrigé, Gradient A-a    app/

       api/v1/endpoints/    # Auth, Users, Admin, Paste

## 📁 Structure du Projet       core/                # Config, Security

       db/                  # MongoDB connection

```       models/              # Beanie ODM models

EMTOOLS/       schemas/             # Pydantic schemas

├── frontend/                    # Application Flutter    tests/                   # Backend tests

│   ├── lib/    Dockerfile

│   │   ├── core/                # Thème, Config, Widgets partagés    requirements.txt

│   │   ├── data/                # Sources de données frontend/                    # Flutter App

│   │   ├── domain/              # Entités, Logique métier    lib/

│   │   └── presentation/        # Écrans, Widgets       core/                # Theme, Config, Localization

│   ├── test/                    # Tests unitaires (256 tests)       data/                # Data sources, API

│   ├── web/                     # Fichiers spécifiques web       domain/              # Entities, Business logic

│   ├── android/                 # Build Android       presentation/        # Screens, Widgets

│   ├── ios/                     # Build iOS    web/                     # Web-specific files

│   └── pubspec.yaml    android/                 # Android build

├── wiki/                        # Documentation    ios/                     # iOS build (coming soon)

└── README.md    Dockerfile               # Web production build

```    pubspec.yaml

 docker-compose.yml           # Production

## 🧪 Tests docker-compose.dev.yml       # Development

 README.md

```bash`

cd frontend

##  Installation

# Lancer tous les tests

flutter test### Prerequisites



# Lancer avec couverture- Docker & Docker Compose

flutter test --coverage- Flutter SDK 3.x (for development)

- Python 3.11+ (for backend development)

# Lancer un fichier spécifique

flutter test test/unit/blood_gas_calculator_test.dart### Quick Start with Docker

```

`ash

**État actuel**: 256 tests passent ✅# Clone the repository

git clone <repository-url>

## 📚 Références Médicalescd EMTOOLS



Les protocoles et calculs sont basés sur :# Start all services

- **Dysnatrémie**: Adrogué HJ, Madias NE. NEJM 2000docker-compose up -d

- **Dyskaliémie**: Guidelines AHA 2020, KDIGO

- **Dyscalcémie**: Shane E. J Clin Endocrinol Metab 2017# Access the application

- **Scores Cliniques**: MDCalc, UpToDate, publications originales# Frontend: http://localhost

# Backend API: http://localhost:8000

⚠️ **Avertissement**: Outil d'aide à la décision uniquement. Ne remplace pas le jugement clinique.# API Docs: http://localhost:8000/docs

`

## 🤖 Généré par IA

### Local Development

Ce projet a été entièrement généré par **Claude Sonnet 4** (Anthropic) via GitHub Copilot.

#### Backend

- **Version**: 0.1.0

- **Date**: Janvier 2025`ash

- **Modèle**: Claude Sonnet 4cd backend

- **IDE**: Visual Studio Code avec GitHub Copilot

# Create virtual environment

L'IA a généré :python -m venv venv

- Architecture frontend (Flutter - iOS/Android/Web)

- 41+ calculateurs médicaux# Activate (Windows)

- Protocoles de sédation et drogues vasoactives.\venv\Scripts\activate

- Corrections métaboliques (Adrogué-Madias)# Activate (Linux/Mac)

- Analyse des gaz du sangsource venv/bin/activate

- Documentation complète

# Install dependencies

## 📄 Licencepip install -r requirements.txt



MIT License - Voir [LICENSE](LICENSE) pour les détails.# Run server

uvicorn app.main:app --reload --port 8000

---`



Développé avec ❤️ pour les professionnels de santé | Propulsé par 🤖 Claude Sonnet 4#### Frontend (Flutter)


`ash
cd frontend

# Get dependencies
flutter pub get

# Run in development (Chrome)
flutter run -d chrome

# Build for web
flutter build web --release
`

##  Default Admin Account

- **Email**: admin@emtools.com
- **Password**: admin123

 **Important**: Change credentials in production!

##  API Endpoints

### Authentication
| Method | Endpoint | Description |
|--------|----------|-------------|
| POST | /api/v1/auth/register | Register |
| POST | /api/v1/auth/login | Login (OAuth2) |
| POST | /api/v1/auth/refresh | Refresh token |

### Users
| Method | Endpoint | Description |
|--------|----------|-------------|
| GET | /api/v1/users/me | User profile |
| PUT | /api/v1/users/me | Update profile |

### Admin
| Method | Endpoint | Description |
|--------|----------|-------------|
| GET | /api/v1/admin/users | List users |
| GET | /api/v1/admin/users/{id} | User details |
| PUT | /api/v1/admin/users/{id} | Update user |
| DELETE | /api/v1/admin/users/{id} | Delete user |
| GET | /api/v1/admin/dashboard/stats | Statistics |

### Pastebin
| Method | Endpoint | Description |
|--------|----------|-------------|
| POST | /api/v1/paste | Create paste |
| GET | /api/v1/paste/{id} | Get paste |

##  Environment Variables

### Backend (.env)
`env
MONGODB_URL=mongodb://localhost:27017
MONGODB_DB_NAME=emtools
SECRET_KEY=your-secret-key-change-in-production
FIRST_SUPERUSER_EMAIL=admin@emtools.com
FIRST_SUPERUSER_PASSWORD=admin123
`

##  Docker Commands

`ash
# Build and start
docker-compose up -d --build

# View logs
docker-compose logs -f

# Stop services
docker-compose down

# Stop and remove volumes
docker-compose down -v
`

##  Medical References

Protocols and calculations are based on:
- **Dysnatremia**: Adrogué HJ, Madias NE. NEJM 2000
- **Dyskalemia**: AHA Guidelines 2020, KDIGO
- **Dyscalcemia**: Shane E. J Clin Endocrinol Metab 2017
- **Clinical Scores**: MDCalc, UpToDate, original publications

 **Disclaimer**: Decision support tool only. Does not replace clinical judgment.

##  Generated by AI

This project was entirely generated by **Claude Sonnet 4** (Anthropic) via GitHub Copilot.

- **Version**: 2.0.0-beta.4
- **Date**: December 2025
- **Model**: Claude Sonnet 4
- **IDE**: Visual Studio Code with GitHub Copilot

The AI generated:
- Backend architecture (FastAPI + MongoDB)
- Frontend interface (Flutter - iOS/Android/Web)
- 41+ medical calculators
- Sedation protocols and vasoactive drugs
- Metabolic corrections (Adrogué-Madias)
- Docker production-ready configuration
- Complete documentation

##  License

MIT License - See [LICENSE](LICENSE) for details.

---

Developed with  for healthcare professionals | Powered by  Claude Sonnet 4
