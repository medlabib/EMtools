# Guide d'Installation# Installation Guide



## Configuration Requise## System Requirements



### Prérequis### Minimum Requirements

- **Flutter SDK**: 3.x ou supérieur- **CPU**: 2 cores

- **Dart**: 3.x ou supérieur- **RAM**: 4 GB

- **IDE**: VS Code ou Android Studio (recommandé)- **Storage**: 10 GB

- **OS**: Windows 10+, macOS 10.15+, Ubuntu 20.04+

### Pour le Développement Mobile

- **Android**: Android Studio avec SDK Android### Recommended

- **iOS**: Xcode 14+ (macOS uniquement)- **CPU**: 4+ cores

- **RAM**: 8 GB

### Pour le Développement Web- **Storage**: 20 GB SSD

- Chrome ou tout navigateur moderne

## Installation Methods

## Installation

### Method 1: Docker (Recommended)

### Étape 1: Installer Flutter

#### Prerequisites

Suivez le guide officiel Flutter pour votre système d'exploitation:- Docker Engine 20.10+

- [Windows](https://docs.flutter.dev/get-started/install/windows)- Docker Compose 2.0+

- [macOS](https://docs.flutter.dev/get-started/install/macos)

- [Linux](https://docs.flutter.dev/get-started/install/linux)#### Steps



Vérifiez l'installation:```bash

```bash# Clone repository

flutter doctorgit clone https://github.com/medlabib/EMtools.git

```cd EMtools



### Étape 2: Cloner le Repository# Start all services

docker compose up -d

```bash

git clone https://github.com/medlabib/EMtools.git# View logs

cd EMtools/frontenddocker compose logs -f

``````



### Étape 3: Installer les Dépendances#### Verify Installation



```bash```bash

flutter pub get# Check running containers

```docker ps



### Étape 4: Lancer l'Application# Expected output:

# emtools-frontend  - Port 80

#### Web (Chrome)# emtools-backend   - Port 8000

```bash# emtools-mongodb   - Port 27017

flutter run -d chrome```

```

### Method 2: Manual Installation

#### Android

```bash#### Backend Setup

# Connectez un appareil Android ou démarrez un émulateur

flutter run -d android```bash

```cd backend



#### iOS (macOS uniquement)# Create virtual environment

```bashpython -m venv venv

# Ouvrez un simulateur ou connectez un iPhonesource venv/bin/activate  # Linux/macOS

flutter run -d ios# or

```.\venv\Scripts\activate   # Windows



## Build pour Production# Install dependencies

pip install -r requirements.txt

### Web

```bash# Start server

flutter build web --releaseuvicorn app.main:app --reload --host 0.0.0.0 --port 8000

```

# Les fichiers sont dans build/web/

# Déployez sur n'importe quel serveur statique#### Frontend Setup

```

```bash

### Android APKcd frontend

```bash

flutter build apk --release# Install dependencies

npm install

# APK disponible dans build/app/outputs/flutter-apk/

```# Development server

npm run dev

### Android App Bundle (Play Store)

```bash# Production build

flutter build appbundle --releasenpm run build

``````



### iOS (macOS uniquement)#### MongoDB Setup

```bash

flutter build ios --release```bash

# Using Docker

# Ouvrez le projet Xcode pour l'archivagedocker run -d --name mongodb -p 27017:27017 mongo:7

open ios/Runner.xcworkspace

```# Or install locally

# See: https://docs.mongodb.com/manual/installation/

## Tests```



Lancez tous les tests:## Production Deployment

```bash

flutter test### Using Docker Compose (Production)

```

```bash

Lancez avec couverture:docker compose -f docker-compose.prod.yml up -d

```bash```

flutter test --coverage

```### Environment Configuration



## Structure des FichiersCreate `.env` file:



``````env

frontend/# Required

├── lib/SECRET_KEY=generate-a-secure-64-char-key

│   ├── main.dart              # Point d'entréeMONGODB_URL=mongodb://mongodb:27017

│   ├── core/MONGODB_DB_NAME=emtools

│   │   ├── config/            # Configuration

│   │   ├── theme/             # Thèmes (clair/sombre)# Optional - SMTP

│   │   ├── utils/             # UtilitairesSMTP_HOST=smtp.gmail.com

│   │   └── widgets/           # Widgets partagésSMTP_PORT=587

│   ├── data/SMTP_USER=your-email@gmail.com

│   │   ├── datasources/       # Données (calculateurs, médicaments...)SMTP_PASSWORD=app-specific-password

│   │   ├── models/            # Modèles de donnéesSMTP_FROM_EMAIL=noreply@yourdomain.com

│   │   └── repositories/      # Repositories

│   ├── domain/# Optional - CORS

│   │   └── entities/          # Entités métierBACKEND_CORS_ORIGINS=["https://yourdomain.com"]

│   └── presentation/```

│       ├── providers/         # State management (Riverpod)

│       ├── screens/           # Écrans### SSL/TLS Setup

│       └── widgets/           # Widgets spécifiques

├── test/                      # Tests unitairesFor production, use a reverse proxy with SSL:

├── web/                       # Configuration web

├── android/                   # Configuration Android#### Nginx Configuration

├── ios/                       # Configuration iOS

└── pubspec.yaml               # Dépendances```nginx

```server {

    listen 443 ssl http2;

## Résolution de Problèmes    server_name yourdomain.com;



### Flutter Doctor échoue    ssl_certificate /path/to/cert.pem;

```bash    ssl_certificate_key /path/to/key.pem;

flutter doctor -v

```    location / {

Suivez les recommandations affichées.        proxy_pass http://localhost:80;

        proxy_set_header Host $host;

### Erreurs de dépendances        proxy_set_header X-Real-IP $remote_addr;

```bash    }

flutter clean

flutter pub get    location /api {

```        proxy_pass http://localhost:8000;

        proxy_set_header Host $host;

### Problèmes Android        proxy_set_header X-Real-IP $remote_addr;

```bash    }

flutter clean}

cd android```

./gradlew clean

cd ..## Troubleshooting

flutter run

```### Common Issues



### Problèmes iOS#### Port Already in Use

```bash

cd ios```bash

pod install --repo-update# Find process using port

cd ..lsof -i :8000  # Linux/macOS

flutter runnetstat -ano | findstr :8000  # Windows

```

# Kill process or change port in docker-compose.yml

## Support```



- [Issues GitHub](https://github.com/medlabib/EMtools/issues)#### MongoDB Connection Failed

- [Documentation Flutter](https://docs.flutter.dev/)

```bash

---# Check MongoDB is running

docker logs emtools-mongodb

*Version 0.1.0 - Application Flutter autonome*

# Verify connection string
docker exec -it emtools-mongodb mongosh --eval "db.adminCommand('ping')"
```

#### Frontend Build Errors

```bash
# Clear cache and reinstall
rm -rf node_modules package-lock.json
npm install
npm run build
```

### Getting Help

- [GitHub Issues](https://github.com/medlabib/EMtools/issues)
- [Discussions](https://github.com/medlabib/EMtools/discussions)

## Updating

```bash
# Pull latest changes
git pull origin master

# Rebuild containers
docker compose up --build -d
```
