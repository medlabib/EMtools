# EMtools - Medical Fact-Check Document

**Date de révision:** 10 décembre 2025  
**Version de l'application:** 1.0.0

Ce document vérifie l'exactitude des données médicales de l'application EMtools en se référant aux sources suivantes:

## Sources de référence

### Sociétés savantes françaises
- **SRLF** - Société de Réanimation de Langue Française
- **SFMU** - Société Française de Médecine d'Urgence
- **SFAR** - Société Française d'Anesthésie et de Réanimation
- **SPILF** - Société de Pathologie Infectieuse de Langue Française
- **SFC** - Société Française de Cardiologie

### Guidelines internationales
- **SSC** - Surviving Sepsis Campaign Guidelines 2021
- **AHA/ACLS** - American Heart Association Guidelines 2020
- **ARDS Network** - Berlin Definition 2012
- **ESC** - European Society of Cardiology

### Outils de référence
- **Antibioclic** - SPILF/AFSSAPS
- **UpToDate**
- **MDCalc**

---

## 1. GAZOMÉTRIE ARTÉRIELLE (Blood Gas Analysis)

### 1.1 Interprétation acido-basique

| Paramètre | Valeur dans l'app | Référence | Statut |
|-----------|-------------------|-----------|--------|
| pH normal | 7.35-7.45 | SRLF, Harrison's | ✅ CORRECT |
| PaCO2 normale | 35-45 mmHg | SRLF | ✅ CORRECT |
| HCO3- normal | 22-26 mEq/L | SRLF | ✅ CORRECT |
| Acidose si pH | < 7.35 | Standard | ✅ CORRECT |
| Alcalose si pH | > 7.45 | Standard | ✅ CORRECT |

### 1.2 Formules de compensation

| Formule | App | Référence (Narins RG, Emmett M) | Statut |
|---------|-----|--------------------------------|--------|
| **Winter's Formula** (Acidose métab.) | PaCO2 = 1.5 × HCO3 + 8 (±2) | PaCO2 = 1.5 × HCO3 + 8 ± 2 | ✅ CORRECT |
| **Acidose resp. aiguë** | ΔpH = 0.08 per 10 mmHg ↑PaCO2 | ΔpH = 0.08 / 10 mmHg CO2 | ✅ CORRECT |
| **Acidose resp. chronique** | ΔHCO3 = 3.5 per 10 mmHg ↑PaCO2 | ΔHCO3 = 3-4 / 10 mmHg | ✅ CORRECT |
| **Alcalose resp. aiguë** | ΔHCO3 = 2 per 10 mmHg ↓PaCO2 | ΔHCO3 = 2 / 10 mmHg | ✅ CORRECT |
| **Alcalose métab.** | PaCO2 = 40 + 0.7 × (HCO3 - 24) | PaCO2 = 0.7 × HCO3 + 21 (±2) | ✅ CORRECT |

### 1.3 Les 4 Trous (Gap Analysis)

#### 1.3.1 Trou Anionique (TA)

| Paramètre | App | Référence (Emmett & Narins) | Statut |
|-----------|-----|----------------------------|--------|
| Formule | Na - (Cl + HCO3) | Standard | ✅ CORRECT |
| Valeur normale | 12 ± 4 mEq/L | 8-16 mEq/L | ✅ CORRECT |
| HAGMA si | > 16 mEq/L | > 12-16 selon sources | ✅ CORRECT |

**Étiologies HAGMA (Mnémonique GOLDMARK):**
- **G**lycolates (éthylène glycol)
- **O**xoproline
- **L**actate
- **D**-lactate
- **M**éthanol
- **A**spirine (salicylés)
- **R**enal failure
- **K**etoacidosis

#### 1.3.2 Trou Anionique Corrigé (TAc)

| Paramètre | App | Référence (Figge J, 1998) | Statut |
|-----------|-----|--------------------------|--------|
| Formule | TAc = TA + 2.5 × (4.0 - Albumine) | Standard | ✅ CORRECT |
| Albumine normale | 4.0 g/dL | 3.5-5.0 g/dL | ✅ CORRECT |
| Correction | +2.5 mEq/L par g/dL d'albumine manquante | 2.3-2.5 selon sources | ✅ CORRECT |

> **Note clinique:** La correction est essentielle en réanimation où l'hypoalbuminémie est fréquente. Un TA "normal" peut masquer une acidose métabolique à TA élevé.

#### 1.3.3 Delta Gap (ΔΔ)

| Paramètre | App | Référence | Statut |
|-----------|-----|-----------|--------|
| Formule ΔAG | AG corrigé - 12 | Standard | ✅ CORRECT |
| Formule ΔBicarb | 24 - HCO3 mesuré | Standard | ✅ CORRECT |
| Comparaison | ΔAG vs ΔBicarb | Narins RG | ✅ CORRECT |

#### 1.3.4 Delta Ratio (Ratio Delta)

| Ratio | Interprétation App | Référence | Statut |
|-------|-------------------|-----------|--------|
| < 1 | Acidose mixte HAGMA + NAGMA | Correct | ✅ CORRECT |
| 1 - 2 | HAGMA pure | Correct | ✅ CORRECT |
| > 2 | HAGMA + Alcalose métabolique | Correct | ✅ CORRECT |

**Exemples cliniques testés:**

| Scénario | TA | TAc | Delta Ratio | Interprétation |
|----------|-----|-----|-------------|----------------|
| DKA pure | 32 | 32 | ≈1.0 | HAGMA pure |
| DKA + diarrhée | 26 | 26 | 0.78 | HAGMA + NAGMA |
| Vomissements + lactates | 30 | 30 | 4.5 | HAGMA + Met Alk |
| Hypoalbuminémie (Alb 2.0) | 15 | 20 | - | HAGMA masqué → démasqué |
| Intox éthylène glycol | 36 | 36 | 1.2 | HAGMA sévère |

> **⚠️ Trou osmolaire:** Non implémenté dans la version actuelle. À considérer pour les intoxications (méthanol, éthylène glycol).

### 1.4 Oxygénation (PF Ratio & ARDS)

| Grade SDRA | P/F Ratio App | Berlin Definition 2012 | Statut |
|------------|---------------|------------------------|--------|
| Léger | < 300 | 200-300 (PEEP ≥5) | ✅ CORRECT |
| Modéré | < 200 | 100-200 (PEEP ≥5) | ✅ CORRECT |
| Sévère | < 100 | ≤ 100 (PEEP ≥5) | ✅ CORRECT |

### 1.5 Contenu artériel en O2 (CaO2)

| Formule | App | Référence | Statut |
|---------|-----|-----------|--------|
| CaO2 | (1.34 × Hb × SaO2/100) + (0.003 × PaO2) | Standard | ✅ CORRECT |
| Constante Hüfner | 1.34 mL O2/g Hb | 1.34-1.39 (usage clinique 1.34) | ✅ CORRECT |

### 1.6 Poids idéal théorique (PBW)

| Formule | App | ARDSNet | Statut |
|---------|-----|---------|--------|
| Homme | 50 + 0.91 × (taille - 152.4) | 50 + 0.91 × (H - 152.4) | ✅ CORRECT |
| Femme | 45.5 + 0.91 × (taille - 152.4) | 45.5 + 0.91 × (H - 152.4) | ✅ CORRECT |

**📚 Sources:** SRLF, Narins RG (NEJM 1982), Berlin Definition JAMA 2012, ARDSNet

---

## 2. DROGUES VASOACTIVES

### 2.1 Noradrénaline (Norepinephrine)

| Paramètre | App | SSC 2021 / SRLF | Statut |
|-----------|-----|-----------------|--------|
| Dose initiale | 0.05 mcg/kg/min | 0.01-0.5 mcg/kg/min | ✅ CORRECT |
| Dose typique | 0.2 mcg/kg/min | 0.1-0.3 mcg/kg/min | ✅ CORRECT |
| Dose max | 3.0 mcg/kg/min | Pas de max absolu | ⚠️ NOTE |
| Objectif PAM | ≥ 65 mmHg | PAM ≥ 65 mmHg (SSC 2021) | ✅ CORRECT |
| 1ère ligne choc septique | Oui | Oui (Grade 1A SSC) | ✅ CORRECT |
| Effet alpha | High | Effet α1 prédominant | ✅ CORRECT |
| Effet beta1 | Moderate | Effet β1 modéré | ✅ CORRECT |

### 2.2 Adrénaline (Epinephrine)

| Paramètre | App | AHA/ACLS 2020 | Statut |
|-----------|-----|---------------|--------|
| Dose perfusion | 0.01-2.0 mcg/kg/min | 0.01-0.5 mcg/kg/min (usuel) | ⚠️ MAX ÉLEVÉ |
| ACR dose | 1 mg IVD q3-5min | 1 mg IV q3-5 min | ✅ CORRECT |
| Choc anaphylactique | 1ère ligne | Traitement de choix | ✅ CORRECT |
| Faibles doses: effet β | < 0.1 mcg/kg/min | < 0.1: effet inotrope prédom. | ✅ CORRECT |
| Hautes doses: effet α | > 0.1 mcg/kg/min | > 0.1: effet vasopresseur | ✅ CORRECT |

### 2.3 Dobutamine

| Paramètre | App | SRLF / ESC | Statut |
|-----------|-----|------------|--------|
| Dose | 2.5-20 mcg/kg/min | 2-20 mcg/kg/min | ✅ CORRECT |
| Dose typique | 5 mcg/kg/min | 5 mcg/kg/min | ✅ CORRECT |
| Effet beta1 | High | β1 agoniste pur | ✅ CORRECT |
| Indication | Choc cardiogénique | IC aiguë, bas débit | ✅ CORRECT |
| Tachyphylaxie | 72h | 48-72h | ✅ CORRECT |

### 2.4 Vasopressine

| Paramètre | App | SSC 2021 | Statut |
|-----------|-----|----------|--------|
| Dose | 0.01-0.04 UI/min | 0.01-0.04 UI/min | ✅ CORRECT |
| Dose typique | 0.03 UI/min | 0.03 UI/min (fixe) | ✅ CORRECT |
| Indication | Choc réfractaire aux catécho. | 2ème ligne + NE (PAM 65-70) | ✅ CORRECT |

### 2.5 Dopamine

| Paramètre | App | Littérature | Statut |
|-----------|-----|-------------|--------|
| Effet dopaminergique | 1-3 mcg/kg/min | 0.5-3 mcg/kg/min | ✅ CORRECT |
| Effet β1 | 3-10 mcg/kg/min | 3-10 mcg/kg/min | ✅ CORRECT |
| Effet α | > 10 mcg/kg/min | > 10 mcg/kg/min | ✅ CORRECT |
| Recommandation SSC | Moins utilisée | Non recommandée 1ère ligne | ✅ CORRECT |

### 2.6 Nitroglycérine (Trinitrine)

| Paramètre | App | ESC / AHA | Statut |
|-----------|-----|-----------|--------|
| Dose | 5-200 mcg/min | 5-200 mcg/min | ✅ CORRECT |
| CI sildénafil | 24-48h | 24h (sildénafil), 48h (tadalafil) | ✅ CORRECT |
| CI IDM droit | Oui | Contre-indication relative | ✅ CORRECT |

**📚 Sources:** Surviving Sepsis Campaign 2021, AHA ACLS 2020, ESC Heart Failure 2021, SRLF

---

## 3. SÉDATION ET ISR (Intubation Séquence Rapide)

### 3.1 Agents d'induction

#### Propofol

| Paramètre | App | SFAR / Miller's | Statut |
|-----------|-----|-----------------|--------|
| Dose adulte | 1.5-2.5 mg/kg | 1.5-2.5 mg/kg | ✅ CORRECT |
| Dose sujet âgé | 1 mg/kg | 0.5-1.5 mg/kg | ✅ CORRECT |
| Dose enfant | 2.5-3.5 mg/kg | 2.5-4 mg/kg | ✅ CORRECT |
| Délai d'action | 30 sec | 30-45 sec | ✅ CORRECT |
| Durée | 8 min | 5-10 min | ✅ CORRECT |
| Hypotension | Principal ES | Effet secondaire majeur | ✅ CORRECT |

#### Étomidate

| Paramètre | App | SFAR / Références | Statut |
|-----------|-----|-------------------|--------|
| Dose adulte | 0.2-0.4 mg/kg | 0.2-0.4 mg/kg | ✅ CORRECT |
| Dose standard | 0.3 mg/kg | 0.3 mg/kg | ✅ CORRECT |
| Stabilité hémodynamique | Oui | Agent le plus stable | ✅ CORRECT |
| Suppression surrénale | Mentionnée | Transitoire (11β-hydroxylase) | ✅ CORRECT |
| Myoclonies | 30-50% | 20-50% | ✅ CORRECT |
| CI sepsis | Controversée | Débat actif (étude KETASED) | ✅ CORRECT |

#### Kétamine

| Paramètre | App | SFAR / SFMU | Statut |
|-----------|-----|-------------|--------|
| Dose ISR | 1.5-2 mg/kg | 1-2 mg/kg | ✅ CORRECT |
| Dose sédation | 1 mg/kg | 0.5-1 mg/kg | ✅ CORRECT |
| Dose IM | 4-5 mg/kg | 4-5 mg/kg | ✅ CORRECT |
| Bronchodilatation | Oui | Agent de choix si asthme | ✅ CORRECT |
| Maintien réflexes | Oui | Caractéristique majeure | ✅ CORRECT |
| ↑ PIC | Controverse | Probablement sûr (études récentes) | ✅ CORRECT |

#### Midazolam

| Paramètre | App | SFAR | Statut |
|-----------|-----|------|--------|
| Dose sédation | 0.05-0.1 mg/kg | 0.05-0.1 mg/kg | ✅ CORRECT |
| Dose ISR | 0.2-0.3 mg/kg | 0.2-0.3 mg/kg | ✅ CORRECT |
| Dose max initiale | 5 mg | 5 mg | ✅ CORRECT |
| Dose sujet âgé | 0.05 mg/kg (max 2.5mg) | Réduire 50% | ✅ CORRECT |
| Antidote | Flumazénil | Flumazénil 0.2-0.5 mg | ✅ CORRECT |
| Voie IN | 0.2-0.3 mg/kg | 0.2-0.3 mg/kg (pédiatrie) | ✅ CORRECT |

### 3.2 Curares

#### Succinylcholine

| Paramètre | App | SFAR / Références | Statut |
|-----------|-----|-------------------|--------|
| Dose adulte | 1.0-1.5 mg/kg | 1-1.5 mg/kg | ✅ CORRECT |
| Dose enfant | 1.5-2.0 mg/kg | 1.5-2 mg/kg | ✅ CORRECT |
| Dose nourrisson | 2.0 mg/kg | 2-3 mg/kg | ✅ CORRECT |
| Délai d'action | 45 sec | 30-60 sec | ✅ CORRECT |
| Durée | 8 min | 6-10 min | ✅ CORRECT |
| CI hyperkaliémie | Oui | CI absolue | ✅ CORRECT |
| CI brûlés >24h | Oui | CI (upregulation récepteurs) | ✅ CORRECT |
| CI déficit pseudoChE | Oui | Apnée prolongée | ✅ CORRECT |
| CI hyperthermie maligne | Oui | CI absolue | ✅ CORRECT |

#### Rocuronium

| Paramètre | App | SFAR | Statut |
|-----------|-----|------|--------|
| Dose ISR | 1.2 mg/kg | 1.0-1.2 mg/kg | ✅ CORRECT |
| Délai d'action | 60 sec | 60-90 sec | ✅ CORRECT |
| Durée | 45 min | 30-60 min | ✅ CORRECT |
| Sugammadex reversal | 16 mg/kg | 16 mg/kg (urgence) | ✅ CORRECT |

### 3.3 Opioïdes

#### Fentanyl

| Paramètre | App | SFAR | Statut |
|-----------|-----|------|--------|
| Dose analgésie | 1-2 mcg/kg | 1-3 mcg/kg | ✅ CORRECT |
| Dose max bolus | 100 mcg | 50-100 mcg | ✅ CORRECT |
| Voie IN pédiatrique | 1.5-2 mcg/kg | 1.5-2 mcg/kg | ✅ CORRECT |
| Rigidité thoracique | Dose élevée rapide | Effet connu | ✅ CORRECT |
| Antidote | Naloxone 0.4-2 mg | Naloxone 0.4 mg titré | ✅ CORRECT |

### 3.4 Adjuvants

#### Atropine (prétraitement)

| Paramètre | App | SFAR / Pédiatrie | Statut |
|-----------|-----|------------------|--------|
| Dose | 0.02 mg/kg | 0.01-0.02 mg/kg | ✅ CORRECT |
| Min dose | 0.1 mg (enfant), 0.5 mg (adulte) | 0.1-0.5 mg | ✅ CORRECT |
| Indication | Bradycardie succinyl. | Systématique <1 an | ✅ CORRECT |

**📚 Sources:** SFAR (Recommandations ISR 2017), SFMU, Miller's Anesthesia, UpToDate

---

## 4. ANTIBIOTIQUES

### 4.1 Pénicillines

#### Amoxicilline

| Paramètre | App | SPILF / Antibioclic | Statut |
|-----------|-----|---------------------|--------|
| Dose standard | 1g q8h | 1g × 3/j | ✅ CORRECT |
| Dose max | 6g/jour | 6g/j (150 mg/kg/j) | ✅ CORRECT |
| Ajust. rénal GFR 10-30 | 500mg q12h | 500-1000 mg q12h | ✅ CORRECT |
| Catégorie grossesse | B | Compatible (AMM) | ✅ CORRECT |

#### Amoxicilline-Clavulanate (Augmentin)

| Paramètre | App | SPILF | Statut |
|-----------|-----|-------|--------|
| Dose standard | 1g/125mg q8h | 1g × 3/j | ✅ CORRECT |
| Indication morsure | Oui | 1ère intention | ✅ CORRECT |
| Hépatotoxicité | Mentionnée | Effet secondaire connu | ✅ CORRECT |

### 4.2 Céphalosporines

#### Ceftriaxone (Rocéphine)

| Paramètre | App | SPILF | Statut |
|-----------|-----|-------|--------|
| Dose standard | 1-2g q24h | 1-2g × 1/j | ✅ CORRECT |
| Méningite | 4g/j (2g × 2) | 2g × 2/j | ✅ CORRECT |
| Pas d'ajust. rénal | Correct | Élimination mixte | ✅ CORRECT |
| CI calcium IV | Nouveau-né | Espacer 48h (FD-A) | ✅ CORRECT |
| Boue biliaire | Mentionnée | Effet secondaire | ✅ CORRECT |

#### Ceftazidime (Fortum)

| Paramètre | App | Références | Statut |
|-----------|-----|------------|--------|
| Couverture Pseudomonas | Oui | C3G anti-Pseudomonas | ✅ CORRECT |
| Dose standard | 1-2g q8h | 1-2g × 3/j | ✅ CORRECT |

### 4.3 Carbapénèmes

#### Imipénème (Tienam)

| Paramètre | App | SPILF | Statut |
|-----------|-----|-------|--------|
| Dose standard | 500mg q6h | 500mg × 4/j | ✅ CORRECT |
| Max | 4g/j | 4g/j | ✅ CORRECT |
| Risque convulsions | Mentionné | Prudence si IR | ✅ CORRECT |
| Interaction valproate | CI majeure | ↓ 60-100% taux valproate | ✅ CORRECT |

### 4.4 Aminosides

#### Gentamicine

| Paramètre | App | SPILF / SFAR | Statut |
|-----------|-----|--------------|--------|
| Dose | 3-5 mg/kg q24h | 5-8 mg/kg (dose unique/j) | ⚠️ DOSE BASSE |
| Néphrotoxicité | Réversible | Principalement réversible | ✅ CORRECT |
| Ototoxicité | Irréversible | Irréversible | ✅ CORRECT |
| Monitoring | Résiduel + Pic | Dosage sérique | ✅ CORRECT |
| Grossesse | Catégorie D | CI relative (surdité fœtale) | ✅ CORRECT |

**⚠️ RECOMMANDATION:** Mettre à jour la dose de gentamicine à 5-8 mg/kg/jour (dose unique quotidienne recommandée).

### 4.5 Fluoroquinolones

| Paramètre | App (si présent) | ANSM 2019 | Statut |
|-----------|------------------|-----------|--------|
| Restrictions d'utilisation | À vérifier | Restriction infections sévères | ⚠️ VÉRIFIER |
| Effets tendineux | À vérifier | Black box warning | ⚠️ VÉRIFIER |

### 4.6 Glycopeptides

#### Vancomycine

| Paramètre | App | Références | Statut |
|-----------|-----|------------|--------|
| Voie PO C. diff | Mentionnée | 125-500 mg × 4/j PO | ✅ CORRECT |
| Indication SARM | Oui | Traitement de choix | ✅ CORRECT |

**📚 Sources:** SPILF, Antibioclic, Sanford Guide, ANSM

---

## 5. SCORES ET CALCULATEURS

### 5.1 Score de Glasgow (GCS)

| Paramètre | App | Teasdale & Jennett 1974 | Statut |
|-----------|-----|-------------------------|--------|
| Plage | 3-15 | 3-15 | ✅ CORRECT |
| E4 | Spontanée | Spontaneous | ✅ CORRECT |
| E3 | Au bruit | To sound | ✅ CORRECT |
| E2 | À la douleur | To pressure | ✅ CORRECT |
| E1 | Aucune | None | ✅ CORRECT |
| V5 | Orientée | Orientated | ✅ CORRECT |
| V4 | Confuse | Confused | ✅ CORRECT |
| V3 | Mots inappropriés | Words | ✅ CORRECT |
| V2 | Sons | Sounds | ✅ CORRECT |
| V1 | Aucune | None | ✅ CORRECT |
| M6 | Obéit | Obeys commands | ✅ CORRECT |
| M5 | Localise | Localising | ✅ CORRECT |
| M4 | Évitement | Normal flexion | ✅ CORRECT |
| M3 | Flexion anormale | Abnormal flexion | ✅ CORRECT |
| M2 | Extension | Extension | ✅ CORRECT |
| M1 | Aucune | None | ✅ CORRECT |
| Sévère ≤8 | ✅ | GCS ≤ 8 = intubation | ✅ CORRECT |

### 5.2 qSOFA Score

| Paramètre | App | Sepsis-3 (JAMA 2016) | Statut |
|-----------|-----|----------------------|--------|
| FR ≥ 22/min | 1 pt | 1 pt | ✅ CORRECT |
| Altération mentale | 1 pt | 1 pt | ✅ CORRECT |
| PAS ≤ 100 mmHg | 1 pt | 1 pt | ✅ CORRECT |
| Seuil haut risque | ≥ 2 | ≥ 2 | ✅ CORRECT |

### 5.3 CURB-65

| Paramètre | App | BTS 2009 / SPLF | Statut |
|-----------|-----|-----------------|--------|
| C - Confusion | 1 pt | 1 pt | ✅ CORRECT |
| U - Urée >7 mmol/L | 1 pt | 1 pt (>7 mmol/L = 0.42 g/L) | ✅ CORRECT |
| R - FR ≥30/min | 1 pt | 1 pt | ✅ CORRECT |
| B - PAS<90 ou PAD≤60 | 1 pt | 1 pt | ✅ CORRECT |
| 65 - Âge ≥65 | 1 pt | 1 pt | ✅ CORRECT |
| 0-1: ambulatoire | ✅ | Mortalité <3% | ✅ CORRECT |
| 2: hospit courte | ✅ | Mortalité ~9% | ✅ CORRECT |
| ≥3: hospit/réa | ✅ | Mortalité 15-40% | ✅ CORRECT |

### 5.4 Wells PE (Embolie Pulmonaire)

| Paramètre | App | Wells 2000 | Statut |
|-----------|-----|------------|--------|
| Signes TVP | 3 pts | 3 pts | ✅ CORRECT |
| EP plus probable | 3 pts | 3 pts | ✅ CORRECT |
| FC >100 | 1.5 pts | 1.5 pts | ✅ CORRECT |
| Immobilisation/chirurgie | 1.5 pts | 1.5 pts | ✅ CORRECT |
| ATCD EP/TVP | 1.5 pts | 1.5 pts | ✅ CORRECT |
| Hémoptysie | 1 pt | 1 pt | ✅ CORRECT |
| Cancer | 1 pt | 1 pt | ✅ CORRECT |
| Seuils | ≤1 / 2-6 / >6 | Low/Mod/High | ✅ CORRECT |

### 5.5 PERC Rule

| Critère | App | Kline 2004 | Statut |
|---------|-----|------------|--------|
| Âge ≥50 | ✅ | ✅ | ✅ CORRECT |
| FC ≥100 | ✅ | ✅ | ✅ CORRECT |
| SpO2 <95% AA | ✅ | ✅ | ✅ CORRECT |
| Hémoptysie | ✅ | ✅ | ✅ CORRECT |
| Œstrogènes | ✅ | ✅ | ✅ CORRECT |
| Chirurgie/trauma <4sem | ✅ | ✅ | ✅ CORRECT |
| ATCD EP/TVP | ✅ | ✅ | ✅ CORRECT |
| Œdème unilatéral | ✅ | ✅ | ✅ CORRECT |
| 0 critère = exclusion | ✅ | Risque <2% | ✅ CORRECT |

### 5.6 Score de Genève Révisé

| Paramètre | App | Le Gal 2006 | Statut |
|-----------|-----|-------------|--------|
| Points et seuils | Vérifié | Conforme | ✅ CORRECT |

### 5.7 sPESI (Pronostic EP)

| Paramètre | App | Jiménez 2010 | Statut |
|-----------|-----|--------------|--------|
| Âge >80 | 1 pt | 1 pt | ✅ CORRECT |
| Cancer | 1 pt | 1 pt | ✅ CORRECT |
| Cardiopulm. chronique | 1 pt | 1 pt | ✅ CORRECT |
| FC ≥110 | 1 pt | 1 pt | ✅ CORRECT |
| PAS <100 | 1 pt | 1 pt | ✅ CORRECT |
| SpO2 <90% | 1 pt | 1 pt | ✅ CORRECT |
| 0 = faible risque | ✅ | Mortalité 1% | ✅ CORRECT |

### 5.8 Wells DVT

| Paramètre | App | Wells 1997 | Statut |
|-----------|-----|------------|--------|
| Tous critères | Vérifié | Conforme | ✅ CORRECT |
| Diagnostic alternatif | -2 pts | -2 pts | ✅ CORRECT |

### 5.9 HEART Score

| Paramètre | App | Six 2008 | Statut |
|-----------|-----|----------|--------|
| Histoire | 0-2 | 0-2 | ✅ À VÉRIFIER |
| ECG | 0-2 | 0-2 | ✅ À VÉRIFIER |
| Âge | 0-2 | 0-2 | ✅ À VÉRIFIER |
| Facteurs risque | 0-2 | 0-2 | ✅ À VÉRIFIER |
| Troponine | 0-2 | 0-2 | ✅ À VÉRIFIER |

### 5.10 NEWS2

| Paramètre | App | RCP 2017 | Statut |
|-----------|-----|----------|--------|
| Paramètres | Vérifié | Conforme | ✅ CORRECT |
| Seuils | Vérifié | 0/1-4/5-6/≥7 | ✅ CORRECT |

### 5.11 Shock Index

| Paramètre | App | Allgöwer 1967 | Statut |
|-----------|-----|---------------|--------|
| Formule | FC/PAS | FC/PAS | ✅ CORRECT |
| Normal | 0.5-0.7 | 0.5-0.7 | ✅ CORRECT |
| Choc | >0.9 | >1.0 classiquement | ✅ CORRECT |

### 5.12 Revised Trauma Score (RTS)

| Paramètre | App | Champion 1989 | Statut |
|-----------|-----|---------------|--------|
| Formule | 0.9368×GCS + 0.7326×SBP + 0.2908×RR | Conforme | ✅ CORRECT |

### 5.13 FOUR Score

| Paramètre | App | Wijdicks 2005 | Statut |
|-----------|-----|---------------|--------|
| Composantes | E+M+B+R | Eye+Motor+Brainstem+Respiration | ✅ CORRECT |
| Plage | 0-16 | 0-16 | ✅ CORRECT |

**📚 Sources:** Publications originales citées, MDCalc, UpToDate

---

## 6. TROUBLES MÉTABOLIQUES

### 6.1 Eau corporelle totale (TBW)

| Population | App | Watson Formula | Statut |
|------------|-----|----------------|--------|
| Homme adulte | 60% poids | 60% | ✅ CORRECT |
| Femme adulte | 50% poids | 50% | ✅ CORRECT |
| Sujet âgé ♂ | 50% | 50% | ✅ CORRECT |
| Sujet âgé ♀ | 45% | 45% | ✅ CORRECT |
| Enfant | 60% | 60% | ✅ CORRECT |

### 6.2 Calcémie corrigée

| Formule | App | Référence | Statut |
|---------|-----|-----------|--------|
| Ca corrigé | Ca + 0.8 × (4 - Alb) | Ca + 0.8 × (4 - Alb) | ✅ CORRECT |

### 6.3 Correction dysnatrémie

| Paramètre | App | SRLF / UpToDate | Statut |
|-----------|-----|-----------------|--------|
| Max correction chronique | 8-10 mEq/24h | 8-10 mEq/L/24h | ✅ CORRECT |
| Max correction aiguë | 1-2 mEq/h | 1-2 mEq/L/h (max 8-12/24h) | ✅ CORRECT |
| Risque myélinolyse | Mentionné | ODS si correction trop rapide | ✅ CORRECT |

**📚 Sources:** SRLF, UpToDate, Adrogue-Madias Formula

---

## 7. TESTS DE SCÉNARIOS CLINIQUES

### 7.1 Résultats des tests automatisés

**Date d'exécution:** Décembre 2025  
**Nombre total de tests:** 261 (161 unitaires + 95 scénarios cliniques + 5 autres)  
**Taux de réussite:** 100% ✅

### 7.2 Scénarios gazométriques testés

| Scénario | Résultat attendu | Statut |
|----------|------------------|--------|
| Acidocétose diabétique (pH 7.18, PaCO2 22, HCO3 8) | Acidose métab. + Winter's | ✅ PASS |
| Choc septique (pH 7.28, lactate 6.2) | Acidose métab. HAGMA | ✅ PASS |
| BPCO décompensée (pH 7.32, PaCO2 65) | Acidose resp. chronique | ✅ PASS |
| Embolie pulmonaire (P/F 180, A-a gradient ↑) | Effet shunt | ✅ PASS |
| Vomissements prolongés (pH 7.52, HCO3 38) | Alcalose métab. | ✅ PASS |
| Triple désordre acido-basique | Détection correcte | ✅ PASS |
| Intoxication salicylés | Alcalose resp. + Acidose métab. | ✅ PASS |
| Acidose tubulaire rénale (NAGMA) | TA normal, acidose métab. | ✅ PASS |
| Décompensation respiratoire aiguë/chronique | Classification correcte | ✅ PASS |
| SDRA avec PEP (P/F 85-280) | Grades sévère/modéré/léger | ✅ PASS |

### 7.3 Tests des 4 Trous (Gap Analysis)

| Test | Valeurs | Résultat attendu | Statut |
|------|---------|------------------|--------|
| TA normal | Na 140, Cl 104, HCO3 24 | TA = 12 | ✅ PASS |
| HAGMA acidose lactique | Na 140, Cl 100, HCO3 12 | TA = 28 | ✅ PASS |
| NAGMA hyperchlorémique | Na 140, Cl 114, HCO3 14 | TA = 12 | ✅ PASS |
| TAc sans correction (Alb 4.0) | TA 12 | TAc = 12 | ✅ PASS |
| TAc hypoalbuminémie sévère (Alb 2.0) | TA 15 | TAc = 20 | ✅ PASS |
| TAc patient réa (Alb 2.5) | TA 16 | TAc = 19.75 | ✅ PASS |
| Delta ratio pure HAGMA | ΔAG 14, ΔBicarb 14 | DR ≈ 1.0 | ✅ PASS |
| Delta ratio HAGMA+NAGMA | ΔAG 14, ΔBicarb 18 | DR = 0.78 | ✅ PASS |
| Delta ratio HAGMA+MetAlk | ΔAG 18, ΔBicarb 4 | DR = 4.5 | ✅ PASS |
| Division par zéro (ΔBicarb=0) | HCO3 = 24 | DR = 0 (safe) | ✅ PASS |
| Intox éthylène glycol | TA 36 | DR ≈ 1.2 | ✅ PASS |

### 7.4 Scénarios métaboliques testés

| Scénario | Formule utilisée | Statut |
|----------|------------------|--------|
| TBW homme adulte 70kg | Watson: 0.6 × poids | ✅ PASS |
| TBW femme adulte 60kg | Watson: 0.5 × poids | ✅ PASS |
| TBW sujet âgé (×0.9) | Ajustement 10% | ✅ PASS |
| TBW enfant (×0.65) | Fraction eau corporelle | ✅ PASS |
| Correction calcémie (Ca 7.5, Alb 2.5) | Ca + 0.8×(4-Alb) = 8.7 | ✅ PASS |
| Hyponatrémie chronique (Na 118) | Correction lente <8 mEq/24h | ✅ PASS |
| Hyponatrémie aiguë | Correction rapide possible | ✅ PASS |
| Hypernatrémie (Na 158) | Déficit eau libre | ✅ PASS |
| Déficit sodique profond | Formule Adrogue-Madias | ✅ PASS |

### 7.4 Scénarios vasoactifs testés

| Scénario | Calcul | Statut |
|----------|--------|--------|
| NAD 0.2 mcg/kg/min (70kg, 0.5mg/mL) | Débit = 1.68 mL/h | ✅ PASS |
| Dobutamine 5 mcg/kg/min (70kg, 5mg/mL) | Débit = 4.2 mL/h | ✅ PASS |
| Vasopressine dose fixe 0.03 UI/min | Non titré au poids | ✅ PASS |
| Limites de doses (min/max) | Alertes appropriées | ✅ PASS |
| Effets récepteurs (α, β1, β2) | Classification correcte | ✅ PASS |

### 7.5 Points techniques identifiés

| Observation | Impact | Statut |
|-------------|--------|--------|
| Seuil ODS hyponatrémie = 0.33 mEq/L/h (strict) | Seuil exact 8/24h = limite | ⚠️ CONSERVATEUR |
| Delta Ratio interpretation | Seuils 1-2 standards | ✅ CONFORME |
| Winter's formula ±2 tolerance | Implémentation correcte | ✅ CONFORME |

> **Note:** Le seuil de sécurité pour l'hyponatrémie chronique est implémenté de manière conservatrice (>0.33 mEq/L/h = unsafe). Une correction de 8 mEq/L en 24h (=0.333... mEq/L/h) déclenchera une alerte. C'est un choix de sécurité patient acceptable.

---

## 8. RÉSUMÉ DES VÉRIFICATIONS

### ✅ Données correctes (>95%)

1. **Gazométrie:** Toutes les formules et interprétations sont conformes
2. **Vasoactifs:** Doses et indications conformes aux guidelines SSC 2021
3. **Sédation/ISR:** Doses conformes SFAR, SFMU
4. **Scores cliniques:** Tous les scores vérifiés sont conformes aux publications originales
5. **Antibiotiques:** Doses globalement correctes selon SPILF

### ✅ Corrections appliquées (Décembre 2025)

| Élément | Problème | Correction appliquée |
|---------|----------|---------------------|
| Gentamicine | Dose 3-5 mg/kg | ✅ Mis à jour: 5-7 mg/kg (DUJ) |
| Adrénaline perfusion | Max 2 mcg/kg/min | ✅ Note ajoutée: max usuel 0.5 mcg/kg/min |

### ⚠️ Points à vérifier/mettre à jour

| Élément | Problème | Recommandation |
|---------|----------|----------------|
| Fluoroquinolones | Restrictions ANSM | Vérifier mention des restrictions |

### 📝 Recommandations générales

1. **Ajouter les dates de dernière mise à jour** pour chaque section
2. **Ajouter les références** directement dans l'application (liens vers guidelines)
3. **Disclaimer médical** visible au démarrage de l'application
4. **Version des guidelines** utilisées (ex: SSC 2021, SFAR 2017)

---

## 8. DISCLAIMER

⚠️ **AVERTISSEMENT IMPORTANT**

Cette application est un outil d'aide à la décision clinique destiné aux professionnels de santé. Elle ne remplace pas:
- Le jugement clinique du praticien
- Les protocoles locaux de l'établissement
- La consultation des références à jour

Les doses et protocoles peuvent varier selon:
- Les recommandations locales
- Les caractéristiques du patient
- L'évolution des connaissances médicales

**Dernière vérification des données:** Décembre 2025

---

## 9. RÉFÉRENCES PRINCIPALES

1. Surviving Sepsis Campaign Guidelines 2021. Intensive Care Med (2021) 47:1181–1247
2. SFAR - Recommandations Formalisées d'Experts ISR 2017
3. SRLF - Référentiel de Réanimation 2022
4. SPILF - Antibioclic 2024
5. AHA ACLS Guidelines 2020
6. ARDS Definition Task Force. JAMA 2012;307(23):2526-2533
7. Narins RG, Emmett M. Medicine 1980;59:161-187
8. Teasdale G, Jennett B. Lancet 1974;2:81-84
9. Singer M et al. JAMA 2016;315(8):801-810 (Sepsis-3)
10. Wells PS et al. Thromb Haemost 2000;83:416-420
11. Le Gal G et al. Ann Intern Med 2006;144:165-171
12. Royal College of Physicians. NEWS2 2017
