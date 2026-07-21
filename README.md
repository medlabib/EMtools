# EMtools 🏥

<p align="center">
  <img src="docs/logo.png" alt="EMtools Logo" width="120">
</p>

<p align="center">
  <strong>Digital Tools for Emergency Medicine</strong><br>
  <em>Outils Numériques pour la Médecine d'Urgence</em>
</p>

<p align="center">
  <a href="https://medlabib.github.io/EMtools/app/">🌐 Web App</a> •
  <a href="https://github.com/medlabib/EMtools/releases">📱 Android</a> •
  <a href="https://github.com/medlabib/EMtools/releases">🖥️ Windows</a>
</p>

<p align="center">
  <img src="https://img.shields.io/badge/flutter-3.x-02569B?logo=flutter" alt="Flutter">
  <img src="https://img.shields.io/badge/platforms-Web%20%7C%20Android%20%7C%20Windows-green" alt="Platforms">
  <img src="https://img.shields.io/badge/license-MIT-yellow" alt="License">
</p>

---

## Overview / Aperçu

**EMtools** is a comprehensive medical decision-support application for **emergency physicians** and **intensivists**. Fully bilingual (English / Français), it provides clinical tools for acute care settings.

---

## Features / Fonctionnalités

| Tool | Description |
|------|-------------|
| ⏱️ **CPR Timer** | Interactive cardiac arrest timer — automatic 2-min cycles, epinephrine alerts, shock counter, auto-generated report |
| 📝 **ABCDE Assessment** | Structured trauma report with automatic severity detection and narrative format |
| 🧮 **40+ Calculators** | GCS, SOFA, APACHE II, CURB-65, Wells, CHA₂DS₂-VASc, HAS-BLED, HEART, NIHSS, and more |
| 🫁 **Blood Gas Analysis** | Acid-base classification, A-a gradient, P/F ratio, ARDS classification (Berlin) |
| 💉 **Vasoactive Drugs** | Norepinephrine, epinephrine, dobutamine, dopamine, isoproterenol infusion calculators |
| 😴 **Sedation Protocols** | RSI (Rapid Sequence Induction) with weight-based dosing, preoxygenation checklist |
| 💧 **Metabolic Disorders** | Dysnatremia, dyskalemia, dyscalcemia correction — Adrogué-Madias formula |
| 💊 **Antibiotic Guide** | Spectrum, dosing, renal adjustment, major interactions |
| 📋 **55 Protocols** | Emergency department clinical protocols and guidelines |

---

## Quick Start / Démarrage Rapide

### Web App
```
https://medlabib.github.io/EMtools/app/
```

### Build from Source

```bash
git clone https://github.com/medlabib/EMtools.git
cd EMtools

flutter pub get
flutter run

# Web build (for GitHub Pages)
flutter build web --release --base-href "/EMtools/app/"

# Android APK
flutter build apk --release

# Windows
flutter build windows --release
```

---

## Tech Stack / Technologies

| Layer | Technology |
|-------|------------|
| **Framework** | Flutter 3.x (Dart) |
| **State** | Riverpod |
| **Routing** | Go Router |
| **Storage** | Shared Preferences |
| **i18n** | Custom AppStrings (FR/EN) |
| **Theme** | Material 3 |
| **Targets** | Web • Android • Windows |

---

## Architecture / Architecture

Clean Architecture with four layers:

```
lib/
├── core/          # AppStrings, theme, routes, utilities
├── data/          # Clinical data, repositories
├── domain/        # Models, business logic
└── presentation/  # Screens, widgets, views
```

---

## Disclaimer / Avertissement

> ⚠️ This application is a **clinical decision-support tool**. It does not replace clinical judgment, physical examination, or official guidelines. Always verify calculations and adapt management to the clinical context.

---

## License / Licence

MIT — See [LICENSE](LICENSE)

---

## Author / Auteur

**Dr. Labib** — Emergency Physician / Médecin Urgentiste

- GitHub: [@medlabib](https://github.com/medlabib)
