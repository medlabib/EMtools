# Features Overview

EMTOOLS provides a comprehensive suite of tools for emergency medicine practitioners.

## 🏥 Medical Report Generator

Generate structured ABCDE medical reports quickly and efficiently.

### Features
- **ABCDE Assessment Structure**
  - **A**irway evaluation
  - **B**reathing assessment (respiratory rate, SpO2, lung sounds)
  - **C**irculation (BP, HR, capillary refill, shock signs)
  - **D**isability (GCS, pupil response, motor function)
  - **E**xposure (temperature, skin findings)
- Patient demographics
- ECG interpretation helper
- Trauma vs Medical context
- Copy-to-clipboard functionality
- Multi-language support (French/English)

### Usage
1. Navigate to Dashboard → Medical Report
2. Fill in patient information
3. Complete ABCDE assessment
4. Generate and copy report

---

## 📋 Secure Pastebin

Share text and images temporarily with security features.

### Features
- **24-hour automatic expiration**
- **Password protection** (optional)
- **Syntax highlighting** for code
- Unique shareable links
- Copy to clipboard
- Deletion confirmation

### Usage
1. Navigate to Dashboard → Pastebin
2. Enter your content
3. Set password (optional)
4. Share the generated link

---

## 🧮 Medical Calculators

41+ validated clinical scoring systems.

### Categories

#### Neurology
| Score | Description |
|-------|-------------|
| NIHSS | Stroke severity assessment |
| Glasgow Coma Scale | Level of consciousness |
| Hunt & Hess | SAH grading |
| FOUR Score | Coma assessment alternative |

#### Cardiology
| Score | Description |
|-------|-------------|
| HEART Score | ACS risk stratification |
| TIMI Score | MI risk assessment |
| CHA2DS2-VASc | Stroke risk in AF |
| HAS-BLED | Bleeding risk in anticoagulation |
| Wells PE | Pulmonary embolism probability |
| Wells DVT | Deep vein thrombosis probability |
| PERC Rule | PE exclusion criteria |

#### Critical Care
| Score | Description |
|-------|-------------|
| SOFA | Organ failure assessment |
| qSOFA | Quick sepsis screening |
| APACHE II | ICU mortality prediction |
| SAPS II | Simplified acute physiology |

#### Trauma
| Score | Description |
|-------|-------------|
| Injury Severity Score | Trauma severity |
| Revised Trauma Score | Field triage |
| NEXUS Criteria | C-spine clearance |
| Canadian C-Spine Rule | C-spine imaging decision |

#### Other Specialties
- CURB-65 (Pneumonia)
- Child-Pugh (Liver disease)
- MELD Score (Liver transplant)
- Ranson Criteria (Pancreatitis)
- Alvarado Score (Appendicitis)
- And many more...

---

## 💉 Vasoactive Drugs Calculator

Calculate infusion rates for critical medications.

### Supported Drugs
- **Norepinephrine** (Noradrenaline)
- **Epinephrine** (Adrenaline)
- **Dobutamine**
- **Dopamine**

### Features
- Weight-based dosing (µg/kg/min)
- Concentration adjustments
- Flow rate calculations (mL/h)
- Common dilution presets
- Safety alerts for high doses

---

## 💊 Sedation & Analgesia

Rapid Sequence Intubation (RSI) protocols and dosing.

### Included Agents
- **Induction**: Etomidate, Ketamine, Propofol
- **Paralytics**: Succinylcholine, Rocuronium
- **Analgesics**: Fentanyl, Morphine

### Features
- Weight-based dosing
- Pediatric considerations
- Contraindication alerts
- Onset/duration information

---

## ⚗️ Metabolic Corrections

Calculate correction protocols for electrolyte disorders.

### Available Corrections
- **Dysnatremia** (Adrogué-Madias formula)
- **Dyskalemia** correction protocols
- **Dyscalcemia** management
- Fluid calculations

### Features
- Step-by-step calculations
- Rate of correction monitoring
- Safety alerts for rapid correction

---

## 📊 Blood Gas & Ventilation Analysis

Comprehensive arterial blood gas interpretation.

### Features
- **ABG Interpretation**
  - pH analysis
  - Primary disorder identification
  - Compensation assessment
  - Anion gap calculation
- **Oxygenation Assessment**
  - P/F ratio calculation
  - A-a gradient
  - Oxygen content
- **Ventilation Parameters**
  - Predicted minute ventilation
  - Tidal volume recommendations

---

## 🦠 Antibiotic Guide

Evidence-based antibiotic reference.

### Features
- **Drug Database**
  - Mechanism of action
  - Spectrum of activity
  - Standard dosing
- **Renal Adjustments**
  - GFR-based dosing
  - Dialysis dosing
- **Interactions**
  - Drug-drug interactions
  - Food interactions
- **Indication-Based Protocols**
  - Community-acquired pneumonia
  - UTI treatment
  - Skin/soft tissue infections

---

## 🌐 General Features

### Multi-Language Support
- French (default)
- English
- Easy language switching

### Theme Support
- Dark mode (default)
- Light mode
- Animated theme toggle
- System preference detection

### Responsive Design
- Desktop optimized
- Tablet support
- Mobile-friendly interface

### Accessibility
- WCAG 2.1 AA compliant contrast
- Keyboard navigation
- Screen reader support
- Focus indicators

### Security
- JWT authentication
- Role-based access control
- Password hashing (bcrypt)
- Session management
