import 'dart:math';
import 'package:flutter/material.dart';
import '../../domain/entities/calculator.dart';

final List<Calculator> allCalculators = [
  // Trauma
  Calculator(
    id: 'gcs',
    name: 'Glasgow Coma Scale (GCS)',
    shortName: 'GCS',
    category: CalculatorCategory.trauma,
    description: 'Évaluation standardisée du niveau de conscience',
    fields: [
      const CalculatorField(
        id: 'eye',
        label: 'Réponse oculaire (E)',
        type: CalculatorFieldType.select,
        options: [
          CalculatorOption(value: 4, label: 'Spontanée', description: 'Yeux ouverts spontanément'),
          CalculatorOption(value: 3, label: 'Au bruit', description: 'Ouverture à l\'appel ou au bruit'),
          CalculatorOption(value: 2, label: 'À la douleur', description: 'Ouverture à la stimulation douloureuse'),
          CalculatorOption(value: 1, label: 'Aucune', description: 'Pas d\'ouverture des yeux'),
        ],
      ),
      const CalculatorField(
        id: 'verbal',
        label: 'Réponse verbale (V)',
        type: CalculatorFieldType.select,
        options: [
          CalculatorOption(value: 5, label: 'Orientée', description: 'Orienté dans le temps, l\'espace et la personne'),
          CalculatorOption(value: 4, label: 'Confuse', description: 'Conversation confuse mais répond aux questions'),
          CalculatorOption(value: 3, label: 'Mots inappropriés', description: 'Mots incohérents, discours reconnaissable'),
          CalculatorOption(value: 2, label: 'Sons incompréhensibles', description: 'Sons ou gémissements incompréhensibles'),
          CalculatorOption(value: 1, label: 'Aucune', description: 'Pas de réponse verbale'),
        ],
      ),
      const CalculatorField(
        id: 'motor',
        label: 'Réponse motrice (M)',
        type: CalculatorFieldType.select,
        options: [
          CalculatorOption(value: 6, label: 'Obéit aux ordres', description: 'Exécute les ordres simples'),
          CalculatorOption(value: 5, label: 'Localise la douleur', description: 'Mouvement dirigé vers le stimulus'),
          CalculatorOption(value: 4, label: 'Évitement', description: 'Retrait à la douleur'),
          CalculatorOption(value: 3, label: 'Flexion anormale', description: 'Décortication'),
          CalculatorOption(value: 2, label: 'Extension', description: 'Décérébration'),
          CalculatorOption(value: 1, label: 'Aucune', description: 'Pas de réponse motrice'),
        ],
      ),
    ],
    calculate: (values) {
      return (values['eye'] as double) + (values['verbal'] as double) + (values['motor'] as double);
    },
    interpretations: [
      const ScoreInterpretation(min: 15, max: 15, label: 'Normal', description: 'Conscience normale', color: Colors.green),
      const ScoreInterpretation(min: 13, max: 14, label: 'Léger', description: 'Traumatisme crânien léger', color: Colors.yellow),
      const ScoreInterpretation(min: 9, max: 12, label: 'Modéré', description: 'Traumatisme crânien modéré', color: Colors.orange),
      const ScoreInterpretation(min: 3, max: 8, label: 'Sévère', description: 'Traumatisme crânien sévère - Intubation recommandée', color: Colors.red),
    ],
    source: 'Teasdale G, Jennett B. Lancet 1974',
    sourceUrl: 'https://pubmed.ncbi.nlm.nih.gov/4136544/',
  ),
  Calculator(
    id: 'shock-index',
    name: 'Indice de Choc',
    shortName: 'SI',
    category: CalculatorCategory.trauma,
    description: 'Détection précoce du choc occulte (FC/PAS)',
    fields: [
      const CalculatorField(
        id: 'heartRate',
        label: 'Fréquence Cardiaque',
        type: CalculatorFieldType.number,
        min: 30,
        max: 250,
        unit: 'bpm',
      ),
      const CalculatorField(
        id: 'systolicBP',
        label: 'PA Systolique',
        type: CalculatorFieldType.number,
        min: 40,
        max: 250,
        unit: 'mmHg',
      ),
    ],
    calculate: (values) {
      final hr = values['heartRate'] as double? ?? 0;
      final sbp = values['systolicBP'] as double? ?? 0;
      if (sbp == 0) return 0;
      return double.parse(((hr / sbp)).toStringAsFixed(2));
    },
    interpretations: [
      const ScoreInterpretation(min: 0, max: 0.5, label: 'Bas Normal', description: 'Pas de signe de choc', color: Colors.green),
      const ScoreInterpretation(min: 0.5, max: 0.7, label: 'Normal', description: 'Valeur normale', color: Colors.green),
      const ScoreInterpretation(min: 0.7, max: 0.9, label: 'Élevé', description: 'Choc compensé possible', color: Colors.yellow),
      const ScoreInterpretation(min: 0.9, max: 1.1, label: 'Haut', description: 'Choc probable - Envisager transfusion massive', color: Colors.orange),
      const ScoreInterpretation(min: 1.1, max: 10, label: 'Critique', description: 'Choc sévère - Réanimation urgente', color: Colors.red),
    ],
    source: 'Allgöwer M, Burri C. Dtsch Med Wochenschr 1967',
    sourceUrl: 'https://pubmed.ncbi.nlm.nih.gov/4860946/',
  ),
  Calculator(
    id: 'rts',
    name: 'Revised Trauma Score (RTS)',
    shortName: 'RTS',
    category: CalculatorCategory.trauma,
    description: 'Score de triage pour orientation vers centre de traumatologie',
    fields: [
      const CalculatorField(
        id: 'gcs',
        label: 'Glasgow Coma Scale',
        type: CalculatorFieldType.select,
        options: [
          CalculatorOption(value: 4, label: '13-15'),
          CalculatorOption(value: 3, label: '9-12'),
          CalculatorOption(value: 2, label: '6-8'),
          CalculatorOption(value: 1, label: '4-5'),
          CalculatorOption(value: 0, label: '3'),
        ],
      ),
      const CalculatorField(
        id: 'sbp',
        label: 'PA Systolique',
        type: CalculatorFieldType.select,
        options: [
          CalculatorOption(value: 4, label: '> 89 mmHg'),
          CalculatorOption(value: 3, label: '76-89 mmHg'),
          CalculatorOption(value: 2, label: '50-75 mmHg'),
          CalculatorOption(value: 1, label: '1-49 mmHg'),
          CalculatorOption(value: 0, label: '0 mmHg'),
        ],
      ),
      const CalculatorField(
        id: 'rr',
        label: 'Fréquence Respiratoire',
        type: CalculatorFieldType.select,
        options: [
          CalculatorOption(value: 4, label: '10-29/min'),
          CalculatorOption(value: 3, label: '> 29/min'),
          CalculatorOption(value: 2, label: '6-9/min'),
          CalculatorOption(value: 1, label: '1-5/min'),
          CalculatorOption(value: 0, label: '0/min'),
        ],
      ),
    ],
    calculate: (values) {
      final gcs = values['gcs'] as double? ?? 0;
      final sbp = values['sbp'] as double? ?? 0;
      final rr = values['rr'] as double? ?? 0;
      return double.parse((0.9368 * gcs + 0.7326 * sbp + 0.2908 * rr).toStringAsFixed(2));
    },
    interpretations: [
      const ScoreInterpretation(min: 7.84, max: 8, label: 'Excellent', description: 'Pronostic excellent', color: Colors.green),
      const ScoreInterpretation(min: 6, max: 7.84, label: 'Bon', description: 'Pronostic favorable', color: Colors.yellow),
      const ScoreInterpretation(min: 4, max: 6, label: 'Modéré', description: 'Centre de traumatologie recommandé', color: Colors.orange),
      const ScoreInterpretation(min: 0, max: 4, label: 'Critique', description: 'Pronostic défavorable - Trauma Center niveau 1', color: Colors.red),
    ],
    source: 'Champion HR et al. J Trauma 1989',
    sourceUrl: 'https://pubmed.ncbi.nlm.nih.gov/2716524/',
  ),
  Calculator(
    id: 'four-score',
    name: 'FOUR Score',
    shortName: 'FOUR',
    category: CalculatorCategory.trauma,
    description: 'Alternative au GCS pour patients intubés - Full Outline of UnResponsiveness',
    fields: [
      const CalculatorField(
        id: 'eye',
        label: 'Réponse oculaire',
        type: CalculatorFieldType.select,
        options: [
          CalculatorOption(value: 4, label: 'Paupières ouvertes, poursuite', description: 'Paupières ouvertes, suit du regard'),
          CalculatorOption(value: 3, label: 'Paupières ouvertes, pas de poursuite', description: 'Paupières ouvertes, pas de poursuite'),
          CalculatorOption(value: 2, label: 'Ouverture à la voix forte', description: 'Paupières fermées, ouverture à la voix forte'),
          CalculatorOption(value: 1, label: 'Ouverture à la douleur', description: 'Paupières fermées, ouverture à la douleur'),
          CalculatorOption(value: 0, label: 'Pas d\'ouverture', description: 'Paupières fermées malgré la douleur'),
        ],
      ),
      const CalculatorField(
        id: 'motor',
        label: 'Réponse motrice',
        type: CalculatorFieldType.select,
        options: [
          CalculatorOption(value: 4, label: 'Pouce levé, poing, signe V', description: 'Exécute des ordres simples'),
          CalculatorOption(value: 3, label: 'Localise la douleur', description: 'Localise la douleur'),
          CalculatorOption(value: 2, label: 'Flexion à la douleur', description: 'Flexion à la douleur'),
          CalculatorOption(value: 1, label: 'Extension à la douleur', description: 'Extension à la douleur'),
          CalculatorOption(value: 0, label: 'Aucune réponse / myoclonies', description: 'Pas de réponse ou myoclonies généralisées'),
        ],
      ),
      const CalculatorField(
        id: 'brainstem',
        label: 'Réflexes du tronc cérébral',
        type: CalculatorFieldType.select,
        options: [
          CalculatorOption(value: 4, label: 'Pupilles et cornéens présents', description: 'Réflexes pupillaires et cornéens présents'),
          CalculatorOption(value: 3, label: 'Une pupille fixe et dilatée', description: 'Une pupille large et fixe'),
          CalculatorOption(value: 2, label: 'Pupilles OU cornéens absents', description: 'Réflexe pupillaire OU cornéen absent'),
          CalculatorOption(value: 1, label: 'Pupilles ET cornéens absents', description: 'Réflexes pupillaires ET cornéens absents'),
          CalculatorOption(value: 0, label: 'Tous réflexes absents', description: 'Pupilles, cornéens ET toux absents'),
        ],
      ),
      const CalculatorField(
        id: 'respiration',
        label: 'Respiration',
        type: CalculatorFieldType.select,
        options: [
          CalculatorOption(value: 4, label: 'Régulière, non intubé', description: 'Respiration régulière, non intubé'),
          CalculatorOption(value: 3, label: 'Cheyne-Stokes', description: 'Respiration de Cheyne-Stokes'),
          CalculatorOption(value: 2, label: 'Irrégulière', description: 'Respiration irrégulière'),
          CalculatorOption(value: 1, label: 'Intubé, cycles spontanés', description: 'Intubé, respire au-dessus du ventilateur'),
          CalculatorOption(value: 0, label: 'Intubé, pas de cycles / Apnée', description: 'Intubé, respire au rythme du ventilateur / Apnée'),
        ],
      ),
    ],
    calculate: (values) {
      return (values['eye'] as double) + (values['motor'] as double) + 
             (values['brainstem'] as double) + (values['respiration'] as double);
    },
    interpretations: [
      const ScoreInterpretation(min: 16, max: 16, label: 'Normal', description: 'Conscience normale', color: Colors.green),
      const ScoreInterpretation(min: 12, max: 15, label: 'Altéré', description: 'Altération modérée', color: Colors.yellow),
      const ScoreInterpretation(min: 8, max: 11, label: 'Sévère', description: 'Altération sévère', color: Colors.orange),
      const ScoreInterpretation(min: 0, max: 7, label: 'Critique', description: 'Coma profond - Rechercher engagement', color: Colors.red),
    ],
    source: 'Wijdicks EF et al. Ann Neurol 2005',
    sourceUrl: 'https://pubmed.ncbi.nlm.nih.gov/15984004/',
  ),
  Calculator(
    id: 'qsofa',
    name: 'qSOFA Score',
    shortName: 'qSOFA',
    category: CalculatorCategory.sepsis,
    description: 'Évaluation rapide du risque de sepsis',
    fields: [
      const CalculatorField(id: 'rr22', label: 'Fréquence respiratoire ≥ 22/min', type: CalculatorFieldType.checkbox),
      const CalculatorField(id: 'gcs15', label: 'Altération mentale (GCS < 15)', type: CalculatorFieldType.checkbox),
      const CalculatorField(id: 'sbp100', label: 'PA systolique ≤ 100 mmHg', type: CalculatorFieldType.checkbox),
    ],
    calculate: (values) {
      int score = 0;
      if (values['rr22'] == 1.0) score += 1;
      if (values['gcs15'] == 1.0) score += 1;
      if (values['sbp100'] == 1.0) score += 1;
      return score.toDouble();
    },
    interpretations: [
      const ScoreInterpretation(min: 0, max: 1, label: 'Risque Faible', description: 'Mortalité hospitalière < 3%. Surveillance.', color: Colors.green),
      const ScoreInterpretation(min: 2, max: 3, label: 'Risque Élevé', description: 'Mortalité hospitalière 10-24%. Évaluer dysfonction d\'organe (SOFA).', color: Colors.red),
    ],
    source: 'Singer M et al. JAMA 2016 (Sepsis-3)',
    sourceUrl: 'https://pubmed.ncbi.nlm.nih.gov/26903338/',
  ),
  Calculator(
    id: 'news2',
    name: 'NEWS2 Score',
    shortName: 'NEWS2',
    category: CalculatorCategory.sepsis,
    description: 'National Early Warning Score 2 - Détection de détérioration clinique',
    fields: [
      const CalculatorField(
        id: 'rr',
        label: 'Fréquence Respiratoire',
        type: CalculatorFieldType.select,
        options: [
          CalculatorOption(value: 3, label: '≤ 8/min'),
          CalculatorOption(value: 1, label: '9-11/min'),
          CalculatorOption(value: 0, label: '12-20/min'),
          CalculatorOption(value: 2, label: '21-24/min'),
          CalculatorOption(value: 3, label: '≥ 25/min'),
        ],
      ),
      const CalculatorField(
        id: 'spo2',
        label: 'SpO2 (Échelle 1)',
        type: CalculatorFieldType.select,
        options: [
          CalculatorOption(value: 3, label: '≤ 91%'),
          CalculatorOption(value: 2, label: '92-93%'),
          CalculatorOption(value: 1, label: '94-95%'),
          CalculatorOption(value: 0, label: '≥ 96%'),
        ],
      ),
      const CalculatorField(id: 'o2', label: 'Oxygène supplémentaire', type: CalculatorFieldType.checkbox),
      const CalculatorField(
        id: 'sbp',
        label: 'PA Systolique',
        type: CalculatorFieldType.select,
        options: [
          CalculatorOption(value: 3, label: '≤ 90 mmHg'),
          CalculatorOption(value: 2, label: '91-100 mmHg'),
          CalculatorOption(value: 1, label: '101-110 mmHg'),
          CalculatorOption(value: 0, label: '111-219 mmHg'),
          CalculatorOption(value: 3, label: '≥ 220 mmHg'),
        ],
      ),
      const CalculatorField(
        id: 'hr',
        label: 'Fréquence Cardiaque',
        type: CalculatorFieldType.select,
        options: [
          CalculatorOption(value: 3, label: '≤ 40/min'),
          CalculatorOption(value: 1, label: '41-50/min'),
          CalculatorOption(value: 0, label: '51-90/min'),
          CalculatorOption(value: 1, label: '91-110/min'),
          CalculatorOption(value: 2, label: '111-130/min'),
          CalculatorOption(value: 3, label: '≥ 131/min'),
        ],
      ),
      const CalculatorField(
        id: 'consciousness',
        label: 'Conscience (ACVPU)',
        type: CalculatorFieldType.select,
        options: [
          CalculatorOption(value: 0, label: 'A - Alerte'),
          CalculatorOption(value: 3, label: 'C - Confusion nouvelle'),
          CalculatorOption(value: 3, label: 'V - Réponse à la voix'),
          CalculatorOption(value: 3, label: 'P - Réponse à la douleur'),
          CalculatorOption(value: 3, label: 'U - Inconscient'),
        ],
      ),
      const CalculatorField(
        id: 'temp',
        label: 'Température',
        type: CalculatorFieldType.select,
        options: [
          CalculatorOption(value: 3, label: '≤ 35.0°C'),
          CalculatorOption(value: 1, label: '35.1-36.0°C'),
          CalculatorOption(value: 0, label: '36.1-38.0°C'),
          CalculatorOption(value: 1, label: '38.1-39.0°C'),
          CalculatorOption(value: 2, label: '≥ 39.1°C'),
        ],
      ),
    ],
    calculate: (values) {
      double score = 0;
      score += (values['rr'] as double? ?? 0);
      score += (values['spo2'] as double? ?? 0);
      if (values['o2'] == 1.0) score += 2;
      score += (values['sbp'] as double? ?? 0);
      score += (values['hr'] as double? ?? 0);
      score += (values['consciousness'] as double? ?? 0);
      score += (values['temp'] as double? ?? 0);
      return score;
    },
    interpretations: [
      const ScoreInterpretation(min: 0, max: 0, label: 'Faible', description: 'Surveillance standard', color: Colors.green),
      const ScoreInterpretation(min: 1, max: 4, label: 'Faible-Moyen', description: 'Surveillance renforcée. Réévaluer à 4-6h.', color: Colors.yellow),
      const ScoreInterpretation(min: 5, max: 6, label: 'Moyen', description: 'Réponse urgente. Avis médecin senior.', color: Colors.orange),
      const ScoreInterpretation(min: 7, max: 20, label: 'Élevé', description: 'Réponse d\'urgence immédiate. Équipe réanimation.', color: Colors.red),
    ],
    source: 'Royal College of Physicians 2017',
    sourceUrl: 'https://www.rcplondon.ac.uk/projects/outputs/national-early-warning-score-news-2',
  ),
  Calculator(
    id: 'curb65',
    name: 'CURB-65 Score',
    shortName: 'CURB-65',
    category: CalculatorCategory.sepsis,
    description: 'Score de sévérité de la pneumonie',
    fields: [
      const CalculatorField(id: 'confusion', label: 'C - Confusion nouvelle', type: CalculatorFieldType.checkbox),
      const CalculatorField(id: 'urea', label: 'U - Urée > 7 mmol/L (0.42 g/L)', type: CalculatorFieldType.checkbox),
      const CalculatorField(id: 'rr30', label: 'R - Fréquence respiratoire ≥ 30/min', type: CalculatorFieldType.checkbox),
      const CalculatorField(id: 'bp', label: 'B - PAS < 90 mmHg OU PAD ≤ 60 mmHg', type: CalculatorFieldType.checkbox),
      const CalculatorField(id: 'age65', label: '65 - Âge ≥ 65 ans', type: CalculatorFieldType.checkbox),
    ],
    calculate: (values) {
      int score = 0;
      if (values['confusion'] == 1.0) score += 1;
      if (values['urea'] == 1.0) score += 1;
      if (values['rr30'] == 1.0) score += 1;
      if (values['bp'] == 1.0) score += 1;
      if (values['age65'] == 1.0) score += 1;
      return score.toDouble();
    },
    interpretations: [
      const ScoreInterpretation(min: 0, max: 1, label: 'Mortalité Faible', description: 'Mortalité < 3%. Traitement ambulatoire possible.', color: Colors.green),
      const ScoreInterpretation(min: 2, max: 2, label: 'Intermédiaire', description: 'Mortalité 9%. Hospitalisation courte ou surveillance étroite.', color: Colors.yellow),
      const ScoreInterpretation(min: 3, max: 5, label: 'Mortalité Élevée', description: 'Mortalité 15-40%. Hospitalisation, réanimation si ≥4.', color: Colors.red),
    ],
    source: 'Lim WS et al. Thorax 2003',
    sourceUrl: 'https://pubmed.ncbi.nlm.nih.gov/12728155/',
  ),
  Calculator(
    id: 'wells-pe',
    name: 'Score de Wells - Embolie Pulmonaire',
    shortName: 'Wells EP',
    category: CalculatorCategory.peDvt,
    description: 'Probabilité pré-test d\'embolie pulmonaire',
    fields: [
      const CalculatorField(id: 'dvtSigns', label: 'Signes cliniques de TVP', type: CalculatorFieldType.checkbox),
      const CalculatorField(id: 'alternative', label: 'EP diagnostic le plus probable', type: CalculatorFieldType.checkbox),
      const CalculatorField(id: 'hr100', label: 'Fréquence cardiaque > 100 bpm', type: CalculatorFieldType.checkbox),
      const CalculatorField(id: 'immobilization', label: 'Immobilisation ≥ 3 jours OU chirurgie < 4 semaines', type: CalculatorFieldType.checkbox),
      const CalculatorField(id: 'previousPE', label: 'Antécédent d\'EP ou TVP', type: CalculatorFieldType.checkbox),
      const CalculatorField(id: 'hemoptysis', label: 'Hémoptysie', type: CalculatorFieldType.checkbox),
      const CalculatorField(id: 'malignancy', label: 'Cancer (actif, < 6 mois, palliatif)', type: CalculatorFieldType.checkbox),
    ],
    calculate: (values) {
      double score = 0;
      if (values['dvtSigns'] == 1.0) score += 3;
      if (values['alternative'] == 1.0) score += 3;
      if (values['hr100'] == 1.0) score += 1.5;
      if (values['immobilization'] == 1.0) score += 1.5;
      if (values['previousPE'] == 1.0) score += 1.5;
      if (values['hemoptysis'] == 1.0) score += 1;
      if (values['malignancy'] == 1.0) score += 1;
      return score;
    },
    interpretations: [
      const ScoreInterpretation(min: 0, max: 1, label: 'Faible', description: 'Probabilité EP 1.3%. Appliquer PERC si applicable.', color: Colors.green),
      const ScoreInterpretation(min: 1.5, max: 4, label: 'Intermédiaire', description: 'Probabilité EP 16%. D-dimères indiqués.', color: Colors.yellow),
      const ScoreInterpretation(min: 4.5, max: 12.5, label: 'Élevé', description: 'Probabilité EP 38%. Angioscanner indiqué.', color: Colors.red),
    ],
    source: 'Wells PS et al. Thromb Haemost 2000',
    sourceUrl: 'https://pubmed.ncbi.nlm.nih.gov/10744147/',
  ),
  Calculator(
    id: 'perc',
    name: 'Règle PERC (Critères d\'exclusion EP)',
    shortName: 'PERC',
    category: CalculatorCategory.peDvt,
    description: 'Exclure l\'EP sans bilan chez les patients à faible risque',
    fields: [
      const CalculatorField(id: 'age50', label: 'Âge ≥ 50 ans', type: CalculatorFieldType.checkbox),
      const CalculatorField(id: 'hr100', label: 'Fréquence cardiaque ≥ 100 bpm', type: CalculatorFieldType.checkbox),
      const CalculatorField(id: 'spo2', label: 'SpO2 < 95% en air ambiant', type: CalculatorFieldType.checkbox),
      const CalculatorField(id: 'hemoptysis', label: 'Hémoptysie', type: CalculatorFieldType.checkbox),
      const CalculatorField(id: 'estrogen', label: 'Traitement œstrogénique', type: CalculatorFieldType.checkbox),
      const CalculatorField(id: 'surgery', label: 'Chirurgie/Traumatisme < 4 semaines', type: CalculatorFieldType.checkbox),
      const CalculatorField(id: 'previousPE', label: 'Antécédent d\'EP ou TVP', type: CalculatorFieldType.checkbox),
      const CalculatorField(id: 'legSwelling', label: 'Œdème unilatéral du MI', type: CalculatorFieldType.checkbox),
    ],
    calculate: (values) {
      double count = 0;
      if (values['age50'] == 1.0) count++;
      if (values['hr100'] == 1.0) count++;
      if (values['spo2'] == 1.0) count++;
      if (values['hemoptysis'] == 1.0) count++;
      if (values['estrogen'] == 1.0) count++;
      if (values['surgery'] == 1.0) count++;
      if (values['previousPE'] == 1.0) count++;
      if (values['legSwelling'] == 1.0) count++;
      return count;
    },
    interpretations: [
      const ScoreInterpretation(min: 0, max: 0, label: 'PERC Négatif', description: 'EP exclue (risque < 2%). Pas de bilan.', color: Colors.green),
      const ScoreInterpretation(min: 1, max: 8, label: 'PERC Positif', description: 'EP non exclue. Poursuivre le bilan.', color: Colors.orange),
    ],
    source: 'Kline JA et al. J Thromb Haemost 2004',
    sourceUrl: 'https://pubmed.ncbi.nlm.nih.gov/15304025/',
  ),
  Calculator(
    id: 'geneva-revised',
    name: 'Score de Genève Révisé',
    shortName: 'Genève',
    category: CalculatorCategory.peDvt,
    description: 'Score objectif de probabilité d\'EP',
    fields: [
      const CalculatorField(id: 'age', label: 'Âge > 65 ans', type: CalculatorFieldType.checkbox),
      const CalculatorField(id: 'previousPE', label: 'Antécédent de TVP ou EP', type: CalculatorFieldType.checkbox),
      const CalculatorField(id: 'surgery', label: 'Chirurgie ou fracture < 1 mois', type: CalculatorFieldType.checkbox),
      const CalculatorField(id: 'malignancy', label: 'Cancer actif ou rémission < 1 an', type: CalculatorFieldType.checkbox),
      const CalculatorField(id: 'legPain', label: 'Douleur unilatérale du MI', type: CalculatorFieldType.checkbox),
      const CalculatorField(id: 'hemoptysis', label: 'Hémoptysie', type: CalculatorFieldType.checkbox),
      const CalculatorField(
        id: 'hr',
        label: 'Fréquence Cardiaque',
        type: CalculatorFieldType.select,
        options: [
          CalculatorOption(value: 0, label: '< 75 bpm'),
          CalculatorOption(value: 3, label: '75-94 bpm'),
          CalculatorOption(value: 5, label: '≥ 95 bpm'),
        ],
      ),
      const CalculatorField(id: 'legEdema', label: 'Douleur à la palpation et œdème du MI', type: CalculatorFieldType.checkbox),
    ],
    calculate: (values) {
      double score = 0;
      if (values['age'] == 1.0) score += 1;
      if (values['previousPE'] == 1.0) score += 3;
      if (values['surgery'] == 1.0) score += 2;
      if (values['malignancy'] == 1.0) score += 2;
      if (values['legPain'] == 1.0) score += 3;
      if (values['hemoptysis'] == 1.0) score += 2;
      score += (values['hr'] as double? ?? 0);
      if (values['legEdema'] == 1.0) score += 4;
      return score;
    },
    interpretations: [
      const ScoreInterpretation(min: 0, max: 3, label: 'Faible', description: 'Probabilité EP 8%. D-dimères indiqués.', color: Colors.green),
      const ScoreInterpretation(min: 4, max: 10, label: 'Intermédiaire', description: 'Probabilité EP 29%. D-dimères ou Angioscanner.', color: Colors.yellow),
      const ScoreInterpretation(min: 11, max: 25, label: 'Élevé', description: 'Probabilité EP 74%. Angioscanner indiqué.', color: Colors.red),
    ],
    source: 'Le Gal G et al. Ann Intern Med 2006',
    sourceUrl: 'https://pubmed.ncbi.nlm.nih.gov/16461963/',
  ),
  Calculator(
    id: 'spesi',
    name: 'Score sPESI Simplifié',
    shortName: 'sPESI',
    category: CalculatorCategory.peDvt,
    description: 'Pronostic d\'EP confirmée - Sélection traitement ambulatoire',
    fields: [
      const CalculatorField(id: 'age80', label: 'Âge > 80 ans', type: CalculatorFieldType.checkbox),
      const CalculatorField(id: 'cancer', label: 'Cancer', type: CalculatorFieldType.checkbox),
      const CalculatorField(id: 'cardiopulmonary', label: 'Maladie cardiopulmonaire chronique', type: CalculatorFieldType.checkbox),
      const CalculatorField(id: 'hr110', label: 'Fréquence cardiaque ≥ 110 bpm', type: CalculatorFieldType.checkbox),
      const CalculatorField(id: 'sbp100', label: 'PA systolique < 100 mmHg', type: CalculatorFieldType.checkbox),
      const CalculatorField(id: 'spo2', label: 'SpO2 < 90%', type: CalculatorFieldType.checkbox),
    ],
    calculate: (values) {
      double score = 0;
      if (values['age80'] == 1.0) score += 1;
      if (values['cancer'] == 1.0) score += 1;
      if (values['cardiopulmonary'] == 1.0) score += 1;
      if (values['hr110'] == 1.0) score += 1;
      if (values['sbp100'] == 1.0) score += 1;
      if (values['spo2'] == 1.0) score += 1;
      return score;
    },
    interpretations: [
      const ScoreInterpretation(min: 0, max: 0, label: 'Risque Faible', description: 'Mortalité à 30j 1%. Traitement ambulatoire possible.', color: Colors.green),
      const ScoreInterpretation(min: 1, max: 6, label: 'Risque Élevé', description: 'Mortalité à 30j 10.9%. Hospitalisation recommandée.', color: Colors.red),
    ],
    source: 'Jiménez D et al. Arch Intern Med 2010',
    sourceUrl: 'https://pubmed.ncbi.nlm.nih.gov/20696951/',
  ),
  Calculator(
    id: 'wells-dvt',
    name: 'Score de Wells - TVP',
    shortName: 'Wells TVP',
    category: CalculatorCategory.peDvt,
    description: 'Probabilité pré-test de Thrombose Veineuse Profonde',
    fields: [
      const CalculatorField(id: 'cancer', label: 'Cancer actif (traitement < 6 mois ou palliatif)', type: CalculatorFieldType.checkbox),
      const CalculatorField(id: 'paralysis', label: 'Paralysie, parésie ou immobilisation plâtrée récente du MI', type: CalculatorFieldType.checkbox),
      const CalculatorField(id: 'bedridden', label: 'Alitement > 3 jours OU chirurgie majeure < 12 semaines', type: CalculatorFieldType.checkbox),
      const CalculatorField(id: 'tenderness', label: 'Douleur localisée sur le trajet veineux profond', type: CalculatorFieldType.checkbox),
      const CalculatorField(id: 'legSwelling', label: 'Œdème de tout le MI', type: CalculatorFieldType.checkbox),
      const CalculatorField(id: 'calfSwelling', label: 'Œdème du mollet > 3 cm vs côté asymptomatique', type: CalculatorFieldType.checkbox),
      const CalculatorField(id: 'pittingEdema', label: 'Œdème prenant le godet (prédominant côté symptomatique)', type: CalculatorFieldType.checkbox),
      const CalculatorField(id: 'collateralVeins', label: 'Veines superficielles collatérales (non variqueuses)', type: CalculatorFieldType.checkbox),
      const CalculatorField(id: 'previousDVT', label: 'Antécédent documenté de TVP', type: CalculatorFieldType.checkbox),
      const CalculatorField(id: 'alternativeDiagnosis', label: 'Diagnostic alternatif au moins aussi probable que TVP', type: CalculatorFieldType.checkbox),
    ],
    calculate: (values) {
      double score = 0;
      if (values['cancer'] == 1.0) score += 1;
      if (values['paralysis'] == 1.0) score += 1;
      if (values['bedridden'] == 1.0) score += 1;
      if (values['tenderness'] == 1.0) score += 1;
      if (values['legSwelling'] == 1.0) score += 1;
      if (values['calfSwelling'] == 1.0) score += 1;
      if (values['pittingEdema'] == 1.0) score += 1;
      if (values['collateralVeins'] == 1.0) score += 1;
      if (values['previousDVT'] == 1.0) score += 1;
      if (values['alternativeDiagnosis'] == 1.0) score -= 2;
      return score;
    },
    interpretations: [
      const ScoreInterpretation(min: -2, max: 0, label: 'Faible', description: 'Probabilité TVP 5%. D-dimères indiqués.', color: Colors.green),
      const ScoreInterpretation(min: 1, max: 2, label: 'Modéré', description: 'Probabilité TVP 17%. D-dimères ou Échographie.', color: Colors.yellow),
      const ScoreInterpretation(min: 3, max: 9, label: 'Élevé', description: 'Probabilité TVP 53%. Échographie indiquée.', color: Colors.red),
    ],
    source: 'Wells PS et al. Lancet 1997',
    sourceUrl: 'https://pubmed.ncbi.nlm.nih.gov/9217107/',
  ),
  Calculator(
    id: 'heart',
    name: 'Score HEART',
    shortName: 'HEART',
    category: CalculatorCategory.cardiovascular,
    description: 'Stratification du risque de SCA aux urgences',
    fields: [
      const CalculatorField(
        id: 'history',
        label: 'Anamnèse',
        type: CalculatorFieldType.select,
        options: [
          CalculatorOption(value: 0, label: 'Peu suspecte', description: 'Atypique pour SCA'),
          CalculatorOption(value: 1, label: 'Modérément suspecte', description: 'Éléments typiques et atypiques'),
          CalculatorOption(value: 2, label: 'Très suspecte', description: 'Typique pour SCA'),
        ],
      ),
      const CalculatorField(
        id: 'ecg',
        label: 'ECG',
        type: CalculatorFieldType.select,
        options: [
          CalculatorOption(value: 0, label: 'Normal', description: 'Complètement normal'),
          CalculatorOption(value: 1, label: 'Anomalies non spécifiques', description: 'BBG, HVG, repolarisation non spécifique'),
          CalculatorOption(value: 2, label: 'Déviation ST significative', description: 'Sous-décalage ST, sus-décalage ST'),
        ],
      ),
      const CalculatorField(
        id: 'age',
        label: 'Âge',
        type: CalculatorFieldType.select,
        options: [
          CalculatorOption(value: 0, label: '< 45 ans'),
          CalculatorOption(value: 1, label: '45-64 ans'),
          CalculatorOption(value: 2, label: '≥ 65 ans'),
        ],
      ),
      const CalculatorField(
        id: 'riskFactors',
        label: 'Facteurs de risque',
        type: CalculatorFieldType.select,
        options: [
          CalculatorOption(value: 0, label: 'Aucun facteur de risque connu'),
          CalculatorOption(value: 1, label: '1-2 facteurs de risque', description: 'HTA, diabète, tabac, dyslipidémie, obésité, ATCD familiaux'),
          CalculatorOption(value: 2, label: '≥ 3 facteurs OU ATCD d\'athérosclérose', description: 'IDM, AVC, AOMI, revascularisation antérieurs'),
        ],
      ),
      const CalculatorField(
        id: 'troponin',
        label: 'Troponine',
        type: CalculatorFieldType.select,
        options: [
          CalculatorOption(value: 0, label: '≤ limite normale'),
          CalculatorOption(value: 1, label: '1-3x limite normale'),
          CalculatorOption(value: 2, label: '> 3x limite normale'),
        ],
      ),
    ],
    calculate: (values) {
      return (values['history'] as double) + (values['ecg'] as double) + 
             (values['age'] as double) + (values['riskFactors'] as double) + (values['troponin'] as double);
    },
    interpretations: [
      const ScoreInterpretation(min: 0, max: 3, label: 'Risque Faible', description: 'MACE < 2% à 6 semaines. Sortie possible.', color: Colors.green),
      const ScoreInterpretation(min: 4, max: 6, label: 'Risque Modéré', description: 'MACE 12-16%. Hospitalisation pour surveillance.', color: Colors.orange),
      const ScoreInterpretation(min: 7, max: 10, label: 'Risque Élevé', description: 'MACE > 50%. Stratégie invasive précoce.', color: Colors.red),
    ],
    source: 'Six AJ et al. Neth Heart J 2008',
    sourceUrl: 'https://pubmed.ncbi.nlm.nih.gov/18665203/',
  ),
  Calculator(
    id: 'cha2ds2-vasc',
    name: 'CHA₂DS₂-VASc Score',
    shortName: 'CHA₂DS₂-VASc',
    category: CalculatorCategory.cardiovascular,
    description: 'Risque d\'AVC dans la Fibrillation Auriculaire',
    fields: [
      const CalculatorField(id: 'chf', label: 'IC / FEVG ≤ 40%', type: CalculatorFieldType.checkbox),
      const CalculatorField(id: 'hypertension', label: 'Hypertension', type: CalculatorFieldType.checkbox),
      const CalculatorField(id: 'age75', label: 'Âge ≥ 75 ans', type: CalculatorFieldType.checkbox),
      const CalculatorField(id: 'diabetes', label: 'Diabète', type: CalculatorFieldType.checkbox),
      const CalculatorField(id: 'stroke', label: 'ATCD AVC / AIT / Thromboembolie', type: CalculatorFieldType.checkbox),
      const CalculatorField(id: 'vascular', label: 'Maladie vasculaire (IDM, AOMI, plaque aortique)', type: CalculatorFieldType.checkbox),
      const CalculatorField(id: 'age65', label: 'Âge 65-74 ans', type: CalculatorFieldType.checkbox),
      const CalculatorField(id: 'female', label: 'Sexe féminin', type: CalculatorFieldType.checkbox),
    ],
    calculate: (values) {
      double score = 0;
      if (values['chf'] == 1.0) score += 1;
      if (values['hypertension'] == 1.0) score += 1;
      if (values['age75'] == 1.0) score += 2;
      if (values['diabetes'] == 1.0) score += 1;
      if (values['stroke'] == 1.0) score += 2;
      if (values['vascular'] == 1.0) score += 1;
      if (values['age65'] == 1.0 && values['age75'] != 1.0) score += 1;
      if (values['female'] == 1.0) score += 1;
      return score;
    },
    interpretations: [
      const ScoreInterpretation(min: 0, max: 0, label: 'Faible (Hommes)', description: 'Risque AVC 0%/an. Pas d\'anticoagulation.', color: Colors.green),
      const ScoreInterpretation(min: 1, max: 1, label: 'Faible-Modéré', description: 'Risque AVC 1.3%/an. Considérer anticoagulation.', color: Colors.yellow),
      const ScoreInterpretation(min: 2, max: 2, label: 'Modéré', description: 'Risque AVC 2.2%/an. Anticoagulation recommandée.', color: Colors.orange),
      const ScoreInterpretation(min: 3, max: 9, label: 'Élevé', description: 'Risque AVC ≥ 3.2%/an. Anticoagulation indiquée.', color: Colors.red),
    ],
    source: 'Lip GY et al. Chest 2010',
    sourceUrl: 'https://pubmed.ncbi.nlm.nih.gov/19762550/',
  ),
  Calculator(
    id: 'has-bled',
    name: 'Score HAS-BLED',
    shortName: 'HAS-BLED',
    category: CalculatorCategory.cardiovascular,
    description: 'Risque de saignement majeur sous anticoagulation',
    fields: [
      const CalculatorField(id: 'hypertension', label: 'HTA non contrôlée (> 160 mmHg systolique)', type: CalculatorFieldType.checkbox),
      const CalculatorField(id: 'renal', label: 'Insuffisance rénale (Dialyse, greffe, Cr > 200)', type: CalculatorFieldType.checkbox),
      const CalculatorField(id: 'liver', label: 'Insuffisance hépatique (Cirrhose, Bili > 2x, AST/ALT > 3x)', type: CalculatorFieldType.checkbox),
      const CalculatorField(id: 'stroke', label: 'Antécédent d\'AVC', type: CalculatorFieldType.checkbox),
      const CalculatorField(id: 'bleeding', label: 'ATCD de saignement majeur ou prédisposition', type: CalculatorFieldType.checkbox),
      const CalculatorField(id: 'labile', label: 'INR labile (TTR < 60%)', type: CalculatorFieldType.checkbox),
      const CalculatorField(id: 'elderly', label: 'Âge > 65 ans', type: CalculatorFieldType.checkbox),
      const CalculatorField(id: 'drugs', label: 'Médicaments (Antiplaquettaires, AINS)', type: CalculatorFieldType.checkbox),
      const CalculatorField(id: 'alcohol', label: 'Alcool (≥ 8 verres/semaine)', type: CalculatorFieldType.checkbox),
    ],
    calculate: (values) {
      double score = 0;
      if (values['hypertension'] == 1.0) score += 1;
      if (values['renal'] == 1.0) score += 1;
      if (values['liver'] == 1.0) score += 1;
      if (values['stroke'] == 1.0) score += 1;
      if (values['bleeding'] == 1.0) score += 1;
      if (values['labile'] == 1.0) score += 1;
      if (values['elderly'] == 1.0) score += 1;
      if (values['drugs'] == 1.0) score += 1;
      if (values['alcohol'] == 1.0) score += 1;
      return score;
    },
    interpretations: [
      const ScoreInterpretation(min: 0, max: 0, label: 'Très bas', description: 'Risque hémorragique 1,13%/an', color: Colors.green),
      const ScoreInterpretation(min: 1, max: 1, label: 'Bas', description: 'Risque hémorragique 1,02%/an', color: Colors.green),
      const ScoreInterpretation(min: 2, max: 2, label: 'Modéré', description: 'Risque hémorragique 1,88%/an', color: Colors.yellow),
      const ScoreInterpretation(min: 3, max: 9, label: 'Élevé', description: 'Risque hémorragique ≥ 3,74%/an. Corriger les facteurs modifiables.', color: Colors.orange),
    ],
    source: 'Pisters R et al. Chest 2010',
    sourceUrl: 'https://pubmed.ncbi.nlm.nih.gov/20299623/',
  ),
  Calculator(
    id: 'canadian-syncope',
    name: 'Score de Risque de Syncope Canadien',
    shortName: 'CSRS',
    category: CalculatorCategory.cardiovascular,
    description: 'Prédiction des événements indésirables graves dans les 30 jours suivant une syncope',
    fields: [
      const CalculatorField(
        id: 'predisposition',
        label: 'Prédisposition Vasovagale',
        type: CalculatorFieldType.select,
        options: [
          CalculatorOption(value: -1, label: 'Oui (chaleur, debout, émotion, douleur)', description: 'Facteur protecteur'),
          CalculatorOption(value: 0, label: 'Non'),
        ],
      ),
      const CalculatorField(
        id: 'heartDisease',
        label: 'Antécédents de Cardiopathie',
        type: CalculatorFieldType.select,
        options: [
          CalculatorOption(value: 0, label: 'Non'),
          CalculatorOption(value: 1, label: 'Oui (Coronaropathie, FA, IC, Valvulopathie)'),
        ],
      ),
      const CalculatorField(
        id: 'sbp',
        label: 'PA Systolique < 90 ou > 180 mmHg',
        type: CalculatorFieldType.select,
        options: [
          CalculatorOption(value: 0, label: 'Non (90-180 mmHg)'),
          CalculatorOption(value: 2, label: 'Oui (< 90 ou > 180 mmHg)'),
        ],
      ),
      const CalculatorField(
        id: 'troponin',
        label: 'Troponine Élevée (> 99e percentile)',
        type: CalculatorFieldType.select,
        options: [
          CalculatorOption(value: 0, label: 'Non'),
          CalculatorOption(value: 2, label: 'Oui'),
        ],
      ),
      const CalculatorField(
        id: 'axis',
        label: 'Axe QRS Anormal (< -30° ou > 100°)',
        type: CalculatorFieldType.select,
        options: [
          CalculatorOption(value: 0, label: 'Non'),
          CalculatorOption(value: 1, label: 'Oui'),
        ],
      ),
      const CalculatorField(
        id: 'qrs',
        label: 'QRS > 130 ms',
        type: CalculatorFieldType.select,
        options: [
          CalculatorOption(value: 0, label: 'Non'),
          CalculatorOption(value: 1, label: 'Oui'),
        ],
      ),
      const CalculatorField(
        id: 'qtc',
        label: 'QTc > 480 ms',
        type: CalculatorFieldType.select,
        options: [
          CalculatorOption(value: 0, label: 'Non'),
          CalculatorOption(value: 2, label: 'Oui'),
        ],
      ),
      const CalculatorField(
        id: 'edDiagnosis',
        label: 'Diagnostic aux Urgences',
        type: CalculatorFieldType.select,
        options: [
          CalculatorOption(value: 0, label: 'Syncope Vasovagale'),
          CalculatorOption(value: 2, label: 'Syncope Cardiaque'),
          CalculatorOption(value: -2, label: 'Présyncope Vasovagale'),
        ],
      ),
    ],
    calculate: (values) {
      return (values['predisposition'] as double) + (values['heartDisease'] as double) +
             (values['sbp'] as double) + (values['troponin'] as double) +
             (values['axis'] as double) + (values['qrs'] as double) +
             (values['qtc'] as double) + (values['edDiagnosis'] as double);
    },
    interpretations: [
      const ScoreInterpretation(min: -3, max: -2, label: 'Très bas', description: 'Risque 0,4%. Sortie sécuritaire.', color: Colors.green),
      const ScoreInterpretation(min: -1, max: 0, label: 'Bas', description: 'Risque 1,2%. Sortie possible.', color: Colors.green),
      const ScoreInterpretation(min: 1, max: 3, label: 'Modéré', description: 'Risque 3-5%. Envisager observation.', color: Colors.yellow),
      const ScoreInterpretation(min: 4, max: 5, label: 'Élevé', description: 'Risque 9%. Hospitalisation recommandée.', color: Colors.orange),
      const ScoreInterpretation(min: 6, max: 11, label: 'Très élevé', description: 'Risque > 18%. Hospitalisation indiquée.', color: Colors.red),
    ],
    source: 'Thiruganasambandamoorthy V et al. CMAJ 2016',
    sourceUrl: 'https://pubmed.ncbi.nlm.nih.gov/27378464/',
  ),
  Calculator(
    id: 'nihss',
    name: 'NIH Stroke Scale',
    shortName: 'NIHSS',
    category: CalculatorCategory.neurology,
    description: 'Ischemic stroke severity and thrombolysis eligibility',
    fields: [
      const CalculatorField(
        id: 'consciousness',
        label: '1a. Level of Consciousness',
        type: CalculatorFieldType.select,
        options: [
          CalculatorOption(value: 0, label: '0 - Alert'),
          CalculatorOption(value: 1, label: '1 - Not alert but arousable'),
          CalculatorOption(value: 2, label: '2 - Not alert, requires repeated stimulation'),
          CalculatorOption(value: 3, label: '3 - Coma'),
        ],
      ),
      const CalculatorField(
        id: 'questions',
        label: '1b. LOC Questions (Month, Age)',
        type: CalculatorFieldType.select,
        options: [
          CalculatorOption(value: 0, label: '0 - Answers both correctly'),
          CalculatorOption(value: 1, label: '1 - Answers one correctly'),
          CalculatorOption(value: 2, label: '2 - Answers neither correctly'),
        ],
      ),
      const CalculatorField(
        id: 'commands',
        label: '1c. LOC Commands (Open/close eyes, grip)',
        type: CalculatorFieldType.select,
        options: [
          CalculatorOption(value: 0, label: '0 - Performs both correctly'),
          CalculatorOption(value: 1, label: '1 - Performs one correctly'),
          CalculatorOption(value: 2, label: '2 - Performs neither correctly'),
        ],
      ),
      const CalculatorField(
        id: 'gaze',
        label: '2. Best Gaze',
        type: CalculatorFieldType.select,
        options: [
          CalculatorOption(value: 0, label: '0 - Normal'),
          CalculatorOption(value: 1, label: '1 - Partial gaze palsy'),
          CalculatorOption(value: 2, label: '2 - Forced deviation'),
        ],
      ),
      const CalculatorField(
        id: 'visual',
        label: '3. Visual Fields',
        type: CalculatorFieldType.select,
        options: [
          CalculatorOption(value: 0, label: '0 - No visual loss'),
          CalculatorOption(value: 1, label: '1 - Partial hemianopia'),
          CalculatorOption(value: 2, label: '2 - Complete hemianopia'),
          CalculatorOption(value: 3, label: '3 - Bilateral hemianopia'),
        ],
      ),
      const CalculatorField(
        id: 'facialPalsy',
        label: '4. Facial Palsy',
        type: CalculatorFieldType.select,
        options: [
          CalculatorOption(value: 0, label: '0 - Normal'),
          CalculatorOption(value: 1, label: '1 - Minor paralysis'),
          CalculatorOption(value: 2, label: '2 - Partial paralysis'),
          CalculatorOption(value: 3, label: '3 - Complete paralysis'),
        ],
      ),
      const CalculatorField(
        id: 'motorArmLeft',
        label: '5a. Motor Left Arm',
        type: CalculatorFieldType.select,
        options: [
          CalculatorOption(value: 0, label: '0 - No drift'),
          CalculatorOption(value: 1, label: '1 - Drift'),
          CalculatorOption(value: 2, label: '2 - Some effort against gravity'),
          CalculatorOption(value: 3, label: '3 - No effort against gravity'),
          CalculatorOption(value: 4, label: '4 - No movement'),
        ],
      ),
      const CalculatorField(
        id: 'motorArmRight',
        label: '5b. Motor Right Arm',
        type: CalculatorFieldType.select,
        options: [
          CalculatorOption(value: 0, label: '0 - No drift'),
          CalculatorOption(value: 1, label: '1 - Drift'),
          CalculatorOption(value: 2, label: '2 - Some effort against gravity'),
          CalculatorOption(value: 3, label: '3 - No effort against gravity'),
          CalculatorOption(value: 4, label: '4 - No movement'),
        ],
      ),
      const CalculatorField(
        id: 'motorLegLeft',
        label: '6a. Motor Left Leg',
        type: CalculatorFieldType.select,
        options: [
          CalculatorOption(value: 0, label: '0 - No drift'),
          CalculatorOption(value: 1, label: '1 - Drift'),
          CalculatorOption(value: 2, label: '2 - Some effort against gravity'),
          CalculatorOption(value: 3, label: '3 - No effort against gravity'),
          CalculatorOption(value: 4, label: '4 - No movement'),
        ],
      ),
      const CalculatorField(
        id: 'motorLegRight',
        label: '6b. Motor Right Leg',
        type: CalculatorFieldType.select,
        options: [
          CalculatorOption(value: 0, label: '0 - No drift'),
          CalculatorOption(value: 1, label: '1 - Drift'),
          CalculatorOption(value: 2, label: '2 - Some effort against gravity'),
          CalculatorOption(value: 3, label: '3 - No effort against gravity'),
          CalculatorOption(value: 4, label: '4 - No movement'),
        ],
      ),
      const CalculatorField(
        id: 'ataxia',
        label: '7. Limb Ataxia',
        type: CalculatorFieldType.select,
        options: [
          CalculatorOption(value: 0, label: '0 - Absent'),
          CalculatorOption(value: 1, label: '1 - Present in one limb'),
          CalculatorOption(value: 2, label: '2 - Present in two limbs'),
        ],
      ),
      const CalculatorField(
        id: 'sensory',
        label: '8. Sensory',
        type: CalculatorFieldType.select,
        options: [
          CalculatorOption(value: 0, label: '0 - Normal'),
          CalculatorOption(value: 1, label: '1 - Mild to moderate loss'),
          CalculatorOption(value: 2, label: '2 - Severe to total loss'),
        ],
      ),
      const CalculatorField(
        id: 'language',
        label: '9. Best Language',
        type: CalculatorFieldType.select,
        options: [
          CalculatorOption(value: 0, label: '0 - No aphasia'),
          CalculatorOption(value: 1, label: '1 - Mild to moderate aphasia'),
          CalculatorOption(value: 2, label: '2 - Severe aphasia'),
          CalculatorOption(value: 3, label: '3 - Mute / Global aphasia'),
        ],
      ),
      const CalculatorField(
        id: 'dysarthria',
        label: '10. Dysarthria',
        type: CalculatorFieldType.select,
        options: [
          CalculatorOption(value: 0, label: '0 - Normal'),
          CalculatorOption(value: 1, label: '1 - Mild to moderate'),
          CalculatorOption(value: 2, label: '2 - Severe'),
        ],
      ),
      const CalculatorField(
        id: 'neglect',
        label: '11. Extinction and Inattention',
        type: CalculatorFieldType.select,
        options: [
          CalculatorOption(value: 0, label: '0 - No abnormality'),
          CalculatorOption(value: 1, label: '1 - Visual, tactile, auditory, spatial, or personal inattention'),
          CalculatorOption(value: 2, label: '2 - Profound hemi-inattention or extinction'),
        ],
      ),
    ],
    calculate: (values) {
      return (values['consciousness'] as double) + (values['questions'] as double) +
             (values['commands'] as double) + (values['gaze'] as double) +
             (values['visual'] as double) + (values['facialPalsy'] as double) +
             (values['motorArmLeft'] as double) + (values['motorArmRight'] as double) +
             (values['motorLegLeft'] as double) + (values['motorLegRight'] as double) +
             (values['ataxia'] as double) + (values['sensory'] as double) +
             (values['language'] as double) + (values['dysarthria'] as double) +
             (values['neglect'] as double);
    },
    interpretations: [
      const ScoreInterpretation(min: 0, max: 4, label: 'Minor', description: 'Minor stroke. Discuss thrombolysis.', color: Colors.green),
      const ScoreInterpretation(min: 5, max: 15, label: 'Moderate', description: 'Moderate stroke. Thrombolysis eligible.', color: Colors.yellow),
      const ScoreInterpretation(min: 16, max: 20, label: 'Severe', description: 'Severe stroke. Discuss thrombolysis + thrombectomy.', color: Colors.orange),
      const ScoreInterpretation(min: 21, max: 42, label: 'Very Severe', description: 'Poor prognosis. Increased bleeding risk.', color: Colors.red),
    ],
    source: 'Brott T et al. Stroke 1989',
    sourceUrl: 'https://pubmed.ncbi.nlm.nih.gov/2749846/',
  ),
  Calculator(
    id: 'abcd2',
    name: 'ABCD² Score for TIA',
    shortName: 'ABCD²',
    category: CalculatorCategory.neurology,
    description: 'Stroke risk after TIA',
    fields: [
      const CalculatorField(id: 'age60', label: 'Age ≥ 60 years', type: CalculatorFieldType.checkbox),
      const CalculatorField(id: 'bp140', label: 'BP ≥ 140/90 mmHg', type: CalculatorFieldType.checkbox),
      const CalculatorField(
        id: 'clinical',
        label: 'Clinical Features',
        type: CalculatorFieldType.select,
        options: [
          CalculatorOption(value: 0, label: 'Other symptoms'),
          CalculatorOption(value: 1, label: 'Speech disturbance without weakness'),
          CalculatorOption(value: 2, label: 'Unilateral weakness'),
        ],
      ),
      const CalculatorField(
        id: 'duration',
        label: 'Duration of Symptoms',
        type: CalculatorFieldType.select,
        options: [
          CalculatorOption(value: 0, label: '< 10 minutes'),
          CalculatorOption(value: 1, label: '10-59 minutes'),
          CalculatorOption(value: 2, label: '≥ 60 minutes'),
        ],
      ),
      const CalculatorField(id: 'diabetes', label: 'Diabetes', type: CalculatorFieldType.checkbox),
    ],
    calculate: (values) {
      double score = 0;
      if (values['age60'] == 1.0) score += 1;
      if (values['bp140'] == 1.0) score += 1;
      score += (values['clinical'] as double? ?? 0);
      score += (values['duration'] as double? ?? 0);
      if (values['diabetes'] == 1.0) score += 1;
      return score;
    },
    interpretations: [
      const ScoreInterpretation(min: 0, max: 3, label: 'Low Risk', description: '2-day stroke risk: 1%. Outpatient workup possible.', color: Colors.green),
      const ScoreInterpretation(min: 4, max: 5, label: 'Moderate Risk', description: '2-day stroke risk: 4%. Hospitalization recommended.', color: Colors.yellow),
      const ScoreInterpretation(min: 6, max: 7, label: 'High Risk', description: '2-day stroke risk: 8%. Urgent hospitalization.', color: Colors.red),
    ],
    source: 'Johnston SC et al. Lancet 2007',
    sourceUrl: 'https://pubmed.ncbi.nlm.nih.gov/17258668/',
  ),
  Calculator(
    id: 'ich',
    name: 'ICH Score',
    shortName: 'ICH',
    category: CalculatorCategory.neurology,
    description: '30-day mortality after Intracerebral Hemorrhage',
    fields: [
      const CalculatorField(
        id: 'gcs',
        label: 'GCS Score',
        type: CalculatorFieldType.select,
        options: [
          CalculatorOption(value: 0, label: '13-15'),
          CalculatorOption(value: 1, label: '5-12'),
          CalculatorOption(value: 2, label: '3-4'),
        ],
      ),
      const CalculatorField(
        id: 'volume',
        label: 'ICH Volume (ABC/2)',
        type: CalculatorFieldType.select,
        options: [
          CalculatorOption(value: 0, label: '< 30 mL'),
          CalculatorOption(value: 1, label: '≥ 30 mL'),
        ],
      ),
      const CalculatorField(id: 'ivh', label: 'Intraventricular Hemorrhage', type: CalculatorFieldType.checkbox),
      const CalculatorField(id: 'infratentorial', label: 'Infratentorial Origin', type: CalculatorFieldType.checkbox),
      const CalculatorField(id: 'age80', label: 'Age ≥ 80 years', type: CalculatorFieldType.checkbox),
    ],
    calculate: (values) {
      double score = 0;
      score += (values['gcs'] as double? ?? 0);
      score += (values['volume'] as double? ?? 0);
      if (values['ivh'] == 1.0) score += 1;
      if (values['infratentorial'] == 1.0) score += 1;
      if (values['age80'] == 1.0) score += 1;
      return score;
    },
    interpretations: [
      const ScoreInterpretation(min: 0, max: 0, label: '0', description: '30-day mortality: 0%', color: Colors.green),
      const ScoreInterpretation(min: 1, max: 1, label: '1', description: '30-day mortality: 13%', color: Colors.yellow),
      const ScoreInterpretation(min: 2, max: 2, label: '2', description: '30-day mortality: 26%', color: Colors.orange),
      const ScoreInterpretation(min: 3, max: 3, label: '3', description: '30-day mortality: 72%', color: Colors.red),
      const ScoreInterpretation(min: 4, max: 4, label: '4', description: '30-day mortality: 97%', color: Colors.red),
      const ScoreInterpretation(min: 5, max: 6, label: '5-6', description: '30-day mortality: 100%', color: Colors.red),
    ],
    source: 'Hemphill JC et al. Stroke 2001',
    sourceUrl: 'https://pubmed.ncbi.nlm.nih.gov/11283388/',
  ),
  Calculator(
    id: 'hunt-hess',
    name: 'Hunt and Hess Scale',
    shortName: 'Hunt-Hess',
    category: CalculatorCategory.neurology,
    description: 'Clinical classification of Subarachnoid Hemorrhage',
    fields: [
      const CalculatorField(
        id: 'grade',
        label: 'Clinical Presentation',
        type: CalculatorFieldType.select,
        options: [
          CalculatorOption(value: 1, label: 'Grade 1 - Asymptomatic or mild headache'),
          CalculatorOption(value: 2, label: 'Grade 2 - Moderate to severe headache, nuchal rigidity'),
          CalculatorOption(value: 3, label: 'Grade 3 - Confusion, drowsiness, mild focal deficit'),
          CalculatorOption(value: 4, label: 'Grade 4 - Stupor, moderate to severe hemiparesis'),
          CalculatorOption(value: 5, label: 'Grade 5 - Coma, decerebrate rigidity'),
        ],
      ),
    ],
    calculate: (values) {
      return (values['grade'] as double? ?? 0);
    },
    interpretations: [
      const ScoreInterpretation(min: 1, max: 1, label: 'Grade 1', description: 'Good prognosis. Mortality ~1%.', color: Colors.green),
      const ScoreInterpretation(min: 2, max: 2, label: 'Grade 2', description: 'Good prognosis. Mortality ~5%.', color: Colors.green),
      const ScoreInterpretation(min: 3, max: 3, label: 'Grade 3', description: 'Intermediate prognosis. Mortality ~19%.', color: Colors.yellow),
      const ScoreInterpretation(min: 4, max: 4, label: 'Grade 4', description: 'Poor prognosis. Mortality ~42%.', color: Colors.orange),
      const ScoreInterpretation(min: 5, max: 5, label: 'Grade 5', description: 'Very poor prognosis. Mortality ~77%.', color: Colors.red),
    ],
    source: 'Hunt WE, Hess RM. J Neurosurg 1968',
    sourceUrl: 'https://pubmed.ncbi.nlm.nih.gov/5635959/',
  ),
  Calculator(
    id: 'alvarado',
    name: 'Alvarado Score (MANTRELS)',
    shortName: 'Alvarado',
    category: CalculatorCategory.gi,
    description: 'Probability of acute appendicitis',
    fields: [
      const CalculatorField(id: 'migration', label: 'M - Migration of pain to RLQ', type: CalculatorFieldType.checkbox),
      const CalculatorField(id: 'anorexia', label: 'A - Anorexia', type: CalculatorFieldType.checkbox),
      const CalculatorField(id: 'nausea', label: 'N - Nausea/Vomiting', type: CalculatorFieldType.checkbox),
      const CalculatorField(id: 'tenderness', label: 'T - Tenderness in RLQ', type: CalculatorFieldType.checkbox),
      const CalculatorField(id: 'rebound', label: 'R - Rebound tenderness', type: CalculatorFieldType.checkbox),
      const CalculatorField(id: 'elevation', label: 'E - Elevated temperature (> 37.3°C)', type: CalculatorFieldType.checkbox),
      const CalculatorField(id: 'leukocytosis', label: 'L - Leukocytosis (> 10,000/mm³)', type: CalculatorFieldType.checkbox),
      const CalculatorField(id: 'shift', label: 'S - Shift to left (neutrophils > 75%)', type: CalculatorFieldType.checkbox),
    ],
    calculate: (values) {
      double score = 0;
      if (values['migration'] == 1.0) score += 1;
      if (values['anorexia'] == 1.0) score += 1;
      if (values['nausea'] == 1.0) score += 1;
      if (values['tenderness'] == 1.0) score += 2;
      if (values['rebound'] == 1.0) score += 1;
      if (values['elevation'] == 1.0) score += 1;
      if (values['leukocytosis'] == 1.0) score += 2;
      if (values['shift'] == 1.0) score += 1;
      return score;
    },
    interpretations: [
      const ScoreInterpretation(min: 0, max: 4, label: 'Low Probability', description: 'Appendicitis unlikely. Observation or discharge.', color: Colors.green),
      const ScoreInterpretation(min: 5, max: 6, label: 'Intermediate', description: 'Appendicitis possible. Imaging (US/CT) recommended.', color: Colors.yellow),
      const ScoreInterpretation(min: 7, max: 8, label: 'High Probability', description: 'Appendicitis probable. Surgical consultation.', color: Colors.red),
    ],
    source: 'Alvarado A. Ann Emerg Med 1986',
    sourceUrl: 'https://pubmed.ncbi.nlm.nih.gov/3963537/',
  ),
  Calculator(
    id: 'bisap',
    name: 'BISAP Score',
    shortName: 'BISAP',
    category: CalculatorCategory.gi,
    description: 'Prognosis of acute pancreatitis within first 24h',
    fields: [
      const CalculatorField(id: 'bun', label: 'B - BUN > 25 mg/dL (8.9 mmol/L)', type: CalculatorFieldType.checkbox),
      const CalculatorField(id: 'impaired', label: 'I - Impaired mental status (GCS < 15)', type: CalculatorFieldType.checkbox),
      const CalculatorField(id: 'sirs', label: 'S - SIRS (≥ 2 criteria)', type: CalculatorFieldType.checkbox),
      const CalculatorField(id: 'age', label: 'A - Age > 60 years', type: CalculatorFieldType.checkbox),
      const CalculatorField(id: 'pleural', label: 'P - Pleural effusion', type: CalculatorFieldType.checkbox),
    ],
    calculate: (values) {
      double score = 0;
      if (values['bun'] == 1.0) score += 1;
      if (values['impaired'] == 1.0) score += 1;
      if (values['sirs'] == 1.0) score += 1;
      if (values['age'] == 1.0) score += 1;
      if (values['pleural'] == 1.0) score += 1;
      return score;
    },
    interpretations: [
      const ScoreInterpretation(min: 0, max: 0, label: 'Score 0', description: 'Mortality < 1%.', color: Colors.green),
      const ScoreInterpretation(min: 1, max: 1, label: 'Score 1', description: 'Mortality < 2%.', color: Colors.green),
      const ScoreInterpretation(min: 2, max: 2, label: 'Score 2', description: 'Mortality 2-5%. Close monitoring.', color: Colors.yellow),
      const ScoreInterpretation(min: 3, max: 3, label: 'Score 3', description: 'Mortality 5-20%. ICU admission probable.', color: Colors.orange),
      const ScoreInterpretation(min: 4, max: 5, label: 'Score 4-5', description: 'Mortality > 20%. ICU admission.', color: Colors.red),
    ],
    source: 'Wu BU et al. Gut 2008',
    sourceUrl: 'https://pubmed.ncbi.nlm.nih.gov/18703447/',
  ),
  Calculator(
    id: 'glasgow-blatchford',
    name: 'Glasgow-Blatchford Score',
    shortName: 'GBS',
    category: CalculatorCategory.gi,
    description: 'Need for intervention in Upper GI Bleeding',
    fields: [
      const CalculatorField(
        id: 'bun',
        label: 'BUN (mmol/L)',
        type: CalculatorFieldType.select,
        options: [
          CalculatorOption(value: 0, label: '< 6.5'),
          CalculatorOption(value: 2, label: '6.5-7.9'),
          CalculatorOption(value: 3, label: '8.0-9.9'),
          CalculatorOption(value: 4, label: '10.0-24.9'),
          CalculatorOption(value: 6, label: '≥ 25'),
        ],
      ),
      const CalculatorField(
        id: 'hbMen',
        label: 'Hemoglobin - Men (g/dL)',
        type: CalculatorFieldType.select,
        options: [
          CalculatorOption(value: 0, label: '≥ 13'),
          CalculatorOption(value: 1, label: '12.0-12.9'),
          CalculatorOption(value: 3, label: '10.0-11.9'),
          CalculatorOption(value: 6, label: '< 10'),
        ],
      ),
      const CalculatorField(
        id: 'hbWomen',
        label: 'Hemoglobin - Women (g/dL)',
        type: CalculatorFieldType.select,
        options: [
          CalculatorOption(value: 0, label: '≥ 12'),
          CalculatorOption(value: 1, label: '10.0-11.9'),
          CalculatorOption(value: 6, label: '< 10'),
        ],
      ),
      const CalculatorField(
        id: 'sbp',
        label: 'Systolic BP (mmHg)',
        type: CalculatorFieldType.select,

        options: [
          CalculatorOption(value: 0, label: '≥ 110'),
          CalculatorOption(value: 1, label: '100-109'),
          CalculatorOption(value: 2, label: '90-99'),
          CalculatorOption(value: 3, label: '< 90'),
        ],
      ),
      const CalculatorField(id: 'pulse', label: 'Pulse ≥ 100/min', type: CalculatorFieldType.checkbox),
      const CalculatorField(id: 'melena', label: 'Melena', type: CalculatorFieldType.checkbox),
      const CalculatorField(id: 'syncope', label: 'Syncope', type: CalculatorFieldType.checkbox),
      const CalculatorField(id: 'liver', label: 'Hepatic Disease', type: CalculatorFieldType.checkbox),
      const CalculatorField(id: 'heart', label: 'Heart Failure', type: CalculatorFieldType.checkbox),
    ],
    calculate: (values) {
      double score = 0;
      score += (values['bun'] as double? ?? 0);
      double hbScore = 0;
      if (values['hbMen'] != null) hbScore = values['hbMen'] as double;
      if (values['hbWomen'] != null && (values['hbWomen'] as double) > hbScore) hbScore = values['hbWomen'] as double;
      score += hbScore;
      score += (values['sbp'] as double? ?? 0);
      if (values['pulse'] == 1.0) score += 1;
      if (values['melena'] == 1.0) score += 1;
      if (values['syncope'] == 1.0) score += 2;
      if (values['liver'] == 1.0) score += 2;
      if (values['heart'] == 1.0) score += 2;
      return score;
    },
    interpretations: [
      const ScoreInterpretation(min: 0, max: 0, label: 'Very Low Risk', description: 'Score 0: Outpatient management possible. NPV 100% for intervention.', color: Colors.green),
      const ScoreInterpretation(min: 1, max: 2, label: 'Low Risk', description: 'Low probability of intervention. Observation.', color: Colors.green),
      const ScoreInterpretation(min: 3, max: 5, label: 'Intermediate Risk', description: 'Intervention possible. Hospitalization.', color: Colors.yellow),
      const ScoreInterpretation(min: 6, max: 11, label: 'High Risk', description: 'Intervention probable. Urgent endoscopy.', color: Colors.orange),
      const ScoreInterpretation(min: 12, max: 23, label: 'Very High Risk', description: 'Intervention very probable. Resuscitation/transfusion.', color: Colors.red),
    ],
    source: 'Blatchford O et al. Lancet 2000',
    sourceUrl: 'https://pubmed.ncbi.nlm.nih.gov/11073017/',
  ),
  Calculator(
    id: 'rockall',
    name: 'Rockall Score',
    shortName: 'Rockall',
    category: CalculatorCategory.gi,
    description: 'Risk of rebleeding and mortality after Upper GI Bleeding',
    fields: [
      const CalculatorField(
        id: 'age',
        label: 'Age',
        type: CalculatorFieldType.select,
        options: [
          CalculatorOption(value: 0, label: '< 60 years'),
          CalculatorOption(value: 1, label: '60-79 years'),
          CalculatorOption(value: 2, label: '≥ 80 years'),
        ],
      ),
      const CalculatorField(
        id: 'shock',
        label: 'Shock',
        type: CalculatorFieldType.select,
        options: [
          CalculatorOption(value: 0, label: 'No shock (SBP ≥ 100, HR < 100)'),
          CalculatorOption(value: 1, label: 'Tachycardia (SBP ≥ 100, HR ≥ 100)'),
          CalculatorOption(value: 2, label: 'Hypotension (SBP < 100)'),
        ],
      ),
      const CalculatorField(
        id: 'comorbidity',
        label: 'Comorbidities',
        type: CalculatorFieldType.select,
        options: [
          CalculatorOption(value: 0, label: 'None'),
          CalculatorOption(value: 2, label: 'Heart failure, IHD, other major'),
          CalculatorOption(value: 3, label: 'Renal/Liver failure, metastatic cancer'),
        ],
      ),
      const CalculatorField(
        id: 'diagnosis',
        label: 'Endoscopic Diagnosis',
        type: CalculatorFieldType.select,
        options: [
          CalculatorOption(value: 0, label: 'Mallory-Weiss, no lesion, no stigmata'),
          CalculatorOption(value: 1, label: 'All other diagnoses'),
          CalculatorOption(value: 2, label: 'Upper GI malignancy'),
        ],
      ),
      const CalculatorField(
        id: 'stigmata',
        label: 'Stigmata of Recent Hemorrhage',
        type: CalculatorFieldType.select,
        options: [
          CalculatorOption(value: 0, label: 'None or dark spot'),
          CalculatorOption(value: 2, label: 'Blood, adherent clot, visible vessel, active bleeding'),
        ],
      ),
    ],
    calculate: (values) {
      return (values['age'] as double? ?? 0) +
             (values['shock'] as double? ?? 0) +
             (values['comorbidity'] as double? ?? 0) +
             (values['diagnosis'] as double? ?? 0) +
             (values['stigmata'] as double? ?? 0);
    },
    interpretations: [
      const ScoreInterpretation(min: 0, max: 2, label: 'Low Risk', description: 'Mortality < 5%. Early discharge possible.', color: Colors.green),
      const ScoreInterpretation(min: 3, max: 4, label: 'Intermediate Risk', description: 'Mortality 11%. Hospitalization.', color: Colors.yellow),
      const ScoreInterpretation(min: 5, max: 6, label: 'High Risk', description: 'Mortality 25%. Close monitoring.', color: Colors.orange),
      const ScoreInterpretation(min: 7, max: 11, label: 'Very High Risk', description: 'Mortality > 40%. Resuscitation.', color: Colors.red),
    ],
    source: 'Rockall TA et al. Gut 1996',
    sourceUrl: 'https://pubmed.ncbi.nlm.nih.gov/8707114/',
  ),
  Calculator(
    id: 'ciwa-ar',
    name: 'CIWA-Ar (Alcohol Withdrawal)',
    shortName: 'CIWA-Ar',
    category: CalculatorCategory.toxicology,
    description: 'Severity of alcohol withdrawal and treatment guide',
    fields: [
      const CalculatorField(
        id: 'nausea',
        label: 'Nausea and Vomiting',
        type: CalculatorFieldType.select,
        options: [
          CalculatorOption(value: 0, label: '0 - None'),
          CalculatorOption(value: 1, label: '1 - Mild nausea, no vomiting'),
          CalculatorOption(value: 4, label: '4 - Intermittent nausea with dry heaves'),
          CalculatorOption(value: 7, label: '7 - Constant nausea, frequent dry heaves, vomiting'),
        ],
      ),
      const CalculatorField(
        id: 'tremor',
        label: 'Tremor (arms extended, fingers spread)',
        type: CalculatorFieldType.select,
        options: [
          CalculatorOption(value: 0, label: '0 - No tremor'),
          CalculatorOption(value: 1, label: '1 - Not visible, but can be felt'),
          CalculatorOption(value: 4, label: '4 - Moderate, with arms extended'),
          CalculatorOption(value: 7, label: '7 - Severe, even with arms not extended'),
        ],
      ),
      const CalculatorField(
        id: 'sweating',
        label: 'Paroxysmal Sweats',
        type: CalculatorFieldType.select,
        options: [
          CalculatorOption(value: 0, label: '0 - No sweat visible'),
          CalculatorOption(value: 1, label: '1 - Barely perceptible sweating, palms moist'),
          CalculatorOption(value: 4, label: '4 - Beads of sweat on forehead'),
          CalculatorOption(value: 7, label: '7 - Drenching sweats'),
        ],
      ),
      const CalculatorField(
        id: 'anxiety',
        label: 'Anxiety',
        type: CalculatorFieldType.select,
        options: [
          CalculatorOption(value: 0, label: '0 - No anxiety, at ease'),
          CalculatorOption(value: 1, label: '1 - Mildly anxious'),
          CalculatorOption(value: 4, label: '4 - Moderately anxious, or guarded'),
          CalculatorOption(value: 7, label: '7 - Equivalent to acute panic states'),
        ],
      ),
      const CalculatorField(
        id: 'agitation',
        label: 'Agitation',
        type: CalculatorFieldType.select,
        options: [
          CalculatorOption(value: 0, label: '0 - Normal activity'),
          CalculatorOption(value: 1, label: '1 - Somewhat more than normal activity'),
          CalculatorOption(value: 4, label: '4 - Moderately fidgety and restless'),
          CalculatorOption(value: 7, label: '7 - Paces back and forth, or constantly thrashes about'),
        ],
      ),
      const CalculatorField(
        id: 'tactile',
        label: 'Tactile Disturbances',
        type: CalculatorFieldType.select,
        options: [
          CalculatorOption(value: 0, label: '0 - None'),
          CalculatorOption(value: 1, label: '1 - Very mild itch, pins and needles, burning or numbness'),
          CalculatorOption(value: 2, label: '2 - Mild itch, pins and needles, burning or numbness'),
          CalculatorOption(value: 3, label: '3 - Moderate itch, pins and needles, burning or numbness'),
          CalculatorOption(value: 4, label: '4 - Moderately severe hallucinations'),
          CalculatorOption(value: 5, label: '5 - Severe hallucinations'),
          CalculatorOption(value: 6, label: '6 - Extremely severe hallucinations'),
          CalculatorOption(value: 7, label: '7 - Continuous hallucinations'),
        ],
      ),
      const CalculatorField(
        id: 'auditory',
        label: 'Auditory Disturbances',
        type: CalculatorFieldType.select,
        options: [
          CalculatorOption(value: 0, label: '0 - Not present'),
          CalculatorOption(value: 1, label: '1 - Very mild harshness or ability to frighten'),
          CalculatorOption(value: 2, label: '2 - Mild harshness or ability to frighten'),
          CalculatorOption(value: 3, label: '3 - Moderate harshness or ability to frighten'),
          CalculatorOption(value: 4, label: '4 - Moderately severe hallucinations'),
          CalculatorOption(value: 5, label: '5 - Severe hallucinations'),
          CalculatorOption(value: 6, label: '6 - Extremely severe hallucinations'),
          CalculatorOption(value: 7, label: '7 - Continuous hallucinations'),
        ],
      ),
      const CalculatorField(
        id: 'visual',
        label: 'Visual Disturbances',
        type: CalculatorFieldType.select,
        options: [
          CalculatorOption(value: 0, label: '0 - Not present'),
          CalculatorOption(value: 1, label: '1 - Very mild sensitivity'),
          CalculatorOption(value: 2, label: '2 - Mild sensitivity'),
          CalculatorOption(value: 3, label: '3 - Moderate sensitivity'),
          CalculatorOption(value: 4, label: '4 - Moderately severe hallucinations'),
          CalculatorOption(value: 5, label: '5 - Severe hallucinations'),
          CalculatorOption(value: 6, label: '6 - Extremely severe hallucinations'),
          CalculatorOption(value: 7, label: '7 - Continuous hallucinations'),
        ],
      ),
      const CalculatorField(
        id: 'headache',
        label: 'Headache, Fullness in Head',
        type: CalculatorFieldType.select,
        options: [
          CalculatorOption(value: 0, label: '0 - Not present'),
          CalculatorOption(value: 1, label: '1 - Very mild'),
          CalculatorOption(value: 2, label: '2 - Mild'),
          CalculatorOption(value: 3, label: '3 - Moderate'),
          CalculatorOption(value: 4, label: '4 - Moderately severe'),
          CalculatorOption(value: 5, label: '5 - Severe'),
          CalculatorOption(value: 6, label: '6 - Very severe'),
          CalculatorOption(value: 7, label: '7 - Extremely severe'),
        ],
      ),
      const CalculatorField(
        id: 'orientation',
        label: 'Orientation and Clouding of Sensorium',
        type: CalculatorFieldType.select,
        options: [
          CalculatorOption(value: 0, label: '0 - Oriented and can do serial additions'),
          CalculatorOption(value: 1, label: '1 - Cannot do serial additions or is uncertain about date'),
          CalculatorOption(value: 2, label: '2 - Disoriented for date by no more than 2 calendar days'),
          CalculatorOption(value: 3, label: '3 - Disoriented for date by more than 2 calendar days'),
          CalculatorOption(value: 4, label: '4 - Disoriented for place and/or person'),
        ],
      ),
    ],
    calculate: (values) {
      return (values['nausea'] as double) + (values['tremor'] as double) +
             (values['sweating'] as double) + (values['anxiety'] as double) +
             (values['agitation'] as double) + (values['tactile'] as double) +
             (values['auditory'] as double) + (values['visual'] as double) +
             (values['headache'] as double) + (values['orientation'] as double);
    },
    interpretations: [
      const ScoreInterpretation(min: 0, max: 8, label: 'Mild Withdrawal', description: 'No pharmacological treatment needed. Monitoring.', color: Colors.green),
      const ScoreInterpretation(min: 9, max: 15, label: 'Moderate Withdrawal', description: 'Consider benzodiazepines. Close monitoring.', color: Colors.yellow),
      const ScoreInterpretation(min: 16, max: 20, label: 'Severe Withdrawal', description: 'Benzodiazepines recommended. Continuous monitoring.', color: Colors.orange),
      const ScoreInterpretation(min: 21, max: 67, label: 'Very Severe Withdrawal', description: 'Risk of delirium tremens. ICU. IV Benzodiazepines.', color: Colors.red),
    ],
    source: 'Sullivan JT et al. Br J Addict 1989',
    sourceUrl: 'https://pubmed.ncbi.nlm.nih.gov/2597811/',
  ),
  Calculator(
    id: 'cows',
    name: 'COWS (Clinical Opiate Withdrawal Scale)',
    shortName: 'COWS',
    category: CalculatorCategory.toxicology,
    description: 'Severity of opiate withdrawal',
    fields: [
      const CalculatorField(
        id: 'pulse',
        label: 'Resting Pulse Rate',
        type: CalculatorFieldType.select,
        options: [
          CalculatorOption(value: 0, label: '0 - ≤ 80/min'),
          CalculatorOption(value: 1, label: '1 - 81-100/min'),
          CalculatorOption(value: 2, label: '2 - 101-120/min'),
          CalculatorOption(value: 4, label: '4 - > 120/min'),
        ],
      ),
      const CalculatorField(
        id: 'sweating',
        label: 'Sweating (over past 1/2 hour)',
        type: CalculatorFieldType.select,
        options: [
          CalculatorOption(value: 0, label: '0 - No report of chills or flushing'),
          CalculatorOption(value: 1, label: '1 - Subjective report of chills or flushing'),
          CalculatorOption(value: 2, label: '2 - Flushed or observable moistness on face'),
          CalculatorOption(value: 3, label: '3 - Beads of sweat on brow or face'),
          CalculatorOption(value: 4, label: '4 - Sweat streaming off face'),
        ],
      ),
      const CalculatorField(
        id: 'restlessness',
        label: 'Restlessness (observation)',
        type: CalculatorFieldType.select,
        options: [
          CalculatorOption(value: 0, label: '0 - Able to sit still'),
          CalculatorOption(value: 1, label: '1 - Reports difficulty sitting still, but is able to do so'),
          CalculatorOption(value: 3, label: '3 - Frequent shifting or extraneous movements of legs/arms'),
          CalculatorOption(value: 5, label: '5 - Unable to sit still for more than a few seconds'),
        ],
      ),
      const CalculatorField(
        id: 'pupils',
        label: 'Pupil Size',
        type: CalculatorFieldType.select,
        options: [
          CalculatorOption(value: 0, label: '0 - Pupils pinned or normal size for room light'),
          CalculatorOption(value: 1, label: '1 - Pupils possibly larger than normal for room light'),
          CalculatorOption(value: 2, label: '2 - Pupils moderately dilated'),
          CalculatorOption(value: 5, label: '5 - Pupils so dilated that only the rim of the iris is visible'),
        ],
      ),
      const CalculatorField(
        id: 'boneJointAches',
        label: 'Bone or Joint Aches',
        type: CalculatorFieldType.select,
        options: [
          CalculatorOption(value: 0, label: '0 - Not present'),
          CalculatorOption(value: 1, label: '1 - Mild diffuse discomfort'),
          CalculatorOption(value: 2, label: '2 - Patient reports severe diffuse aching of joints/muscles'),
          CalculatorOption(value: 4, label: '4 - Patient is rubbing joints or muscles and is unable to sit still because of discomfort'),
        ],
      ),
      const CalculatorField(
        id: 'runnyNose',
        label: 'Runny Nose or Tearing',
        type: CalculatorFieldType.select,
        options: [
          CalculatorOption(value: 0, label: '0 - Not present'),
          CalculatorOption(value: 1, label: '1 - Nasal stuffiness or unusually moist eyes'),
          CalculatorOption(value: 2, label: '2 - Nose running or tearing'),
          CalculatorOption(value: 4, label: '4 - Nose constantly running or tears streaming down cheeks'),
        ],
      ),
      const CalculatorField(
        id: 'gi',
        label: 'GI Upset',
        type: CalculatorFieldType.select,
        options: [
          CalculatorOption(value: 0, label: '0 - No GI symptoms'),
          CalculatorOption(value: 1, label: '1 - Stomach cramps'),
          CalculatorOption(value: 2, label: '2 - Nausea or loose stool'),
          CalculatorOption(value: 3, label: '3 - Vomiting or diarrhea'),
          CalculatorOption(value: 5, label: '5 - Multiple episodes of diarrhea or vomiting'),
        ],
      ),
      const CalculatorField(
        id: 'tremor',
        label: 'Tremor (observation of outstretched hands)',
        type: CalculatorFieldType.select,
        options: [
          CalculatorOption(value: 0, label: '0 - No tremor'),
          CalculatorOption(value: 1, label: '1 - Tremor can be felt, but not observed'),
          CalculatorOption(value: 2, label: '2 - Slight tremor observable'),
          CalculatorOption(value: 4, label: '4 - Gross tremor or muscle twitching'),
        ],
      ),
      const CalculatorField(
        id: 'yawning',
        label: 'Yawning (observation)',
        type: CalculatorFieldType.select,
        options: [
          CalculatorOption(value: 0, label: '0 - No yawning'),
          CalculatorOption(value: 1, label: '1 - Yawning once or twice during assessment'),
          CalculatorOption(value: 2, label: '2 - Yawning three or more times during assessment'),
          CalculatorOption(value: 4, label: '4 - Yawning several times/minute'),
        ],
      ),
      const CalculatorField(
        id: 'anxiety',
        label: 'Anxiety or Irritability',
        type: CalculatorFieldType.select,
        options: [
          CalculatorOption(value: 0, label: '0 - None'),
          CalculatorOption(value: 1, label: '1 - Patient reports increasing irritability or anxiety'),
          CalculatorOption(value: 2, label: '2 - Patient obviously irritable or anxious'),
          CalculatorOption(value: 4, label: '4 - Patient so irritable or anxious that participation in the assessment is difficult'),
        ],
      ),
      const CalculatorField(
        id: 'gooseflesh',
        label: 'Gooseflesh Skin',
        type: CalculatorFieldType.select,
        options: [
          CalculatorOption(value: 0, label: '0 - Skin is smooth'),
          CalculatorOption(value: 3, label: '3 - Piloerection of skin can be felt or hairs standing up on arms'),
          CalculatorOption(value: 5, label: '5 - Prominent piloerection'),
        ],
      ),
    ],
    calculate: (values) {
      return (values['pulse'] as double) + (values['sweating'] as double) +
             (values['restlessness'] as double) + (values['pupils'] as double) +
             (values['boneJointAches'] as double) + (values['runnyNose'] as double) +
             (values['gi'] as double) + (values['tremor'] as double) +
             (values['yawning'] as double) + (values['anxiety'] as double) +
             (values['gooseflesh'] as double);
    },
    interpretations: [
      const ScoreInterpretation(min: 0, max: 4, label: 'No Withdrawal', description: 'No significant symptoms.', color: Colors.green),
      const ScoreInterpretation(min: 5, max: 12, label: 'Mild Withdrawal', description: 'Symptomatic treatment.', color: Colors.green),
      const ScoreInterpretation(min: 13, max: 24, label: 'Moderate Withdrawal', description: 'Consider substitution treatment.', color: Colors.yellow),
      const ScoreInterpretation(min: 25, max: 36, label: 'Moderately Severe', description: 'Substitution treatment recommended.', color: Colors.orange),
      const ScoreInterpretation(min: 37, max: 48, label: 'Severe Withdrawal', description: 'Intensive treatment. Possible hospitalization.', color: Colors.red),
    ],
    source: 'Wesson DR, Ling W. J Psychoactive Drugs 2003',
    sourceUrl: 'https://pubmed.ncbi.nlm.nih.gov/12924748/',
  ),
  Calculator(
    id: 'ottawa-ankle',
    name: 'Ottawa Ankle Rules',
    shortName: 'Ottawa Ankle',
    category: CalculatorCategory.msk,
    description: 'Indication for radiography after ankle trauma',
    fields: [
      const CalculatorField(id: 'bonePostMalleolus', label: 'Bone tenderness at posterior edge of lateral malleolus (6cm)', type: CalculatorFieldType.checkbox),
      const CalculatorField(id: 'boneMedialMalleolus', label: 'Bone tenderness at posterior edge of medial malleolus (6cm)', type: CalculatorFieldType.checkbox),
      const CalculatorField(id: 'boneBaseMetatarsal', label: 'Bone tenderness at base of 5th metatarsal', type: CalculatorFieldType.checkbox),
      const CalculatorField(id: 'boneNavicular', label: 'Bone tenderness at navicular', type: CalculatorFieldType.checkbox),
      const CalculatorField(id: 'unableToWalk', label: 'Inability to bear weight both immediately and in ED (4 steps)', type: CalculatorFieldType.checkbox),
    ],
    calculate: (values) {
      bool anklePositive = (values['bonePostMalleolus'] == 1.0) || (values['boneMedialMalleolus'] == 1.0) || (values['unableToWalk'] == 1.0);
      bool footPositive = (values['boneBaseMetatarsal'] == 1.0) || (values['boneNavicular'] == 1.0) || (values['unableToWalk'] == 1.0);
      
      if (anklePositive || footPositive) return 1;
      return 0;
    },
    interpretations: [
      const ScoreInterpretation(min: 0, max: 0, label: 'Negative Rule', description: 'X-ray NOT indicated. Sensitivity ~100% for significant fracture.', color: Colors.green),
      const ScoreInterpretation(min: 1, max: 1, label: 'Positive Rule', description: 'X-ray indicated (ankle and/or foot depending on criteria).', color: Colors.yellow),
    ],
    source: 'Stiell IG et al. JAMA 1993',
    sourceUrl: 'https://pubmed.ncbi.nlm.nih.gov/8411587/',
  ),
  Calculator(
    id: 'ottawa-knee',
    name: 'Ottawa Knee Rules',
    shortName: 'Ottawa Knee',
    category: CalculatorCategory.msk,
    description: 'Indication for radiography after knee trauma',
    fields: [
      const CalculatorField(id: 'age55', label: 'Age ≥ 55 years', type: CalculatorFieldType.checkbox),
      const CalculatorField(id: 'fibulaHead', label: 'Isolated tenderness of head of fibula', type: CalculatorFieldType.checkbox),
      const CalculatorField(id: 'patella', label: 'Isolated tenderness of patella', type: CalculatorFieldType.checkbox),
      const CalculatorField(id: 'unableFlex90', label: 'Inability to flex to 90°', type: CalculatorFieldType.checkbox),
      const CalculatorField(id: 'unableToWalk', label: 'Inability to bear weight both immediately and in ED (4 steps)', type: CalculatorFieldType.checkbox),
    ],
    calculate: (values) {
      bool positive = (values['age55'] == 1.0) || (values['fibulaHead'] == 1.0) || (values['patella'] == 1.0) || 
                      (values['unableFlex90'] == 1.0) || (values['unableToWalk'] == 1.0);
      return positive ? 1 : 0;
    },
    interpretations: [
      const ScoreInterpretation(min: 0, max: 0, label: 'Negative Rule', description: 'X-ray NOT indicated. Sensitivity ~100% for fracture.', color: Colors.green),
      const ScoreInterpretation(min: 1, max: 1, label: 'Positive Rule', description: 'Knee X-ray indicated.', color: Colors.yellow),
    ],
    source: 'Stiell IG et al. Ann Emerg Med 1995',
    sourceUrl: 'https://pubmed.ncbi.nlm.nih.gov/7864338/',
  ),
  Calculator(
    id: 'nexus-c-spine',
    name: 'NEXUS C-Spine Rule',
    shortName: 'NEXUS',
    category: CalculatorCategory.msk,
    description: 'Clearance of cervical spine injury without imaging',
    fields: [
      const CalculatorField(id: 'focalDeficit', label: 'Focal neurologic deficit', type: CalculatorFieldType.checkbox),
      const CalculatorField(id: 'midlineSpinal', label: 'Midline cervical spinal tenderness', type: CalculatorFieldType.checkbox),
      const CalculatorField(id: 'alteredConsciousness', label: 'Altered level of consciousness', type: CalculatorFieldType.checkbox),
      const CalculatorField(id: 'intoxication', label: 'Intoxication', type: CalculatorFieldType.checkbox),
      const CalculatorField(id: 'distractingInjury', label: 'Distracting painful injury', type: CalculatorFieldType.checkbox),
    ],
    calculate: (values) {
      bool positive = (values['focalDeficit'] == 1.0) || (values['midlineSpinal'] == 1.0) || 
                      (values['alteredConsciousness'] == 1.0) || (values['intoxication'] == 1.0) || 
                      (values['distractingInjury'] == 1.0);
      return positive ? 1 : 0;
    },
    interpretations: [
      const ScoreInterpretation(min: 0, max: 0, label: 'Negative Rule', description: 'C-spine injury clinically excluded. No imaging needed.', color: Colors.green),
      const ScoreInterpretation(min: 1, max: 1, label: 'Positive Rule', description: 'C-spine imaging indicated.', color: Colors.yellow),
    ],
    source: 'Hoffman JR et al. N Engl J Med 2000',
    sourceUrl: 'https://pubmed.ncbi.nlm.nih.gov/10891517/',
  ),
  Calculator(
    id: 'canadian-c-spine',
    name: 'Canadian C-Spine Rule',
    shortName: 'Canadian C-Spine',
    category: CalculatorCategory.msk,
    description: 'Indication for C-spine imaging after trauma',
    fields: [
      const CalculatorField(
        id: 'highRiskFactor',
        label: 'High Risk Factor (any one)',
        type: CalculatorFieldType.select,
        options: [
          CalculatorOption(value: 0, label: 'No high risk factor'),
          CalculatorOption(value: 1, label: 'Age ≥ 65 years'),
          CalculatorOption(value: 1, label: 'Dangerous mechanism'),
          CalculatorOption(value: 1, label: 'Paresthesias in extremities'),
        ],
      ),
      const CalculatorField(
        id: 'lowRiskFactor',
        label: 'Low Risk Factor (allows ROM assessment)',
        type: CalculatorFieldType.select,
        options: [
          CalculatorOption(value: 0, label: 'No low risk factor'),
          CalculatorOption(value: 1, label: 'Simple rear-end MVC'),
          CalculatorOption(value: 1, label: 'Sitting position in ED'),
          CalculatorOption(value: 1, label: 'Ambulatory at any time'),
          CalculatorOption(value: 1, label: 'Delayed onset of neck pain'),
          CalculatorOption(value: 1, label: 'Absence of midline c-spine tenderness'),
        ],
      ),
      const CalculatorField(id: 'canRotate45', label: 'Able to actively rotate neck 45° left and right', type: CalculatorFieldType.checkbox),
    ],
    calculate: (values) {
      // High risk = imaging needed
      if ((values['highRiskFactor'] as double? ?? 0) == 1.0) return 2;
      
      // No low risk factor = cannot assess rotation = imaging
      if ((values['lowRiskFactor'] as double? ?? 0) == 0.0) return 2;
      
      // Low risk present, can we test rotation?
      if (values['canRotate45'] == 1.0) return 0; // No imaging needed
      
      return 1; // Cannot rotate = imaging needed
    },
    interpretations: [
      const ScoreInterpretation(min: 0, max: 0, label: 'Negative Rule', description: 'No imaging needed. C-collar removal.', color: Colors.green),
      const ScoreInterpretation(min: 1, max: 1, label: 'Unable to Rotate', description: 'Unable to rotate neck. Imaging indicated.', color: Colors.yellow),
      const ScoreInterpretation(min: 2, max: 2, label: 'High Risk', description: 'C-spine imaging MANDATORY.', color: Colors.red),
    ],
    source: 'Stiell IG et al. JAMA 2001',
    sourceUrl: 'https://pubmed.ncbi.nlm.nih.gov/11594897/',
  ),
  Calculator(
    id: 'pecarn-head',
    name: 'PECARN Head CT Rule',
    shortName: 'PECARN',
    category: CalculatorCategory.pediatric,
    description: 'Indication for head CT in children after minor head trauma',
    fields: [
      const CalculatorField(
        id: 'ageGroup',
        label: 'Age Group',
        type: CalculatorFieldType.select,
        options: [
          CalculatorOption(value: 0, label: '< 2 years'),
          CalculatorOption(value: 1, label: '≥ 2 years'),
        ],
      ),
      const CalculatorField(id: 'gcs14', label: 'GCS < 15', type: CalculatorFieldType.checkbox),
      const CalculatorField(id: 'alteredMental', label: 'Altered mental status (agitation, somnolence, repetitive questioning, slow response)', type: CalculatorFieldType.checkbox),
      const CalculatorField(id: 'baseFracture', label: 'Signs of basilar skull fracture', type: CalculatorFieldType.checkbox),
      const CalculatorField(id: 'palpableFracture', label: 'Palpable skull fracture (< 2y) / Signs of fracture (≥ 2y)', type: CalculatorFieldType.checkbox),
      const CalculatorField(id: 'hematoma', label: 'Scalp hematoma (occipital, parietal or temporal for < 2y)', type: CalculatorFieldType.checkbox),
      const CalculatorField(id: 'lossOfConsciousness', label: 'Loss of consciousness ≥ 5 seconds', type: CalculatorFieldType.checkbox),
      const CalculatorField(id: 'severeMechanism', label: 'Severe mechanism (MVC, fall > 0.9m if <2y or >1.5m if ≥2y, high impact object)', type: CalculatorFieldType.checkbox),
      const CalculatorField(id: 'notActingNormally', label: 'Not acting normally per parent (< 2y)', type: CalculatorFieldType.checkbox),
      const CalculatorField(id: 'severeHeadache', label: 'Severe headache (≥ 2y)', type: CalculatorFieldType.checkbox),
      const CalculatorField(id: 'vomiting', label: 'Vomiting (≥ 2y)', type: CalculatorFieldType.checkbox),
    ],
    calculate: (values) {
      bool isUnder2 = (values['ageGroup'] as double? ?? 0) == 0.0;
      
      // High risk criteria (CT recommended)
      bool highRisk = (values['gcs14'] == 1.0) || (values['alteredMental'] == 1.0) || 
                      (values['baseFracture'] == 1.0) || (values['palpableFracture'] == 1.0);
      
      // Intermediate risk criteria
      bool intermediateRisk = false;
      if (isUnder2) {
        intermediateRisk = (values['hematoma'] == 1.0) || (values['lossOfConsciousness'] == 1.0) || 
                           (values['severeMechanism'] == 1.0) || (values['notActingNormally'] == 1.0);
      } else {
        intermediateRisk = (values['lossOfConsciousness'] == 1.0) || (values['severeMechanism'] == 1.0) || 
                           (values['severeHeadache'] == 1.0) || (values['vomiting'] == 1.0);
      }
      
      if (highRisk) return 2; // CT recommended
      if (intermediateRisk) return 1; // Observation vs CT
      return 0; // No CT needed
    },
    interpretations: [
      const ScoreInterpretation(min: 0, max: 0, label: 'Very Low Risk', description: 'Risk of ciTBI < 0.02%. CT NOT indicated.', color: Colors.green),
      const ScoreInterpretation(min: 1, max: 1, label: 'Intermediate Risk', description: 'Risk of ciTBI 0.9%. Observation 4-6h OR CT based on clinical judgment.', color: Colors.yellow),
      const ScoreInterpretation(min: 2, max: 2, label: 'High Risk', description: 'Risk of ciTBI 4.4%. Head CT RECOMMENDED.', color: Colors.red),
    ],
    source: 'Kuppermann N et al. Lancet 2009',
    sourceUrl: 'https://pubmed.ncbi.nlm.nih.gov/19758692/',
  ),
  Calculator(
    id: 'westley-croup',
    name: 'Westley Croup Score',
    shortName: 'Westley',
    category: CalculatorCategory.pediatric,
    description: 'Severity of croup (laryngotracheobronchitis)',
    fields: [
      const CalculatorField(
        id: 'stridor',
        label: 'Stridor',
        type: CalculatorFieldType.select,
        options: [
          CalculatorOption(value: 0, label: 'None'),
          CalculatorOption(value: 1, label: 'With agitation'),
          CalculatorOption(value: 2, label: 'At rest'),
        ],
      ),
      const CalculatorField(
        id: 'retraction',
        label: 'Retractions',
        type: CalculatorFieldType.select,
        options: [
          CalculatorOption(value: 0, label: 'None'),
          CalculatorOption(value: 1, label: 'Mild'),
          CalculatorOption(value: 2, label: 'Moderate'),
          CalculatorOption(value: 3, label: 'Severe'),
        ],
      ),
      const CalculatorField(
        id: 'airEntry',
        label: 'Air Entry',
        type: CalculatorFieldType.select,
        options: [
          CalculatorOption(value: 0, label: 'Normal'),
          CalculatorOption(value: 1, label: 'Decreased'),
          CalculatorOption(value: 2, label: 'Markedly decreased'),
        ],
      ),
      const CalculatorField(
        id: 'cyanosis',
        label: 'Cyanosis',
        type: CalculatorFieldType.select,
        options: [
          CalculatorOption(value: 0, label: 'None'),
          CalculatorOption(value: 4, label: 'With agitation'),
          CalculatorOption(value: 5, label: 'At rest'),
        ],
      ),
      const CalculatorField(
        id: 'consciousness',
        label: 'Level of Consciousness',
        type: CalculatorFieldType.select,
        options: [
          CalculatorOption(value: 0, label: 'Normal'),
          CalculatorOption(value: 5, label: 'Disoriented'),
        ],
      ),
    ],
    calculate: (values) {
      return (values['stridor'] as double? ?? 0) +
             (values['retraction'] as double? ?? 0) +
             (values['airEntry'] as double? ?? 0) +
             (values['cyanosis'] as double? ?? 0) +
             (values['consciousness'] as double? ?? 0);
    },
    interpretations: [
      const ScoreInterpretation(min: 0, max: 2, label: 'Mild', description: 'Mild croup. Outpatient management, oral steroids.', color: Colors.green),
      const ScoreInterpretation(min: 3, max: 5, label: 'Moderate', description: 'Moderate croup. Dexamethasone + observation.', color: Colors.yellow),
      const ScoreInterpretation(min: 6, max: 11, label: 'Severe', description: 'Severe croup. Nebulized epinephrine + admission.', color: Colors.orange),
      const ScoreInterpretation(min: 12, max: 17, label: 'Respiratory Failure', description: 'Impending respiratory failure. Resuscitation.', color: Colors.red),
    ],
    source: 'Westley CR et al. Am J Dis Child 1978',
    sourceUrl: 'https://pubmed.ncbi.nlm.nih.gov/308551/',
  ),
  Calculator(
    id: 'pas',
    name: 'Pediatric Appendicitis Score (PAS)',
    shortName: 'PAS',
    category: CalculatorCategory.pediatric,
    description: 'Probability of appendicitis in children',
    fields: [
      const CalculatorField(id: 'migration', label: 'Migration of pain to RLQ', type: CalculatorFieldType.checkbox),
      const CalculatorField(id: 'anorexia', label: 'Anorexia', type: CalculatorFieldType.checkbox),
      const CalculatorField(id: 'nausea', label: 'Nausea/Vomiting', type: CalculatorFieldType.checkbox),
      const CalculatorField(id: 'rlfTenderness', label: 'Tenderness in RLQ', type: CalculatorFieldType.checkbox),
      const CalculatorField(id: 'coughPain', label: 'Cough/Percussion/Hop tenderness', type: CalculatorFieldType.checkbox),
      const CalculatorField(id: 'fever', label: 'Fever (T ≥ 38°C)', type: CalculatorFieldType.checkbox),
      const CalculatorField(id: 'leukocytosis', label: 'Leukocytosis > 10,000/mm³', type: CalculatorFieldType.checkbox),
      const CalculatorField(id: 'neutrophilia', label: 'Neutrophilia (PMN > 75%)', type: CalculatorFieldType.checkbox),
    ],
    calculate: (values) {
      double score = 0;
      if (values['migration'] == 1.0) score += 1;
      if (values['anorexia'] == 1.0) score += 1;
      if (values['nausea'] == 1.0) score += 1;
      if (values['rlfTenderness'] == 1.0) score += 2;
      if (values['coughPain'] == 1.0) score += 2;
      if (values['fever'] == 1.0) score += 1;
      if (values['leukocytosis'] == 1.0) score += 1;
      if (values['neutrophilia'] == 1.0) score += 1;
      return score;
    },
    interpretations: [
      const ScoreInterpretation(min: 0, max: 3, label: 'Low Probability', description: 'Appendicitis unlikely. Observation or re-evaluation.', color: Colors.green),
      const ScoreInterpretation(min: 4, max: 6, label: 'Intermediate', description: 'Appendicitis possible. Imaging recommended (US).', color: Colors.yellow),
      const ScoreInterpretation(min: 7, max: 10, label: 'High Probability', description: 'Appendicitis probable. Surgical consultation.', color: Colors.red),
    ],
    source: 'Samuel M. J Pediatr Surg 2002',
    sourceUrl: 'https://pubmed.ncbi.nlm.nih.gov/12149680/',
  ),
  Calculator(
    id: 'clinical-dehydration-scale',
    name: 'Clinical Dehydration Scale (CDS)',
    shortName: 'CDS',
    category: CalculatorCategory.pediatric,
    description: 'Assessment of dehydration in children 1mo - 5y',
    fields: [
      const CalculatorField(
        id: 'appearance',
        label: 'General Appearance',
        type: CalculatorFieldType.select,
        options: [
          CalculatorOption(value: 0, label: 'Normal'),
          CalculatorOption(value: 1, label: 'Thirsty, restless or lethargic but irritable when touched'),
          CalculatorOption(value: 2, label: 'Drowsy, limp, cold, sweaty; ± comatose'),
        ],
      ),
      const CalculatorField(
        id: 'eyes',
        label: 'Eyes',
        type: CalculatorFieldType.select,
        options: [
          CalculatorOption(value: 0, label: 'Normal'),
          CalculatorOption(value: 1, label: 'Slightly sunken'),
          CalculatorOption(value: 2, label: 'Very sunken'),
        ],
      ),
      const CalculatorField(
        id: 'mucous',
        label: 'Mucous Membranes (tongue)',
        type: CalculatorFieldType.select,
        options: [
          CalculatorOption(value: 0, label: 'Moist'),
          CalculatorOption(value: 1, label: 'Sticky'),
          CalculatorOption(value: 2, label: 'Dry'),
        ],
      ),
      const CalculatorField(
        id: 'tears',
        label: 'Tears',
        type: CalculatorFieldType.select,
        options: [
          CalculatorOption(value: 0, label: 'Present'),
          CalculatorOption(value: 1, label: 'Decreased'),
          CalculatorOption(value: 2, label: 'Absent'),
        ],
      ),
    ],
    calculate: (values) {
      return (values['appearance'] as double? ?? 0) +
             (values['eyes'] as double? ?? 0) +
             (values['mucous'] as double? ?? 0) +
             (values['tears'] as double? ?? 0);
    },
    interpretations: [
      const ScoreInterpretation(min: 0, max: 0, label: 'No Dehydration', description: 'Normal hydration. Home oral rehydration.', color: Colors.green),
      const ScoreInterpretation(min: 1, max: 4, label: 'Mild to Moderate', description: 'Dehydration 3-6%. Supervised oral rehydration.', color: Colors.yellow),
      const ScoreInterpretation(min: 5, max: 8, label: 'Moderate to Severe', description: 'Dehydration > 6%. IV rehydration probable.', color: Colors.red),
    ],
    source: 'Friedman JN et al. Pediatrics 2004',
    sourceUrl: 'https://pubmed.ncbi.nlm.nih.gov/15520095/',
  ),
  Calculator(
    id: 'qtc',
    name: 'QTc Calculator (Bazett & Fridericia)',
    shortName: 'QTc',
    category: CalculatorCategory.cardiovascular,
    description: 'Corrected QT interval calculation. Alert for QT-prolonging drugs.',
    fields: [
      const CalculatorField(id: 'qt', label: 'QT Interval (ms)', type: CalculatorFieldType.number, min: 200, max: 700, unit: 'ms'),
      const CalculatorField(id: 'rr', label: 'RR Interval (ms) or HR', type: CalculatorFieldType.number, min: 300, max: 2000, unit: 'ms'),
      const CalculatorField(id: 'useHr', label: 'Use Heart Rate instead of RR', type: CalculatorFieldType.checkbox),
    ],
    calculate: (values) {
      double qt = values['qt'] as double? ?? 0;
      double rr = values['rr'] as double? ?? 0;
      
      // Convert HR to RR if checkbox is selected
      if (values['useHr'] == 1.0) {
        if (rr == 0) return 0;
        rr = 60000 / rr; // Convert bpm to ms
      }
      
      // Bazett formula: QTc = QT / √(RR in seconds)
      double rrSeconds = rr / 1000;
      if (rrSeconds <= 0) return 0;
      double qtcBazett = qt / sqrt(rrSeconds);
      
      return qtcBazett;
    },
    interpretations: [
      const ScoreInterpretation(min: 0, max: 440, label: 'Normal QTc', description: 'QTc < 440 ms. Normal for both sexes.', color: Colors.green),
      const ScoreInterpretation(min: 441, max: 460, label: 'Borderline (Men)', description: 'QTc 440-460 ms. Borderline for men, normal for women.', color: Colors.yellow),
      const ScoreInterpretation(min: 461, max: 480, label: 'Prolonged Moderate', description: 'QTc 460-480 ms. Prolonged, monitor medications.', color: Colors.orange),
      const ScoreInterpretation(min: 481, max: 1000, label: 'Prolonged Severe', description: 'QTc > 480 ms. Risk of Torsades de Pointes. Review meds/electrolytes.', color: Colors.red),
    ],
    source: 'Bazett HC (1920), Fridericia LS (1920)',
    sourceUrl: 'https://www.ncbi.nlm.nih.gov/pmc/articles/PMC5390937/',
  ),
  Calculator(
    id: 'creatinine-clearance',
    name: 'Creatinine Clearance (Cockcroft-Gault)',
    shortName: 'CrCl',
    category: CalculatorCategory.cardiovascular,
    description: 'Estimation of GFR for drug dosing adjustment',
    fields: [
      const CalculatorField(id: 'age', label: 'Age', type: CalculatorFieldType.number, min: 18, max: 120, unit: 'years'),
      const CalculatorField(id: 'weight', label: 'Weight', type: CalculatorFieldType.number, min: 30, max: 300, unit: 'kg'),
      const CalculatorField(id: 'creatinine', label: 'Serum Creatinine', type: CalculatorFieldType.number, min: 20, max: 2000, unit: 'µmol/L'),
      const CalculatorField(id: 'female', label: 'Female Sex', type: CalculatorFieldType.checkbox),
    ],
    calculate: (values) {
      double age = values['age'] as double? ?? 0;
      double weight = values['weight'] as double? ?? 0;
      double creatMumol = values['creatinine'] as double? ?? 0;
      bool isFemale = (values['female'] as double? ?? 0) == 1.0;
      
      if (creatMumol == 0) return 0;

      // Convert µmol/L to mg/dL
      double creatMgDl = creatMumol / 88.4;
      
      // Cockcroft-Gault formula
      double cg = ((140 - age) * weight) / (72 * creatMgDl);
      if (isFemale) cg *= 0.85;
      
      return cg;
    },
    interpretations: [
      const ScoreInterpretation(min: 90, max: 200, label: 'Normal Renal Function', description: 'GFR ≥ 90 mL/min. Stage 1 CKD or normal.', color: Colors.green),
      const ScoreInterpretation(min: 60, max: 89, label: 'Mild CKD (Stage 2)', description: 'GFR 60-89 mL/min. Monitor, no major adjustment.', color: Colors.yellow),
      const ScoreInterpretation(min: 30, max: 59, label: 'Moderate CKD (Stage 3)', description: 'GFR 30-59 mL/min. Dose adjustment needed.', color: Colors.orange),
      const ScoreInterpretation(min: 15, max: 29, label: 'Severe CKD (Stage 4)', description: 'GFR 15-29 mL/min. Major adjustment, prep for dialysis.', color: Colors.red),
      const ScoreInterpretation(min: 0, max: 14, label: 'ESRD (Stage 5)', description: 'GFR < 15 mL/min. Dialysis/Transplantation.', color: Colors.red),
    ],
    source: 'Cockcroft DW, Gault MH (1976)',
    sourceUrl: 'https://pubmed.ncbi.nlm.nih.gov/1244564/',
  ),
  Calculator(
    id: 'corrected-calcium',
    name: 'Corrected Calcium (for Albumin)',
    shortName: 'Ca Corr',
    category: CalculatorCategory.cardiovascular,
    description: 'Correction of total calcium for hypoalbuminemia',
    fields: [
      const CalculatorField(id: 'calcium', label: 'Total Calcium', type: CalculatorFieldType.number, min: 1, max: 5, unit: 'mmol/L'),
      const CalculatorField(id: 'albumin', label: 'Albumin', type: CalculatorFieldType.number, min: 10, max: 60, unit: 'g/L'),
    ],
    calculate: (values) {
      double calcium = values['calcium'] as double? ?? 0;
      double albumin = values['albumin'] as double? ?? 0;
      
      // Formula: Ca corrected = Ca measured + 0.02 * (40 - Albumin)
      double corrected = calcium + 0.02 * (40 - albumin);
      
      // Return in mmol/L * 100 for display logic (e.g., 2.35 -> 235)
      return corrected * 100;
    },
    interpretations: [
      const ScoreInterpretation(min: 0, max: 209, label: 'Hypocalcemia', description: 'Corr Ca < 2.10 mmol/L. Investigate and treat.', color: Colors.orange),
      const ScoreInterpretation(min: 210, max: 260, label: 'Normal Calcium', description: 'Corr Ca 2.10-2.60 mmol/L. Normal.', color: Colors.green),
      const ScoreInterpretation(min: 261, max: 300, label: 'Mild Hypercalcemia', description: 'Corr Ca 2.60-3.00 mmol/L. Investigate cause.', color: Colors.yellow),
      const ScoreInterpretation(min: 301, max: 500, label: 'Severe Hypercalcemia', description: 'Corr Ca > 3.00 mmol/L. Emergency, hydration + bisphosphonates.', color: Colors.red),
    ],
    source: 'Payne RB et al. BMJ 1973',
    sourceUrl: 'https://pubmed.ncbi.nlm.nih.gov/4723462/',
  ),
  Calculator(
    id: 'aa-gradient',
    name: 'Alveolar-arterial Gradient (A-a)',
    shortName: 'A-a Gradient',
    category: CalculatorCategory.cardiovascular,
    description: 'Calculation of A-a gradient and comparison with expected value for age',
    fields: [
      const CalculatorField(id: 'age', label: 'Age', type: CalculatorFieldType.number, min: 1, max: 120, unit: 'years'),
      const CalculatorField(id: 'fio2', label: 'FiO2', type: CalculatorFieldType.number, min: 21, max: 100, unit: '%'),
      const CalculatorField(id: 'pao2', label: 'PaO2 (ABG)', type: CalculatorFieldType.number, min: 20, max: 600, unit: 'mmHg'),
      const CalculatorField(id: 'paco2', label: 'PaCO2 (ABG)', type: CalculatorFieldType.number, min: 10, max: 120, unit: 'mmHg'),
      const CalculatorField(id: 'patm', label: 'Atmospheric Pressure', type: CalculatorFieldType.number, min: 600, max: 800, unit: 'mmHg'),
    ],
    calculate: (values) {
      double fio2 = (values['fio2'] as double? ?? 21) / 100;
      double pao2 = values['pao2'] as double? ?? 0;
      double paco2 = values['paco2'] as double? ?? 0;
      double patm = values['patm'] as double? ?? 760;
      if (patm == 0) patm = 760;
      
      // PAO2 = FiO2 * (Patm - 47) - (PaCO2 / 0.8)
      double pao2Alveolar = fio2 * (patm - 47) - (paco2 / 0.8);
      
      // A-a gradient = PAO2 - PaO2
      double aaGradient = pao2Alveolar - pao2;
      
      return aaGradient;
    },
    interpretations: [
      const ScoreInterpretation(min: -50, max: 15, label: 'Normal A-a Gradient', description: 'Normal gradient (expected = age/4 + 4). No gas exchange issue.', color: Colors.green),
      const ScoreInterpretation(min: 16, max: 30, label: 'Mildly Elevated', description: 'Mild gas exchange issue. May be normal in elderly.', color: Colors.yellow),
      const ScoreInterpretation(min: 31, max: 50, label: 'Moderately Elevated', description: 'Moderate issue: shunt, V/Q mismatch, parenchymal disease.', color: Colors.orange),
      const ScoreInterpretation(min: 51, max: 700, label: 'Severely Elevated', description: 'Severe gas exchange issue. Significant shunt or severe disease.', color: Colors.red),
    ],
    source: 'Mellemgaard K. Acta Physiol Scand 1966',
    sourceUrl: 'https://pubmed.ncbi.nlm.nih.gov/5963795/',
  ),
  Calculator(
    id: 'meld',
    name: 'MELD Score (Model for End-Stage Liver Disease)',
    shortName: 'MELD',
    category: CalculatorCategory.gi,
    description: 'Severity of end-stage liver disease. Transplant priority.',
    fields: [
      const CalculatorField(id: 'creatinine', label: 'Serum Creatinine', type: CalculatorFieldType.number, min: 10, max: 1500, unit: 'µmol/L'),
      const CalculatorField(id: 'bilirubin', label: 'Total Bilirubin', type: CalculatorFieldType.number, min: 1, max: 1000, unit: 'µmol/L'),
      const CalculatorField(id: 'inr', label: 'INR', type: CalculatorFieldType.number, min: 0.5, max: 15),
      const CalculatorField(id: 'dialysis', label: 'Dialysis (≥2x/week) or CVVHD in past 7 days', type: CalculatorFieldType.checkbox),
    ],
    calculate: (values) {
      double creatMumol = values['creatinine'] as double? ?? 0;
      double biliMumol = values['bilirubin'] as double? ?? 0;
      double inr = values['inr'] as double? ?? 0;
      bool dialysis = (values['dialysis'] as double? ?? 0) == 1.0;

      double creatMgDl = creatMumol / 88.4;
      double biliMgDl = biliMumol / 17.1;
      
      // Cap values per UNOS guidelines
      if (creatMgDl < 1) creatMgDl = 1;
      if (creatMgDl > 4 || dialysis) creatMgDl = 4;
      if (biliMgDl < 1) biliMgDl = 1;
      if (inr < 1) inr = 1;
      
      // MELD = 10 * (0.957 * ln(Creat) + 0.378 * ln(Bili) + 1.120 * ln(INR) + 0.643)
      double meld = 10 * (
        0.957 * log(creatMgDl) +
        0.378 * log(biliMgDl) +
        1.120 * log(inr) +
        0.643
      );
      
      // Round and cap at 40
      double result = meld.roundToDouble();
      if (result > 40) result = 40;
      return result;
    },
    interpretations: [
      const ScoreInterpretation(min: 6, max: 9, label: 'MELD 6-9', description: '3-month mortality: 1.9%. Low transplant priority.', color: Colors.green),
      const ScoreInterpretation(min: 10, max: 19, label: 'MELD 10-19', description: '3-month mortality: 6%. Close monitoring.', color: Colors.yellow),
      const ScoreInterpretation(min: 20, max: 29, label: 'MELD 20-29', description: '3-month mortality: 19.6%. Moderate transplant priority.', color: Colors.orange),
      const ScoreInterpretation(min: 30, max: 39, label: 'MELD 30-39', description: '3-month mortality: 52.6%. High transplant priority.', color: Colors.red),
      const ScoreInterpretation(min: 40, max: 50, label: 'MELD ≥ 40', description: '3-month mortality: 71.3%. Emergency transplantation.', color: Colors.red),
    ],
    source: 'Kamath PS et al. Hepatology 2001; UNOS',
    sourceUrl: 'https://pubmed.ncbi.nlm.nih.gov/11172350/',
  ),
  // LRINEC Score - Necrotizing Fasciitis
  Calculator(
    id: 'lrinec',
    name: 'LRINEC Score',
    shortName: 'LRINEC',
    category: CalculatorCategory.sepsis,
    description: 'Laboratory Risk Indicator for Necrotizing Fasciitis',
    fields: [
      const CalculatorField(
        id: 'crp',
        label: 'CRP (mg/L)',
        type: CalculatorFieldType.select,
        options: [
          CalculatorOption(value: 0, label: '< 150'),
          CalculatorOption(value: 4, label: '≥ 150'),
        ],
      ),
      const CalculatorField(
        id: 'wbc',
        label: 'White Blood Cell Count (×10⁹/L)',
        type: CalculatorFieldType.select,
        options: [
          CalculatorOption(value: 0, label: '< 15'),
          CalculatorOption(value: 1, label: '15-25'),
          CalculatorOption(value: 2, label: '> 25'),
        ],
      ),
      const CalculatorField(
        id: 'hb',
        label: 'Hemoglobin (g/dL)',
        type: CalculatorFieldType.select,
        options: [
          CalculatorOption(value: 0, label: '> 13.5'),
          CalculatorOption(value: 1, label: '11-13.5'),
          CalculatorOption(value: 2, label: '< 11'),
        ],
      ),
      const CalculatorField(
        id: 'sodium',
        label: 'Sodium (mmol/L)',
        type: CalculatorFieldType.select,
        options: [
          CalculatorOption(value: 0, label: '≥ 135'),
          CalculatorOption(value: 2, label: '< 135'),
        ],
      ),
      const CalculatorField(
        id: 'creatinine',
        label: 'Creatinine (µmol/L)',
        type: CalculatorFieldType.select,
        options: [
          CalculatorOption(value: 0, label: '≤ 141'),
          CalculatorOption(value: 2, label: '> 141'),
        ],
      ),
      const CalculatorField(
        id: 'glucose',
        label: 'Glucose (mmol/L)',
        type: CalculatorFieldType.select,
        options: [
          CalculatorOption(value: 0, label: '≤ 10'),
          CalculatorOption(value: 1, label: '> 10'),
        ],
      ),
    ],
    calculate: (values) {
      double score = 0;
      score += (values['crp'] as double? ?? 0);
      score += (values['wbc'] as double? ?? 0);
      score += (values['hb'] as double? ?? 0);
      score += (values['sodium'] as double? ?? 0);
      score += (values['creatinine'] as double? ?? 0);
      score += (values['glucose'] as double? ?? 0);
      return score;
    },
    interpretations: [
      const ScoreInterpretation(min: 0, max: 5, label: 'Low Risk', description: 'Necrotizing fasciitis probability < 50%.', color: Colors.green),
      const ScoreInterpretation(min: 6, max: 7, label: 'Intermediate Risk', description: 'Necrotizing fasciitis probability 50-75%. Urgent imaging.', color: Colors.yellow),
      const ScoreInterpretation(min: 8, max: 13, label: 'High Risk', description: 'Necrotizing fasciitis probability > 75%. Urgent surgical exploration.', color: Colors.red),
    ],
    source: 'Wong CH et al. Crit Care Med 2004',
    sourceUrl: 'https://pubmed.ncbi.nlm.nih.gov/15241098/',
  ),
  // Centor Criteria - Strep Throat
  Calculator(
    id: 'centor',
    name: 'Centor Criteria (Modified/McIsaac)',
    shortName: 'Centor',
    category: CalculatorCategory.sepsis,
    description: 'Probability of Group A Streptococcal pharyngitis',
    fields: [
      const CalculatorField(id: 'exudate', label: 'Tonsillar exudate or swelling', type: CalculatorFieldType.checkbox),
      const CalculatorField(id: 'adenopathy', label: 'Tender anterior cervical lymphadenopathy', type: CalculatorFieldType.checkbox),
      const CalculatorField(id: 'fever', label: 'Fever (> 38°C) or history of fever', type: CalculatorFieldType.checkbox),
      const CalculatorField(id: 'noCough', label: 'Absence of cough', type: CalculatorFieldType.checkbox),
      const CalculatorField(
        id: 'age',
        label: 'Age',
        type: CalculatorFieldType.select,
        options: [
          CalculatorOption(value: 1, label: '3-14 years'),
          CalculatorOption(value: 0, label: '15-44 years'),
          CalculatorOption(value: -1, label: '≥ 45 years'),
        ],
      ),
    ],
    calculate: (values) {
      double score = 0;
      if (values['exudate'] == 1.0) score += 1;
      if (values['adenopathy'] == 1.0) score += 1;
      if (values['fever'] == 1.0) score += 1;
      if (values['noCough'] == 1.0) score += 1;
      score += (values['age'] as double? ?? 0);
      return score;
    },
    interpretations: [
      const ScoreInterpretation(min: -1, max: 0, label: 'Très bas', description: 'Probabilité SGA 1-2,5%. Pas d\'antibiotiques ni test rapide.', color: Colors.green),
      const ScoreInterpretation(min: 1, max: 1, label: 'Bas', description: 'Probabilité SGA 5-10%. Test rapide optionnel.', color: Colors.green),
      const ScoreInterpretation(min: 2, max: 3, label: 'Modéré', description: 'Probabilité SGA 11-35%. Test rapide recommandé.', color: Colors.yellow),
      const ScoreInterpretation(min: 4, max: 5, label: 'Élevé', description: 'Probabilité SGA 51-53%. Test rapide ou antibiotiques empiriques.', color: Colors.red),
    ],
    source: 'McIsaac WJ et al. CMAJ 2000',
    sourceUrl: 'https://pubmed.ncbi.nlm.nih.gov/10680463/',
  ),
];
