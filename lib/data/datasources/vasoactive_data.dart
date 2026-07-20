import '../../domain/entities/vasoactive.dart';
import '../../core/l10n/localized.dart';

/// Vasoactive Drug Data Source
/// Updated: 2025 (SSC 2021, ESICM, AHA/ACC)
/// All clinician-facing free-text is bilingual (French / English) via [LString].
class VasoactiveData {
  static final List<VasoactiveDrug> allDrugs = [
    // =====================
    // VASOPRESSORS
    // =====================
    VasoactiveDrug(
      id: 'noradrenaline',
      name: 'Noradrénaline',
      genericName: 'Norepinephrine',
      category: VasoactiveCategory.vasopressor,
      description: LString(
        'Vasopresseur de première ligne pour le choc septique et distributif (SSC 2021)',
        'First-line vasopressor for septic and distributive shock (SSC 2021)',
      ),
      concentrations: [
        DrugConcentration(label: '0.5 mg/mL (8mg/16mL)', mgPerMl: 0.5, commonPrep: LString('8 mg dans 16 mL (seringue 20 mL)', '8 mg in 16 mL (20 mL syringe)')),
        DrugConcentration(label: '1 mg/mL (8mg/8mL)', mgPerMl: 1.0, commonPrep: LString('8 mg dans 8 mL NaCl (seringue 10 mL)', '8 mg in 8 mL NaCl (10 mL syringe)')),
        DrugConcentration(label: '0.25 mg/mL (8mg/32mL)', mgPerMl: 0.25, commonPrep: LString('8 mg dans 32 mL (seringue 50 mL)', '8 mg in 32 mL (50 mL syringe)')),
        DrugConcentration(label: '0.16 mg/mL (8mg/50mL)', mgPerMl: 0.16, commonPrep: LString('8 mg dans 50 mL (seringue 50 mL)', '8 mg in 50 mL (50 mL syringe)')),
      ],
      defaultConcentrationIndex: 0,
      doseUnit: 'mcg/kg/min',
      doseRange: DrugDoseRange(min: 0.05, max: 3.0, typical: 0.2, step: 0.05),
      indications: [
        LString('Choc septique (1ère ligne - SSC 2021)', 'Septic shock (1st line - SSC 2021)'),
        LString('Choc distributif', 'Distributive shock'),
        LString('Hypotension réfractaire au remplissage', 'Fluid-refractory hypotension'),
        LString('Choc cardiogénique (en association)', 'Cardiogenic shock (in combination)'),
      ],
      effects: DrugEffects(alpha: 'high', beta1: 'moderate'),
      sideEffects: [
        LString('Vasoconstriction périphérique (ischémie digitale)', 'Peripheral vasoconstriction (digital ischemia)'),
        LString('Arythmies', 'Arrhythmias'),
        LString('Hypertension', 'Hypertension'),
        LString('Nécrose tissulaire si extravasation', 'Tissue necrosis if extravasation'),
        LString('Bradycardie réflexe', 'Reflex bradycardia'),
      ],
      contraindications: [
        LString('Hypovolémie non corrigée (relative)', 'Uncorrected hypovolemia (relative)'),
        LString('Thrombose vasculaire périphérique', 'Peripheral vascular thrombosis'),
      ],
      notes: [
        LString('Voie veineuse centrale préférée', 'Central venous access preferred'),
        LString('Titrer pour PAM ≥ 65 mmHg (SSC 2021)', 'Titrate to MAP ≥ 65 mmHg (SSC 2021)'),
        LString('Si dose ≥ 0.25-0.5 mcg/kg/min: ajouter vasopressine (SSC 2021)', 'If dose ≥ 0.25-0.5 mcg/kg/min: add vasopressin (SSC 2021)'),
        LString('Associer à la dobutamine si dysfonction cardiaque', 'Combine with dobutamine if cardiac dysfunction'),
      ],
    ),

    VasoactiveDrug(
      id: 'vasopressine',
      name: 'Vasopressine',
      genericName: 'Arginine Vasopressin',
      category: VasoactiveCategory.vasopressor,
      description: LString(
        'Vasopresseur non-catécholaminergique - ajout à la noradrénaline (SSC 2021)',
        'Non-catecholamine vasopressor - add-on to norepinephrine (SSC 2021)',
      ),
      concentrations: [
        DrugConcentration(label: '0.4 UI/mL (20UI/50mL)', mgPerMl: 0.4, commonPrep: LString('20 UI dans 50 mL NaCl', '20 IU in 50 mL NaCl')),
        DrugConcentration(label: '1 UI/mL (20UI/20mL)', mgPerMl: 1.0, commonPrep: LString('20 UI dans 20 mL NaCl', '20 IU in 20 mL NaCl')),
      ],
      defaultConcentrationIndex: 0,
      doseUnit: 'UI/min',
      doseRange: DrugDoseRange(min: 0.01, max: 0.04, typical: 0.03, step: 0.005),
      indications: [
        LString('Choc septique réfractaire aux catécholamines (ajout SSC 2021)', 'Catecholamine-refractory septic shock (add-on, SSC 2021)'),
        LString('Choc vasoplégique', 'Vasoplegic shock'),
        LString('Diabète insipide central', 'Central diabetes insipidus'),
        LString('Hémorragie digestive (varices)', 'GI bleeding (varices)'),
      ],
      effects: DrugEffects(vasopressin: 'high'),
      sideEffects: [
        LString('Ischémie digitale', 'Digital ischemia'),
        LString('Ischémie mésentérique', 'Mesenteric ischemia'),
        LString('Hyponatrémie', 'Hyponatremia'),
        LString('Bradycardie', 'Bradycardia'),
        LString('Vasoconstriction coronaire', 'Coronary vasoconstriction'),
      ],
      contraindications: [
        LString('Insuffisance coronaire sévère', 'Severe coronary insufficiency'),
        LString('Artériopathie périphérique sévère', 'Severe peripheral arteriopathy'),
      ],
      notes: [
        LString('Dose fixe: 0.03 UI/min, ajoutée à la noradrénaline ≥0.25-0.5 mcg/kg/min (SSC 2021)', 'Fixed dose: 0.03 IU/min, added to norepinephrine ≥0.25-0.5 mcg/kg/min (SSC 2021)'),
        LString('Ne pas titrer comme les catécholamines', 'Do not titrate like catecholamines'),
        LString('Épargne catécholaminergique', 'Catecholamine-sparing effect'),
        LString('Utile si tachyarythmie sous catécholamines', 'Useful if tachyarrhythmia on catecholamines'),
      ],
    ),

    VasoactiveDrug(
      id: 'phenylephrine',
      name: 'Phényléphrine',
      genericName: 'Phenylephrine',
      category: VasoactiveCategory.vasopressor,
      description: LString(
        'Vasopresseur α pur - utile en tachycardie ou tachyarythmie',
        'Pure α-agonist vasopressor - useful in tachycardia or tachyarrhythmia',
      ),
      concentrations: [
        DrugConcentration(label: '0.1 mg/mL (5mg/50mL)', mgPerMl: 0.1, commonPrep: LString('5 mg dans 50 mL NaCl', '5 mg in 50 mL NaCl')),
        DrugConcentration(label: '0.2 mg/mL (10mg/50mL)', mgPerMl: 0.2, commonPrep: LString('10 mg dans 50 mL NaCl', '10 mg in 50 mL NaCl')),
      ],
      defaultConcentrationIndex: 0,
      doseUnit: 'mcg/kg/min',
      doseRange: DrugDoseRange(min: 0.1, max: 5.0, typical: 0.5, step: 0.1),
      indications: [
        LString('Hypotension avec tachycardie (pas d\'effet β)', 'Hypotension with tachycardia (no β effect)'),
        LString('Choc distributif (alternative si tachyarythmie)', 'Distributive shock (alternative if tachyarrhythmia)'),
        LString('Hypotension anesthésique', 'Anesthetic hypotension'),
        LString('Sténose aortique avec hypotension', 'Aortic stenosis with hypotension'),
      ],
      effects: DrugEffects(alpha: 'high'),
      sideEffects: [
        LString('Bradycardie réflexe', 'Reflex bradycardia'),
        LString('Hypertension', 'Hypertension'),
        LString('Ischémie périphérique', 'Peripheral ischemia'),
      ],
      contraindications: [
        LString('Bradycardie sévère', 'Severe bradycardia'),
        LString('Insuffisance cardiaque avec bas débit (↓ DC via ↑ postcharge)', 'Low-output heart failure (↓ CO via ↑ afterload)'),
      ],
      notes: [
        LString('Pas d\'effet β: utile si tachycardie ou fibrillation auriculaire rapide', 'No β effect: useful in tachycardia or rapid atrial fibrillation'),
        LString('Pur alpha: pas d\'augmentation du débit cardiaque', 'Pure alpha: no increase in cardiac output'),
        LString('Alternative temporaire si tachyarythmie sous noradrénaline', 'Temporary alternative if tachyarrhythmia on norepinephrine'),
      ],
    ),

    VasoactiveDrug(
      id: 'angiotensin_ii',
      name: 'Angiotensine II',
      genericName: 'Angiotensin II (Giapreza)',
      category: VasoactiveCategory.vasopressor,
      description: LString(
        'Analogue synthétique de l\'angiotensine II - vasopresseur non catécholaminergique (ATRACT-2 2025)',
        'Synthetic angiotensin II analogue - non-catecholamine vasopressor (ATRACT-2 2025)',
      ),
      concentrations: [
        DrugConcentration(label: '0.01 mg/mL (2.5mg/250mL)', mgPerMl: 0.01, commonPrep: LString('2.5 mg dans 250 mL NaCl (flacon prêt)', '2.5 mg in 250 mL NaCl (premixed bag)')),
      ],
      defaultConcentrationIndex: 0,
      doseUnit: 'mcg/kg/min',
      doseRange: DrugDoseRange(min: 0.01, max: 0.08, typical: 0.02, step: 0.005),
      indications: [
        LString('Choc distributif réfractaire aux catécholamines et vasopressine', 'Distributive shock refractory to catecholamines and vasopressin'),
        LString('Choc septique sévère (ATRACT-2, Angiotensin II for the Treatment of High-Output Shock 3)', 'Severe septic shock (ATHOS-3 trial)'),
        LString('Choc vasoplégique post-CEC', 'Post-bypass vasoplegic shock'),
      ],
      effects: DrugEffects(vasopressin: 'none'), // RAS effector, not adrenergic
      sideEffects: [
        LString('Thromboembolie veineuse', 'Venous thromboembolism'),
        LString('Thrombocytopénie', 'Thrombocytopenia'),
        LString('Tachycardie', 'Tachycardia'),
        LString('Acidose métabolique', 'Metabolic acidosis'),
      ],
      contraindications: [
        LString('Thromboembolie veineuse active', 'Active venous thromboembolism'),
        LString('Thrombocytopénie <50 000/mm³', 'Thrombocytopenia <50,000/mm³'),
      ],
      notes: [
        LString('Surveillance thromboembolique (HBPM prophylactique)', 'Thromboembolic prophylaxis (LMWH)'),
        LString('Ne pas boluser: débuter à 0.02 mcg/kg/min et titrer', 'Do not bolus: start at 0.02 mcg/kg/min and titrate'),
        LString('Réservé au choc réfractaire aux 2 premières lignes', 'Reserved for shock refractory to 1st and 2nd line'),
      ],
    ),

    // =====================
    // MIXED (VASOPRESSOR + INOTROPE)
    // =====================
    VasoactiveDrug(
      id: 'adrenaline',
      name: 'Adrénaline',
      genericName: 'Epinephrine',
      category: VasoactiveCategory.mixed,
      description: LString(
        'Catécholamine mixte - inotrope et vasopresseur, 2ème ligne après noradrénaline (SSC 2021)',
        'Mixed catecholamine - inotrope and vasopressor, 2nd line after norepinephrine (SSC 2021)',
      ),
      concentrations: [
        DrugConcentration(label: '0.1 mg/mL (1mg/10mL)', mgPerMl: 0.1, commonPrep: LString('1 mg dans 10 mL NaCl', '1 mg in 10 mL NaCl')),
        DrugConcentration(label: '0.2 mg/mL (5mg/25mL)', mgPerMl: 0.2, commonPrep: LString('5 mg dans 25 mL (seringue 50 mL)', '5 mg in 25 mL (50 mL syringe)')),
        DrugConcentration(label: '0.5 mg/mL (5mg/10mL)', mgPerMl: 0.5, commonPrep: LString('5 mg dans 10 mL', '5 mg in 10 mL')),
        DrugConcentration(label: '1 mg/mL (pur)', mgPerMl: 1.0, commonPrep: LString('Non dilué (urgence)', 'Undiluted (emergency)')),
      ],
      defaultConcentrationIndex: 1,
      doseUnit: 'mcg/kg/min',
      doseRange: DrugDoseRange(min: 0.01, max: 2.0, typical: 0.1, step: 0.01),
      indications: [
        LString('Choc anaphylactique (1ère ligne)', 'Anaphylactic shock (1st line)'),
        LString('Arrêt cardiaque', 'Cardiac arrest'),
        LString('Choc cardiogénique (2ème ligne SSC 2021)', 'Cardiogenic shock (2nd line, SSC 2021)'),
        LString('Bronchospasme sévère', 'Severe bronchospasm'),
        LString('Choc septique réfractaire (2ème ligne après noradrénaline)', 'Refractory septic shock (2nd line after norepinephrine)'),
      ],
      effects: DrugEffects(alpha: 'high', beta1: 'high', beta2: 'moderate'),
      sideEffects: [
        LString('Tachycardie', 'Tachycardia'),
        LString('Arythmies ventriculaires', 'Ventricular arrhythmias'),
        LString('Hypertension', 'Hypertension'),
        LString('Hyperglycémie', 'Hyperglycemia'),
        LString('Hypokaliémie', 'Hypokalemia'),
        LString('Acidose lactique', 'Lactic acidosis'),
        LString('Ischémie myocardique', 'Myocardial ischemia'),
      ],
      contraindications: [
        LString('Arythmie ventriculaire non contrôlée (relative)', 'Uncontrolled ventricular arrhythmia (relative)'),
        LString('Phéochromocytome', 'Pheochromocytoma'),
      ],
      notes: [
        LString('Faibles doses (< 0.1): effet β prédominant (inotrope)', 'Low doses (< 0.1): predominant β effect (inotrope)'),
        LString('Hautes doses (> 0.1): effet α prédominant (vasopresseur)', 'High doses (> 0.1): predominant α effect (vasopressor)'),
        LString('Arrêt cardiaque: 1 mg IVD toutes les 3-5 min (ERC 2021)', 'Cardiac arrest: 1 mg IV push q3-5 min (ERC 2021)'),
        LString('⚠️ Dose usuelle max: 0.5 mcg/kg/min (max absolu: 2 mcg/kg/min)', '⚠️ Usual max dose: 0.5 mcg/kg/min (absolute max: 2 mcg/kg/min)'),
      ],
    ),

    VasoactiveDrug(
      id: 'dopamine',
      name: 'Dopamine',
      genericName: 'Dopamine',
      category: VasoactiveCategory.mixed,
      description: LString(
        'Effets dose-dépendants: dopaminergique, β puis α - usage déconseillé en choc (SSC 2021, risque d\'arythmie)',
        'Dose-dependent effects: dopaminergic, β then α - not recommended in shock (SSC 2021, arrhythmia risk)',
      ),
      concentrations: [
        DrugConcentration(label: '5 mg/mL (200mg/40mL)', mgPerMl: 5.0, commonPrep: LString('200 mg dans 40 mL G5%', '200 mg in 40 mL D5W')),
        DrugConcentration(label: '4 mg/mL (200mg/50mL)', mgPerMl: 4.0, commonPrep: LString('200 mg dans 50 mL G5%', '200 mg in 50 mL D5W')),
        DrugConcentration(label: '8 mg/mL (400mg/50mL)', mgPerMl: 8.0, commonPrep: LString('400 mg dans 50 mL G5%', '400 mg in 50 mL D5W')),
      ],
      defaultConcentrationIndex: 0,
      doseUnit: 'mcg/kg/min',
      doseRange: DrugDoseRange(min: 1.0, max: 20.0, typical: 5.0, step: 0.5),
      indications: [
        LString('Bradycardie symptomatique (alternative atropine)', 'Symptomatic bradycardia (atropine alternative)'),
        LString('Choc cardiogénique (2ème ligne, SSC 2021 - préférer noradrénaline ± dobutamine)', 'Cardiogenic shock (2nd line, SSC 2021 - prefer norepinephrine ± dobutamine)'),
        LString('Bas débit rénal (controversé, non recommandé)', 'Renal-dose (controversial, not recommended)'),
      ],
      effects: DrugEffects(alpha: 'moderate', beta1: 'moderate', beta2: 'low', dopaminergic: 'moderate'),
      sideEffects: [
        LString('Tachycardie', 'Tachycardia'),
        LString('Arythmies (risque accru vs noradrénaline - SSC 2021)', 'Arrhythmias (increased risk vs norepinephrine - SSC 2021)'),
        LString('Nausées, vomissements', 'Nausea, vomiting'),
        LString('Ischémie périphérique', 'Peripheral ischemia'),
        LString('Nécrose tissulaire', 'Tissue necrosis'),
      ],
      contraindications: [
        LString('Phéochromocytome', 'Pheochromocytoma'),
        LString('Tachyarythmie non contrôlée', 'Uncontrolled tachyarrhythmia'),
        LString('Fibrillation ventriculaire', 'Ventricular fibrillation'),
      ],
      notes: [
        LString('1-3 mcg/kg/min: effet dopaminergique (rénal)', '1-3 mcg/kg/min: dopaminergic effect (renal)'),
        LString('3-10 mcg/kg/min: effet β1 (inotrope)', '3-10 mcg/kg/min: β1 effect (inotrope)'),
        LString('> 10 mcg/kg/min: effet α (vasopresseur)', '> 10 mcg/kg/min: α effect (vasopressor)'),
        LString('⚠️ Plus d\'arythmies que la noradrénaline (SOAP II, SSC 2021) - ne plus utiliser en 1ère intention dans le choc', '⚠️ More arrhythmias than norepinephrine (SOAP II, SSC 2021) - no longer first-line in shock'),
      ],
    ),

    // =====================
    // INOTROPES
    // =====================
    VasoactiveDrug(
      id: 'dobutamine',
      name: 'Dobutamine',
      genericName: 'Dobutamine',
      category: VasoactiveCategory.inotrope,
      description: LString(
        'Inotrope pur - augmente le débit cardiaque sans vasoconstriction (SSC 2021: avec noradrénaline dans le choc cardiogénique)',
        'Pure inotrope - increases cardiac output without vasoconstriction (SSC 2021: with norepinephrine in cardiogenic shock)',
      ),
      concentrations: [
        DrugConcentration(label: '5 mg/mL (250mg/50mL)', mgPerMl: 5.0, commonPrep: LString('250 mg dans 50 mL G5%', '250 mg in 50 mL D5W')),
        DrugConcentration(label: '2.5 mg/mL (250mg/100mL)', mgPerMl: 2.5, commonPrep: LString('250 mg dans 100 mL G5%', '250 mg in 100 mL D5W')),
        DrugConcentration(label: '10 mg/mL (500mg/50mL)', mgPerMl: 10.0, commonPrep: LString('500 mg dans 50 mL G5%', '500 mg in 50 mL D5W')),
      ],
      defaultConcentrationIndex: 0,
      doseUnit: 'mcg/kg/min',
      doseRange: DrugDoseRange(min: 2.5, max: 20.0, typical: 5.0, step: 0.5),
      indications: [
        LString('Choc cardiogénique (SSC 2021)', 'Cardiogenic shock (SSC 2021)'),
        LString('Insuffisance cardiaque aiguë décompensée', 'Acute decompensated heart failure'),
        LString('Bas débit cardiaque post-chirurgie', 'Postoperative low cardiac output'),
        LString('Stress test pharmacologique', 'Pharmacologic stress test'),
      ],
      effects: DrugEffects(alpha: 'low', beta1: 'high', beta2: 'moderate'),
      sideEffects: [
        LString('Tachycardie', 'Tachycardia'),
        LString('Arythmies', 'Arrhythmias'),
        LString('Hypotension (vasodilatation β2)', 'Hypotension (β2 vasodilation)'),
        LString('Céphalées', 'Headaches'),
        LString('Angor', 'Angina'),
        LString('Hypokaliémie', 'Hypokalemia'),
      ],
      contraindications: [
        LString('Cardiomyopathie obstructive', 'Obstructive cardiomyopathy'),
        LString('Sténose aortique serrée', 'Severe aortic stenosis'),
        LString('Tamponnade', 'Tamponade'),
        LString('Fibrillation auriculaire rapide', 'Rapid atrial fibrillation'),
      ],
      notes: [
        LString('Ne pas utiliser seule en cas d\'hypotension', 'Do not use alone in hypotension'),
        LString('Associer à la noradrénaline si PAM basse (SSC 2021)', 'Combine with norepinephrine if low MAP (SSC 2021)'),
        LString('Tachyphylaxie après 72h d\'utilisation continue', 'Tachyphylaxis after 72h continuous use'),
      ],
    ),

    VasoactiveDrug(
      id: 'milrinone',
      name: 'Milrinone',
      genericName: 'Milrinone',
      category: VasoactiveCategory.inotrope,
      description: LString(
        'Inhibiteur de la phosphodiestérase III - inotrope et vasodilatateur',
        'Phosphodiesterase-III inhibitor - inotrope and vasodilator',
      ),
      concentrations: [
        DrugConcentration(label: '0.2 mg/mL (10mg/50mL)', mgPerMl: 0.2, commonPrep: LString('10 mg dans 50 mL G5%', '10 mg in 50 mL D5W')),
        DrugConcentration(label: '0.4 mg/mL (20mg/50mL)', mgPerMl: 0.4, commonPrep: LString('20 mg dans 50 mL G5%', '20 mg in 50 mL D5W')),
      ],
      defaultConcentrationIndex: 0,
      doseUnit: 'mcg/kg/min',
      doseRange: DrugDoseRange(min: 0.125, max: 0.75, typical: 0.375, step: 0.125),
      indications: [
        LString('Insuffisance cardiaque aiguë', 'Acute heart failure'),
        LString('Choc cardiogénique', 'Cardiogenic shock'),
        LString('Post-chirurgie cardiaque', 'Post-cardiac surgery'),
        LString('HTAP (vasodilatation pulmonaire)', 'Pulmonary hypertension (pulmonary vasodilation)'),
      ],
      effects: DrugEffects(), // PDE3 inhibitor, not adrenergic
      sideEffects: [
        LString('Hypotension (vasodilatation)', 'Hypotension (vasodilation)'),
        LString('Arythmies ventriculaires', 'Ventricular arrhythmias'),
        LString('Thrombocytopénie', 'Thrombocytopenia'),
        LString('Céphalées', 'Headaches'),
      ],
      contraindications: [
        LString('Sténose aortique ou pulmonaire sévère', 'Severe aortic or pulmonic stenosis'),
        LString('Cardiomyopathie obstructive', 'Obstructive cardiomyopathy'),
        LString('Infarctus aigu (phase aiguë)', 'Acute MI (acute phase)'),
      ],
      notes: [
        LString('Bolus optionnel: 50 mcg/kg en 10 min', 'Optional bolus: 50 mcg/kg over 10 min'),
        LString('Réduire dose si insuffisance rénale', 'Reduce dose in renal impairment'),
        LString('Demi-vie longue (2-3h)', 'Long half-life (2-3h)'),
        LString('Action indépendante des récepteurs β', 'Action independent of β receptors'),
      ],
    ),

    VasoactiveDrug(
      id: 'isoproterenol',
      name: 'Isoprénaline',
      genericName: 'Isoproterenol',
      category: VasoactiveCategory.inotrope,
      description: LString(
        'Agoniste β pur - chronotrope et inotrope positif',
        'Pure β-agonist - positive chronotrope and inotrope',
      ),
      concentrations: [
        DrugConcentration(label: '0.02 mg/mL (1mg/50mL)', mgPerMl: 0.02, commonPrep: LString('1 mg dans 50 mL G5%', '1 mg in 50 mL D5W')),
        DrugConcentration(label: '0.04 mg/mL (2mg/50mL)', mgPerMl: 0.04, commonPrep: LString('2 mg dans 50 mL G5%', '2 mg in 50 mL D5W')),
      ],
      defaultConcentrationIndex: 0,
      doseUnit: 'mcg/min',
      doseRange: DrugDoseRange(min: 1.0, max: 20.0, typical: 5.0, step: 1.0),
      indications: [
        LString('Bradycardie sévère réfractaire à l\'atropine', 'Severe bradycardia refractory to atropine'),
        LString('BAV complet en attente de pacemaker', 'Complete AV block awaiting pacemaker'),
        LString('Torsades de pointe (↑ FC)', 'Torsades de pointes (↑ HR)'),
        LString('Test de provocation (Brugada)', 'Provocation test (Brugada)'),
      ],
      effects: DrugEffects(beta1: 'high', beta2: 'high'),
      sideEffects: [
        LString('Tachycardie excessive', 'Excessive tachycardia'),
        LString('Arythmies ventriculaires', 'Ventricular arrhythmias'),
        LString('Hypotension (β2)', 'Hypotension (β2)'),
        LString('Flush', 'Flushing'),
        LString('Tremblements', 'Tremors'),
        LString('Angor', 'Angina'),
      ],
      contraindications: [
        LString('Tachyarythmie', 'Tachyarrhythmia'),
        LString('Intoxication digitalique', 'Digitalis toxicity'),
        LString('Cardiopathie ischémique sévère', 'Severe ischemic heart disease'),
      ],
      notes: [
        LString('Dose non basée sur le poids', 'Non-weight-based dosing'),
        LString('Titrer pour FC cible', 'Titrate to target HR'),
        LString('Solution de temporisation avant pacing', 'Bridging solution before pacing'),
      ],
    ),

    // =====================
    // VASODILATORS
    // =====================
    VasoactiveDrug(
      id: 'nicardipine',
      name: 'Nicardipine',
      genericName: 'Nicardipine',
      category: VasoactiveCategory.vasodilator,
      description: LString(
        'Inhibiteur calcique - vasodilatateur artériel',
        'Calcium-channel blocker - arterial vasodilator',
      ),
      concentrations: [
        DrugConcentration(label: '0.2 mg/mL (10mg/50mL)', mgPerMl: 0.2, commonPrep: LString('10 mg dans 50 mL NaCl', '10 mg in 50 mL NaCl')),
        DrugConcentration(label: '0.5 mg/mL (25mg/50mL)', mgPerMl: 0.5, commonPrep: LString('25 mg dans 50 mL NaCl', '25 mg in 50 mL NaCl')),
        DrugConcentration(label: '1 mg/mL (50mg/50mL)', mgPerMl: 1.0, commonPrep: LString('50 mg dans 50 mL NaCl', '50 mg in 50 mL NaCl')),
      ],
      defaultConcentrationIndex: 0,
      doseUnit: 'mg/h',
      doseRange: DrugDoseRange(min: 1.0, max: 15.0, typical: 5.0, step: 0.5),
      indications: [
        LString('Urgence hypertensive', 'Hypertensive emergency'),
        LString('HTA périopératoire', 'Perioperative hypertension'),
        LString('Dissection aortique', 'Aortic dissection'),
        LString('AVC hémorragique', 'Hemorrhagic stroke'),
      ],
      effects: DrugEffects(), // Calcium channel blocker
      sideEffects: [
        LString('Hypotension', 'Hypotension'),
        LString('Tachycardie réflexe', 'Reflex tachycardia'),
        LString('Céphalées', 'Headaches'),
        LString('Flush', 'Flushing'),
        LString('Nausées', 'Nausea'),
        LString('Phlébite au site d\'injection', 'Injection-site phlebitis'),
      ],
      contraindications: [
        LString('Sténose aortique sévère', 'Severe aortic stenosis'),
        LString('Choc cardiogénique', 'Cardiogenic shock'),
        LString('Insuffisance cardiaque décompensée', 'Decompensated heart failure'),
      ],
      notes: [
        LString('Début d\'action: 5-10 min', 'Onset: 5-10 min'),
        LString('Augmenter par paliers de 2.5 mg/h toutes les 5-15 min', 'Increase by 2.5 mg/h increments q5-15 min'),
        LString('Changer de site de perfusion toutes les 12h (phlébite)', 'Change infusion site q12h (phlebitis)'),
      ],
    ),

    VasoactiveDrug(
      id: 'nitroprusside',
      name: 'Nitroprussiate de sodium',
      genericName: 'Sodium Nitroprusside',
      category: VasoactiveCategory.vasodilator,
      description: LString(
        'Vasodilatateur artériel et veineux puissant',
        'Potent arterial and venous vasodilator',
      ),
      concentrations: [
        DrugConcentration(label: '0.5 mg/mL (25mg/50mL)', mgPerMl: 0.5, commonPrep: LString('25 mg dans 50 mL G5% (protéger de la lumière)', '25 mg in 50 mL D5W (protect from light)')),
        DrugConcentration(label: '1 mg/mL (50mg/50mL)', mgPerMl: 1.0, commonPrep: LString('50 mg dans 50 mL G5%', '50 mg in 50 mL D5W')),
      ],
      defaultConcentrationIndex: 0,
      doseUnit: 'mcg/kg/min',
      doseRange: DrugDoseRange(min: 0.25, max: 10.0, typical: 2.0, step: 0.25),
      indications: [
        LString('Urgence hypertensive sévère', 'Severe hypertensive emergency'),
        LString('Dissection aortique (avec β-bloquant)', 'Aortic dissection (with β-blocker)'),
        LString('Insuffisance cardiaque aiguë', 'Acute heart failure'),
        LString('Hypotension contrôlée peropératoire', 'Controlled intraoperative hypotension'),
      ],
      effects: DrugEffects(), // NO donor
      sideEffects: [
        LString('Hypotension', 'Hypotension'),
        LString('Tachycardie réflexe', 'Reflex tachycardia'),
        LString('Céphalées', 'Headaches'),
        LString('Nausées', 'Nausea'),
        LString('Toxicité au cyanure (doses élevées ou prolongées)', 'Cyanide toxicity (high doses or prolonged use)'),
        LString('Méthémoglobinémie', 'Methemoglobinemia'),
      ],
      contraindications: [
        LString('Insuffisance hépatique sévère', 'Severe hepatic impairment'),
        LString('Déficit en vitamine B12', 'Vitamin B12 deficiency'),
        LString('Atrophie optique de Leber', 'Leber optic atrophy'),
        LString('Shunt artério-veineux', 'Arteriovenous shunt'),
      ],
      notes: [
        LString('PROTÉGER DE LA LUMIÈRE (tubulure opaque)', 'PROTECT FROM LIGHT (opaque tubing)'),
        LString('Surveillance thiocyanatémie si > 48h', 'Monitor thiocyanate levels if > 48h'),
        LString('Antidote: hydroxocobalamine', 'Antidote: hydroxocobalamin'),
        LString('Début d\'action immédiat, arrêt effet en 1-2 min', 'Immediate onset, effect stops in 1-2 min'),
      ],
    ),

    VasoactiveDrug(
      id: 'nitroglycerin',
      name: 'Trinitrine',
      genericName: 'Nitroglycerin',
      category: VasoactiveCategory.vasodilator,
      description: LString(
        'Vasodilatateur veineux > artériel - Réduction précharge',
        'Venous > arterial vasodilator - preload reduction',
      ),
      concentrations: [
        DrugConcentration(label: '1 mg/mL (50mg/50mL)', mgPerMl: 1.0, commonPrep: LString('50 mg dans 50 mL G5%', '50 mg in 50 mL D5W')),
        DrugConcentration(label: '0.4 mg/mL (20mg/50mL)', mgPerMl: 0.4, commonPrep: LString('20 mg dans 50 mL G5%', '20 mg in 50 mL D5W')),
      ],
      defaultConcentrationIndex: 0,
      doseUnit: 'mcg/min',
      doseRange: DrugDoseRange(min: 5.0, max: 200.0, typical: 20.0, step: 5.0),
      indications: [
        LString('Syndrome coronaire aigu', 'Acute coronary syndrome'),
        LString('OAP cardiogénique', 'Cardiogenic pulmonary edema'),
        LString('Urgence hypertensive', 'Hypertensive emergency'),
        LString('Spasme coronaire', 'Coronary spasm'),
      ],
      effects: DrugEffects(), // NO donor
      sideEffects: [
        LString('Hypotension', 'Hypotension'),
        LString('Céphalées', 'Headaches'),
        LString('Tachycardie réflexe', 'Reflex tachycardia'),
        LString('Flush', 'Flushing'),
        LString('Méthémoglobinémie (rare)', 'Methemoglobinemia (rare)'),
      ],
      contraindications: [
        LString('Hypotension', 'Hypotension'),
        LString('Choc cardiogénique', 'Cardiogenic shock'),
        LString('Utilisation de sildénafil/tadalafil (24-48h)', 'Sildenafil/tadalafil use (24-48h)'),
        LString('Sténose aortique sévère', 'Severe aortic stenosis'),
        LString('IDM droit', 'Right ventricular MI'),
      ],
      notes: [
        LString('Dose non basée sur le poids', 'Non-weight-based dosing'),
        LString('Tachyphylaxie après 24-48h', 'Tachyphylaxis after 24-48h'),
        LString('Utiliser tubulure spéciale (adsorption PVC)', 'Use special tubing (PVC adsorption)'),
      ],
    ),
  ];
}
