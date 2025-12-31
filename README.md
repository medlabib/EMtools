# EMtools 🏥

<p align="center">
  <img src="docs/logo.png" alt="EMtools Logo" width="120">
</p>

<p align="center">
  <strong>Outils Numériques pour la Médecine d'Urgence</strong>
</p>

<p align="center">
  <a href="https://medlabib.github.io/EMtools/app/">🌐 Web App</a> •
  <a href="https://github.com/medlabib/EMtools/releases">📱 Android</a> •
  <a href="https://github.com/medlabib/EMtools/releases">🖥️ Windows</a> •
  <a href="#fonctionnalités">✨ Fonctionnalités</a>
</p>

<p align="center">
  <img src="https://img.shields.io/badge/version-0.1.2-blue" alt="Version">
  <img src="https://img.shields.io/badge/flutter-3.x-02569B?logo=flutter" alt="Flutter">
  <img src="https://img.shields.io/badge/platforms-Web%20%7C%20Android%20%7C%20Windows-green" alt="Platforms">
  <img src="https://img.shields.io/badge/license-MIT-yellow" alt="License">
</p>

---

## 📋 Description

**EMtools** est une application complète d'outils médicaux conçue pour les **urgentistes** et **réanimateurs**. Elle offre une suite d'outils cliniques pour faciliter la prise en charge des patients en situation d'urgence.

> ⚠️ **Version Beta (v0.1.2)** - Cette application est en développement actif. Les retours sont les bienvenus !

---

## ✨ Fonctionnalités

### ⏱️ Timer RCP (Réanimation Cardio-Pulmonaire)
Timer interactif pour la gestion de l'arrêt cardiaque :
- Chronomètre avec cycles de 2 minutes automatiques
- Alertes visuelles et sonores pour les changements de relève
- Suivi des doses d'adrénaline (intervalle 3-5 min)
- Compteur de chocs électriques
- Rapport RCP automatique avec timeline complète
- Mode sombre optimisé pour les urgences

### 📝 Évaluation ABCDE
Génération automatique de rapports médicaux structurés selon l'approche ABCDE :
- **A** - Voies Aériennes : état, dispositif, action
- **B** - Respiration : FR, signes de lutte, auscultation, SpO2, oxygénothérapie
- **C** - Circulation : extrémités, signes de choc, TA, pouls, ECG complet
- **D** - Neurologie : GCS, pupilles, déficit neurologique, glycémie
- **E** - Exposition : terrain, habitudes, HDM, reste de l'examen
- **CAT** - Conduite à Tenir avec options rapides

Inclut :
- Détection automatique des détresses vitales
- Évaluation de gravité avec score de sévérité
- Format narratif en français
- Copie rapide du rapport

### 🧮 Calculateurs Médicaux (40+)
Scores cliniques validés internationalement :

| Catégorie | Scores |
|-----------|--------|
| **Réanimation** | SOFA, APACHE II, qSOFA, NEWS2 |
| **Cardiologie** | CHA₂DS₂-VASc, HAS-BLED, HEART, TIMI |
| **Pneumologie** | CURB-65, PSI/PORT, Wells EP, Genève |
| **Neurologie** | Glasgow, NIHSS, Hunt & Hess |
| **Néphrologie** | DFG (CKD-EPI, MDRD), RIFLE |
| **Divers** | Child-Pugh, MELD, Ranson, Alvarado |

### 🫁 Gazométrie Artérielle
Interprétation complète des gaz du sang :
- Classification des troubles acido-basiques
- Calcul du gradient alvéolo-artériel (A-a)
- Classification ARDS (Berlin 2012)
- Calcul du rapport PaO2/FiO2
- Compensation attendue des troubles

### 💉 Drogues Vasoactives
Calcul des débits de perfusion pour :
- **Noradrénaline** (0.1-3 µg/kg/min)
- **Adrénaline** (0.01-0.5 µg/kg/min)  
- **Dobutamine** (2.5-20 µg/kg/min)
- **Dopamine** (2-20 µg/kg/min)
- **Isoprénaline** (0.01-0.1 µg/kg/min)

Options de dilution personnalisables avec calcul automatique du débit en ml/h.

### 💊 Sédation ISR
Protocoles d'Induction en Séquence Rapide :
- **Hypnotiques** : Étomidate, Kétamine, Propofol
- **Curares** : Succinylcholine, Rocuronium
- Doses adaptées au poids avec ajustement selon comorbidités
- Aide à la préoxygénation et checklist

### 💧 Troubles Métaboliques
Correction des dysnatrémies et dyskaliémies :
- Formule d'Adrogué-Madias pour la correction du sodium
- Calcul du déficit hydrique
- Vitesse de correction sécuritaire
- Protocoles de correction du potassium et calcium

### 💊 Guide Antibiotiques
Base de données antibiotiques avec :
- Spectre d'action bactérien
- Posologies standards
- Ajustement selon fonction rénale
- Interactions médicamenteuses principales

---

## 🚀 Installation

### 🌐 Application Web
Accédez directement depuis votre navigateur :
```
https://medlabib.github.io/EMtools/app/
```

### 📱 Android
Téléchargez l'APK depuis les releases :
```
https://github.com/medlabib/EMtools/releases
```

### 🖥️ Windows
Téléchargez l'exécutable Windows depuis les releases :
```
https://github.com/medlabib/EMtools/releases
```
> Décompressez l'archive et lancez `EMtools.exe`

### 🛠️ Build depuis les sources

```bash
# Cloner le repository
git clone https://github.com/medlabib/EMtools.git
cd EMtools

# Installer les dépendances
flutter pub get

# Lancer l'application
flutter run

# Build Web
flutter build web --release --base-href "/EMtools/app/"

# Build Android APK
flutter build apk --release

# Build Windows (nécessite Visual Studio)
flutter build windows --release
```

---

## 🛠️ Technologies

| Technologie | Description |
|-------------|-------------|
| **Framework** | Flutter 3.x |
| **Langage** | Dart |
| **State Management** | Riverpod |
| **Navigation** | Go Router |
| **Stockage** | Shared Preferences |
| **Plateformes** | Web, Android, Windows |

---

## 📱 Captures d'écran

| Dashboard | Évaluation ABCDE | Calculateurs |
|-----------|------------------|--------------|
| Accès rapide aux outils | Formulaire structuré | Scores cliniques |

---

## 🤝 Contribution

Les contributions sont les bienvenues ! 

1. Fork le projet
2. Créez une branche (`git checkout -b feature/AmazingFeature`)
3. Committez vos changements (`git commit -m 'Add AmazingFeature'`)
4. Push sur la branche (`git push origin feature/AmazingFeature`)
5. Ouvrez une Pull Request

---

## ⚠️ Avertissement

Cette application est un **outil d'aide à la décision médicale**. Elle ne remplace en aucun cas :
- Le jugement clinique du praticien
- L'examen physique du patient
- Les recommandations officielles

Vérifiez toujours les calculs et adaptez la prise en charge au contexte clinique.

---

## 📄 Licence

Distribué sous licence MIT. Voir `LICENSE` pour plus d'informations.

---

## 👨‍⚕️ Auteur

**Dr. Labib** - Médecin Urgentiste

- GitHub: [@medlabib](https://github.com/medlabib)

---

<p align="center">
  Fait avec ❤️ pour les professionnels de santé
</p>
