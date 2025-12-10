# Contribuer à EMTOOLS# Contributing to EMTOOLS



Merci de votre intérêt pour contribuer à EMTOOLS ! Ce guide vous aidera à démarrer.Thank you for your interest in contributing to EMTOOLS! This guide will help you get started.



## 🤝 Code de Conduite## 🤝 Code of Conduct



Soyez respectueux et inclusif. Nous accueillons les contributions de tous.Please be respectful and inclusive. We welcome contributions from everyone.



## 🚀 Démarrage## 🚀 Getting Started



### Prérequis### Prerequisites



- Flutter SDK 3.19+- Node.js 18+

- Dart SDK 3.3+- Python 3.11+

- Git- Docker and Docker Compose

- Un IDE (VS Code recommandé avec l'extension Flutter)- Git



### Configuration de l'Environnement### Development Setup



1. **Forkez le dépôt** sur GitHub1. **Fork the repository** on GitHub



2. **Clonez votre fork**2. **Clone your fork**

   ```bash   ```bash

   git clone https://github.com/VOTRE-USERNAME/EMtools.git   git clone https://github.com/YOUR-USERNAME/EMtools.git

   cd EMtools/frontend   cd EMtools

   ```   ```



3. **Installez les dépendances**3. **Start development environment**

   ```bash   ```bash

   flutter pub get   docker compose -f docker-compose.dev.yml up

   ```   ```



4. **Lancez l'application en mode développement**4. **Frontend development**

   ```bash   ```bash

   flutter run   cd frontend

   ```   npm install

   npm run dev

5. **Exécutez les tests**   ```

   ```bash

   flutter test5. **Backend development**

   ```   ```bash

   cd backend

## 📝 Effectuer des Modifications   python -m venv venv

   source venv/bin/activate

### Structure du Projet   pip install -r requirements.txt

   uvicorn app.main:app --reload

```   ```

frontend/

├── lib/## 📝 Making Changes

│   ├── main.dart              # Point d'entrée

│   ├── core/                  # Configuration, thèmes, utilitaires### Branch Naming

│   ├── data/                  # Sources de données, modèles

│   ├── domain/                # Entités, interfaces repositoriesUse descriptive branch names:

│   └── presentation/          # Écrans, widgets, providers- `feature/add-calculator-xyz`

├── test/                      # Tests unitaires- `fix/button-contrast-issue`

├── assets/                    # Ressources (icônes, images)- `docs/update-api-documentation`

└── pubspec.yaml              # Dépendances

```### Commit Messages



### Conventions de CodeFollow [Conventional Commits](https://www.conventionalcommits.org/):



- **Style**: Suivez les [conventions Dart](https://dart.dev/guides/language/effective-dart/style)```

- **Formatage**: Utilisez `dart format` avant chaque commitfeat: add new medical calculator

- **Analyse**: Assurez-vous que `flutter analyze` ne retourne aucune erreurfix: resolve button contrast issue

- **Tests**: Ajoutez des tests pour toute nouvelle fonctionnalitédocs: update API documentation

style: improve code formatting

### Workflow de Développementrefactor: restructure auth module

test: add unit tests for calculators

1. Créez une branche pour votre fonctionnalitéchore: update dependencies

   ```bash```

   git checkout -b feature/ma-fonctionnalite

   ```### Code Style



2. Effectuez vos modifications#### TypeScript/Svelte

- Use TypeScript for all new code

3. Formatez et analysez le code- Follow existing component structure

   ```bash- Use DaisyUI classes for styling

   dart format .- Ensure accessibility (WCAG AA)

   flutter analyze

   ```#### Python

- Follow PEP 8 style guide

4. Exécutez les tests- Use type hints

   ```bash- Write docstrings for functions

   flutter test- Use async where appropriate

   ```

### Testing

5. Commitez avec un message descriptif

   ```bash#### Frontend Tests

   git commit -m "feat: ajouter calculateur X"```bash

   ```cd frontend

npm run test          # Run once

6. Poussez votre branchenpm run test:watch    # Watch mode

   ```bashnpm run test:coverage # With coverage

   git push origin feature/ma-fonctionnalite```

   ```

#### Backend Tests

7. Créez une Pull Request```bash

cd backend

## 🎯 Types de Contributionspytest

pytest --cov=app      # With coverage

### 🔧 Nouveaux Calculateurs```



Pour ajouter un nouveau calculateur médical :## 🔄 Pull Request Process



1. Ajoutez la définition dans `lib/data/datasources/calculators_data.dart`1. **Create a feature branch**

2. Suivez le format des calculateurs existants   ```bash

3. Incluez les références scientifiques   git checkout -b feature/your-feature

4. Ajoutez des tests unitaires dans `test/unit/`   ```



### 🐛 Corrections de Bugs2. **Make your changes**

   - Write clean, documented code

1. Vérifiez si le bug n'a pas déjà été signalé   - Add tests for new features

2. Créez une issue décrivant le problème   - Update documentation as needed

3. Soumettez un fix avec les tests correspondants

3. **Test your changes**

### 📚 Documentation   ```bash

   # Frontend

- Améliorations du README   npm run check    # Type checking

- Corrections de fautes   npm run test     # Unit tests

- Ajout d'exemples   npm run build    # Build test

- Mise à jour du wiki

   # Backend

### 🎨 Améliorations UI/UX   pytest           # Unit tests

   ```

- Améliorations de l'accessibilité

- Corrections du thème sombre4. **Commit your changes**

- Optimisations de l'expérience utilisateur   ```bash

   git add .

## 📋 Guidelines pour les Pull Requests   git commit -m "feat: add your feature description"

   ```

### Checklist

5. **Push to your fork**

- [ ] Le code suit les conventions du projet   ```bash

- [ ] Les tests passent (`flutter test`)   git push origin feature/your-feature

- [ ] L'analyse statique passe (`flutter analyze`)   ```

- [ ] Le code est formaté (`dart format`)

- [ ] La documentation est mise à jour si nécessaire6. **Open a Pull Request**

- [ ] Le message de commit est descriptif   - Provide a clear title and description

   - Reference any related issues

### Convention de Commit   - Request review from maintainers



Utilisez le format [Conventional Commits](https://www.conventionalcommits.org/) :## 📋 What to Contribute



- `feat:` nouvelle fonctionnalité### Good First Issues

- `fix:` correction de bugLook for issues labeled `good first issue` on GitHub.

- `docs:` documentation

- `style:` formatage (pas de changement de code)### Ideas for Contributions

- `refactor:` refactorisation du code

- `test:` ajout/modification de tests#### Features

- `chore:` maintenance- New medical calculators

- Additional language translations

### Exemples- Accessibility improvements

- Mobile optimizations

```

feat: ajouter score SOFA pour sepsis#### Documentation

fix: corriger calcul IMC avec virgule- Code documentation

docs: mettre à jour guide d'installation- Wiki improvements

test: ajouter tests pour score HAS-BLED- Tutorial videos

```- Usage examples



## 🧪 Tests#### Testing

- Unit tests

### Exécuter Tous les Tests- Integration tests

- E2E tests

```bash- Accessibility testing

flutter test

```#### Bug Fixes

- UI/UX issues

### Exécuter un Fichier de Test Spécifique- Performance improvements

- Security fixes

```bash

flutter test test/unit/calculators_data_test.dart## 🏗️ Project Structure

```

```

### Structure des TestsEMtools/

├── frontend/

```dart│   ├── src/

void main() {│   │   ├── lib/

  group('NomCalculateur', () {│   │   │   ├── components/   # Reusable components

    test('devrait calculer correctement avec valeurs normales', () {│   │   │   ├── pages/        # Page components

      // Arrange│   │   │   ├── stores/       # Svelte stores

      final input = {'variable': valeur};│   │   │   └── locales/      # i18n translations

      │   │   ├── app.css           # Global styles

      // Act│   │   └── main.ts           # Entry point

      final result = calculer(input);│   └── tests/                # Test files

      │

      // Assert├── backend/

      expect(result, expectedValue);│   ├── app/

    });│   │   ├── api/              # API endpoints

  });│   │   ├── core/             # Core config

}│   │   ├── db/               # Database

```│   │   ├── models/           # Beanie models

│   │   └── schemas/          # Pydantic schemas

## 📞 Aide et Support│   └── tests/                # Test files

│

- **Issues GitHub**: Pour signaler des bugs ou demander des fonctionnalités└── wiki/                     # Documentation

- **Discussions**: Pour questions et échanges```



## 🙏 Remerciements## 🐛 Reporting Bugs



Merci à tous les contributeurs qui aident à améliorer EMTOOLS !Use the GitHub issue template:



---1. **Description** - Clear description of the bug

2. **Steps to Reproduce** - How to trigger the bug

## Licence3. **Expected Behavior** - What should happen

4. **Actual Behavior** - What actually happens

En contribuant, vous acceptez que vos contributions soient sous la même licence que le projet (MIT).5. **Screenshots** - If applicable

6. **Environment** - Browser, OS, version

## 💡 Feature Requests

Use the GitHub feature request template:

1. **Problem** - What problem does this solve?
2. **Solution** - Your proposed solution
3. **Alternatives** - Other options considered
4. **Context** - Additional information

## 📞 Getting Help

- **GitHub Discussions** - For questions and ideas
- **GitHub Issues** - For bugs and features
- **Wiki** - For documentation

## 📜 License

By contributing, you agree that your contributions will be licensed under the MIT License.

---

Thank you for contributing to EMTOOLS! 🎉
