import 'dart:math';
import 'package:flutter/material.dart';
import '../../domain/entities/calculator.dart';
import '../../core/l10n/localized.dart';

final List<Calculator> allCalculators = [
  // Trauma
  Calculator(
    id: 'gcs',
    name: LString('Glasgow Coma Scale (GCS)', 'Glasgow Coma Scale (GCS)'),
    shortName: 'GCS',
    category: CalculatorCategory.trauma,
    description: LString('Évaluation standardisée du niveau de conscience', 'Évaluation standardisée du niveau de conscience'),
    fields: [
      const CalculatorField(
        id: 'eye',
        label: LString('Réponse oculaire (E)', 'Réponse oculaire (E)'),
        type: CalculatorFieldType.select,
        options: [
          CalculatorOption(value: 4, label: LString('Spontanée', 'Spontanée'), description: LString('Yeux ouverts spontanément', 'Yeux ouverts spontanément')),
          CalculatorOption(value: 3, label: LString('Au bruit', 'Au bruit'), description: LString('Ouverture à l\'appel ou au bruit', 'Ouverture à l\'appel ou au bruit')),
          CalculatorOption(value: 2, label: LString('À la douleur', 'À la douleur'), description: LString('Ouverture à la stimulation douloureuse', 'Ouverture à la stimulation douloureuse')),
          CalculatorOption(value: 1, label: LString('Aucune', 'Aucune'), description: LString('Pas d\'ouverture des yeux', 'Pas d\'ouverture des yeux')),
        ],
      ),
      const CalculatorField(
        id: 'verbal',
        label: LString('Réponse verbale (V)', 'Réponse verbale (V)'),
        type: CalculatorFieldType.select,
        options: [
          CalculatorOption(value: 5, label: LString('Orientée', 'Orientée'), description: LString('Orienté dans le temps, l\'espace et la personne', 'Orienté dans le temps, l\'espace et la personne')),
          CalculatorOption(value: 4, label: LString('Confuse', 'Confuse'), description: LString('Conversation confuse mais répond aux questions', 'Conversation confuse mais répond aux questions')),
          CalculatorOption(value: 3, label: LString('Mots inappropriés', 'Mots inappropriés'), description: LString('Mots incohérents, discours reconnaissable', 'Mots incohérents, discours reconnaissable')),
          CalculatorOption(value: 2, label: LString('Sons incompréhensibles', 'Sons incompréhensibles'), description: LString('Sons ou gémissements incompréhensibles', 'Sons ou gémissements incompréhensibles')),
          CalculatorOption(value: 1, label: LString('Aucune', 'Aucune'), description: LString('Pas de réponse verbale', 'Pas de réponse verbale')),
        ],
      ),
      const CalculatorField(
        id: 'motor',
        label: LString('Réponse motrice (M)', 'Réponse motrice (M)'),
        type: CalculatorFieldType.select,
        options: [
          CalculatorOption(value: 6, label: LString('Obéit aux ordres', 'Obéit aux ordres'), description: LString('Exécute les ordres simples', 'Exécute les ordres simples')),
          CalculatorOption(value: 5, label: LString('Localise la douleur', 'Localise la douleur'), description: LString('Mouvement dirigé vers le stimulus', 'Mouvement dirigé vers le stimulus')),
          CalculatorOption(value: 4, label: LString('Évitement', 'Évitement'), description: LString('Retrait à la douleur', 'Retrait à la douleur')),
          CalculatorOption(value: 3, label: LString('Flexion anormale', 'Flexion anormale'), description: LString('Décortication', 'Décortication')),
          CalculatorOption(value: 2, label: LString('Extension', 'Extension'), description: LString('Décérébration', 'Décérébration')),
          CalculatorOption(value: 1, label: LString('Aucune', 'Aucune'), description: LString('Pas de réponse motrice', 'Pas de réponse motrice')),
        ],
      ),
    ],
    calculate: (values) {
      return (values['eye'] as double) + (values['verbal'] as double) + (values['motor'] as double);
    },
    interpretations: [
      const ScoreInterpretation(min: 15, max: 15, label: LString('Normal', 'Normal'), description: LString('Conscience normale', 'Conscience normale'), color: Colors.green),
      const ScoreInterpretation(min: 13, max: 14, label: LString('Léger', 'Léger'), description: LString('Traumatisme crânien léger', 'Traumatisme crânien léger'), color: Colors.yellow),
      const ScoreInterpretation(min: 9, max: 12, label: LString('Modéré', 'Modéré'), description: LString('Traumatisme crânien modéré', 'Traumatisme crânien modéré'), color: Colors.orange),
      const ScoreInterpretation(min: 3, max: 8, label: LString('Sévère', 'Sévère'), description: LString('Traumatisme crânien sévère - Intubation recommandée', 'Traumatisme crânien sévère - Intubation recommandée'), color: Colors.red),
    ],
    source: 'Teasdale G, Jennett B. Lancet 1974',
    sourceUrl: 'https://pubmed.ncbi.nlm.nih.gov/4136544/',
  ),
  Calculator(
    id: 'shock-index',
    name: LString('Indice de Choc', 'Indice de Choc'),
    shortName: 'SI',
    category: CalculatorCategory.trauma,
    description: LString('Détection précoce du choc occulte (FC/PAS)', 'Détection précoce du choc occulte (FC/PAS)'),
    fields: [
      const CalculatorField(
        id: 'heartRate',
        label: LString('Fréquence Cardiaque', 'Fréquence Cardiaque'),
        type: CalculatorFieldType.number,
        min: 30,
        max: 250,
        unit: 'bpm',
      ),
      const CalculatorField(
        id: 'systolicBP',
        label: LString('PA Systolique', 'PA Systolique'),
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
      const ScoreInterpretation(min: 0, max: 0.5, label: LString('Bas Normal', 'Bas Normal'), description: LString('Pas de signe de choc', 'Pas de signe de choc'), color: Colors.green),
      const ScoreInterpretation(min: 0.5, max: 0.7, label: LString('Normal', 'Normal'), description: LString('Valeur normale', 'Valeur normale'), color: Colors.green),
      const ScoreInterpretation(min: 0.7, max: 0.9, label: LString('Élevé', 'Élevé'), description: LString('Choc compensé possible', 'Choc compensé possible'), color: Colors.yellow),
      const ScoreInterpretation(min: 0.9, max: 1.1, label: LString('Haut', 'Haut'), description: LString('Choc probable - Envisager transfusion massive', 'Choc probable - Envisager transfusion massive'), color: Colors.orange),
      const ScoreInterpretation(min: 1.1, max: 10, label: LString('Critique', 'Critique'), description: LString('Choc sévère - Réanimation urgente', 'Choc sévère - Réanimation urgente'), color: Colors.red),
    ],
    source: 'Allgöwer M, Burri C. Dtsch Med Wochenschr 1967',
    sourceUrl: 'https://pubmed.ncbi.nlm.nih.gov/4860946/',
  ),
  Calculator(
    id: 'rts',
    name: LString('Revised Trauma Score (RTS)', 'Revised Trauma Score (RTS)'),
    shortName: 'RTS',
    category: CalculatorCategory.trauma,
    description: LString('Score de triage pour orientation vers centre de traumatologie', 'Score de triage pour orientation vers centre de traumatologie'),
    fields: [
      const CalculatorField(
        id: 'gcs',
        label: LString('Glasgow Coma Scale', 'Glasgow Coma Scale'),
        type: CalculatorFieldType.select,
        options: [
          CalculatorOption(value: 4, label: LString('13-15', '13-15')),
          CalculatorOption(value: 3, label: LString('9-12', '9-12')),
          CalculatorOption(value: 2, label: LString('6-8', '6-8')),
          CalculatorOption(value: 1, label: LString('4-5', '4-5')),
          CalculatorOption(value: 0, label: LString('3', '3')),
        ],
      ),
      const CalculatorField(
        id: 'sbp',
        label: LString('PA Systolique', 'PA Systolique'),
        type: CalculatorFieldType.select,
        options: [
          CalculatorOption(value: 4, label: LString('> 89 mmHg', '> 89 mmHg')),
          CalculatorOption(value: 3, label: LString('76-89 mmHg', '76-89 mmHg')),
          CalculatorOption(value: 2, label: LString('50-75 mmHg', '50-75 mmHg')),
          CalculatorOption(value: 1, label: LString('1-49 mmHg', '1-49 mmHg')),
          CalculatorOption(value: 0, label: LString('0 mmHg', '0 mmHg')),
        ],
      ),
      const CalculatorField(
        id: 'rr',
        label: LString('Fréquence Respiratoire', 'Fréquence Respiratoire'),
        type: CalculatorFieldType.select,
        options: [
          CalculatorOption(value: 4, label: LString('10-29/min', '10-29/min')),
          CalculatorOption(value: 3, label: LString('> 29/min', '> 29/min')),
          CalculatorOption(value: 2, label: LString('6-9/min', '6-9/min')),
          CalculatorOption(value: 1, label: LString('1-5/min', '1-5/min')),
          CalculatorOption(value: 0, label: LString('0/min', '0/min')),
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
      const ScoreInterpretation(min: 7.84, max: 8, label: LString('Excellent', 'Excellent'), description: LString('Pronostic excellent', 'Pronostic excellent'), color: Colors.green),
      const ScoreInterpretation(min: 6, max: 7.84, label: LString('Bon', 'Bon'), description: LString('Pronostic favorable', 'Pronostic favorable'), color: Colors.yellow),
      const ScoreInterpretation(min: 4, max: 6, label: LString('Modéré', 'Modéré'), description: LString('Centre de traumatologie recommandé', 'Centre de traumatologie recommandé'), color: Colors.orange),
      const ScoreInterpretation(min: 0, max: 4, label: LString('Critique', 'Critique'), description: LString('Pronostic défavorable - Trauma Center niveau 1', 'Pronostic défavorable - Trauma Center niveau 1'), color: Colors.red),
    ],
    source: 'Champion HR et al. J Trauma 1989',
    sourceUrl: 'https://pubmed.ncbi.nlm.nih.gov/2716524/',
  ),
  Calculator(
    id: 'four-score',
    name: LString('FOUR Score', 'FOUR Score'),
    shortName: 'FOUR',
    category: CalculatorCategory.trauma,
    description: LString('Alternative au GCS pour patients intubés - Full Outline of UnResponsiveness', 'Alternative au GCS pour patients intubés - Full Outline of UnResponsiveness'),
    fields: [
      const CalculatorField(
        id: 'eye',
        label: LString('Réponse oculaire', 'Réponse oculaire'),
        type: CalculatorFieldType.select,
        options: [
          CalculatorOption(value: 4, label: LString('Paupières ouvertes, poursuite', 'Paupières ouvertes, poursuite'), description: LString('Paupières ouvertes, suit du regard', 'Paupières ouvertes, suit du regard')),
          CalculatorOption(value: 3, label: LString('Paupières ouvertes, pas de poursuite', 'Paupières ouvertes, pas de poursuite'), description: LString('Paupières ouvertes, pas de poursuite', 'Paupières ouvertes, pas de poursuite')),
          CalculatorOption(value: 2, label: LString('Ouverture à la voix forte', 'Ouverture à la voix forte'), description: LString('Paupières fermées, ouverture à la voix forte', 'Paupières fermées, ouverture à la voix forte')),
          CalculatorOption(value: 1, label: LString('Ouverture à la douleur', 'Ouverture à la douleur'), description: LString('Paupières fermées, ouverture à la douleur', 'Paupières fermées, ouverture à la douleur')),
          CalculatorOption(value: 0, label: LString('Pas d\'ouverture', 'Pas d\'ouverture'), description: LString('Paupières fermées malgré la douleur', 'Paupières fermées malgré la douleur')),
        ],
      ),
      const CalculatorField(
        id: 'motor',
        label: LString('Réponse motrice', 'Réponse motrice'),
        type: CalculatorFieldType.select,
        options: [
          CalculatorOption(value: 4, label: LString('Pouce levé, poing, signe V', 'Pouce levé, poing, signe V'), description: LString('Exécute des ordres simples', 'Exécute des ordres simples')),
          CalculatorOption(value: 3, label: LString('Localise la douleur', 'Localise la douleur'), description: LString('Localise la douleur', 'Localise la douleur')),
          CalculatorOption(value: 2, label: LString('Flexion à la douleur', 'Flexion à la douleur'), description: LString('Flexion à la douleur', 'Flexion à la douleur')),
          CalculatorOption(value: 1, label: LString('Extension à la douleur', 'Extension à la douleur'), description: LString('Extension à la douleur', 'Extension à la douleur')),
          CalculatorOption(value: 0, label: LString('Aucune réponse / myoclonies', 'Aucune réponse / myoclonies'), description: LString('Pas de réponse ou myoclonies généralisées', 'Pas de réponse ou myoclonies généralisées')),
        ],
      ),
      const CalculatorField(
        id: 'brainstem',
        label: LString('Réflexes du tronc cérébral', 'Réflexes du tronc cérébral'),
        type: CalculatorFieldType.select,
        options: [
          CalculatorOption(value: 4, label: LString('Pupilles et cornéens présents', 'Pupilles et cornéens présents'), description: LString('Réflexes pupillaires et cornéens présents', 'Réflexes pupillaires et cornéens présents')),
          CalculatorOption(value: 3, label: LString('Une pupille fixe et dilatée', 'Une pupille fixe et dilatée'), description: LString('Une pupille large et fixe', 'Une pupille large et fixe')),
          CalculatorOption(value: 2, label: LString('Pupilles OU cornéens absents', 'Pupilles OU cornéens absents'), description: LString('Réflexe pupillaire OU cornéen absent', 'Réflexe pupillaire OU cornéen absent')),
          CalculatorOption(value: 1, label: LString('Pupilles ET cornéens absents', 'Pupilles ET cornéens absents'), description: LString('Réflexes pupillaires ET cornéens absents', 'Réflexes pupillaires ET cornéens absents')),
          CalculatorOption(value: 0, label: LString('Tous réflexes absents', 'Tous réflexes absents'), description: LString('Pupilles, cornéens ET toux absents', 'Pupilles, cornéens ET toux absents')),
        ],
      ),
      const CalculatorField(
        id: 'respiration',
        label: LString('Respiration', 'Respiration'),
        type: CalculatorFieldType.select,
        options: [
          CalculatorOption(value: 4, label: LString('Régulière, non intubé', 'Régulière, non intubé'), description: LString('Respiration régulière, non intubé', 'Respiration régulière, non intubé')),
          CalculatorOption(value: 3, label: LString('Cheyne-Stokes', 'Cheyne-Stokes'), description: LString('Respiration de Cheyne-Stokes', 'Respiration de Cheyne-Stokes')),
          CalculatorOption(value: 2, label: LString('Irrégulière', 'Irrégulière'), description: LString('Respiration irrégulière', 'Respiration irrégulière')),
          CalculatorOption(value: 1, label: LString('Intubé, cycles spontanés', 'Intubé, cycles spontanés'), description: LString('Intubé, respire au-dessus du ventilateur', 'Intubé, respire au-dessus du ventilateur')),
          CalculatorOption(value: 0, label: LString('Intubé, pas de cycles / Apnée', 'Intubé, pas de cycles / Apnée'), description: LString('Intubé, respire au rythme du ventilateur / Apnée', 'Intubé, respire au rythme du ventilateur / Apnée')),
        ],
      ),
    ],
    calculate: (values) {
      return (values['eye'] as double) + (values['motor'] as double) + 
             (values['brainstem'] as double) + (values['respiration'] as double);
    },
    interpretations: [
      const ScoreInterpretation(min: 16, max: 16, label: LString('Normal', 'Normal'), description: LString('Conscience normale', 'Conscience normale'), color: Colors.green),
      const ScoreInterpretation(min: 12, max: 15, label: LString('Altéré', 'Altéré'), description: LString('Altération modérée', 'Altération modérée'), color: Colors.yellow),
      const ScoreInterpretation(min: 8, max: 11, label: LString('Sévère', 'Sévère'), description: LString('Altération sévère', 'Altération sévère'), color: Colors.orange),
      const ScoreInterpretation(min: 0, max: 7, label: LString('Critique', 'Critique'), description: LString('Coma profond - Rechercher engagement', 'Coma profond - Rechercher engagement'), color: Colors.red),
    ],
    source: 'Wijdicks EF et al. Ann Neurol 2005',
    sourceUrl: 'https://pubmed.ncbi.nlm.nih.gov/15984004/',
  ),
  Calculator(
    id: 'qsofa',
    name: LString('qSOFA Score', 'qSOFA Score'),
    shortName: 'qSOFA',
    category: CalculatorCategory.sepsis,
    description: LString('Évaluation rapide du risque de sepsis', 'Évaluation rapide du risque de sepsis'),
    fields: [
      const CalculatorField(id: 'rr22', label: LString('Fréquence respiratoire ≥ 22/min', 'Fréquence respiratoire ≥ 22/min'), type: CalculatorFieldType.checkbox),
      const CalculatorField(id: 'gcs15', label: LString('Altération mentale (GCS < 15)', 'Altération mentale (GCS < 15)'), type: CalculatorFieldType.checkbox),
      const CalculatorField(id: 'sbp100', label: LString('PA systolique ≤ 100 mmHg', 'PA systolique ≤ 100 mmHg'), type: CalculatorFieldType.checkbox),
    ],
    calculate: (values) {
      int score = 0;
      if (values['rr22'] == 1.0) score += 1;
      if (values['gcs15'] == 1.0) score += 1;
      if (values['sbp100'] == 1.0) score += 1;
      return score.toDouble();
    },
    interpretations: [
      const ScoreInterpretation(min: 0, max: 1, label: LString('Risque Faible', 'Risque Faible'), description: LString('Mortalité hospitalière < 3%. Surveillance.', 'Mortalité hospitalière < 3%. Surveillance.'), color: Colors.green),
      const ScoreInterpretation(min: 2, max: 3, label: LString('Risque Élevé', 'Risque Élevé'), description: LString('Mortalité hospitalière 10-24%. Évaluer dysfonction d\'organe (SOFA).', 'Mortalité hospitalière 10-24%. Évaluer dysfonction d\'organe (SOFA).'), color: Colors.red),
    ],
    source: 'Singer M et al. JAMA 2016 (Sepsis-3)',
    sourceUrl: 'https://pubmed.ncbi.nlm.nih.gov/26903338/',
  ),
  Calculator(
    id: 'news2',
    name: LString('NEWS2 Score', 'NEWS2 Score'),
    shortName: 'NEWS2',
    category: CalculatorCategory.sepsis,
    description: LString('National Early Warning Score 2 - Détection de détérioration clinique', 'National Early Warning Score 2 - Détection de détérioration clinique'),
    fields: [
      const CalculatorField(
        id: 'rr',
        label: LString('Fréquence Respiratoire', 'Fréquence Respiratoire'),
        type: CalculatorFieldType.select,
        options: [
          CalculatorOption(value: 3, label: LString('≤ 8/min', '≤ 8/min')),
          CalculatorOption(value: 1, label: LString('9-11/min', '9-11/min')),
          CalculatorOption(value: 0, label: LString('12-20/min', '12-20/min')),
          CalculatorOption(value: 2, label: LString('21-24/min', '21-24/min')),
          CalculatorOption(value: 3, label: LString('≥ 25/min', '≥ 25/min')),
        ],
      ),
      const CalculatorField(
        id: 'spo2',
        label: LString('SpO2 (Échelle 1)', 'SpO2 (Échelle 1)'),
        type: CalculatorFieldType.select,
        options: [
          CalculatorOption(value: 3, label: LString('≤ 91%', '≤ 91%')),
          CalculatorOption(value: 2, label: LString('92-93%', '92-93%')),
          CalculatorOption(value: 1, label: LString('94-95%', '94-95%')),
          CalculatorOption(value: 0, label: LString('≥ 96%', '≥ 96%')),
        ],
      ),
      const CalculatorField(id: 'o2', label: LString('Oxygène supplémentaire', 'Oxygène supplémentaire'), type: CalculatorFieldType.checkbox),
      const CalculatorField(
        id: 'sbp',
        label: LString('PA Systolique', 'PA Systolique'),
        type: CalculatorFieldType.select,
        options: [
          CalculatorOption(value: 3, label: LString('≤ 90 mmHg', '≤ 90 mmHg')),
          CalculatorOption(value: 2, label: LString('91-100 mmHg', '91-100 mmHg')),
          CalculatorOption(value: 1, label: LString('101-110 mmHg', '101-110 mmHg')),
          CalculatorOption(value: 0, label: LString('111-219 mmHg', '111-219 mmHg')),
          CalculatorOption(value: 3, label: LString('≥ 220 mmHg', '≥ 220 mmHg')),
        ],
      ),
      const CalculatorField(
        id: 'hr',
        label: LString('Fréquence Cardiaque', 'Fréquence Cardiaque'),
        type: CalculatorFieldType.select,
        options: [
          CalculatorOption(value: 3, label: LString('≤ 40/min', '≤ 40/min')),
          CalculatorOption(value: 1, label: LString('41-50/min', '41-50/min')),
          CalculatorOption(value: 0, label: LString('51-90/min', '51-90/min')),
          CalculatorOption(value: 1, label: LString('91-110/min', '91-110/min')),
          CalculatorOption(value: 2, label: LString('111-130/min', '111-130/min')),
          CalculatorOption(value: 3, label: LString('≥ 131/min', '≥ 131/min')),
        ],
      ),
      const CalculatorField(
        id: 'consciousness',
        label: LString('Conscience (ACVPU)', 'Conscience (ACVPU)'),
        type: CalculatorFieldType.select,
        options: [
          CalculatorOption(value: 0, label: LString('A - Alerte', 'A - Alerte')),
          CalculatorOption(value: 3, label: LString('C - Confusion nouvelle', 'C - Confusion nouvelle')),
          CalculatorOption(value: 3, label: LString('V - Réponse à la voix', 'V - Réponse à la voix')),
          CalculatorOption(value: 3, label: LString('P - Réponse à la douleur', 'P - Réponse à la douleur')),
          CalculatorOption(value: 3, label: LString('U - Inconscient', 'U - Inconscient')),
        ],
      ),
      const CalculatorField(
        id: 'temp',
        label: LString('Température', 'Température'),
        type: CalculatorFieldType.select,
        options: [
          CalculatorOption(value: 3, label: LString('≤ 35.0°C', '≤ 35.0°C')),
          CalculatorOption(value: 1, label: LString('35.1-36.0°C', '35.1-36.0°C')),
          CalculatorOption(value: 0, label: LString('36.1-38.0°C', '36.1-38.0°C')),
          CalculatorOption(value: 1, label: LString('38.1-39.0°C', '38.1-39.0°C')),
          CalculatorOption(value: 2, label: LString('≥ 39.1°C', '≥ 39.1°C')),
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
      const ScoreInterpretation(min: 0, max: 0, label: LString('Faible', 'Faible'), description: LString('Surveillance standard', 'Surveillance standard'), color: Colors.green),
      const ScoreInterpretation(min: 1, max: 4, label: LString('Faible-Moyen', 'Faible-Moyen'), description: LString('Surveillance renforcée. Réévaluer à 4-6h.', 'Surveillance renforcée. Réévaluer à 4-6h.'), color: Colors.yellow),
      const ScoreInterpretation(min: 5, max: 6, label: LString('Moyen', 'Moyen'), description: LString('Réponse urgente. Avis médecin senior.', 'Réponse urgente. Avis médecin senior.'), color: Colors.orange),
      const ScoreInterpretation(min: 7, max: 20, label: LString('Élevé', 'Élevé'), description: LString('Réponse d\'urgence immédiate. Équipe réanimation.', 'Réponse d\'urgence immédiate. Équipe réanimation.'), color: Colors.red),
    ],
    source: 'Royal College of Physicians 2017',
    sourceUrl: 'https://www.rcplondon.ac.uk/projects/outputs/national-early-warning-score-news-2',
  ),
  Calculator(
    id: 'curb65',
    name: LString('CURB-65 Score', 'CURB-65 Score'),
    shortName: 'CURB-65',
    category: CalculatorCategory.sepsis,
    description: LString('Score de sévérité de la pneumonie', 'Score de sévérité de la pneumonie'),
    fields: [
      const CalculatorField(id: 'confusion', label: LString('C - Confusion nouvelle', 'C - Confusion nouvelle'), type: CalculatorFieldType.checkbox),
      const CalculatorField(id: 'urea', label: LString('U - Urée > 7 mmol/L (0.42 g/L)', 'U - Urée > 7 mmol/L (0.42 g/L)'), type: CalculatorFieldType.checkbox),
      const CalculatorField(id: 'rr30', label: LString('R - Fréquence respiratoire ≥ 30/min', 'R - Fréquence respiratoire ≥ 30/min'), type: CalculatorFieldType.checkbox),
      const CalculatorField(id: 'bp', label: LString('B - PAS < 90 mmHg OU PAD ≤ 60 mmHg', 'B - PAS < 90 mmHg OU PAD ≤ 60 mmHg'), type: CalculatorFieldType.checkbox),
      const CalculatorField(id: 'age65', label: LString('65 - Âge ≥ 65 ans', '65 - Âge ≥ 65 ans'), type: CalculatorFieldType.checkbox),
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
      const ScoreInterpretation(min: 0, max: 1, label: LString('Mortalité Faible', 'Mortalité Faible'), description: LString('Mortalité < 3%. Traitement ambulatoire possible.', 'Mortalité < 3%. Traitement ambulatoire possible.'), color: Colors.green),
      const ScoreInterpretation(min: 2, max: 2, label: LString('Intermédiaire', 'Intermédiaire'), description: LString('Mortalité 9%. Hospitalisation courte ou surveillance étroite.', 'Mortalité 9%. Hospitalisation courte ou surveillance étroite.'), color: Colors.yellow),
      const ScoreInterpretation(min: 3, max: 5, label: LString('Mortalité Élevée', 'Mortalité Élevée'), description: LString('Mortalité 15-40%. Hospitalisation, réanimation si ≥4.', 'Mortalité 15-40%. Hospitalisation, réanimation si ≥4.'), color: Colors.red),
    ],
    source: 'Lim WS et al. Thorax 2003',
    sourceUrl: 'https://pubmed.ncbi.nlm.nih.gov/12728155/',
  ),
  Calculator(
    id: 'wells-pe',
    name: LString('Score de Wells - Embolie Pulmonaire', 'Score de Wells - Embolie Pulmonaire'),
    shortName: 'Wells EP',
    category: CalculatorCategory.peDvt,
    description: LString('Probabilité pré-test d\'embolie pulmonaire', 'Probabilité pré-test d\'embolie pulmonaire'),
    fields: [
      const CalculatorField(id: 'dvtSigns', label: LString('Signes cliniques de TVP', 'Signes cliniques de TVP'), type: CalculatorFieldType.checkbox),
      const CalculatorField(id: 'alternative', label: LString('EP diagnostic le plus probable', 'EP diagnostic le plus probable'), type: CalculatorFieldType.checkbox),
      const CalculatorField(id: 'hr100', label: LString('Fréquence cardiaque > 100 bpm', 'Fréquence cardiaque > 100 bpm'), type: CalculatorFieldType.checkbox),
      const CalculatorField(id: 'immobilization', label: LString('Immobilisation ≥ 3 jours OU chirurgie < 4 semaines', 'Immobilisation ≥ 3 jours OU chirurgie < 4 semaines'), type: CalculatorFieldType.checkbox),
      const CalculatorField(id: 'previousPE', label: LString('Antécédent d\'EP ou TVP', 'Antécédent d\'EP ou TVP'), type: CalculatorFieldType.checkbox),
      const CalculatorField(id: 'hemoptysis', label: LString('Hémoptysie', 'Hémoptysie'), type: CalculatorFieldType.checkbox),
      const CalculatorField(id: 'malignancy', label: LString('Cancer (actif, < 6 mois, palliatif)', 'Cancer (actif, < 6 mois, palliatif)'), type: CalculatorFieldType.checkbox),
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
      const ScoreInterpretation(min: 0, max: 1, label: LString('Faible', 'Faible'), description: LString('Probabilité EP 1.3%. Appliquer PERC si applicable.', 'Probabilité EP 1.3%. Appliquer PERC si applicable.'), color: Colors.green),
      const ScoreInterpretation(min: 1.5, max: 4, label: LString('Intermédiaire', 'Intermédiaire'), description: LString('Probabilité EP 16%. D-dimères indiqués.', 'Probabilité EP 16%. D-dimères indiqués.'), color: Colors.yellow),
      const ScoreInterpretation(min: 4.5, max: 12.5, label: LString('Élevé', 'Élevé'), description: LString('Probabilité EP 38%. Angioscanner indiqué.', 'Probabilité EP 38%. Angioscanner indiqué.'), color: Colors.red),
    ],
    source: 'Wells PS et al. Thromb Haemost 2000',
    sourceUrl: 'https://pubmed.ncbi.nlm.nih.gov/10744147/',
  ),
  Calculator(
    id: 'perc',
    name: LString('Règle PERC (Critères d\'exclusion EP)', 'Règle PERC (Critères d\'exclusion EP)'),
    shortName: 'PERC',
    category: CalculatorCategory.peDvt,
    description: LString('Exclure l\'EP sans bilan chez les patients à faible risque', 'Exclure l\'EP sans bilan chez les patients à faible risque'),
    fields: [
      const CalculatorField(id: 'age50', label: LString('Âge ≥ 50 ans', 'Âge ≥ 50 ans'), type: CalculatorFieldType.checkbox),
      const CalculatorField(id: 'hr100', label: LString('Fréquence cardiaque ≥ 100 bpm', 'Fréquence cardiaque ≥ 100 bpm'), type: CalculatorFieldType.checkbox),
      const CalculatorField(id: 'spo2', label: LString('SpO2 < 95% en air ambiant', 'SpO2 < 95% en air ambiant'), type: CalculatorFieldType.checkbox),
      const CalculatorField(id: 'hemoptysis', label: LString('Hémoptysie', 'Hémoptysie'), type: CalculatorFieldType.checkbox),
      const CalculatorField(id: 'estrogen', label: LString('Traitement œstrogénique', 'Traitement œstrogénique'), type: CalculatorFieldType.checkbox),
      const CalculatorField(id: 'surgery', label: LString('Chirurgie/Traumatisme < 4 semaines', 'Chirurgie/Traumatisme < 4 semaines'), type: CalculatorFieldType.checkbox),
      const CalculatorField(id: 'previousPE', label: LString('Antécédent d\'EP ou TVP', 'Antécédent d\'EP ou TVP'), type: CalculatorFieldType.checkbox),
      const CalculatorField(id: 'legSwelling', label: LString('Œdème unilatéral du MI', 'Œdème unilatéral du MI'), type: CalculatorFieldType.checkbox),
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
      const ScoreInterpretation(min: 0, max: 0, label: LString('PERC Négatif', 'PERC Négatif'), description: LString('EP exclue (risque < 2%). Pas de bilan.', 'EP exclue (risque < 2%). Pas de bilan.'), color: Colors.green),
      const ScoreInterpretation(min: 1, max: 8, label: LString('PERC Positif', 'PERC Positif'), description: LString('EP non exclue. Poursuivre le bilan.', 'EP non exclue. Poursuivre le bilan.'), color: Colors.orange),
    ],
    source: 'Kline JA et al. J Thromb Haemost 2004',
    sourceUrl: 'https://pubmed.ncbi.nlm.nih.gov/15304025/',
  ),
  Calculator(
    id: 'geneva-revised',
    name: LString('Score de Genève Révisé', 'Score de Genève Révisé'),
    shortName: 'Genève',
    category: CalculatorCategory.peDvt,
    description: LString('Score objectif de probabilité d\'EP', 'Score objectif de probabilité d\'EP'),
    fields: [
      const CalculatorField(id: 'age', label: LString('Âge > 65 ans', 'Âge > 65 ans'), type: CalculatorFieldType.checkbox),
      const CalculatorField(id: 'previousPE', label: LString('Antécédent de TVP ou EP', 'Antécédent de TVP ou EP'), type: CalculatorFieldType.checkbox),
      const CalculatorField(id: 'surgery', label: LString('Chirurgie ou fracture < 1 mois', 'Chirurgie ou fracture < 1 mois'), type: CalculatorFieldType.checkbox),
      const CalculatorField(id: 'malignancy', label: LString('Cancer actif ou rémission < 1 an', 'Cancer actif ou rémission < 1 an'), type: CalculatorFieldType.checkbox),
      const CalculatorField(id: 'legPain', label: LString('Douleur unilatérale du MI', 'Douleur unilatérale du MI'), type: CalculatorFieldType.checkbox),
      const CalculatorField(id: 'hemoptysis', label: LString('Hémoptysie', 'Hémoptysie'), type: CalculatorFieldType.checkbox),
      const CalculatorField(
        id: 'hr',
        label: LString('Fréquence Cardiaque', 'Fréquence Cardiaque'),
        type: CalculatorFieldType.select,
        options: [
          CalculatorOption(value: 0, label: LString('< 75 bpm', '< 75 bpm')),
          CalculatorOption(value: 3, label: LString('75-94 bpm', '75-94 bpm')),
          CalculatorOption(value: 5, label: LString('≥ 95 bpm', '≥ 95 bpm')),
        ],
      ),
      const CalculatorField(id: 'legEdema', label: LString('Douleur à la palpation et œdème du MI', 'Douleur à la palpation et œdème du MI'), type: CalculatorFieldType.checkbox),
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
      const ScoreInterpretation(min: 0, max: 3, label: LString('Faible', 'Faible'), description: LString('Probabilité EP 8%. D-dimères indiqués.', 'Probabilité EP 8%. D-dimères indiqués.'), color: Colors.green),
      const ScoreInterpretation(min: 4, max: 10, label: LString('Intermédiaire', 'Intermédiaire'), description: LString('Probabilité EP 29%. D-dimères ou Angioscanner.', 'Probabilité EP 29%. D-dimères ou Angioscanner.'), color: Colors.yellow),
      const ScoreInterpretation(min: 11, max: 25, label: LString('Élevé', 'Élevé'), description: LString('Probabilité EP 74%. Angioscanner indiqué.', 'Probabilité EP 74%. Angioscanner indiqué.'), color: Colors.red),
    ],
    source: 'Le Gal G et al. Ann Intern Med 2006',
    sourceUrl: 'https://pubmed.ncbi.nlm.nih.gov/16461963/',
  ),
  Calculator(
    id: 'spesi',
    name: LString('Score sPESI Simplifié', 'Score sPESI Simplifié'),
    shortName: 'sPESI',
    category: CalculatorCategory.peDvt,
    description: LString('Pronostic d\'EP confirmée - Sélection traitement ambulatoire', 'Pronostic d\'EP confirmée - Sélection traitement ambulatoire'),
    fields: [
      const CalculatorField(id: 'age80', label: LString('Âge > 80 ans', 'Âge > 80 ans'), type: CalculatorFieldType.checkbox),
      const CalculatorField(id: 'cancer', label: LString('Cancer', 'Cancer'), type: CalculatorFieldType.checkbox),
      const CalculatorField(id: 'cardiopulmonary', label: LString('Maladie cardiopulmonaire chronique', 'Maladie cardiopulmonaire chronique'), type: CalculatorFieldType.checkbox),
      const CalculatorField(id: 'hr110', label: LString('Fréquence cardiaque ≥ 110 bpm', 'Fréquence cardiaque ≥ 110 bpm'), type: CalculatorFieldType.checkbox),
      const CalculatorField(id: 'sbp100', label: LString('PA systolique < 100 mmHg', 'PA systolique < 100 mmHg'), type: CalculatorFieldType.checkbox),
      const CalculatorField(id: 'spo2', label: LString('SpO2 < 90%', 'SpO2 < 90%'), type: CalculatorFieldType.checkbox),
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
      const ScoreInterpretation(min: 0, max: 0, label: LString('Risque Faible', 'Risque Faible'), description: LString('Mortalité à 30j 1%. Traitement ambulatoire possible.', 'Mortalité à 30j 1%. Traitement ambulatoire possible.'), color: Colors.green),
      const ScoreInterpretation(min: 1, max: 6, label: LString('Risque Élevé', 'Risque Élevé'), description: LString('Mortalité à 30j 10.9%. Hospitalisation recommandée.', 'Mortalité à 30j 10.9%. Hospitalisation recommandée.'), color: Colors.red),
    ],
    source: 'Jiménez D et al. Arch Intern Med 2010',
    sourceUrl: 'https://pubmed.ncbi.nlm.nih.gov/20696951/',
  ),
  Calculator(
    id: 'wells-dvt',
    name: LString('Score de Wells - TVP', 'Score de Wells - TVP'),
    shortName: 'Wells TVP',
    category: CalculatorCategory.peDvt,
    description: LString('Probabilité pré-test de Thrombose Veineuse Profonde', 'Probabilité pré-test de Thrombose Veineuse Profonde'),
    fields: [
      const CalculatorField(id: 'cancer', label: LString('Cancer actif (traitement < 6 mois ou palliatif)', 'Cancer actif (traitement < 6 mois ou palliatif)'), type: CalculatorFieldType.checkbox),
      const CalculatorField(id: 'paralysis', label: LString('Paralysie, parésie ou immobilisation plâtrée récente du MI', 'Paralysie, parésie ou immobilisation plâtrée récente du MI'), type: CalculatorFieldType.checkbox),
      const CalculatorField(id: 'bedridden', label: LString('Alitement > 3 jours OU chirurgie majeure < 12 semaines', 'Alitement > 3 jours OU chirurgie majeure < 12 semaines'), type: CalculatorFieldType.checkbox),
      const CalculatorField(id: 'tenderness', label: LString('Douleur localisée sur le trajet veineux profond', 'Douleur localisée sur le trajet veineux profond'), type: CalculatorFieldType.checkbox),
      const CalculatorField(id: 'legSwelling', label: LString('Œdème de tout le MI', 'Œdème de tout le MI'), type: CalculatorFieldType.checkbox),
      const CalculatorField(id: 'calfSwelling', label: LString('Œdème du mollet > 3 cm vs côté asymptomatique', 'Œdème du mollet > 3 cm vs côté asymptomatique'), type: CalculatorFieldType.checkbox),
      const CalculatorField(id: 'pittingEdema', label: LString('Œdème prenant le godet (prédominant côté symptomatique)', 'Œdème prenant le godet (prédominant côté symptomatique)'), type: CalculatorFieldType.checkbox),
      const CalculatorField(id: 'collateralVeins', label: LString('Veines superficielles collatérales (non variqueuses)', 'Veines superficielles collatérales (non variqueuses)'), type: CalculatorFieldType.checkbox),
      const CalculatorField(id: 'previousDVT', label: LString('Antécédent documenté de TVP', 'Antécédent documenté de TVP'), type: CalculatorFieldType.checkbox),
      const CalculatorField(id: 'alternativeDiagnosis', label: LString('Diagnostic alternatif au moins aussi probable que TVP', 'Diagnostic alternatif au moins aussi probable que TVP'), type: CalculatorFieldType.checkbox),
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
      const ScoreInterpretation(min: -2, max: 0, label: LString('Faible', 'Faible'), description: LString('Probabilité TVP 5%. D-dimères indiqués.', 'Probabilité TVP 5%. D-dimères indiqués.'), color: Colors.green),
      const ScoreInterpretation(min: 1, max: 2, label: LString('Modéré', 'Modéré'), description: LString('Probabilité TVP 17%. D-dimères ou Échographie.', 'Probabilité TVP 17%. D-dimères ou Échographie.'), color: Colors.yellow),
      const ScoreInterpretation(min: 3, max: 9, label: LString('Élevé', 'Élevé'), description: LString('Probabilité TVP 53%. Échographie indiquée.', 'Probabilité TVP 53%. Échographie indiquée.'), color: Colors.red),
    ],
    source: 'Wells PS et al. Lancet 1997',
    sourceUrl: 'https://pubmed.ncbi.nlm.nih.gov/9217107/',
  ),
  Calculator(
    id: 'heart',
    name: LString('Score HEART', 'Score HEART'),
    shortName: 'HEART',
    category: CalculatorCategory.cardiovascular,
    description: LString('Stratification du risque de SCA aux urgences', 'Stratification du risque de SCA aux urgences'),
    fields: [
      const CalculatorField(
        id: 'history',
        label: LString('Anamnèse', 'Anamnèse'),
        type: CalculatorFieldType.select,
        options: [
          CalculatorOption(value: 0, label: LString('Peu suspecte', 'Peu suspecte'), description: LString('Atypique pour SCA', 'Atypique pour SCA')),
          CalculatorOption(value: 1, label: LString('Modérément suspecte', 'Modérément suspecte'), description: LString('Éléments typiques et atypiques', 'Éléments typiques et atypiques')),
          CalculatorOption(value: 2, label: LString('Très suspecte', 'Très suspecte'), description: LString('Typique pour SCA', 'Typique pour SCA')),
        ],
      ),
      const CalculatorField(
        id: 'ecg',
        label: LString('ECG', 'ECG'),
        type: CalculatorFieldType.select,
        options: [
          CalculatorOption(value: 0, label: LString('Normal', 'Normal'), description: LString('Complètement normal', 'Complètement normal')),
          CalculatorOption(value: 1, label: LString('Anomalies non spécifiques', 'Anomalies non spécifiques'), description: LString('BBG, HVG, repolarisation non spécifique', 'BBG, HVG, repolarisation non spécifique')),
          CalculatorOption(value: 2, label: LString('Déviation ST significative', 'Déviation ST significative'), description: LString('Sous-décalage ST, sus-décalage ST', 'Sous-décalage ST, sus-décalage ST')),
        ],
      ),
      const CalculatorField(
        id: 'age',
        label: LString('Âge', 'Âge'),
        type: CalculatorFieldType.select,
        options: [
          CalculatorOption(value: 0, label: LString('< 45 ans', '< 45 ans')),
          CalculatorOption(value: 1, label: LString('45-64 ans', '45-64 ans')),
          CalculatorOption(value: 2, label: LString('≥ 65 ans', '≥ 65 ans')),
        ],
      ),
      const CalculatorField(
        id: 'riskFactors',
        label: LString('Facteurs de risque', 'Facteurs de risque'),
        type: CalculatorFieldType.select,
        options: [
          CalculatorOption(value: 0, label: LString('Aucun facteur de risque connu', 'Aucun facteur de risque connu')),
          CalculatorOption(value: 1, label: LString('1-2 facteurs de risque', '1-2 facteurs de risque'), description: LString('HTA, diabète, tabac, dyslipidémie, obésité, ATCD familiaux', 'HTA, diabète, tabac, dyslipidémie, obésité, ATCD familiaux')),
          CalculatorOption(value: 2, label: LString('≥ 3 facteurs OU ATCD d\'athérosclérose', '≥ 3 facteurs OU ATCD d\'athérosclérose'), description: LString('IDM, AVC, AOMI, revascularisation antérieurs', 'IDM, AVC, AOMI, revascularisation antérieurs')),
        ],
      ),
      const CalculatorField(
        id: 'troponin',
        label: LString('Troponine', 'Troponine'),
        type: CalculatorFieldType.select,
        options: [
          CalculatorOption(value: 0, label: LString('≤ limite normale', '≤ limite normale')),
          CalculatorOption(value: 1, label: LString('1-3x limite normale', '1-3x limite normale')),
          CalculatorOption(value: 2, label: LString('> 3x limite normale', '> 3x limite normale')),
        ],
      ),
    ],
    calculate: (values) {
      return (values['history'] as double) + (values['ecg'] as double) + 
             (values['age'] as double) + (values['riskFactors'] as double) + (values['troponin'] as double);
    },
    interpretations: [
      const ScoreInterpretation(min: 0, max: 3, label: LString('Risque Faible', 'Risque Faible'), description: LString('MACE < 2% à 6 semaines. Sortie possible.', 'MACE < 2% à 6 semaines. Sortie possible.'), color: Colors.green),
      const ScoreInterpretation(min: 4, max: 6, label: LString('Risque Modéré', 'Risque Modéré'), description: LString('MACE 12-16%. Hospitalisation pour surveillance.', 'MACE 12-16%. Hospitalisation pour surveillance.'), color: Colors.orange),
      const ScoreInterpretation(min: 7, max: 10, label: LString('Risque Élevé', 'Risque Élevé'), description: LString('MACE > 50%. Stratégie invasive précoce.', 'MACE > 50%. Stratégie invasive précoce.'), color: Colors.red),
    ],
    source: 'Six AJ et al. Neth Heart J 2008',
    sourceUrl: 'https://pubmed.ncbi.nlm.nih.gov/18665203/',
  ),
  Calculator(
    id: 'cha2ds2-vasc',
    name: LString('CHA₂DS₂-VASc Score', 'CHA₂DS₂-VASc Score'),
    shortName: 'CHA₂DS₂-VASc',
    category: CalculatorCategory.cardiovascular,
    description: LString('Risque d\'AVC dans la Fibrillation Auriculaire', 'Risque d\'AVC dans la Fibrillation Auriculaire'),
    fields: [
      const CalculatorField(id: 'chf', label: LString('IC / FEVG ≤ 40%', 'IC / FEVG ≤ 40%'), type: CalculatorFieldType.checkbox),
      const CalculatorField(id: 'hypertension', label: LString('Hypertension', 'Hypertension'), type: CalculatorFieldType.checkbox),
      const CalculatorField(id: 'age75', label: LString('Âge ≥ 75 ans', 'Âge ≥ 75 ans'), type: CalculatorFieldType.checkbox),
      const CalculatorField(id: 'diabetes', label: LString('Diabète', 'Diabète'), type: CalculatorFieldType.checkbox),
      const CalculatorField(id: 'stroke', label: LString('ATCD AVC / AIT / Thromboembolie', 'ATCD AVC / AIT / Thromboembolie'), type: CalculatorFieldType.checkbox),
      const CalculatorField(id: 'vascular', label: LString('Maladie vasculaire (IDM, AOMI, plaque aortique)', 'Maladie vasculaire (IDM, AOMI, plaque aortique)'), type: CalculatorFieldType.checkbox),
      const CalculatorField(id: 'age65', label: LString('Âge 65-74 ans', 'Âge 65-74 ans'), type: CalculatorFieldType.checkbox),
      const CalculatorField(id: 'female', label: LString('Sexe féminin', 'Sexe féminin'), type: CalculatorFieldType.checkbox),
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
      const ScoreInterpretation(min: 0, max: 0, label: LString('Faible (Hommes)', 'Faible (Hommes)'), description: LString('Risque AVC 0%/an. Pas d\'anticoagulation.', 'Risque AVC 0%/an. Pas d\'anticoagulation.'), color: Colors.green),
      const ScoreInterpretation(min: 1, max: 1, label: LString('Faible-Modéré', 'Faible-Modéré'), description: LString('Risque AVC 1.3%/an. Considérer anticoagulation.', 'Risque AVC 1.3%/an. Considérer anticoagulation.'), color: Colors.yellow),
      const ScoreInterpretation(min: 2, max: 2, label: LString('Modéré', 'Modéré'), description: LString('Risque AVC 2.2%/an. Anticoagulation recommandée.', 'Risque AVC 2.2%/an. Anticoagulation recommandée.'), color: Colors.orange),
      const ScoreInterpretation(min: 3, max: 9, label: LString('Élevé', 'Élevé'), description: LString('Risque AVC ≥ 3.2%/an. Anticoagulation indiquée.', 'Risque AVC ≥ 3.2%/an. Anticoagulation indiquée.'), color: Colors.red),
    ],
    source: 'Lip GY et al. Chest 2010',
    sourceUrl: 'https://pubmed.ncbi.nlm.nih.gov/19762550/',
  ),
  Calculator(
    id: 'has-bled',
    name: LString('Score HAS-BLED', 'Score HAS-BLED'),
    shortName: 'HAS-BLED',
    category: CalculatorCategory.cardiovascular,
    description: LString('Risque de saignement majeur sous anticoagulation', 'Risque de saignement majeur sous anticoagulation'),
    fields: [
      const CalculatorField(id: 'hypertension', label: LString('HTA non contrôlée (> 160 mmHg systolique)', 'HTA non contrôlée (> 160 mmHg systolique)'), type: CalculatorFieldType.checkbox),
      const CalculatorField(id: 'renal', label: LString('Insuffisance rénale (Dialyse, greffe, Cr > 200)', 'Insuffisance rénale (Dialyse, greffe, Cr > 200)'), type: CalculatorFieldType.checkbox),
      const CalculatorField(id: 'liver', label: LString('Insuffisance hépatique (Cirrhose, Bili > 2x, AST/ALT > 3x)', 'Insuffisance hépatique (Cirrhose, Bili > 2x, AST/ALT > 3x)'), type: CalculatorFieldType.checkbox),
      const CalculatorField(id: 'stroke', label: LString('Antécédent d\'AVC', 'Antécédent d\'AVC'), type: CalculatorFieldType.checkbox),
      const CalculatorField(id: 'bleeding', label: LString('ATCD de saignement majeur ou prédisposition', 'ATCD de saignement majeur ou prédisposition'), type: CalculatorFieldType.checkbox),
      const CalculatorField(id: 'labile', label: LString('INR labile (TTR < 60%)', 'INR labile (TTR < 60%)'), type: CalculatorFieldType.checkbox),
      const CalculatorField(id: 'elderly', label: LString('Âge > 65 ans', 'Âge > 65 ans'), type: CalculatorFieldType.checkbox),
      const CalculatorField(id: 'drugs', label: LString('Médicaments (Antiplaquettaires, AINS)', 'Médicaments (Antiplaquettaires, AINS)'), type: CalculatorFieldType.checkbox),
      const CalculatorField(id: 'alcohol', label: LString('Alcool (≥ 8 verres/semaine)', 'Alcool (≥ 8 verres/semaine)'), type: CalculatorFieldType.checkbox),
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
      const ScoreInterpretation(min: 0, max: 0, label: LString('Très bas', 'Très bas'), description: LString('Risque hémorragique 1,13%/an', 'Risque hémorragique 1,13%/an'), color: Colors.green),
      const ScoreInterpretation(min: 1, max: 1, label: LString('Bas', 'Bas'), description: LString('Risque hémorragique 1,02%/an', 'Risque hémorragique 1,02%/an'), color: Colors.green),
      const ScoreInterpretation(min: 2, max: 2, label: LString('Modéré', 'Modéré'), description: LString('Risque hémorragique 1,88%/an', 'Risque hémorragique 1,88%/an'), color: Colors.yellow),
      const ScoreInterpretation(min: 3, max: 9, label: LString('Élevé', 'Élevé'), description: LString('Risque hémorragique ≥ 3,74%/an. Corriger les facteurs modifiables.', 'Risque hémorragique ≥ 3,74%/an. Corriger les facteurs modifiables.'), color: Colors.orange),
    ],
    source: 'Pisters R et al. Chest 2010',
    sourceUrl: 'https://pubmed.ncbi.nlm.nih.gov/20299623/',
  ),
  Calculator(
    id: 'canadian-syncope',
    name: LString('Score de Risque de Syncope Canadien', 'Score de Risque de Syncope Canadien'),
    shortName: 'CSRS',
    category: CalculatorCategory.cardiovascular,
    description: LString('Prédiction des événements indésirables graves dans les 30 jours suivant une syncope', 'Prédiction des événements indésirables graves dans les 30 jours suivant une syncope'),
    fields: [
      const CalculatorField(
        id: 'predisposition',
        label: LString('Prédisposition Vasovagale', 'Prédisposition Vasovagale'),
        type: CalculatorFieldType.select,
        options: [
          CalculatorOption(value: -1, label: LString('Oui (chaleur, debout, émotion, douleur)', 'Oui (chaleur, debout, émotion, douleur)'), description: LString('Facteur protecteur', 'Facteur protecteur')),
          CalculatorOption(value: 0, label: LString('Non', 'Non')),
        ],
      ),
      const CalculatorField(
        id: 'heartDisease',
        label: LString('Antécédents de Cardiopathie', 'Antécédents de Cardiopathie'),
        type: CalculatorFieldType.select,
        options: [
          CalculatorOption(value: 0, label: LString('Non', 'Non')),
          CalculatorOption(value: 1, label: LString('Oui (Coronaropathie, FA, IC, Valvulopathie)', 'Oui (Coronaropathie, FA, IC, Valvulopathie)')),
        ],
      ),
      const CalculatorField(
        id: 'sbp',
        label: LString('PA Systolique < 90 ou > 180 mmHg', 'PA Systolique < 90 ou > 180 mmHg'),
        type: CalculatorFieldType.select,
        options: [
          CalculatorOption(value: 0, label: LString('Non (90-180 mmHg)', 'Non (90-180 mmHg)')),
          CalculatorOption(value: 2, label: LString('Oui (< 90 ou > 180 mmHg)', 'Oui (< 90 ou > 180 mmHg)')),
        ],
      ),
      const CalculatorField(
        id: 'troponin',
        label: LString('Troponine Élevée (> 99e percentile)', 'Troponine Élevée (> 99e percentile)'),
        type: CalculatorFieldType.select,
        options: [
          CalculatorOption(value: 0, label: LString('Non', 'Non')),
          CalculatorOption(value: 2, label: LString('Oui', 'Oui')),
        ],
      ),
      const CalculatorField(
        id: 'axis',
        label: LString('Axe QRS Anormal (< -30° ou > 100°)', 'Axe QRS Anormal (< -30° ou > 100°)'),
        type: CalculatorFieldType.select,
        options: [
          CalculatorOption(value: 0, label: LString('Non', 'Non')),
          CalculatorOption(value: 1, label: LString('Oui', 'Oui')),
        ],
      ),
      const CalculatorField(
        id: 'qrs',
        label: LString('QRS > 130 ms', 'QRS > 130 ms'),
        type: CalculatorFieldType.select,
        options: [
          CalculatorOption(value: 0, label: LString('Non', 'Non')),
          CalculatorOption(value: 1, label: LString('Oui', 'Oui')),
        ],
      ),
      const CalculatorField(
        id: 'qtc',
        label: LString('QTc > 480 ms', 'QTc > 480 ms'),
        type: CalculatorFieldType.select,
        options: [
          CalculatorOption(value: 0, label: LString('Non', 'Non')),
          CalculatorOption(value: 2, label: LString('Oui', 'Oui')),
        ],
      ),
      const CalculatorField(
        id: 'edDiagnosis',
        label: LString('Diagnostic aux Urgences', 'Diagnostic aux Urgences'),
        type: CalculatorFieldType.select,
        options: [
          CalculatorOption(value: 0, label: LString('Syncope Vasovagale', 'Syncope Vasovagale')),
          CalculatorOption(value: 2, label: LString('Syncope Cardiaque', 'Syncope Cardiaque')),
          CalculatorOption(value: -2, label: LString('Présyncope Vasovagale', 'Présyncope Vasovagale')),
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
      const ScoreInterpretation(min: -3, max: -2, label: LString('Très bas', 'Très bas'), description: LString('Risque 0,4%. Sortie sécuritaire.', 'Risque 0,4%. Sortie sécuritaire.'), color: Colors.green),
      const ScoreInterpretation(min: -1, max: 0, label: LString('Bas', 'Bas'), description: LString('Risque 1,2%. Sortie possible.', 'Risque 1,2%. Sortie possible.'), color: Colors.green),
      const ScoreInterpretation(min: 1, max: 3, label: LString('Modéré', 'Modéré'), description: LString('Risque 3-5%. Envisager observation.', 'Risque 3-5%. Envisager observation.'), color: Colors.yellow),
      const ScoreInterpretation(min: 4, max: 5, label: LString('Élevé', 'Élevé'), description: LString('Risque 9%. Hospitalisation recommandée.', 'Risque 9%. Hospitalisation recommandée.'), color: Colors.orange),
      const ScoreInterpretation(min: 6, max: 11, label: LString('Très élevé', 'Très élevé'), description: LString('Risque > 18%. Hospitalisation indiquée.', 'Risque > 18%. Hospitalisation indiquée.'), color: Colors.red),
    ],
    source: 'Thiruganasambandamoorthy V et al. CMAJ 2016',
    sourceUrl: 'https://pubmed.ncbi.nlm.nih.gov/27378464/',
  ),
  Calculator(
    id: 'nihss',
    name: LString('NIH Stroke Scale', 'NIH Stroke Scale'),
    shortName: 'NIHSS',
    category: CalculatorCategory.neurology,
    description: LString('Ischemic stroke severity and thrombolysis eligibility', 'Ischemic stroke severity and thrombolysis eligibility'),
    fields: [
      const CalculatorField(
        id: 'consciousness',
        label: LString('1a. Level of Consciousness', '1a. Level of Consciousness'),
        type: CalculatorFieldType.select,
        options: [
          CalculatorOption(value: 0, label: LString('0 - Alert', '0 - Alert')),
          CalculatorOption(value: 1, label: LString('1 - Not alert but arousable', '1 - Not alert but arousable')),
          CalculatorOption(value: 2, label: LString('2 - Not alert, requires repeated stimulation', '2 - Not alert, requires repeated stimulation')),
          CalculatorOption(value: 3, label: LString('3 - Coma', '3 - Coma')),
        ],
      ),
      const CalculatorField(
        id: 'questions',
        label: LString('1b. LOC Questions (Month, Age)', '1b. LOC Questions (Month, Age)'),
        type: CalculatorFieldType.select,
        options: [
          CalculatorOption(value: 0, label: LString('0 - Answers both correctly', '0 - Answers both correctly')),
          CalculatorOption(value: 1, label: LString('1 - Answers one correctly', '1 - Answers one correctly')),
          CalculatorOption(value: 2, label: LString('2 - Answers neither correctly', '2 - Answers neither correctly')),
        ],
      ),
      const CalculatorField(
        id: 'commands',
        label: LString('1c. LOC Commands (Open/close eyes, grip)', '1c. LOC Commands (Open/close eyes, grip)'),
        type: CalculatorFieldType.select,
        options: [
          CalculatorOption(value: 0, label: LString('0 - Performs both correctly', '0 - Performs both correctly')),
          CalculatorOption(value: 1, label: LString('1 - Performs one correctly', '1 - Performs one correctly')),
          CalculatorOption(value: 2, label: LString('2 - Performs neither correctly', '2 - Performs neither correctly')),
        ],
      ),
      const CalculatorField(
        id: 'gaze',
        label: LString('2. Best Gaze', '2. Best Gaze'),
        type: CalculatorFieldType.select,
        options: [
          CalculatorOption(value: 0, label: LString('0 - Normal', '0 - Normal')),
          CalculatorOption(value: 1, label: LString('1 - Partial gaze palsy', '1 - Partial gaze palsy')),
          CalculatorOption(value: 2, label: LString('2 - Forced deviation', '2 - Forced deviation')),
        ],
      ),
      const CalculatorField(
        id: 'visual',
        label: LString('3. Visual Fields', '3. Visual Fields'),
        type: CalculatorFieldType.select,
        options: [
          CalculatorOption(value: 0, label: LString('0 - No visual loss', '0 - No visual loss')),
          CalculatorOption(value: 1, label: LString('1 - Partial hemianopia', '1 - Partial hemianopia')),
          CalculatorOption(value: 2, label: LString('2 - Complete hemianopia', '2 - Complete hemianopia')),
          CalculatorOption(value: 3, label: LString('3 - Bilateral hemianopia', '3 - Bilateral hemianopia')),
        ],
      ),
      const CalculatorField(
        id: 'facialPalsy',
        label: LString('4. Facial Palsy', '4. Facial Palsy'),
        type: CalculatorFieldType.select,
        options: [
          CalculatorOption(value: 0, label: LString('0 - Normal', '0 - Normal')),
          CalculatorOption(value: 1, label: LString('1 - Minor paralysis', '1 - Minor paralysis')),
          CalculatorOption(value: 2, label: LString('2 - Partial paralysis', '2 - Partial paralysis')),
          CalculatorOption(value: 3, label: LString('3 - Complete paralysis', '3 - Complete paralysis')),
        ],
      ),
      const CalculatorField(
        id: 'motorArmLeft',
        label: LString('5a. Motor Left Arm', '5a. Motor Left Arm'),
        type: CalculatorFieldType.select,
        options: [
          CalculatorOption(value: 0, label: LString('0 - No drift', '0 - No drift')),
          CalculatorOption(value: 1, label: LString('1 - Drift', '1 - Drift')),
          CalculatorOption(value: 2, label: LString('2 - Some effort against gravity', '2 - Some effort against gravity')),
          CalculatorOption(value: 3, label: LString('3 - No effort against gravity', '3 - No effort against gravity')),
          CalculatorOption(value: 4, label: LString('4 - No movement', '4 - No movement')),
        ],
      ),
      const CalculatorField(
        id: 'motorArmRight',
        label: LString('5b. Motor Right Arm', '5b. Motor Right Arm'),
        type: CalculatorFieldType.select,
        options: [
          CalculatorOption(value: 0, label: LString('0 - No drift', '0 - No drift')),
          CalculatorOption(value: 1, label: LString('1 - Drift', '1 - Drift')),
          CalculatorOption(value: 2, label: LString('2 - Some effort against gravity', '2 - Some effort against gravity')),
          CalculatorOption(value: 3, label: LString('3 - No effort against gravity', '3 - No effort against gravity')),
          CalculatorOption(value: 4, label: LString('4 - No movement', '4 - No movement')),
        ],
      ),
      const CalculatorField(
        id: 'motorLegLeft',
        label: LString('6a. Motor Left Leg', '6a. Motor Left Leg'),
        type: CalculatorFieldType.select,
        options: [
          CalculatorOption(value: 0, label: LString('0 - No drift', '0 - No drift')),
          CalculatorOption(value: 1, label: LString('1 - Drift', '1 - Drift')),
          CalculatorOption(value: 2, label: LString('2 - Some effort against gravity', '2 - Some effort against gravity')),
          CalculatorOption(value: 3, label: LString('3 - No effort against gravity', '3 - No effort against gravity')),
          CalculatorOption(value: 4, label: LString('4 - No movement', '4 - No movement')),
        ],
      ),
      const CalculatorField(
        id: 'motorLegRight',
        label: LString('6b. Motor Right Leg', '6b. Motor Right Leg'),
        type: CalculatorFieldType.select,
        options: [
          CalculatorOption(value: 0, label: LString('0 - No drift', '0 - No drift')),
          CalculatorOption(value: 1, label: LString('1 - Drift', '1 - Drift')),
          CalculatorOption(value: 2, label: LString('2 - Some effort against gravity', '2 - Some effort against gravity')),
          CalculatorOption(value: 3, label: LString('3 - No effort against gravity', '3 - No effort against gravity')),
          CalculatorOption(value: 4, label: LString('4 - No movement', '4 - No movement')),
        ],
      ),
      const CalculatorField(
        id: 'ataxia',
        label: LString('7. Limb Ataxia', '7. Limb Ataxia'),
        type: CalculatorFieldType.select,
        options: [
          CalculatorOption(value: 0, label: LString('0 - Absent', '0 - Absent')),
          CalculatorOption(value: 1, label: LString('1 - Present in one limb', '1 - Present in one limb')),
          CalculatorOption(value: 2, label: LString('2 - Present in two limbs', '2 - Present in two limbs')),
        ],
      ),
      const CalculatorField(
        id: 'sensory',
        label: LString('8. Sensory', '8. Sensory'),
        type: CalculatorFieldType.select,
        options: [
          CalculatorOption(value: 0, label: LString('0 - Normal', '0 - Normal')),
          CalculatorOption(value: 1, label: LString('1 - Mild to moderate loss', '1 - Mild to moderate loss')),
          CalculatorOption(value: 2, label: LString('2 - Severe to total loss', '2 - Severe to total loss')),
        ],
      ),
      const CalculatorField(
        id: 'language',
        label: LString('9. Best Language', '9. Best Language'),
        type: CalculatorFieldType.select,
        options: [
          CalculatorOption(value: 0, label: LString('0 - No aphasia', '0 - No aphasia')),
          CalculatorOption(value: 1, label: LString('1 - Mild to moderate aphasia', '1 - Mild to moderate aphasia')),
          CalculatorOption(value: 2, label: LString('2 - Severe aphasia', '2 - Severe aphasia')),
          CalculatorOption(value: 3, label: LString('3 - Mute / Global aphasia', '3 - Mute / Global aphasia')),
        ],
      ),
      const CalculatorField(
        id: 'dysarthria',
        label: LString('10. Dysarthria', '10. Dysarthria'),
        type: CalculatorFieldType.select,
        options: [
          CalculatorOption(value: 0, label: LString('0 - Normal', '0 - Normal')),
          CalculatorOption(value: 1, label: LString('1 - Mild to moderate', '1 - Mild to moderate')),
          CalculatorOption(value: 2, label: LString('2 - Severe', '2 - Severe')),
        ],
      ),
      const CalculatorField(
        id: 'neglect',
        label: LString('11. Extinction and Inattention', '11. Extinction and Inattention'),
        type: CalculatorFieldType.select,
        options: [
          CalculatorOption(value: 0, label: LString('0 - No abnormality', '0 - No abnormality')),
          CalculatorOption(value: 1, label: LString('1 - Visual, tactile, auditory, spatial, or personal inattention', '1 - Visual, tactile, auditory, spatial, or personal inattention')),
          CalculatorOption(value: 2, label: LString('2 - Profound hemi-inattention or extinction', '2 - Profound hemi-inattention or extinction')),
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
      const ScoreInterpretation(min: 0, max: 4, label: LString('Minor', 'Minor'), description: LString('Minor stroke. Discuss thrombolysis.', 'Minor stroke. Discuss thrombolysis.'), color: Colors.green),
      const ScoreInterpretation(min: 5, max: 15, label: LString('Moderate', 'Moderate'), description: LString('Moderate stroke. Thrombolysis eligible.', 'Moderate stroke. Thrombolysis eligible.'), color: Colors.yellow),
      const ScoreInterpretation(min: 16, max: 20, label: LString('Severe', 'Severe'), description: LString('Severe stroke. Discuss thrombolysis + thrombectomy.', 'Severe stroke. Discuss thrombolysis + thrombectomy.'), color: Colors.orange),
      const ScoreInterpretation(min: 21, max: 42, label: LString('Very Severe', 'Very Severe'), description: LString('Poor prognosis. Increased bleeding risk.', 'Poor prognosis. Increased bleeding risk.'), color: Colors.red),
    ],
    source: 'Brott T et al. Stroke 1989',
    sourceUrl: 'https://pubmed.ncbi.nlm.nih.gov/2749846/',
  ),
  Calculator(
    id: 'abcd2',
    name: LString('ABCD² Score for TIA', 'ABCD² Score for TIA'),
    shortName: 'ABCD²',
    category: CalculatorCategory.neurology,
    description: LString('Stroke risk after TIA', 'Stroke risk after TIA'),
    fields: [
      const CalculatorField(id: 'age60', label: LString('Age ≥ 60 years', 'Age ≥ 60 years'), type: CalculatorFieldType.checkbox),
      const CalculatorField(id: 'bp140', label: LString('BP ≥ 140/90 mmHg', 'BP ≥ 140/90 mmHg'), type: CalculatorFieldType.checkbox),
      const CalculatorField(
        id: 'clinical',
        label: LString('Clinical Features', 'Clinical Features'),
        type: CalculatorFieldType.select,
        options: [
          CalculatorOption(value: 0, label: LString('Other symptoms', 'Other symptoms')),
          CalculatorOption(value: 1, label: LString('Speech disturbance without weakness', 'Speech disturbance without weakness')),
          CalculatorOption(value: 2, label: LString('Unilateral weakness', 'Unilateral weakness')),
        ],
      ),
      const CalculatorField(
        id: 'duration',
        label: LString('Duration of Symptoms', 'Duration of Symptoms'),
        type: CalculatorFieldType.select,
        options: [
          CalculatorOption(value: 0, label: LString('< 10 minutes', '< 10 minutes')),
          CalculatorOption(value: 1, label: LString('10-59 minutes', '10-59 minutes')),
          CalculatorOption(value: 2, label: LString('≥ 60 minutes', '≥ 60 minutes')),
        ],
      ),
      const CalculatorField(id: 'diabetes', label: LString('Diabetes', 'Diabetes'), type: CalculatorFieldType.checkbox),
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
      const ScoreInterpretation(min: 0, max: 3, label: LString('Low Risk', 'Low Risk'), description: LString('2-day stroke risk: 1%. Outpatient workup possible.', '2-day stroke risk: 1%. Outpatient workup possible.'), color: Colors.green),
      const ScoreInterpretation(min: 4, max: 5, label: LString('Moderate Risk', 'Moderate Risk'), description: LString('2-day stroke risk: 4%. Hospitalization recommended.', '2-day stroke risk: 4%. Hospitalization recommended.'), color: Colors.yellow),
      const ScoreInterpretation(min: 6, max: 7, label: LString('High Risk', 'High Risk'), description: LString('2-day stroke risk: 8%. Urgent hospitalization.', '2-day stroke risk: 8%. Urgent hospitalization.'), color: Colors.red),
    ],
    source: 'Johnston SC et al. Lancet 2007',
    sourceUrl: 'https://pubmed.ncbi.nlm.nih.gov/17258668/',
  ),
  Calculator(
    id: 'ich',
    name: LString('ICH Score', 'ICH Score'),
    shortName: 'ICH',
    category: CalculatorCategory.neurology,
    description: LString('30-day mortality after Intracerebral Hemorrhage', '30-day mortality after Intracerebral Hemorrhage'),
    fields: [
      const CalculatorField(
        id: 'gcs',
        label: LString('GCS Score', 'GCS Score'),
        type: CalculatorFieldType.select,
        options: [
          CalculatorOption(value: 0, label: LString('13-15', '13-15')),
          CalculatorOption(value: 1, label: LString('5-12', '5-12')),
          CalculatorOption(value: 2, label: LString('3-4', '3-4')),
        ],
      ),
      const CalculatorField(
        id: 'volume',
        label: LString('ICH Volume (ABC/2)', 'ICH Volume (ABC/2)'),
        type: CalculatorFieldType.select,
        options: [
          CalculatorOption(value: 0, label: LString('< 30 mL', '< 30 mL')),
          CalculatorOption(value: 1, label: LString('≥ 30 mL', '≥ 30 mL')),
        ],
      ),
      const CalculatorField(id: 'ivh', label: LString('Intraventricular Hemorrhage', 'Intraventricular Hemorrhage'), type: CalculatorFieldType.checkbox),
      const CalculatorField(id: 'infratentorial', label: LString('Infratentorial Origin', 'Infratentorial Origin'), type: CalculatorFieldType.checkbox),
      const CalculatorField(id: 'age80', label: LString('Age ≥ 80 years', 'Age ≥ 80 years'), type: CalculatorFieldType.checkbox),
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
      const ScoreInterpretation(min: 0, max: 0, label: LString('0', '0'), description: LString('30-day mortality: 0%', '30-day mortality: 0%'), color: Colors.green),
      const ScoreInterpretation(min: 1, max: 1, label: LString('1', '1'), description: LString('30-day mortality: 13%', '30-day mortality: 13%'), color: Colors.yellow),
      const ScoreInterpretation(min: 2, max: 2, label: LString('2', '2'), description: LString('30-day mortality: 26%', '30-day mortality: 26%'), color: Colors.orange),
      const ScoreInterpretation(min: 3, max: 3, label: LString('3', '3'), description: LString('30-day mortality: 72%', '30-day mortality: 72%'), color: Colors.red),
      const ScoreInterpretation(min: 4, max: 4, label: LString('4', '4'), description: LString('30-day mortality: 97%', '30-day mortality: 97%'), color: Colors.red),
      const ScoreInterpretation(min: 5, max: 6, label: LString('5-6', '5-6'), description: LString('30-day mortality: 100%', '30-day mortality: 100%'), color: Colors.red),
    ],
    source: 'Hemphill JC et al. Stroke 2001',
    sourceUrl: 'https://pubmed.ncbi.nlm.nih.gov/11283388/',
  ),
  Calculator(
    id: 'hunt-hess',
    name: LString('Hunt and Hess Scale', 'Hunt and Hess Scale'),
    shortName: 'Hunt-Hess',
    category: CalculatorCategory.neurology,
    description: LString('Clinical classification of Subarachnoid Hemorrhage', 'Clinical classification of Subarachnoid Hemorrhage'),
    fields: [
      const CalculatorField(
        id: 'grade',
        label: LString('Clinical Presentation', 'Clinical Presentation'),
        type: CalculatorFieldType.select,
        options: [
          CalculatorOption(value: 1, label: LString('Grade 1 - Asymptomatic or mild headache', 'Grade 1 - Asymptomatic or mild headache')),
          CalculatorOption(value: 2, label: LString('Grade 2 - Moderate to severe headache, nuchal rigidity', 'Grade 2 - Moderate to severe headache, nuchal rigidity')),
          CalculatorOption(value: 3, label: LString('Grade 3 - Confusion, drowsiness, mild focal deficit', 'Grade 3 - Confusion, drowsiness, mild focal deficit')),
          CalculatorOption(value: 4, label: LString('Grade 4 - Stupor, moderate to severe hemiparesis', 'Grade 4 - Stupor, moderate to severe hemiparesis')),
          CalculatorOption(value: 5, label: LString('Grade 5 - Coma, decerebrate rigidity', 'Grade 5 - Coma, decerebrate rigidity')),
        ],
      ),
    ],
    calculate: (values) {
      return (values['grade'] as double? ?? 0);
    },
    interpretations: [
      const ScoreInterpretation(min: 1, max: 1, label: LString('Grade 1', 'Grade 1'), description: LString('Good prognosis. Mortality ~1%.', 'Good prognosis. Mortality ~1%.'), color: Colors.green),
      const ScoreInterpretation(min: 2, max: 2, label: LString('Grade 2', 'Grade 2'), description: LString('Good prognosis. Mortality ~5%.', 'Good prognosis. Mortality ~5%.'), color: Colors.green),
      const ScoreInterpretation(min: 3, max: 3, label: LString('Grade 3', 'Grade 3'), description: LString('Intermediate prognosis. Mortality ~19%.', 'Intermediate prognosis. Mortality ~19%.'), color: Colors.yellow),
      const ScoreInterpretation(min: 4, max: 4, label: LString('Grade 4', 'Grade 4'), description: LString('Poor prognosis. Mortality ~42%.', 'Poor prognosis. Mortality ~42%.'), color: Colors.orange),
      const ScoreInterpretation(min: 5, max: 5, label: LString('Grade 5', 'Grade 5'), description: LString('Very poor prognosis. Mortality ~77%.', 'Very poor prognosis. Mortality ~77%.'), color: Colors.red),
    ],
    source: 'Hunt WE, Hess RM. J Neurosurg 1968',
    sourceUrl: 'https://pubmed.ncbi.nlm.nih.gov/5635959/',
  ),
  Calculator(
    id: 'alvarado',
    name: LString('Alvarado Score (MANTRELS)', 'Alvarado Score (MANTRELS)'),
    shortName: 'Alvarado',
    category: CalculatorCategory.gi,
    description: LString('Probability of acute appendicitis', 'Probability of acute appendicitis'),
    fields: [
      const CalculatorField(id: 'migration', label: LString('M - Migration of pain to RLQ', 'M - Migration of pain to RLQ'), type: CalculatorFieldType.checkbox),
      const CalculatorField(id: 'anorexia', label: LString('A - Anorexia', 'A - Anorexia'), type: CalculatorFieldType.checkbox),
      const CalculatorField(id: 'nausea', label: LString('N - Nausea/Vomiting', 'N - Nausea/Vomiting'), type: CalculatorFieldType.checkbox),
      const CalculatorField(id: 'tenderness', label: LString('T - Tenderness in RLQ', 'T - Tenderness in RLQ'), type: CalculatorFieldType.checkbox),
      const CalculatorField(id: 'rebound', label: LString('R - Rebound tenderness', 'R - Rebound tenderness'), type: CalculatorFieldType.checkbox),
      const CalculatorField(id: 'elevation', label: LString('E - Elevated temperature (> 37.3°C)', 'E - Elevated temperature (> 37.3°C)'), type: CalculatorFieldType.checkbox),
      const CalculatorField(id: 'leukocytosis', label: LString('L - Leukocytosis (> 10,000/mm³)', 'L - Leukocytosis (> 10,000/mm³)'), type: CalculatorFieldType.checkbox),
      const CalculatorField(id: 'shift', label: LString('S - Shift to left (neutrophils > 75%)', 'S - Shift to left (neutrophils > 75%)'), type: CalculatorFieldType.checkbox),
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
      const ScoreInterpretation(min: 0, max: 4, label: LString('Low Probability', 'Low Probability'), description: LString('Appendicitis unlikely. Observation or discharge.', 'Appendicitis unlikely. Observation or discharge.'), color: Colors.green),
      const ScoreInterpretation(min: 5, max: 6, label: LString('Intermediate', 'Intermediate'), description: LString('Appendicitis possible. Imaging (US/CT) recommended.', 'Appendicitis possible. Imaging (US/CT) recommended.'), color: Colors.yellow),
      const ScoreInterpretation(min: 7, max: 8, label: LString('High Probability', 'High Probability'), description: LString('Appendicitis probable. Surgical consultation.', 'Appendicitis probable. Surgical consultation.'), color: Colors.red),
    ],
    source: 'Alvarado A. Ann Emerg Med 1986',
    sourceUrl: 'https://pubmed.ncbi.nlm.nih.gov/3963537/',
  ),
  Calculator(
    id: 'bisap',
    name: LString('BISAP Score', 'BISAP Score'),
    shortName: 'BISAP',
    category: CalculatorCategory.gi,
    description: LString('Prognosis of acute pancreatitis within first 24h', 'Prognosis of acute pancreatitis within first 24h'),
    fields: [
      const CalculatorField(id: 'bun', label: LString('B - BUN > 25 mg/dL (8.9 mmol/L)', 'B - BUN > 25 mg/dL (8.9 mmol/L)'), type: CalculatorFieldType.checkbox),
      const CalculatorField(id: 'impaired', label: LString('I - Impaired mental status (GCS < 15)', 'I - Impaired mental status (GCS < 15)'), type: CalculatorFieldType.checkbox),
      const CalculatorField(id: 'sirs', label: LString('S - SIRS (≥ 2 criteria)', 'S - SIRS (≥ 2 criteria)'), type: CalculatorFieldType.checkbox),
      const CalculatorField(id: 'age', label: LString('A - Age > 60 years', 'A - Age > 60 years'), type: CalculatorFieldType.checkbox),
      const CalculatorField(id: 'pleural', label: LString('P - Pleural effusion', 'P - Pleural effusion'), type: CalculatorFieldType.checkbox),
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
      const ScoreInterpretation(min: 0, max: 0, label: LString('Score 0', 'Score 0'), description: LString('Mortality < 1%.', 'Mortality < 1%.'), color: Colors.green),
      const ScoreInterpretation(min: 1, max: 1, label: LString('Score 1', 'Score 1'), description: LString('Mortality < 2%.', 'Mortality < 2%.'), color: Colors.green),
      const ScoreInterpretation(min: 2, max: 2, label: LString('Score 2', 'Score 2'), description: LString('Mortality 2-5%. Close monitoring.', 'Mortality 2-5%. Close monitoring.'), color: Colors.yellow),
      const ScoreInterpretation(min: 3, max: 3, label: LString('Score 3', 'Score 3'), description: LString('Mortality 5-20%. ICU admission probable.', 'Mortality 5-20%. ICU admission probable.'), color: Colors.orange),
      const ScoreInterpretation(min: 4, max: 5, label: LString('Score 4-5', 'Score 4-5'), description: LString('Mortality > 20%. ICU admission.', 'Mortality > 20%. ICU admission.'), color: Colors.red),
    ],
    source: 'Wu BU et al. Gut 2008',
    sourceUrl: 'https://pubmed.ncbi.nlm.nih.gov/18703447/',
  ),
  Calculator(
    id: 'glasgow-blatchford',
    name: LString('Glasgow-Blatchford Score', 'Glasgow-Blatchford Score'),
    shortName: 'GBS',
    category: CalculatorCategory.gi,
    description: LString('Need for intervention in Upper GI Bleeding', 'Need for intervention in Upper GI Bleeding'),
    fields: [
      const CalculatorField(
        id: 'bun',
        label: LString('BUN (mmol/L)', 'BUN (mmol/L)'),
        type: CalculatorFieldType.select,
        options: [
          CalculatorOption(value: 0, label: LString('< 6.5', '< 6.5')),
          CalculatorOption(value: 2, label: LString('6.5-7.9', '6.5-7.9')),
          CalculatorOption(value: 3, label: LString('8.0-9.9', '8.0-9.9')),
          CalculatorOption(value: 4, label: LString('10.0-24.9', '10.0-24.9')),
          CalculatorOption(value: 6, label: LString('≥ 25', '≥ 25')),
        ],
      ),
      const CalculatorField(
        id: 'hbMen',
        label: LString('Hemoglobin - Men (g/dL)', 'Hemoglobin - Men (g/dL)'),
        type: CalculatorFieldType.select,
        options: [
          CalculatorOption(value: 0, label: LString('≥ 13', '≥ 13')),
          CalculatorOption(value: 1, label: LString('12.0-12.9', '12.0-12.9')),
          CalculatorOption(value: 3, label: LString('10.0-11.9', '10.0-11.9')),
          CalculatorOption(value: 6, label: LString('< 10', '< 10')),
        ],
      ),
      const CalculatorField(
        id: 'hbWomen',
        label: LString('Hemoglobin - Women (g/dL)', 'Hemoglobin - Women (g/dL)'),
        type: CalculatorFieldType.select,
        options: [
          CalculatorOption(value: 0, label: LString('≥ 12', '≥ 12')),
          CalculatorOption(value: 1, label: LString('10.0-11.9', '10.0-11.9')),
          CalculatorOption(value: 6, label: LString('< 10', '< 10')),
        ],
      ),
      const CalculatorField(
        id: 'sbp',
        label: LString('Systolic BP (mmHg)', 'Systolic BP (mmHg)'),
        type: CalculatorFieldType.select,

        options: [
          CalculatorOption(value: 0, label: LString('≥ 110', '≥ 110')),
          CalculatorOption(value: 1, label: LString('100-109', '100-109')),
          CalculatorOption(value: 2, label: LString('90-99', '90-99')),
          CalculatorOption(value: 3, label: LString('< 90', '< 90')),
        ],
      ),
      const CalculatorField(id: 'pulse', label: LString('Pulse ≥ 100/min', 'Pulse ≥ 100/min'), type: CalculatorFieldType.checkbox),
      const CalculatorField(id: 'melena', label: LString('Melena', 'Melena'), type: CalculatorFieldType.checkbox),
      const CalculatorField(id: 'syncope', label: LString('Syncope', 'Syncope'), type: CalculatorFieldType.checkbox),
      const CalculatorField(id: 'liver', label: LString('Hepatic Disease', 'Hepatic Disease'), type: CalculatorFieldType.checkbox),
      const CalculatorField(id: 'heart', label: LString('Heart Failure', 'Heart Failure'), type: CalculatorFieldType.checkbox),
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
      const ScoreInterpretation(min: 0, max: 0, label: LString('Very Low Risk', 'Very Low Risk'), description: LString('Score 0: Outpatient management possible. NPV 100% for intervention.', 'Score 0: Outpatient management possible. NPV 100% for intervention.'), color: Colors.green),
      const ScoreInterpretation(min: 1, max: 2, label: LString('Low Risk', 'Low Risk'), description: LString('Low probability of intervention. Observation.', 'Low probability of intervention. Observation.'), color: Colors.green),
      const ScoreInterpretation(min: 3, max: 5, label: LString('Intermediate Risk', 'Intermediate Risk'), description: LString('Intervention possible. Hospitalization.', 'Intervention possible. Hospitalization.'), color: Colors.yellow),
      const ScoreInterpretation(min: 6, max: 11, label: LString('High Risk', 'High Risk'), description: LString('Intervention probable. Urgent endoscopy.', 'Intervention probable. Urgent endoscopy.'), color: Colors.orange),
      const ScoreInterpretation(min: 12, max: 23, label: LString('Very High Risk', 'Very High Risk'), description: LString('Intervention very probable. Resuscitation/transfusion.', 'Intervention very probable. Resuscitation/transfusion.'), color: Colors.red),
    ],
    source: 'Blatchford O et al. Lancet 2000',
    sourceUrl: 'https://pubmed.ncbi.nlm.nih.gov/11073017/',
  ),
  Calculator(
    id: 'rockall',
    name: LString('Rockall Score', 'Rockall Score'),
    shortName: 'Rockall',
    category: CalculatorCategory.gi,
    description: LString('Risk of rebleeding and mortality after Upper GI Bleeding', 'Risk of rebleeding and mortality after Upper GI Bleeding'),
    fields: [
      const CalculatorField(
        id: 'age',
        label: LString('Age', 'Age'),
        type: CalculatorFieldType.select,
        options: [
          CalculatorOption(value: 0, label: LString('< 60 years', '< 60 years')),
          CalculatorOption(value: 1, label: LString('60-79 years', '60-79 years')),
          CalculatorOption(value: 2, label: LString('≥ 80 years', '≥ 80 years')),
        ],
      ),
      const CalculatorField(
        id: 'shock',
        label: LString('Shock', 'Shock'),
        type: CalculatorFieldType.select,
        options: [
          CalculatorOption(value: 0, label: LString('No shock (SBP ≥ 100, HR < 100)', 'No shock (SBP ≥ 100, HR < 100)')),
          CalculatorOption(value: 1, label: LString('Tachycardia (SBP ≥ 100, HR ≥ 100)', 'Tachycardia (SBP ≥ 100, HR ≥ 100)')),
          CalculatorOption(value: 2, label: LString('Hypotension (SBP < 100)', 'Hypotension (SBP < 100)')),
        ],
      ),
      const CalculatorField(
        id: 'comorbidity',
        label: LString('Comorbidities', 'Comorbidities'),
        type: CalculatorFieldType.select,
        options: [
          CalculatorOption(value: 0, label: LString('None', 'None')),
          CalculatorOption(value: 2, label: LString('Heart failure, IHD, other major', 'Heart failure, IHD, other major')),
          CalculatorOption(value: 3, label: LString('Renal/Liver failure, metastatic cancer', 'Renal/Liver failure, metastatic cancer')),
        ],
      ),
      const CalculatorField(
        id: 'diagnosis',
        label: LString('Endoscopic Diagnosis', 'Endoscopic Diagnosis'),
        type: CalculatorFieldType.select,
        options: [
          CalculatorOption(value: 0, label: LString('Mallory-Weiss, no lesion, no stigmata', 'Mallory-Weiss, no lesion, no stigmata')),
          CalculatorOption(value: 1, label: LString('All other diagnoses', 'All other diagnoses')),
          CalculatorOption(value: 2, label: LString('Upper GI malignancy', 'Upper GI malignancy')),
        ],
      ),
      const CalculatorField(
        id: 'stigmata',
        label: LString('Stigmata of Recent Hemorrhage', 'Stigmata of Recent Hemorrhage'),
        type: CalculatorFieldType.select,
        options: [
          CalculatorOption(value: 0, label: LString('None or dark spot', 'None or dark spot')),
          CalculatorOption(value: 2, label: LString('Blood, adherent clot, visible vessel, active bleeding', 'Blood, adherent clot, visible vessel, active bleeding')),
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
      const ScoreInterpretation(min: 0, max: 2, label: LString('Low Risk', 'Low Risk'), description: LString('Mortality < 5%. Early discharge possible.', 'Mortality < 5%. Early discharge possible.'), color: Colors.green),
      const ScoreInterpretation(min: 3, max: 4, label: LString('Intermediate Risk', 'Intermediate Risk'), description: LString('Mortality 11%. Hospitalization.', 'Mortality 11%. Hospitalization.'), color: Colors.yellow),
      const ScoreInterpretation(min: 5, max: 6, label: LString('High Risk', 'High Risk'), description: LString('Mortality 25%. Close monitoring.', 'Mortality 25%. Close monitoring.'), color: Colors.orange),
      const ScoreInterpretation(min: 7, max: 11, label: LString('Very High Risk', 'Very High Risk'), description: LString('Mortality > 40%. Resuscitation.', 'Mortality > 40%. Resuscitation.'), color: Colors.red),
    ],
    source: 'Rockall TA et al. Gut 1996',
    sourceUrl: 'https://pubmed.ncbi.nlm.nih.gov/8707114/',
  ),
  Calculator(
    id: 'ciwa-ar',
    name: LString('CIWA-Ar (Alcohol Withdrawal)', 'CIWA-Ar (Alcohol Withdrawal)'),
    shortName: 'CIWA-Ar',
    category: CalculatorCategory.toxicology,
    description: LString('Severity of alcohol withdrawal and treatment guide', 'Severity of alcohol withdrawal and treatment guide'),
    fields: [
      const CalculatorField(
        id: 'nausea',
        label: LString('Nausea and Vomiting', 'Nausea and Vomiting'),
        type: CalculatorFieldType.select,
        options: [
          CalculatorOption(value: 0, label: LString('0 - None', '0 - None')),
          CalculatorOption(value: 1, label: LString('1 - Mild nausea, no vomiting', '1 - Mild nausea, no vomiting')),
          CalculatorOption(value: 4, label: LString('4 - Intermittent nausea with dry heaves', '4 - Intermittent nausea with dry heaves')),
          CalculatorOption(value: 7, label: LString('7 - Constant nausea, frequent dry heaves, vomiting', '7 - Constant nausea, frequent dry heaves, vomiting')),
        ],
      ),
      const CalculatorField(
        id: 'tremor',
        label: LString('Tremor (arms extended, fingers spread)', 'Tremor (arms extended, fingers spread)'),
        type: CalculatorFieldType.select,
        options: [
          CalculatorOption(value: 0, label: LString('0 - No tremor', '0 - No tremor')),
          CalculatorOption(value: 1, label: LString('1 - Not visible, but can be felt', '1 - Not visible, but can be felt')),
          CalculatorOption(value: 4, label: LString('4 - Moderate, with arms extended', '4 - Moderate, with arms extended')),
          CalculatorOption(value: 7, label: LString('7 - Severe, even with arms not extended', '7 - Severe, even with arms not extended')),
        ],
      ),
      const CalculatorField(
        id: 'sweating',
        label: LString('Paroxysmal Sweats', 'Paroxysmal Sweats'),
        type: CalculatorFieldType.select,
        options: [
          CalculatorOption(value: 0, label: LString('0 - No sweat visible', '0 - No sweat visible')),
          CalculatorOption(value: 1, label: LString('1 - Barely perceptible sweating, palms moist', '1 - Barely perceptible sweating, palms moist')),
          CalculatorOption(value: 4, label: LString('4 - Beads of sweat on forehead', '4 - Beads of sweat on forehead')),
          CalculatorOption(value: 7, label: LString('7 - Drenching sweats', '7 - Drenching sweats')),
        ],
      ),
      const CalculatorField(
        id: 'anxiety',
        label: LString('Anxiety', 'Anxiety'),
        type: CalculatorFieldType.select,
        options: [
          CalculatorOption(value: 0, label: LString('0 - No anxiety, at ease', '0 - No anxiety, at ease')),
          CalculatorOption(value: 1, label: LString('1 - Mildly anxious', '1 - Mildly anxious')),
          CalculatorOption(value: 4, label: LString('4 - Moderately anxious, or guarded', '4 - Moderately anxious, or guarded')),
          CalculatorOption(value: 7, label: LString('7 - Equivalent to acute panic states', '7 - Equivalent to acute panic states')),
        ],
      ),
      const CalculatorField(
        id: 'agitation',
        label: LString('Agitation', 'Agitation'),
        type: CalculatorFieldType.select,
        options: [
          CalculatorOption(value: 0, label: LString('0 - Normal activity', '0 - Normal activity')),
          CalculatorOption(value: 1, label: LString('1 - Somewhat more than normal activity', '1 - Somewhat more than normal activity')),
          CalculatorOption(value: 4, label: LString('4 - Moderately fidgety and restless', '4 - Moderately fidgety and restless')),
          CalculatorOption(value: 7, label: LString('7 - Paces back and forth, or constantly thrashes about', '7 - Paces back and forth, or constantly thrashes about')),
        ],
      ),
      const CalculatorField(
        id: 'tactile',
        label: LString('Tactile Disturbances', 'Tactile Disturbances'),
        type: CalculatorFieldType.select,
        options: [
          CalculatorOption(value: 0, label: LString('0 - None', '0 - None')),
          CalculatorOption(value: 1, label: LString('1 - Very mild itch, pins and needles, burning or numbness', '1 - Very mild itch, pins and needles, burning or numbness')),
          CalculatorOption(value: 2, label: LString('2 - Mild itch, pins and needles, burning or numbness', '2 - Mild itch, pins and needles, burning or numbness')),
          CalculatorOption(value: 3, label: LString('3 - Moderate itch, pins and needles, burning or numbness', '3 - Moderate itch, pins and needles, burning or numbness')),
          CalculatorOption(value: 4, label: LString('4 - Moderately severe hallucinations', '4 - Moderately severe hallucinations')),
          CalculatorOption(value: 5, label: LString('5 - Severe hallucinations', '5 - Severe hallucinations')),
          CalculatorOption(value: 6, label: LString('6 - Extremely severe hallucinations', '6 - Extremely severe hallucinations')),
          CalculatorOption(value: 7, label: LString('7 - Continuous hallucinations', '7 - Continuous hallucinations')),
        ],
      ),
      const CalculatorField(
        id: 'auditory',
        label: LString('Auditory Disturbances', 'Auditory Disturbances'),
        type: CalculatorFieldType.select,
        options: [
          CalculatorOption(value: 0, label: LString('0 - Not present', '0 - Not present')),
          CalculatorOption(value: 1, label: LString('1 - Very mild harshness or ability to frighten', '1 - Very mild harshness or ability to frighten')),
          CalculatorOption(value: 2, label: LString('2 - Mild harshness or ability to frighten', '2 - Mild harshness or ability to frighten')),
          CalculatorOption(value: 3, label: LString('3 - Moderate harshness or ability to frighten', '3 - Moderate harshness or ability to frighten')),
          CalculatorOption(value: 4, label: LString('4 - Moderately severe hallucinations', '4 - Moderately severe hallucinations')),
          CalculatorOption(value: 5, label: LString('5 - Severe hallucinations', '5 - Severe hallucinations')),
          CalculatorOption(value: 6, label: LString('6 - Extremely severe hallucinations', '6 - Extremely severe hallucinations')),
          CalculatorOption(value: 7, label: LString('7 - Continuous hallucinations', '7 - Continuous hallucinations')),
        ],
      ),
      const CalculatorField(
        id: 'visual',
        label: LString('Visual Disturbances', 'Visual Disturbances'),
        type: CalculatorFieldType.select,
        options: [
          CalculatorOption(value: 0, label: LString('0 - Not present', '0 - Not present')),
          CalculatorOption(value: 1, label: LString('1 - Very mild sensitivity', '1 - Very mild sensitivity')),
          CalculatorOption(value: 2, label: LString('2 - Mild sensitivity', '2 - Mild sensitivity')),
          CalculatorOption(value: 3, label: LString('3 - Moderate sensitivity', '3 - Moderate sensitivity')),
          CalculatorOption(value: 4, label: LString('4 - Moderately severe hallucinations', '4 - Moderately severe hallucinations')),
          CalculatorOption(value: 5, label: LString('5 - Severe hallucinations', '5 - Severe hallucinations')),
          CalculatorOption(value: 6, label: LString('6 - Extremely severe hallucinations', '6 - Extremely severe hallucinations')),
          CalculatorOption(value: 7, label: LString('7 - Continuous hallucinations', '7 - Continuous hallucinations')),
        ],
      ),
      const CalculatorField(
        id: 'headache',
        label: LString('Headache, Fullness in Head', 'Headache, Fullness in Head'),
        type: CalculatorFieldType.select,
        options: [
          CalculatorOption(value: 0, label: LString('0 - Not present', '0 - Not present')),
          CalculatorOption(value: 1, label: LString('1 - Very mild', '1 - Very mild')),
          CalculatorOption(value: 2, label: LString('2 - Mild', '2 - Mild')),
          CalculatorOption(value: 3, label: LString('3 - Moderate', '3 - Moderate')),
          CalculatorOption(value: 4, label: LString('4 - Moderately severe', '4 - Moderately severe')),
          CalculatorOption(value: 5, label: LString('5 - Severe', '5 - Severe')),
          CalculatorOption(value: 6, label: LString('6 - Very severe', '6 - Very severe')),
          CalculatorOption(value: 7, label: LString('7 - Extremely severe', '7 - Extremely severe')),
        ],
      ),
      const CalculatorField(
        id: 'orientation',
        label: LString('Orientation and Clouding of Sensorium', 'Orientation and Clouding of Sensorium'),
        type: CalculatorFieldType.select,
        options: [
          CalculatorOption(value: 0, label: LString('0 - Oriented and can do serial additions', '0 - Oriented and can do serial additions')),
          CalculatorOption(value: 1, label: LString('1 - Cannot do serial additions or is uncertain about date', '1 - Cannot do serial additions or is uncertain about date')),
          CalculatorOption(value: 2, label: LString('2 - Disoriented for date by no more than 2 calendar days', '2 - Disoriented for date by no more than 2 calendar days')),
          CalculatorOption(value: 3, label: LString('3 - Disoriented for date by more than 2 calendar days', '3 - Disoriented for date by more than 2 calendar days')),
          CalculatorOption(value: 4, label: LString('4 - Disoriented for place and/or person', '4 - Disoriented for place and/or person')),
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
      const ScoreInterpretation(min: 0, max: 8, label: LString('Mild Withdrawal', 'Mild Withdrawal'), description: LString('No pharmacological treatment needed. Monitoring.', 'No pharmacological treatment needed. Monitoring.'), color: Colors.green),
      const ScoreInterpretation(min: 9, max: 15, label: LString('Moderate Withdrawal', 'Moderate Withdrawal'), description: LString('Consider benzodiazepines. Close monitoring.', 'Consider benzodiazepines. Close monitoring.'), color: Colors.yellow),
      const ScoreInterpretation(min: 16, max: 20, label: LString('Severe Withdrawal', 'Severe Withdrawal'), description: LString('Benzodiazepines recommended. Continuous monitoring.', 'Benzodiazepines recommended. Continuous monitoring.'), color: Colors.orange),
      const ScoreInterpretation(min: 21, max: 67, label: LString('Very Severe Withdrawal', 'Very Severe Withdrawal'), description: LString('Risk of delirium tremens. ICU. IV Benzodiazepines.', 'Risk of delirium tremens. ICU. IV Benzodiazepines.'), color: Colors.red),
    ],
    source: 'Sullivan JT et al. Br J Addict 1989',
    sourceUrl: 'https://pubmed.ncbi.nlm.nih.gov/2597811/',
  ),
  Calculator(
    id: 'cows',
    name: LString('COWS (Clinical Opiate Withdrawal Scale)', 'COWS (Clinical Opiate Withdrawal Scale)'),
    shortName: 'COWS',
    category: CalculatorCategory.toxicology,
    description: LString('Severity of opiate withdrawal', 'Severity of opiate withdrawal'),
    fields: [
      const CalculatorField(
        id: 'pulse',
        label: LString('Resting Pulse Rate', 'Resting Pulse Rate'),
        type: CalculatorFieldType.select,
        options: [
          CalculatorOption(value: 0, label: LString('0 - ≤ 80/min', '0 - ≤ 80/min')),
          CalculatorOption(value: 1, label: LString('1 - 81-100/min', '1 - 81-100/min')),
          CalculatorOption(value: 2, label: LString('2 - 101-120/min', '2 - 101-120/min')),
          CalculatorOption(value: 4, label: LString('4 - > 120/min', '4 - > 120/min')),
        ],
      ),
      const CalculatorField(
        id: 'sweating',
        label: LString('Sweating (over past 1/2 hour)', 'Sweating (over past 1/2 hour)'),
        type: CalculatorFieldType.select,
        options: [
          CalculatorOption(value: 0, label: LString('0 - No report of chills or flushing', '0 - No report of chills or flushing')),
          CalculatorOption(value: 1, label: LString('1 - Subjective report of chills or flushing', '1 - Subjective report of chills or flushing')),
          CalculatorOption(value: 2, label: LString('2 - Flushed or observable moistness on face', '2 - Flushed or observable moistness on face')),
          CalculatorOption(value: 3, label: LString('3 - Beads of sweat on brow or face', '3 - Beads of sweat on brow or face')),
          CalculatorOption(value: 4, label: LString('4 - Sweat streaming off face', '4 - Sweat streaming off face')),
        ],
      ),
      const CalculatorField(
        id: 'restlessness',
        label: LString('Restlessness (observation)', 'Restlessness (observation)'),
        type: CalculatorFieldType.select,
        options: [
          CalculatorOption(value: 0, label: LString('0 - Able to sit still', '0 - Able to sit still')),
          CalculatorOption(value: 1, label: LString('1 - Reports difficulty sitting still, but is able to do so', '1 - Reports difficulty sitting still, but is able to do so')),
          CalculatorOption(value: 3, label: LString('3 - Frequent shifting or extraneous movements of legs/arms', '3 - Frequent shifting or extraneous movements of legs/arms')),
          CalculatorOption(value: 5, label: LString('5 - Unable to sit still for more than a few seconds', '5 - Unable to sit still for more than a few seconds')),
        ],
      ),
      const CalculatorField(
        id: 'pupils',
        label: LString('Pupil Size', 'Pupil Size'),
        type: CalculatorFieldType.select,
        options: [
          CalculatorOption(value: 0, label: LString('0 - Pupils pinned or normal size for room light', '0 - Pupils pinned or normal size for room light')),
          CalculatorOption(value: 1, label: LString('1 - Pupils possibly larger than normal for room light', '1 - Pupils possibly larger than normal for room light')),
          CalculatorOption(value: 2, label: LString('2 - Pupils moderately dilated', '2 - Pupils moderately dilated')),
          CalculatorOption(value: 5, label: LString('5 - Pupils so dilated that only the rim of the iris is visible', '5 - Pupils so dilated that only the rim of the iris is visible')),
        ],
      ),
      const CalculatorField(
        id: 'boneJointAches',
        label: LString('Bone or Joint Aches', 'Bone or Joint Aches'),
        type: CalculatorFieldType.select,
        options: [
          CalculatorOption(value: 0, label: LString('0 - Not present', '0 - Not present')),
          CalculatorOption(value: 1, label: LString('1 - Mild diffuse discomfort', '1 - Mild diffuse discomfort')),
          CalculatorOption(value: 2, label: LString('2 - Patient reports severe diffuse aching of joints/muscles', '2 - Patient reports severe diffuse aching of joints/muscles')),
          CalculatorOption(value: 4, label: LString('4 - Patient is rubbing joints or muscles and is unable to sit still because of discomfort', '4 - Patient is rubbing joints or muscles and is unable to sit still because of discomfort')),
        ],
      ),
      const CalculatorField(
        id: 'runnyNose',
        label: LString('Runny Nose or Tearing', 'Runny Nose or Tearing'),
        type: CalculatorFieldType.select,
        options: [
          CalculatorOption(value: 0, label: LString('0 - Not present', '0 - Not present')),
          CalculatorOption(value: 1, label: LString('1 - Nasal stuffiness or unusually moist eyes', '1 - Nasal stuffiness or unusually moist eyes')),
          CalculatorOption(value: 2, label: LString('2 - Nose running or tearing', '2 - Nose running or tearing')),
          CalculatorOption(value: 4, label: LString('4 - Nose constantly running or tears streaming down cheeks', '4 - Nose constantly running or tears streaming down cheeks')),
        ],
      ),
      const CalculatorField(
        id: 'gi',
        label: LString('GI Upset', 'GI Upset'),
        type: CalculatorFieldType.select,
        options: [
          CalculatorOption(value: 0, label: LString('0 - No GI symptoms', '0 - No GI symptoms')),
          CalculatorOption(value: 1, label: LString('1 - Stomach cramps', '1 - Stomach cramps')),
          CalculatorOption(value: 2, label: LString('2 - Nausea or loose stool', '2 - Nausea or loose stool')),
          CalculatorOption(value: 3, label: LString('3 - Vomiting or diarrhea', '3 - Vomiting or diarrhea')),
          CalculatorOption(value: 5, label: LString('5 - Multiple episodes of diarrhea or vomiting', '5 - Multiple episodes of diarrhea or vomiting')),
        ],
      ),
      const CalculatorField(
        id: 'tremor',
        label: LString('Tremor (observation of outstretched hands)', 'Tremor (observation of outstretched hands)'),
        type: CalculatorFieldType.select,
        options: [
          CalculatorOption(value: 0, label: LString('0 - No tremor', '0 - No tremor')),
          CalculatorOption(value: 1, label: LString('1 - Tremor can be felt, but not observed', '1 - Tremor can be felt, but not observed')),
          CalculatorOption(value: 2, label: LString('2 - Slight tremor observable', '2 - Slight tremor observable')),
          CalculatorOption(value: 4, label: LString('4 - Gross tremor or muscle twitching', '4 - Gross tremor or muscle twitching')),
        ],
      ),
      const CalculatorField(
        id: 'yawning',
        label: LString('Yawning (observation)', 'Yawning (observation)'),
        type: CalculatorFieldType.select,
        options: [
          CalculatorOption(value: 0, label: LString('0 - No yawning', '0 - No yawning')),
          CalculatorOption(value: 1, label: LString('1 - Yawning once or twice during assessment', '1 - Yawning once or twice during assessment')),
          CalculatorOption(value: 2, label: LString('2 - Yawning three or more times during assessment', '2 - Yawning three or more times during assessment')),
          CalculatorOption(value: 4, label: LString('4 - Yawning several times/minute', '4 - Yawning several times/minute')),
        ],
      ),
      const CalculatorField(
        id: 'anxiety',
        label: LString('Anxiety or Irritability', 'Anxiety or Irritability'),
        type: CalculatorFieldType.select,
        options: [
          CalculatorOption(value: 0, label: LString('0 - None', '0 - None')),
          CalculatorOption(value: 1, label: LString('1 - Patient reports increasing irritability or anxiety', '1 - Patient reports increasing irritability or anxiety')),
          CalculatorOption(value: 2, label: LString('2 - Patient obviously irritable or anxious', '2 - Patient obviously irritable or anxious')),
          CalculatorOption(value: 4, label: LString('4 - Patient so irritable or anxious that participation in the assessment is difficult', '4 - Patient so irritable or anxious that participation in the assessment is difficult')),
        ],
      ),
      const CalculatorField(
        id: 'gooseflesh',
        label: LString('Gooseflesh Skin', 'Gooseflesh Skin'),
        type: CalculatorFieldType.select,
        options: [
          CalculatorOption(value: 0, label: LString('0 - Skin is smooth', '0 - Skin is smooth')),
          CalculatorOption(value: 3, label: LString('3 - Piloerection of skin can be felt or hairs standing up on arms', '3 - Piloerection of skin can be felt or hairs standing up on arms')),
          CalculatorOption(value: 5, label: LString('5 - Prominent piloerection', '5 - Prominent piloerection')),
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
      const ScoreInterpretation(min: 0, max: 4, label: LString('No Withdrawal', 'No Withdrawal'), description: LString('No significant symptoms.', 'No significant symptoms.'), color: Colors.green),
      const ScoreInterpretation(min: 5, max: 12, label: LString('Mild Withdrawal', 'Mild Withdrawal'), description: LString('Symptomatic treatment.', 'Symptomatic treatment.'), color: Colors.green),
      const ScoreInterpretation(min: 13, max: 24, label: LString('Moderate Withdrawal', 'Moderate Withdrawal'), description: LString('Consider substitution treatment.', 'Consider substitution treatment.'), color: Colors.yellow),
      const ScoreInterpretation(min: 25, max: 36, label: LString('Moderately Severe', 'Moderately Severe'), description: LString('Substitution treatment recommended.', 'Substitution treatment recommended.'), color: Colors.orange),
      const ScoreInterpretation(min: 37, max: 48, label: LString('Severe Withdrawal', 'Severe Withdrawal'), description: LString('Intensive treatment. Possible hospitalization.', 'Intensive treatment. Possible hospitalization.'), color: Colors.red),
    ],
    source: 'Wesson DR, Ling W. J Psychoactive Drugs 2003',
    sourceUrl: 'https://pubmed.ncbi.nlm.nih.gov/12924748/',
  ),
  Calculator(
    id: 'ottawa-ankle',
    name: LString('Ottawa Ankle Rules', 'Ottawa Ankle Rules'),
    shortName: 'Ottawa Ankle',
    category: CalculatorCategory.msk,
    description: LString('Indication for radiography after ankle trauma', 'Indication for radiography after ankle trauma'),
    fields: [
      const CalculatorField(id: 'bonePostMalleolus', label: LString('Bone tenderness at posterior edge of lateral malleolus (6cm)', 'Bone tenderness at posterior edge of lateral malleolus (6cm)'), type: CalculatorFieldType.checkbox),
      const CalculatorField(id: 'boneMedialMalleolus', label: LString('Bone tenderness at posterior edge of medial malleolus (6cm)', 'Bone tenderness at posterior edge of medial malleolus (6cm)'), type: CalculatorFieldType.checkbox),
      const CalculatorField(id: 'boneBaseMetatarsal', label: LString('Bone tenderness at base of 5th metatarsal', 'Bone tenderness at base of 5th metatarsal'), type: CalculatorFieldType.checkbox),
      const CalculatorField(id: 'boneNavicular', label: LString('Bone tenderness at navicular', 'Bone tenderness at navicular'), type: CalculatorFieldType.checkbox),
      const CalculatorField(id: 'unableToWalk', label: LString('Inability to bear weight both immediately and in ED (4 steps)', 'Inability to bear weight both immediately and in ED (4 steps)'), type: CalculatorFieldType.checkbox),
    ],
    calculate: (values) {
      bool anklePositive = (values['bonePostMalleolus'] == 1.0) || (values['boneMedialMalleolus'] == 1.0) || (values['unableToWalk'] == 1.0);
      bool footPositive = (values['boneBaseMetatarsal'] == 1.0) || (values['boneNavicular'] == 1.0) || (values['unableToWalk'] == 1.0);
      
      if (anklePositive || footPositive) return 1;
      return 0;
    },
    interpretations: [
      const ScoreInterpretation(min: 0, max: 0, label: LString('Negative Rule', 'Negative Rule'), description: LString('X-ray NOT indicated. Sensitivity ~100% for significant fracture.', 'X-ray NOT indicated. Sensitivity ~100% for significant fracture.'), color: Colors.green),
      const ScoreInterpretation(min: 1, max: 1, label: LString('Positive Rule', 'Positive Rule'), description: LString('X-ray indicated (ankle and/or foot depending on criteria).', 'X-ray indicated (ankle and/or foot depending on criteria).'), color: Colors.yellow),
    ],
    source: 'Stiell IG et al. JAMA 1993',
    sourceUrl: 'https://pubmed.ncbi.nlm.nih.gov/8411587/',
  ),
  Calculator(
    id: 'ottawa-knee',
    name: LString('Ottawa Knee Rules', 'Ottawa Knee Rules'),
    shortName: 'Ottawa Knee',
    category: CalculatorCategory.msk,
    description: LString('Indication for radiography after knee trauma', 'Indication for radiography after knee trauma'),
    fields: [
      const CalculatorField(id: 'age55', label: LString('Age ≥ 55 years', 'Age ≥ 55 years'), type: CalculatorFieldType.checkbox),
      const CalculatorField(id: 'fibulaHead', label: LString('Isolated tenderness of head of fibula', 'Isolated tenderness of head of fibula'), type: CalculatorFieldType.checkbox),
      const CalculatorField(id: 'patella', label: LString('Isolated tenderness of patella', 'Isolated tenderness of patella'), type: CalculatorFieldType.checkbox),
      const CalculatorField(id: 'unableFlex90', label: LString('Inability to flex to 90°', 'Inability to flex to 90°'), type: CalculatorFieldType.checkbox),
      const CalculatorField(id: 'unableToWalk', label: LString('Inability to bear weight both immediately and in ED (4 steps)', 'Inability to bear weight both immediately and in ED (4 steps)'), type: CalculatorFieldType.checkbox),
    ],
    calculate: (values) {
      bool positive = (values['age55'] == 1.0) || (values['fibulaHead'] == 1.0) || (values['patella'] == 1.0) || 
                      (values['unableFlex90'] == 1.0) || (values['unableToWalk'] == 1.0);
      return positive ? 1 : 0;
    },
    interpretations: [
      const ScoreInterpretation(min: 0, max: 0, label: LString('Negative Rule', 'Negative Rule'), description: LString('X-ray NOT indicated. Sensitivity ~100% for fracture.', 'X-ray NOT indicated. Sensitivity ~100% for fracture.'), color: Colors.green),
      const ScoreInterpretation(min: 1, max: 1, label: LString('Positive Rule', 'Positive Rule'), description: LString('Knee X-ray indicated.', 'Knee X-ray indicated.'), color: Colors.yellow),
    ],
    source: 'Stiell IG et al. Ann Emerg Med 1995',
    sourceUrl: 'https://pubmed.ncbi.nlm.nih.gov/7864338/',
  ),
  Calculator(
    id: 'nexus-c-spine',
    name: LString('NEXUS C-Spine Rule', 'NEXUS C-Spine Rule'),
    shortName: 'NEXUS',
    category: CalculatorCategory.msk,
    description: LString('Clearance of cervical spine injury without imaging', 'Clearance of cervical spine injury without imaging'),
    fields: [
      const CalculatorField(id: 'focalDeficit', label: LString('Focal neurologic deficit', 'Focal neurologic deficit'), type: CalculatorFieldType.checkbox),
      const CalculatorField(id: 'midlineSpinal', label: LString('Midline cervical spinal tenderness', 'Midline cervical spinal tenderness'), type: CalculatorFieldType.checkbox),
      const CalculatorField(id: 'alteredConsciousness', label: LString('Altered level of consciousness', 'Altered level of consciousness'), type: CalculatorFieldType.checkbox),
      const CalculatorField(id: 'intoxication', label: LString('Intoxication', 'Intoxication'), type: CalculatorFieldType.checkbox),
      const CalculatorField(id: 'distractingInjury', label: LString('Distracting painful injury', 'Distracting painful injury'), type: CalculatorFieldType.checkbox),
    ],
    calculate: (values) {
      bool positive = (values['focalDeficit'] == 1.0) || (values['midlineSpinal'] == 1.0) || 
                      (values['alteredConsciousness'] == 1.0) || (values['intoxication'] == 1.0) || 
                      (values['distractingInjury'] == 1.0);
      return positive ? 1 : 0;
    },
    interpretations: [
      const ScoreInterpretation(min: 0, max: 0, label: LString('Negative Rule', 'Negative Rule'), description: LString('C-spine injury clinically excluded. No imaging needed.', 'C-spine injury clinically excluded. No imaging needed.'), color: Colors.green),
      const ScoreInterpretation(min: 1, max: 1, label: LString('Positive Rule', 'Positive Rule'), description: LString('C-spine imaging indicated.', 'C-spine imaging indicated.'), color: Colors.yellow),
    ],
    source: 'Hoffman JR et al. N Engl J Med 2000',
    sourceUrl: 'https://pubmed.ncbi.nlm.nih.gov/10891517/',
  ),
  Calculator(
    id: 'canadian-c-spine',
    name: LString('Canadian C-Spine Rule', 'Canadian C-Spine Rule'),
    shortName: 'Canadian C-Spine',
    category: CalculatorCategory.msk,
    description: LString('Indication for C-spine imaging after trauma', 'Indication for C-spine imaging after trauma'),
    fields: [
      const CalculatorField(
        id: 'highRiskFactor',
        label: LString('High Risk Factor (any one)', 'High Risk Factor (any one)'),
        type: CalculatorFieldType.select,
        options: [
          CalculatorOption(value: 0, label: LString('No high risk factor', 'No high risk factor')),
          CalculatorOption(value: 1, label: LString('Age ≥ 65 years', 'Age ≥ 65 years')),
          CalculatorOption(value: 1, label: LString('Dangerous mechanism', 'Dangerous mechanism')),
          CalculatorOption(value: 1, label: LString('Paresthesias in extremities', 'Paresthesias in extremities')),
        ],
      ),
      const CalculatorField(
        id: 'lowRiskFactor',
        label: LString('Low Risk Factor (allows ROM assessment)', 'Low Risk Factor (allows ROM assessment)'),
        type: CalculatorFieldType.select,
        options: [
          CalculatorOption(value: 0, label: LString('No low risk factor', 'No low risk factor')),
          CalculatorOption(value: 1, label: LString('Simple rear-end MVC', 'Simple rear-end MVC')),
          CalculatorOption(value: 1, label: LString('Sitting position in ED', 'Sitting position in ED')),
          CalculatorOption(value: 1, label: LString('Ambulatory at any time', 'Ambulatory at any time')),
          CalculatorOption(value: 1, label: LString('Delayed onset of neck pain', 'Delayed onset of neck pain')),
          CalculatorOption(value: 1, label: LString('Absence of midline c-spine tenderness', 'Absence of midline c-spine tenderness')),
        ],
      ),
      const CalculatorField(id: 'canRotate45', label: LString('Able to actively rotate neck 45° left and right', 'Able to actively rotate neck 45° left and right'), type: CalculatorFieldType.checkbox),
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
      const ScoreInterpretation(min: 0, max: 0, label: LString('Negative Rule', 'Negative Rule'), description: LString('No imaging needed. C-collar removal.', 'No imaging needed. C-collar removal.'), color: Colors.green),
      const ScoreInterpretation(min: 1, max: 1, label: LString('Unable to Rotate', 'Unable to Rotate'), description: LString('Unable to rotate neck. Imaging indicated.', 'Unable to rotate neck. Imaging indicated.'), color: Colors.yellow),
      const ScoreInterpretation(min: 2, max: 2, label: LString('High Risk', 'High Risk'), description: LString('C-spine imaging MANDATORY.', 'C-spine imaging MANDATORY.'), color: Colors.red),
    ],
    source: 'Stiell IG et al. JAMA 2001',
    sourceUrl: 'https://pubmed.ncbi.nlm.nih.gov/11594897/',
  ),
  Calculator(
    id: 'pecarn-head',
    name: LString('PECARN Head CT Rule', 'PECARN Head CT Rule'),
    shortName: 'PECARN',
    category: CalculatorCategory.pediatric,
    description: LString('Indication for head CT in children after minor head trauma', 'Indication for head CT in children after minor head trauma'),
    fields: [
      const CalculatorField(
        id: 'ageGroup',
        label: LString('Age Group', 'Age Group'),
        type: CalculatorFieldType.select,
        options: [
          CalculatorOption(value: 0, label: LString('< 2 years', '< 2 years')),
          CalculatorOption(value: 1, label: LString('≥ 2 years', '≥ 2 years')),
        ],
      ),
      const CalculatorField(id: 'gcs14', label: LString('GCS < 15', 'GCS < 15'), type: CalculatorFieldType.checkbox),
      const CalculatorField(id: 'alteredMental', label: LString('Altered mental status (agitation, somnolence, repetitive questioning, slow response)', 'Altered mental status (agitation, somnolence, repetitive questioning, slow response)'), type: CalculatorFieldType.checkbox),
      const CalculatorField(id: 'baseFracture', label: LString('Signs of basilar skull fracture', 'Signs of basilar skull fracture'), type: CalculatorFieldType.checkbox),
      const CalculatorField(id: 'palpableFracture', label: LString('Palpable skull fracture (< 2y) / Signs of fracture (≥ 2y)', 'Palpable skull fracture (< 2y) / Signs of fracture (≥ 2y)'), type: CalculatorFieldType.checkbox),
      const CalculatorField(id: 'hematoma', label: LString('Scalp hematoma (occipital, parietal or temporal for < 2y)', 'Scalp hematoma (occipital, parietal or temporal for < 2y)'), type: CalculatorFieldType.checkbox),
      const CalculatorField(id: 'lossOfConsciousness', label: LString('Loss of consciousness ≥ 5 seconds', 'Loss of consciousness ≥ 5 seconds'), type: CalculatorFieldType.checkbox),
      const CalculatorField(id: 'severeMechanism', label: LString('Severe mechanism (MVC, fall > 0.9m if <2y or >1.5m if ≥2y, high impact object)', 'Severe mechanism (MVC, fall > 0.9m if <2y or >1.5m if ≥2y, high impact object)'), type: CalculatorFieldType.checkbox),
      const CalculatorField(id: 'notActingNormally', label: LString('Not acting normally per parent (< 2y)', 'Not acting normally per parent (< 2y)'), type: CalculatorFieldType.checkbox),
      const CalculatorField(id: 'severeHeadache', label: LString('Severe headache (≥ 2y)', 'Severe headache (≥ 2y)'), type: CalculatorFieldType.checkbox),
      const CalculatorField(id: 'vomiting', label: LString('Vomiting (≥ 2y)', 'Vomiting (≥ 2y)'), type: CalculatorFieldType.checkbox),
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
      const ScoreInterpretation(min: 0, max: 0, label: LString('Very Low Risk', 'Very Low Risk'), description: LString('Risk of ciTBI < 0.02%. CT NOT indicated.', 'Risk of ciTBI < 0.02%. CT NOT indicated.'), color: Colors.green),
      const ScoreInterpretation(min: 1, max: 1, label: LString('Intermediate Risk', 'Intermediate Risk'), description: LString('Risk of ciTBI 0.9%. Observation 4-6h OR CT based on clinical judgment.', 'Risk of ciTBI 0.9%. Observation 4-6h OR CT based on clinical judgment.'), color: Colors.yellow),
      const ScoreInterpretation(min: 2, max: 2, label: LString('High Risk', 'High Risk'), description: LString('Risk of ciTBI 4.4%. Head CT RECOMMENDED.', 'Risk of ciTBI 4.4%. Head CT RECOMMENDED.'), color: Colors.red),
    ],
    source: 'Kuppermann N et al. Lancet 2009',
    sourceUrl: 'https://pubmed.ncbi.nlm.nih.gov/19758692/',
  ),
  Calculator(
    id: 'westley-croup',
    name: LString('Westley Croup Score', 'Westley Croup Score'),
    shortName: 'Westley',
    category: CalculatorCategory.pediatric,
    description: LString('Severity of croup (laryngotracheobronchitis)', 'Severity of croup (laryngotracheobronchitis)'),
    fields: [
      const CalculatorField(
        id: 'stridor',
        label: LString('Stridor', 'Stridor'),
        type: CalculatorFieldType.select,
        options: [
          CalculatorOption(value: 0, label: LString('None', 'None')),
          CalculatorOption(value: 1, label: LString('With agitation', 'With agitation')),
          CalculatorOption(value: 2, label: LString('At rest', 'At rest')),
        ],
      ),
      const CalculatorField(
        id: 'retraction',
        label: LString('Retractions', 'Retractions'),
        type: CalculatorFieldType.select,
        options: [
          CalculatorOption(value: 0, label: LString('None', 'None')),
          CalculatorOption(value: 1, label: LString('Mild', 'Mild')),
          CalculatorOption(value: 2, label: LString('Moderate', 'Moderate')),
          CalculatorOption(value: 3, label: LString('Severe', 'Severe')),
        ],
      ),
      const CalculatorField(
        id: 'airEntry',
        label: LString('Air Entry', 'Air Entry'),
        type: CalculatorFieldType.select,
        options: [
          CalculatorOption(value: 0, label: LString('Normal', 'Normal')),
          CalculatorOption(value: 1, label: LString('Decreased', 'Decreased')),
          CalculatorOption(value: 2, label: LString('Markedly decreased', 'Markedly decreased')),
        ],
      ),
      const CalculatorField(
        id: 'cyanosis',
        label: LString('Cyanosis', 'Cyanosis'),
        type: CalculatorFieldType.select,
        options: [
          CalculatorOption(value: 0, label: LString('None', 'None')),
          CalculatorOption(value: 4, label: LString('With agitation', 'With agitation')),
          CalculatorOption(value: 5, label: LString('At rest', 'At rest')),
        ],
      ),
      const CalculatorField(
        id: 'consciousness',
        label: LString('Level of Consciousness', 'Level of Consciousness'),
        type: CalculatorFieldType.select,
        options: [
          CalculatorOption(value: 0, label: LString('Normal', 'Normal')),
          CalculatorOption(value: 5, label: LString('Disoriented', 'Disoriented')),
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
      const ScoreInterpretation(min: 0, max: 2, label: LString('Mild', 'Mild'), description: LString('Mild croup. Outpatient management, oral steroids.', 'Mild croup. Outpatient management, oral steroids.'), color: Colors.green),
      const ScoreInterpretation(min: 3, max: 5, label: LString('Moderate', 'Moderate'), description: LString('Moderate croup. Dexamethasone + observation.', 'Moderate croup. Dexamethasone + observation.'), color: Colors.yellow),
      const ScoreInterpretation(min: 6, max: 11, label: LString('Severe', 'Severe'), description: LString('Severe croup. Nebulized epinephrine + admission.', 'Severe croup. Nebulized epinephrine + admission.'), color: Colors.orange),
      const ScoreInterpretation(min: 12, max: 17, label: LString('Respiratory Failure', 'Respiratory Failure'), description: LString('Impending respiratory failure. Resuscitation.', 'Impending respiratory failure. Resuscitation.'), color: Colors.red),
    ],
    source: 'Westley CR et al. Am J Dis Child 1978',
    sourceUrl: 'https://pubmed.ncbi.nlm.nih.gov/308551/',
  ),
  Calculator(
    id: 'pas',
    name: LString('Pediatric Appendicitis Score (PAS)', 'Pediatric Appendicitis Score (PAS)'),
    shortName: 'PAS',
    category: CalculatorCategory.pediatric,
    description: LString('Probability of appendicitis in children', 'Probability of appendicitis in children'),
    fields: [
      const CalculatorField(id: 'migration', label: LString('Migration of pain to RLQ', 'Migration of pain to RLQ'), type: CalculatorFieldType.checkbox),
      const CalculatorField(id: 'anorexia', label: LString('Anorexia', 'Anorexia'), type: CalculatorFieldType.checkbox),
      const CalculatorField(id: 'nausea', label: LString('Nausea/Vomiting', 'Nausea/Vomiting'), type: CalculatorFieldType.checkbox),
      const CalculatorField(id: 'rlfTenderness', label: LString('Tenderness in RLQ', 'Tenderness in RLQ'), type: CalculatorFieldType.checkbox),
      const CalculatorField(id: 'coughPain', label: LString('Cough/Percussion/Hop tenderness', 'Cough/Percussion/Hop tenderness'), type: CalculatorFieldType.checkbox),
      const CalculatorField(id: 'fever', label: LString('Fever (T ≥ 38°C)', 'Fever (T ≥ 38°C)'), type: CalculatorFieldType.checkbox),
      const CalculatorField(id: 'leukocytosis', label: LString('Leukocytosis > 10,000/mm³', 'Leukocytosis > 10,000/mm³'), type: CalculatorFieldType.checkbox),
      const CalculatorField(id: 'neutrophilia', label: LString('Neutrophilia (PMN > 75%)', 'Neutrophilia (PMN > 75%)'), type: CalculatorFieldType.checkbox),
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
      const ScoreInterpretation(min: 0, max: 3, label: LString('Low Probability', 'Low Probability'), description: LString('Appendicitis unlikely. Observation or re-evaluation.', 'Appendicitis unlikely. Observation or re-evaluation.'), color: Colors.green),
      const ScoreInterpretation(min: 4, max: 6, label: LString('Intermediate', 'Intermediate'), description: LString('Appendicitis possible. Imaging recommended (US).', 'Appendicitis possible. Imaging recommended (US).'), color: Colors.yellow),
      const ScoreInterpretation(min: 7, max: 10, label: LString('High Probability', 'High Probability'), description: LString('Appendicitis probable. Surgical consultation.', 'Appendicitis probable. Surgical consultation.'), color: Colors.red),
    ],
    source: 'Samuel M. J Pediatr Surg 2002',
    sourceUrl: 'https://pubmed.ncbi.nlm.nih.gov/12149680/',
  ),
  Calculator(
    id: 'clinical-dehydration-scale',
    name: LString('Clinical Dehydration Scale (CDS)', 'Clinical Dehydration Scale (CDS)'),
    shortName: 'CDS',
    category: CalculatorCategory.pediatric,
    description: LString('Assessment of dehydration in children 1mo - 5y', 'Assessment of dehydration in children 1mo - 5y'),
    fields: [
      const CalculatorField(
        id: 'appearance',
        label: LString('General Appearance', 'General Appearance'),
        type: CalculatorFieldType.select,
        options: [
          CalculatorOption(value: 0, label: LString('Normal', 'Normal')),
          CalculatorOption(value: 1, label: LString('Thirsty, restless or lethargic but irritable when touched', 'Thirsty, restless or lethargic but irritable when touched')),
          CalculatorOption(value: 2, label: LString('Drowsy, limp, cold, sweaty; ± comatose', 'Drowsy, limp, cold, sweaty; ± comatose')),
        ],
      ),
      const CalculatorField(
        id: 'eyes',
        label: LString('Eyes', 'Eyes'),
        type: CalculatorFieldType.select,
        options: [
          CalculatorOption(value: 0, label: LString('Normal', 'Normal')),
          CalculatorOption(value: 1, label: LString('Slightly sunken', 'Slightly sunken')),
          CalculatorOption(value: 2, label: LString('Very sunken', 'Very sunken')),
        ],
      ),
      const CalculatorField(
        id: 'mucous',
        label: LString('Mucous Membranes (tongue)', 'Mucous Membranes (tongue)'),
        type: CalculatorFieldType.select,
        options: [
          CalculatorOption(value: 0, label: LString('Moist', 'Moist')),
          CalculatorOption(value: 1, label: LString('Sticky', 'Sticky')),
          CalculatorOption(value: 2, label: LString('Dry', 'Dry')),
        ],
      ),
      const CalculatorField(
        id: 'tears',
        label: LString('Tears', 'Tears'),
        type: CalculatorFieldType.select,
        options: [
          CalculatorOption(value: 0, label: LString('Present', 'Present')),
          CalculatorOption(value: 1, label: LString('Decreased', 'Decreased')),
          CalculatorOption(value: 2, label: LString('Absent', 'Absent')),
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
      const ScoreInterpretation(min: 0, max: 0, label: LString('No Dehydration', 'No Dehydration'), description: LString('Normal hydration. Home oral rehydration.', 'Normal hydration. Home oral rehydration.'), color: Colors.green),
      const ScoreInterpretation(min: 1, max: 4, label: LString('Mild to Moderate', 'Mild to Moderate'), description: LString('Dehydration 3-6%. Supervised oral rehydration.', 'Dehydration 3-6%. Supervised oral rehydration.'), color: Colors.yellow),
      const ScoreInterpretation(min: 5, max: 8, label: LString('Moderate to Severe', 'Moderate to Severe'), description: LString('Dehydration > 6%. IV rehydration probable.', 'Dehydration > 6%. IV rehydration probable.'), color: Colors.red),
    ],
    source: 'Friedman JN et al. Pediatrics 2004',
    sourceUrl: 'https://pubmed.ncbi.nlm.nih.gov/15520095/',
  ),
  Calculator(
    id: 'qtc',
    name: LString('QTc Calculator (Bazett & Fridericia)', 'QTc Calculator (Bazett & Fridericia)'),
    shortName: 'QTc',
    category: CalculatorCategory.cardiovascular,
    description: LString('Corrected QT interval calculation. Alert for QT-prolonging drugs.', 'Corrected QT interval calculation. Alert for QT-prolonging drugs.'),
    fields: [
      const CalculatorField(id: 'qt', label: LString('QT Interval (ms)', 'QT Interval (ms)'), type: CalculatorFieldType.number, min: 200, max: 700, unit: 'ms'),
      const CalculatorField(id: 'rr', label: LString('RR Interval (ms) or HR', 'RR Interval (ms) or HR'), type: CalculatorFieldType.number, min: 300, max: 2000, unit: 'ms'),
      const CalculatorField(id: 'useHr', label: LString('Use Heart Rate instead of RR', 'Use Heart Rate instead of RR'), type: CalculatorFieldType.checkbox),
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
      const ScoreInterpretation(min: 0, max: 440, label: LString('Normal QTc', 'Normal QTc'), description: LString('QTc < 440 ms. Normal for both sexes.', 'QTc < 440 ms. Normal for both sexes.'), color: Colors.green),
      const ScoreInterpretation(min: 441, max: 460, label: LString('Borderline (Men)', 'Borderline (Men)'), description: LString('QTc 440-460 ms. Borderline for men, normal for women.', 'QTc 440-460 ms. Borderline for men, normal for women.'), color: Colors.yellow),
      const ScoreInterpretation(min: 461, max: 480, label: LString('Prolonged Moderate', 'Prolonged Moderate'), description: LString('QTc 460-480 ms. Prolonged, monitor medications.', 'QTc 460-480 ms. Prolonged, monitor medications.'), color: Colors.orange),
      const ScoreInterpretation(min: 481, max: 1000, label: LString('Prolonged Severe', 'Prolonged Severe'), description: LString('QTc > 480 ms. Risk of Torsades de Pointes. Review meds/electrolytes.', 'QTc > 480 ms. Risk of Torsades de Pointes. Review meds/electrolytes.'), color: Colors.red),
    ],
    source: 'Bazett HC (1920), Fridericia LS (1920)',
    sourceUrl: 'https://www.ncbi.nlm.nih.gov/pmc/articles/PMC5390937/',
  ),
  Calculator(
    id: 'creatinine-clearance',
    name: LString('Creatinine Clearance (Cockcroft-Gault)', 'Creatinine Clearance (Cockcroft-Gault)'),
    shortName: 'CrCl',
    category: CalculatorCategory.cardiovascular,
    description: LString('Estimation of GFR for drug dosing adjustment', 'Estimation of GFR for drug dosing adjustment'),
    fields: [
      const CalculatorField(id: 'age', label: LString('Age', 'Age'), type: CalculatorFieldType.number, min: 18, max: 120, unit: 'years'),
      const CalculatorField(id: 'weight', label: LString('Weight', 'Weight'), type: CalculatorFieldType.number, min: 30, max: 300, unit: 'kg'),
      const CalculatorField(id: 'creatinine', label: LString('Serum Creatinine', 'Serum Creatinine'), type: CalculatorFieldType.number, min: 20, max: 2000, unit: 'µmol/L'),
      const CalculatorField(id: 'female', label: LString('Female Sex', 'Female Sex'), type: CalculatorFieldType.checkbox),
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
      const ScoreInterpretation(min: 90, max: 200, label: LString('Normal Renal Function', 'Normal Renal Function'), description: LString('GFR ≥ 90 mL/min. Stage 1 CKD or normal.', 'GFR ≥ 90 mL/min. Stage 1 CKD or normal.'), color: Colors.green),
      const ScoreInterpretation(min: 60, max: 89, label: LString('Mild CKD (Stage 2)', 'Mild CKD (Stage 2)'), description: LString('GFR 60-89 mL/min. Monitor, no major adjustment.', 'GFR 60-89 mL/min. Monitor, no major adjustment.'), color: Colors.yellow),
      const ScoreInterpretation(min: 30, max: 59, label: LString('Moderate CKD (Stage 3)', 'Moderate CKD (Stage 3)'), description: LString('GFR 30-59 mL/min. Dose adjustment needed.', 'GFR 30-59 mL/min. Dose adjustment needed.'), color: Colors.orange),
      const ScoreInterpretation(min: 15, max: 29, label: LString('Severe CKD (Stage 4)', 'Severe CKD (Stage 4)'), description: LString('GFR 15-29 mL/min. Major adjustment, prep for dialysis.', 'GFR 15-29 mL/min. Major adjustment, prep for dialysis.'), color: Colors.red),
      const ScoreInterpretation(min: 0, max: 14, label: LString('ESRD (Stage 5)', 'ESRD (Stage 5)'), description: LString('GFR < 15 mL/min. Dialysis/Transplantation.', 'GFR < 15 mL/min. Dialysis/Transplantation.'), color: Colors.red),
    ],
    source: 'Cockcroft DW, Gault MH (1976)',
    sourceUrl: 'https://pubmed.ncbi.nlm.nih.gov/1244564/',
  ),
  Calculator(
    id: 'corrected-calcium',
    name: LString('Corrected Calcium (for Albumin)', 'Corrected Calcium (for Albumin)'),
    shortName: 'Ca Corr',
    category: CalculatorCategory.cardiovascular,
    description: LString('Correction of total calcium for hypoalbuminemia', 'Correction of total calcium for hypoalbuminemia'),
    fields: [
      const CalculatorField(id: 'calcium', label: LString('Total Calcium', 'Total Calcium'), type: CalculatorFieldType.number, min: 1, max: 5, unit: 'mmol/L'),
      const CalculatorField(id: 'albumin', label: LString('Albumin', 'Albumin'), type: CalculatorFieldType.number, min: 10, max: 60, unit: 'g/L'),
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
      const ScoreInterpretation(min: 0, max: 209, label: LString('Hypocalcemia', 'Hypocalcemia'), description: LString('Corr Ca < 2.10 mmol/L. Investigate and treat.', 'Corr Ca < 2.10 mmol/L. Investigate and treat.'), color: Colors.orange),
      const ScoreInterpretation(min: 210, max: 260, label: LString('Normal Calcium', 'Normal Calcium'), description: LString('Corr Ca 2.10-2.60 mmol/L. Normal.', 'Corr Ca 2.10-2.60 mmol/L. Normal.'), color: Colors.green),
      const ScoreInterpretation(min: 261, max: 300, label: LString('Mild Hypercalcemia', 'Mild Hypercalcemia'), description: LString('Corr Ca 2.60-3.00 mmol/L. Investigate cause.', 'Corr Ca 2.60-3.00 mmol/L. Investigate cause.'), color: Colors.yellow),
      const ScoreInterpretation(min: 301, max: 500, label: LString('Severe Hypercalcemia', 'Severe Hypercalcemia'), description: LString('Corr Ca > 3.00 mmol/L. Emergency, hydration + bisphosphonates.', 'Corr Ca > 3.00 mmol/L. Emergency, hydration + bisphosphonates.'), color: Colors.red),
    ],
    source: 'Payne RB et al. BMJ 1973',
    sourceUrl: 'https://pubmed.ncbi.nlm.nih.gov/4723462/',
  ),
  Calculator(
    id: 'aa-gradient',
    name: LString('Alveolar-arterial Gradient (A-a)', 'Alveolar-arterial Gradient (A-a)'),
    shortName: 'A-a Gradient',
    category: CalculatorCategory.cardiovascular,
    description: LString('Calculation of A-a gradient and comparison with expected value for age', 'Calculation of A-a gradient and comparison with expected value for age'),
    fields: [
      const CalculatorField(id: 'age', label: LString('Age', 'Age'), type: CalculatorFieldType.number, min: 1, max: 120, unit: 'years'),
      const CalculatorField(id: 'fio2', label: LString('FiO2', 'FiO2'), type: CalculatorFieldType.number, min: 21, max: 100, unit: '%'),
      const CalculatorField(id: 'pao2', label: LString('PaO2 (ABG)', 'PaO2 (ABG)'), type: CalculatorFieldType.number, min: 20, max: 600, unit: 'mmHg'),
      const CalculatorField(id: 'paco2', label: LString('PaCO2 (ABG)', 'PaCO2 (ABG)'), type: CalculatorFieldType.number, min: 10, max: 120, unit: 'mmHg'),
      const CalculatorField(id: 'patm', label: LString('Atmospheric Pressure', 'Atmospheric Pressure'), type: CalculatorFieldType.number, min: 600, max: 800, unit: 'mmHg'),
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
      const ScoreInterpretation(min: -50, max: 15, label: LString('Normal A-a Gradient', 'Normal A-a Gradient'), description: LString('Normal gradient (expected = age/4 + 4). No gas exchange issue.', 'Normal gradient (expected = age/4 + 4). No gas exchange issue.'), color: Colors.green),
      const ScoreInterpretation(min: 16, max: 30, label: LString('Mildly Elevated', 'Mildly Elevated'), description: LString('Mild gas exchange issue. May be normal in elderly.', 'Mild gas exchange issue. May be normal in elderly.'), color: Colors.yellow),
      const ScoreInterpretation(min: 31, max: 50, label: LString('Moderately Elevated', 'Moderately Elevated'), description: LString('Moderate issue: shunt, V/Q mismatch, parenchymal disease.', 'Moderate issue: shunt, V/Q mismatch, parenchymal disease.'), color: Colors.orange),
      const ScoreInterpretation(min: 51, max: 700, label: LString('Severely Elevated', 'Severely Elevated'), description: LString('Severe gas exchange issue. Significant shunt or severe disease.', 'Severe gas exchange issue. Significant shunt or severe disease.'), color: Colors.red),
    ],
    source: 'Mellemgaard K. Acta Physiol Scand 1966',
    sourceUrl: 'https://pubmed.ncbi.nlm.nih.gov/5963795/',
  ),
  Calculator(
    id: 'meld',
    name: LString('MELD Score (Model for End-Stage Liver Disease)', 'MELD Score (Model for End-Stage Liver Disease)'),
    shortName: 'MELD',
    category: CalculatorCategory.gi,
    description: LString('Severity of end-stage liver disease. Transplant priority.', 'Severity of end-stage liver disease. Transplant priority.'),
    fields: [
      const CalculatorField(id: 'creatinine', label: LString('Serum Creatinine', 'Serum Creatinine'), type: CalculatorFieldType.number, min: 10, max: 1500, unit: 'µmol/L'),
      const CalculatorField(id: 'bilirubin', label: LString('Total Bilirubin', 'Total Bilirubin'), type: CalculatorFieldType.number, min: 1, max: 1000, unit: 'µmol/L'),
      const CalculatorField(id: 'inr', label: LString('INR', 'INR'), type: CalculatorFieldType.number, min: 0.5, max: 15),
      const CalculatorField(id: 'dialysis', label: LString('Dialysis (≥2x/week) or CVVHD in past 7 days', 'Dialysis (≥2x/week) or CVVHD in past 7 days'), type: CalculatorFieldType.checkbox),
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
      const ScoreInterpretation(min: 6, max: 9, label: LString('MELD 6-9', 'MELD 6-9'), description: LString('3-month mortality: 1.9%. Low transplant priority.', '3-month mortality: 1.9%. Low transplant priority.'), color: Colors.green),
      const ScoreInterpretation(min: 10, max: 19, label: LString('MELD 10-19', 'MELD 10-19'), description: LString('3-month mortality: 6%. Close monitoring.', '3-month mortality: 6%. Close monitoring.'), color: Colors.yellow),
      const ScoreInterpretation(min: 20, max: 29, label: LString('MELD 20-29', 'MELD 20-29'), description: LString('3-month mortality: 19.6%. Moderate transplant priority.', '3-month mortality: 19.6%. Moderate transplant priority.'), color: Colors.orange),
      const ScoreInterpretation(min: 30, max: 39, label: LString('MELD 30-39', 'MELD 30-39'), description: LString('3-month mortality: 52.6%. High transplant priority.', '3-month mortality: 52.6%. High transplant priority.'), color: Colors.red),
      const ScoreInterpretation(min: 40, max: 50, label: LString('MELD ≥ 40', 'MELD ≥ 40'), description: LString('3-month mortality: 71.3%. Emergency transplantation.', '3-month mortality: 71.3%. Emergency transplantation.'), color: Colors.red),
    ],
    source: 'Kamath PS et al. Hepatology 2001; UNOS',
    sourceUrl: 'https://pubmed.ncbi.nlm.nih.gov/11172350/',
  ),
  // LRINEC Score - Necrotizing Fasciitis
  Calculator(
    id: 'lrinec',
    name: LString('LRINEC Score', 'LRINEC Score'),
    shortName: 'LRINEC',
    category: CalculatorCategory.sepsis,
    description: LString('Laboratory Risk Indicator for Necrotizing Fasciitis', 'Laboratory Risk Indicator for Necrotizing Fasciitis'),
    fields: [
      const CalculatorField(
        id: 'crp',
        label: LString('CRP (mg/L)', 'CRP (mg/L)'),
        type: CalculatorFieldType.select,
        options: [
          CalculatorOption(value: 0, label: LString('< 150', '< 150')),
          CalculatorOption(value: 4, label: LString('≥ 150', '≥ 150')),
        ],
      ),
      const CalculatorField(
        id: 'wbc',
        label: LString('White Blood Cell Count (×10⁹/L)', 'White Blood Cell Count (×10⁹/L)'),
        type: CalculatorFieldType.select,
        options: [
          CalculatorOption(value: 0, label: LString('< 15', '< 15')),
          CalculatorOption(value: 1, label: LString('15-25', '15-25')),
          CalculatorOption(value: 2, label: LString('> 25', '> 25')),
        ],
      ),
      const CalculatorField(
        id: 'hb',
        label: LString('Hemoglobin (g/dL)', 'Hemoglobin (g/dL)'),
        type: CalculatorFieldType.select,
        options: [
          CalculatorOption(value: 0, label: LString('> 13.5', '> 13.5')),
          CalculatorOption(value: 1, label: LString('11-13.5', '11-13.5')),
          CalculatorOption(value: 2, label: LString('< 11', '< 11')),
        ],
      ),
      const CalculatorField(
        id: 'sodium',
        label: LString('Sodium (mmol/L)', 'Sodium (mmol/L)'),
        type: CalculatorFieldType.select,
        options: [
          CalculatorOption(value: 0, label: LString('≥ 135', '≥ 135')),
          CalculatorOption(value: 2, label: LString('< 135', '< 135')),
        ],
      ),
      const CalculatorField(
        id: 'creatinine',
        label: LString('Creatinine (µmol/L)', 'Creatinine (µmol/L)'),
        type: CalculatorFieldType.select,
        options: [
          CalculatorOption(value: 0, label: LString('≤ 141', '≤ 141')),
          CalculatorOption(value: 2, label: LString('> 141', '> 141')),
        ],
      ),
      const CalculatorField(
        id: 'glucose',
        label: LString('Glucose (mmol/L)', 'Glucose (mmol/L)'),
        type: CalculatorFieldType.select,
        options: [
          CalculatorOption(value: 0, label: LString('≤ 10', '≤ 10')),
          CalculatorOption(value: 1, label: LString('> 10', '> 10')),
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
      const ScoreInterpretation(min: 0, max: 5, label: LString('Low Risk', 'Low Risk'), description: LString('Necrotizing fasciitis probability < 50%.', 'Necrotizing fasciitis probability < 50%.'), color: Colors.green),
      const ScoreInterpretation(min: 6, max: 7, label: LString('Intermediate Risk', 'Intermediate Risk'), description: LString('Necrotizing fasciitis probability 50-75%. Urgent imaging.', 'Necrotizing fasciitis probability 50-75%. Urgent imaging.'), color: Colors.yellow),
      const ScoreInterpretation(min: 8, max: 13, label: LString('High Risk', 'High Risk'), description: LString('Necrotizing fasciitis probability > 75%. Urgent surgical exploration.', 'Necrotizing fasciitis probability > 75%. Urgent surgical exploration.'), color: Colors.red),
    ],
    source: 'Wong CH et al. Crit Care Med 2004',
    sourceUrl: 'https://pubmed.ncbi.nlm.nih.gov/15241098/',
  ),
  // Centor Criteria - Strep Throat
  Calculator(
    id: 'centor',
    name: LString('Centor Criteria (Modified/McIsaac)', 'Centor Criteria (Modified/McIsaac)'),
    shortName: 'Centor',
    category: CalculatorCategory.sepsis,
    description: LString('Probability of Group A Streptococcal pharyngitis', 'Probability of Group A Streptococcal pharyngitis'),
    fields: [
      const CalculatorField(id: 'exudate', label: LString('Tonsillar exudate or swelling', 'Tonsillar exudate or swelling'), type: CalculatorFieldType.checkbox),
      const CalculatorField(id: 'adenopathy', label: LString('Tender anterior cervical lymphadenopathy', 'Tender anterior cervical lymphadenopathy'), type: CalculatorFieldType.checkbox),
      const CalculatorField(id: 'fever', label: LString('Fever (> 38°C) or history of fever', 'Fever (> 38°C) or history of fever'), type: CalculatorFieldType.checkbox),
      const CalculatorField(id: 'noCough', label: LString('Absence of cough', 'Absence of cough'), type: CalculatorFieldType.checkbox),
      const CalculatorField(
        id: 'age',
        label: LString('Age', 'Age'),
        type: CalculatorFieldType.select,
        options: [
          CalculatorOption(value: 1, label: LString('3-14 years', '3-14 years')),
          CalculatorOption(value: 0, label: LString('15-44 years', '15-44 years')),
          CalculatorOption(value: -1, label: LString('≥ 45 years', '≥ 45 years')),
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
      const ScoreInterpretation(min: -1, max: 0, label: LString('Très bas', 'Très bas'), description: LString('Probabilité SGA 1-2,5%. Pas d\'antibiotiques ni test rapide.', 'Probabilité SGA 1-2,5%. Pas d\'antibiotiques ni test rapide.'), color: Colors.green),
      const ScoreInterpretation(min: 1, max: 1, label: LString('Bas', 'Bas'), description: LString('Probabilité SGA 5-10%. Test rapide optionnel.', 'Probabilité SGA 5-10%. Test rapide optionnel.'), color: Colors.green),
      const ScoreInterpretation(min: 2, max: 3, label: LString('Modéré', 'Modéré'), description: LString('Probabilité SGA 11-35%. Test rapide recommandé.', 'Probabilité SGA 11-35%. Test rapide recommandé.'), color: Colors.yellow),
      const ScoreInterpretation(min: 4, max: 5, label: LString('Élevé', 'Élevé'), description: LString('Probabilité SGA 51-53%. Test rapide ou antibiotiques empiriques.', 'Probabilité SGA 51-53%. Test rapide ou antibiotiques empiriques.'), color: Colors.red),
    ],
    source: 'McIsaac WJ et al. CMAJ 2000',
    sourceUrl: 'https://pubmed.ncbi.nlm.nih.gov/10680463/',
  ),
];
