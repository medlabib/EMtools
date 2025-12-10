# Démarrage avec EMTOOLS# Getting Started with EMTOOLS



Ce guide vous aidera à lancer EMTOOLS rapidement.This guide will help you get EMTOOLS up and running quickly.



## Prérequis## Prerequisites



Avant de commencer, assurez-vous d'avoir :Before you begin, ensure you have:



- **Flutter SDK 3.x** installé- **Docker** and **Docker Compose** installed

- **Git** pour cloner le repository- **Git** for cloning the repository

- Un IDE (VS Code ou Android Studio recommandé)- A modern web browser (Chrome, Firefox, Safari, Edge)

- Pour Android : Android Studio avec SDK Android

- Pour iOS : Xcode (macOS uniquement)## Quick Start



## Démarrage Rapide### 1. Clone the Repository



### 1. Cloner le Repository```bash

git clone https://github.com/medlabib/EMtools.git

```bashcd EMtools

git clone https://github.com/medlabib/EMtools.git```

cd EMtools/frontend

```### 2. Start with Docker



### 2. Installer les Dépendances```bash

docker compose up -d

```bash```

flutter pub get

```This will start:

- **Frontend** at http://localhost:80

### 3. Lancer l'Application- **Backend API** at http://localhost:8000

- **MongoDB** database

#### Sur le Web

```bash### 3. Initial Setup

flutter run -d chrome

```1. Navigate to http://localhost in your browser

2. You'll be redirected to the setup wizard

#### Sur Android3. Create your admin account

```bash4. Configure signup mode and SMTP (optional)

# Connectez un appareil ou démarrez un émulateur

flutter run -d android## First-Time Configuration

```

### Setup Wizard Steps

#### Sur iOS

```bash1. **Welcome** - Introduction and requirements

# Ouvrez un simulateur2. **Admin Account** - Create the first administrator

flutter run -d ios3. **Settings** - Configure signup mode and domains

```

### Signup Modes

## Première Utilisation

| Mode | Description |

### Navigation|------|-------------|

| **Open** | Anyone can register |

L'application est organisée en trois sections principales :| **Institutional** | Only emails from allowed domains |

| **Closed** | Admin creates all accounts |

1. **Tableau de bord** - Accès rapide à vos outils favoris

2. **Outils** - Liste complète de tous les outils disponibles## Accessing the Application

3. **Paramètres** - Personnalisation (thème, etc.)

After setup:

### Ajouter des Favoris

- **Home Page**: http://localhost/

1. Accédez à n'importe quel outil- **Dashboard**: http://localhost/dashboard

2. Cliquez sur l'icône ⭐ pour l'ajouter aux favoris- **Admin Panel**: http://localhost/admin (admin only)

3. L'outil apparaîtra sur votre tableau de bord

## Environment Variables

### Changer de Thème

Create a `.env` file for custom configuration:

1. Accédez aux Paramètres

2. Basculez entre le mode clair et le mode sombre```env

# MongoDB

## Outils DisponiblesMONGODB_URL=mongodb://mongodb:27017

MONGODB_DB_NAME=emtools

| Outil | Description |

|-------|-------------|# Security

| Rapport Médical | Évaluation structurée ABCDE |SECRET_KEY=your-secret-key-change-in-production

| Calculateurs | 41+ scores cliniques |

| Drogues Vasoactives | Calculs de débit PSE |# SMTP (optional)

| Sédation | Protocoles ISR |SMTP_HOST=smtp.gmail.com

| Métabolique | Corrections Na/K/Ca |SMTP_PORT=587

| Gaz du Sang | Analyse des GDS |SMTP_USER=your-email@gmail.com

| Antibiotiques | Guide de posologie |SMTP_PASSWORD=your-app-password

```

## Build pour Production

## Development Mode

### Web

```bashFor development with hot-reload:

flutter build web --release

``````bash

Les fichiers sont dans `build/web/`. Déployez-les sur n'importe quel serveur statique.docker compose -f docker-compose.dev.yml up

```

### Android APK

```bashFrontend will be available at http://localhost:5173 with HMR enabled.

flutter build apk --release

```## Next Steps

L'APK est dans `build/app/outputs/flutter-apk/app-release.apk`.

- [Explore Features](Features)

### iOS- [API Documentation](API-Documentation)

```bash- [Customize Settings](Admin-Guide)

flutter build ios --release
```
Ouvrez ensuite le projet Xcode pour l'archivage.

## Prochaines Étapes

- Consultez les [Fonctionnalités](Features) pour découvrir tous les outils
- Lisez le [Guide d'Installation](Installation) pour plus de détails
- Consultez [Contribuer](Contributing) pour participer au projet

---

*Version 0.1.0 - Application Flutter autonome*
