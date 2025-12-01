# EMTOOLS 🏥

> **Version Alpha 0.1.0**

**Outils numériques pour la médecine d'urgence**

[![AI Generated](https://img.shields.io/badge/AI%20Generated-Claude%20Sonnet%204-blueviolet?logo=anthropic)](https://www.anthropic.com)
[![Version](https://img.shields.io/badge/Version-Alpha%200.1.0-orange)](https://github.com)
[![Tests](https://img.shields.io/badge/Tests-156%20passed-brightgreen?logo=pytest)](https://pytest.org)
[![Backend Coverage](https://img.shields.io/badge/Backend%20Coverage-75%25-green)](https://pytest.org)
[![Frontend Coverage](https://img.shields.io/badge/Frontend%20Coverage-35%25-yellow)](https://vitest.dev)
[![Security](https://img.shields.io/badge/Security-Hardened-blue?logo=shield)](SECURITY.md)
[![FastAPI](https://img.shields.io/badge/FastAPI-0.104.1-009688?logo=fastapi)](https://fastapi.tiangolo.com)
[![Svelte](https://img.shields.io/badge/Svelte-4.2.8-FF3E00?logo=svelte)](https://svelte.dev)
[![MongoDB](https://img.shields.io/badge/MongoDB-7.0-47A248?logo=mongodb)](https://www.mongodb.com)
[![TypeScript](https://img.shields.io/badge/TypeScript-5.3-3178C6?logo=typescript)](https://www.typescriptlang.org)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

Application full-stack pour les urgentistes francophones : calculateurs médicaux, protocoles de sédation, drogues vasoactives, corrections métaboliques et plus.

## 🚀 Fonctionnalités

### 🛠️ Outils Cliniques

| Outil | Description |
|-------|-------------|
| 🏥 **Dossier Médical** | Génération rapide avec évaluation ABCDE structurée |
| 📋 **Pastebin Sécurisé** | Partage temporaire (max 24h) avec mot de passe |
| 🧮 **Calculateurs Médicaux** | 33 scores cliniques (NIHSS, Wells, SOFA, Glasgow, HEART, PERC...) |
| 💉 **Drogues Vasoactives** | Calcul de débit PSE (Noradrénaline, Adrénaline, Dobutamine, Dopamine, Isoprénaline, Milrinone) |
| 💊 **Sédation & Analgésie** | Protocoles ISR (Étomidate, Kétamine, Propofol, Succinylcholine, Rocuronium, Fentanyl, Midazolam, Morphine) |
| ⚗️ **Troubles Métaboliques** | Dysnatrémie (Adrogué-Madias), Dyskaliémie, Dyscalcémie |

### 📊 Calculateurs Médicaux (33 scores)

- **Cardiologie**: HEART, TIMI, CHA₂DS₂-VASc, HAS-BLED
- **Neurologie**: NIHSS, Glasgow, Hunt-Hess, Fisher
- **Pneumologie/EP-TVP**: Wells EP, Wells TVP, PERC, Geneva, PESI
- **Sepsis**: qSOFA, SOFA, NEWS2
- **Trauma**: RTS, ISS, TRISS
- **Pédiatrie**: PRISM III, PIM2, APGAR
- **Toxicologie**: Nomogramme Paracétamol, Rumack-Matthew
- **Gastro**: Rockall, Glasgow-Blatchford, MELD, Child-Pugh
- **MSK**: Ottawa (genou, cheville), Canadian C-Spine

### 🔧 Fonctionnalités Techniques

- **Backend**: FastAPI avec async MongoDB (Motor + Beanie ODM)
- **Frontend**: Svelte avec TypeScript
- **Base de données**: MongoDB (NoSQL)
- **Authentification**: JWT avec tokens access/refresh
- **i18n**: Support multilingue (Français, Anglais)
- **Admin**: Tableau de bord avec gestion utilisateurs
- **Docker**: Conteneurisation complète

## 📁 Structure du Projet

```
EMTOOLS/
├── backend/
│   ├── app/
│   │   ├── api/v1/endpoints/    # Auth, Users, Admin, Paste
│   │   ├── core/                # Config, Security
│   │   ├── db/                  # MongoDB connection
│   │   ├── models/              # Beanie ODM models
│   │   └── schemas/             # Pydantic schemas
│   ├── tests/                   # Backend tests
│   ├── Dockerfile
│   └── requirements.txt
├── frontend/
│   ├── src/
│   │   ├── lib/
│   │   │   ├── components/      # Layout, ProtectedRoute
│   │   │   ├── pages/           # Home, Login, Tools...
│   │   │   │   └── tools/       # 6 clinical tools
│   │   │   │       ├── calculators/   # 33 scoring systems
│   │   │   │       ├── vasoactive/    # Drug calculations
│   │   │   │       ├── sedation/      # RSI protocols
│   │   │   │       └── metabolic/     # Electrolyte corrections
│   │   │   ├── stores/          # Auth store
│   │   │   └── locales/         # i18n (en, fr)
│   │   └── App.svelte
│   ├── tests/                   # Frontend tests
│   ├── Dockerfile
│   └── package.json
├── docker-compose.yml
├── docker-compose.dev.yml
└── README.md
```

## 🛠️ Installation

### Prérequis

- Docker & Docker Compose
- Node.js 18+ (développement frontend)
- Python 3.11+ (développement backend)

### Démarrage Rapide avec Docker

```bash
# Cloner le dépôt
git clone <repository-url>
cd EMTOOLS

# Démarrer tous les services
docker-compose up -d

# Accéder à l'application
# Frontend: http://localhost
# Backend API: http://localhost:8000
# API Docs: http://localhost:8000/docs
```

### Développement Local

#### Backend

```bash
cd backend

# Créer l'environnement virtuel
python -m venv venv

# Activer (Windows)
.\venv\Scripts\activate
# Activer (Linux/Mac)
source venv/bin/activate

# Installer les dépendances
pip install -r requirements.txt

# Lancer le serveur
uvicorn app.main:app --reload --port 8000
```

#### Frontend

```bash
cd frontend

# Installer les dépendances
npm install

# Lancer en développement
npm run dev
```

## 🧪 Tests

### Backend (pytest + coverage)

```bash
cd backend

# Installer les dépendances de test
pip install pytest pytest-asyncio pytest-cov httpx

# Lancer les tests avec couverture
pytest --cov=app --cov-report=html --cov-report=term-missing

# Voir le rapport HTML
start htmlcov/index.html  # Windows
open htmlcov/index.html   # Mac
```

### Frontend (Vitest + coverage)

```bash
cd frontend

# Installer les dépendances de test
npm install -D vitest @testing-library/svelte jsdom @vitest/coverage-v8

# Lancer les tests
npm run test

# Lancer les tests avec couverture
npm run test:coverage

# Mode watch
npm run test:watch
```

## 🔐 Compte Admin par Défaut

- **Email**: admin@emtools.com
- **Mot de passe**: admin123

⚠️ **Important**: Changer les identifiants en production !

## 🌐 Endpoints API

### Authentification
| Méthode | Endpoint | Description |
|---------|----------|-------------|
| POST | `/api/v1/auth/register` | Inscription |
| POST | `/api/v1/auth/login` | Connexion (OAuth2) |
| POST | `/api/v1/auth/refresh` | Rafraîchir le token |

### Utilisateurs
| Méthode | Endpoint | Description |
|---------|----------|-------------|
| GET | `/api/v1/users/me` | Profil utilisateur |
| PUT | `/api/v1/users/me` | Modifier profil |

### Admin
| Méthode | Endpoint | Description |
|---------|----------|-------------|
| GET | `/api/v1/admin/users` | Lister utilisateurs |
| GET | `/api/v1/admin/users/{id}` | Détail utilisateur |
| PUT | `/api/v1/admin/users/{id}` | Modifier utilisateur |
| DELETE | `/api/v1/admin/users/{id}` | Supprimer utilisateur |
| GET | `/api/v1/admin/dashboard/stats` | Statistiques |

### Pastebin
| Méthode | Endpoint | Description |
|---------|----------|-------------|
| POST | `/api/v1/paste` | Créer un paste |
| GET | `/api/v1/paste/{id}` | Récupérer un paste |

## 🌍 Internationalisation

Langues supportées :
- 🇫🇷 Français (fr) - par défaut
- 🇬🇧 Anglais (en)

Ajouter des traductions dans `frontend/src/lib/locales/`.

## 📝 Variables d'Environnement

### Backend (.env)
```env
MONGODB_URL=mongodb://localhost:27017
MONGODB_DB_NAME=emtools
SECRET_KEY=your-secret-key-change-in-production
FIRST_SUPERUSER_EMAIL=admin@emtools.com
FIRST_SUPERUSER_PASSWORD=admin123
```

## 🧪 Tests

### Frontend Tests (Vitest)

```bash
cd frontend
npm run test          # Exécuter les tests
npm run test:coverage # Avec couverture
```

**Résultats des tests Frontend :**

| Fichier de Test | Tests | Statut |
|-----------------|-------|--------|
| `stores/auth.test.ts` | 5 | ✅ Passé |
| `lib/api.test.ts` | 3 | ✅ Passé |
| `calculators/calculators.test.ts` | 10 | ✅ Passé |
| `vasoactive/drugs.test.ts` | 9 | ✅ Passé |
| `metabolic/metabolic.test.ts` | 17 | ✅ Passé |
| `sedation/sedation.test.ts` | 52 | ✅ Passé |
| `i18n/i18n.test.ts` | 8 | ✅ Passé |
| **Total Frontend** | **104** | **✅ 100% passés** |

**Couverture Frontend :**

| Module | Coverage |
|--------|----------|
| `vasoactive/drugs.ts` | 98.32% |
| `calculators/*` | 89.46% |
| `lib/api.ts` | 82.14% |
| `sedation/*` | 72.15% |
| `metabolic/*` | 68.13% |
| `stores/auth.ts` | 55.43% |
| **Global** | **~35%** |

### Backend Tests (pytest)

```bash
cd backend
pytest                      # Exécuter les tests
pytest --cov=app --cov-report=html  # Avec couverture
```

**Résultats des tests Backend :**

| Fichier de Test | Tests | Statut |
|-----------------|-------|--------|
| `test_auth.py` | 10 | ✅ Passé |
| `test_paste.py` | 13 | ✅ Passé |
| `test_security.py` | 19 | ✅ Passé |
| `test_users.py` | 10 | ✅ Passé |
| **Total Backend** | **52** | **✅ 100% passés** |

**Couverture Backend :**

| Module | Coverage |
|--------|----------|
| `core/security.py` | 100% |
| `core/config.py` | 100% |
| `models/*` | 100% |
| `schemas/*` | 100% |
| `api/deps.py` | 87% |
| `main.py` | 85% |
| `api/v1/endpoints/auth.py` | 73% |
| `db/mongodb.py` | 56% |
| `api/v1/endpoints/paste.py` | 55% |
| `api/v1/endpoints/users.py` | 48% |
| `api/v1/endpoints/admin.py` | 40% |
| **Global** | **75%** |

### Résumé Total

| Suite | Tests | Passés | Coverage |
|-------|-------|--------|----------|
| Frontend (Vitest) | 104 | ✅ 104 | ~35% |
| Backend (pytest) | 52 | ✅ 52 | 75% |
| **Total** | **156** | **✅ 156** | - |

## 🐳 Commandes Docker

```bash
# Build et démarrer
docker-compose up -d --build

# Voir les logs
docker-compose logs -f

# Arrêter les services
docker-compose down

# Arrêter et supprimer les volumes
docker-compose down -v
```

## 📚 Références Médicales

Les protocoles et calculs sont basés sur :
- **Dysnatrémie**: Adrogué HJ, Madias NE. NEJM 2000
- **Dyskaliémie**: AHA Guidelines 2020, KDIGO
- **Dyscalcémie**: Shane E. J Clin Endocrinol Metab 2017
- **Scores cliniques**: MDCalc, UpToDate, publications originales

⚠️ **Avertissement**: Outil d'aide à la décision uniquement. Ne remplace pas le jugement clinique.

## 🤖 Généré par IA

Ce projet a été entièrement généré par **Claude Sonnet 4** (Anthropic) via GitHub Copilot.

- **Version**: Alpha 0.1.0
- **Date**: Janvier 2025
- **Modèle**: Claude Sonnet 4
- **IDE**: Visual Studio Code avec GitHub Copilot

L'IA a généré :
- Architecture backend (FastAPI + MongoDB)
- Interface frontend (Svelte + TypeScript)
- 33 calculateurs médicaux
- Protocoles de sédation et drogues vasoactives
- Corrections métaboliques (Adrogué-Madias)
- Tests unitaires (155 tests: 104 frontend + 51 backend)
- Documentation complète
- Politique de sécurité (SECURITY.md)

## 📄 Licence

MIT License - Voir [LICENSE](LICENSE) pour plus de détails.

---

Développé avec ❤️ pour les professionnels de santé | Propulsé par 🤖 Claude Sonnet 4
