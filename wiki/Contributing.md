# Contributing to EMTOOLS

Thank you for your interest in contributing to EMTOOLS! This guide will help you get started.

## 🤝 Code of Conduct

Please be respectful and inclusive. We welcome contributions from everyone.

## 🚀 Getting Started

### Prerequisites

- Node.js 18+
- Python 3.11+
- Docker and Docker Compose
- Git

### Development Setup

1. **Fork the repository** on GitHub

2. **Clone your fork**
   ```bash
   git clone https://github.com/YOUR-USERNAME/EMtools.git
   cd EMtools
   ```

3. **Start development environment**
   ```bash
   docker compose -f docker-compose.dev.yml up
   ```

4. **Frontend development**
   ```bash
   cd frontend
   npm install
   npm run dev
   ```

5. **Backend development**
   ```bash
   cd backend
   python -m venv venv
   source venv/bin/activate
   pip install -r requirements.txt
   uvicorn app.main:app --reload
   ```

## 📝 Making Changes

### Branch Naming

Use descriptive branch names:
- `feature/add-calculator-xyz`
- `fix/button-contrast-issue`
- `docs/update-api-documentation`

### Commit Messages

Follow [Conventional Commits](https://www.conventionalcommits.org/):

```
feat: add new medical calculator
fix: resolve button contrast issue
docs: update API documentation
style: improve code formatting
refactor: restructure auth module
test: add unit tests for calculators
chore: update dependencies
```

### Code Style

#### TypeScript/Svelte
- Use TypeScript for all new code
- Follow existing component structure
- Use DaisyUI classes for styling
- Ensure accessibility (WCAG AA)

#### Python
- Follow PEP 8 style guide
- Use type hints
- Write docstrings for functions
- Use async where appropriate

### Testing

#### Frontend Tests
```bash
cd frontend
npm run test          # Run once
npm run test:watch    # Watch mode
npm run test:coverage # With coverage
```

#### Backend Tests
```bash
cd backend
pytest
pytest --cov=app      # With coverage
```

## 🔄 Pull Request Process

1. **Create a feature branch**
   ```bash
   git checkout -b feature/your-feature
   ```

2. **Make your changes**
   - Write clean, documented code
   - Add tests for new features
   - Update documentation as needed

3. **Test your changes**
   ```bash
   # Frontend
   npm run check    # Type checking
   npm run test     # Unit tests
   npm run build    # Build test

   # Backend
   pytest           # Unit tests
   ```

4. **Commit your changes**
   ```bash
   git add .
   git commit -m "feat: add your feature description"
   ```

5. **Push to your fork**
   ```bash
   git push origin feature/your-feature
   ```

6. **Open a Pull Request**
   - Provide a clear title and description
   - Reference any related issues
   - Request review from maintainers

## 📋 What to Contribute

### Good First Issues
Look for issues labeled `good first issue` on GitHub.

### Ideas for Contributions

#### Features
- New medical calculators
- Additional language translations
- Accessibility improvements
- Mobile optimizations

#### Documentation
- Code documentation
- Wiki improvements
- Tutorial videos
- Usage examples

#### Testing
- Unit tests
- Integration tests
- E2E tests
- Accessibility testing

#### Bug Fixes
- UI/UX issues
- Performance improvements
- Security fixes

## 🏗️ Project Structure

```
EMtools/
├── frontend/
│   ├── src/
│   │   ├── lib/
│   │   │   ├── components/   # Reusable components
│   │   │   ├── pages/        # Page components
│   │   │   ├── stores/       # Svelte stores
│   │   │   └── locales/      # i18n translations
│   │   ├── app.css           # Global styles
│   │   └── main.ts           # Entry point
│   └── tests/                # Test files
│
├── backend/
│   ├── app/
│   │   ├── api/              # API endpoints
│   │   ├── core/             # Core config
│   │   ├── db/               # Database
│   │   ├── models/           # Beanie models
│   │   └── schemas/          # Pydantic schemas
│   └── tests/                # Test files
│
└── wiki/                     # Documentation
```

## 🐛 Reporting Bugs

Use the GitHub issue template:

1. **Description** - Clear description of the bug
2. **Steps to Reproduce** - How to trigger the bug
3. **Expected Behavior** - What should happen
4. **Actual Behavior** - What actually happens
5. **Screenshots** - If applicable
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
