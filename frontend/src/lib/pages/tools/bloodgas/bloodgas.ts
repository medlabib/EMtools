/**
 * Blood Gas & Ventilation Calculator
 * Réa-Logic Pro - Precision ICU Tool
 */

// === CONSTANTS ===
export const NORMALS = {
  ph: 7.40,
  paco2: 40,
  hco3: 24,
  ag: 12,
  alb: 4.0,
  patm: 760, // Atmospheric pressure at sea level
  ph2o: 47   // Water vapor pressure
};

// === TYPES ===
export interface PatientData {
  // Blood Gas
  ph: number;
  paco2: number;
  pao2: number;
  hco3: number;
  sao2: number;
  lactate: number;
  // Hematology & Biochemistry
  hb: number;
  na: number;
  cl: number;
  alb: number;
  temp: number;
  // Ventilator Settings
  fio2: number;
  mode: string;
  vt: number;
  rr: number;
  peep: number;
  pplat: number;
  ppeak: number;
  // Demographics
  height: number;
  gender: 'male' | 'female';
  age: number;
}

export interface CalculationResults {
  // Patient
  pbw: number;
  // Anion Gap
  ag_uncorrected: number;
  ag_corrected: number;
  delta_ratio: number;
  // Acid-Base
  status: string;
  primary: string;
  winter_msg: string;
  // Oxygenation
  pf_ratio: number;
  ards_grade: string;
  cao2: number;
  aa_gradient: number;
  expected_aa: number;
  // Ventilation Mechanics
  vt_per_kg: number;
  lactate_status: string;
  driving_pressure: number;
  compliance: number;
  rsbi: number;
  resistive_gradient: number;
}

// === DEFAULT PATIENT DATA ===
export const defaultPatientData: PatientData = {
  // Blood Gas
  ph: 7.25,
  paco2: 30,
  pao2: 75,
  hco3: 14,
  sao2: 92,
  lactate: 4.5,
  // Hematology & Biochemistry
  hb: 9.5,
  na: 140,
  cl: 100,
  alb: 2.5,
  temp: 38.5,
  // Ventilator Settings
  fio2: 0.5,
  mode: 'VAC',
  vt: 450,
  rr: 22,
  peep: 8,
  pplat: 26,
  ppeak: 35,
  // Demographics
  height: 175,
  gender: 'male',
  age: 65
};

// === CALCULATIONS ===

/**
 * Calculate Predicted Body Weight (PBW) using ARDSNet formula
 */
export function calculatePBW(height: number, gender: 'male' | 'female'): number {
  const heightDiff = Math.max(0, height - 152.4);
  return gender === 'male' 
    ? 50 + (0.91 * heightDiff)
    : 45.5 + (0.91 * heightDiff);
}

/**
 * Calculate Anion Gap (uncorrected and corrected for albumin)
 */
export function calculateAnionGap(na: number, cl: number, hco3: number, alb: number): { uncorrected: number; corrected: number } {
  const uncorrected = na - (cl + hco3);
  const corrected = uncorrected + (2.5 * (NORMALS.alb - alb));
  return { uncorrected, corrected };
}

/**
 * Calculate Delta Ratio for mixed acid-base disorders
 */
export function calculateDeltaRatio(ag_corrected: number, hco3: number): number {
  const delta_gap = ag_corrected - 12;
  const delta_bicarb = 24 - hco3;
  if (delta_bicarb === 0) return 0;
  return delta_gap / delta_bicarb;
}

/**
 * Determine acid-base status
 */
export function determineAcidBaseStatus(ph: number, paco2: number, hco3: number): { status: string; primary: string; winter_msg: string } {
  let status = "Normal";
  let primary = "";
  let winter_msg = "";

  if (ph < 7.35) status = "Acidose";
  else if (ph > 7.45) status = "Alcalose";

  if (status === "Acidose") {
    if (paco2 > 45) primary = "Respiratoire";
    else if (hco3 < 22) primary = "Métabolique";
    else primary = "Mixte";
  } else if (status === "Alcalose") {
    if (paco2 < 35) primary = "Respiratoire";
    else if (hco3 > 26) primary = "Métabolique";
    else primary = "Mixte";
  }

  // Winter's formula for metabolic acidosis compensation
  if (status === "Acidose" && primary === "Métabolique") {
    const expected_paco2 = (1.5 * hco3) + 8;
    if (Math.abs(paco2 - expected_paco2) <= 2) {
      winter_msg = "Compensée (Pure)";
    } else if (paco2 < expected_paco2 - 2) {
      winter_msg = "+ Alcalose Resp.";
    } else {
      winter_msg = "+ Acidose Resp.";
    }
  }

  return { status, primary, winter_msg };
}

/**
 * Calculate P/F ratio and ARDS grade
 */
export function calculateOxygenation(pao2: number, fio2: number): { pf_ratio: number; ards_grade: string } {
  const pf_ratio = pao2 / fio2;
  let ards_grade = "Normal";
  
  if (pf_ratio < 300) ards_grade = "SDRA Léger";
  if (pf_ratio < 200) ards_grade = "SDRA Modéré";
  if (pf_ratio < 100) ards_grade = "SDRA Sévère";
  
  return { pf_ratio, ards_grade };
}

/**
 * Calculate arterial oxygen content (CaO2)
 */
export function calculateCaO2(hb: number, sao2: number, pao2: number): number {
  return (1.34 * hb * (sao2 / 100)) + (0.003 * pao2);
}

/**
 * Calculate A-a gradient
 */
export function calculateAaGradient(fio2: number, paco2: number, pao2: number, age: number): { aa_gradient: number; expected_aa: number } {
  const pao2_alveolar = (NORMALS.patm - NORMALS.ph2o) * fio2 - (paco2 / 0.8);
  const aa_gradient = pao2_alveolar - pao2;
  const expected_aa = (age / 4) + 4;
  return { aa_gradient, expected_aa };
}

/**
 * Calculate ventilator mechanics
 */
export function calculateMechanics(vt: number, pbw: number, pplat: number, peep: number, ppeak: number, rr: number): {
  vt_per_kg: number;
  driving_pressure: number;
  compliance: number;
  rsbi: number;
  resistive_gradient: number;
} {
  const vt_per_kg = vt / pbw;
  const driving_pressure = pplat - peep;
  const compliance = driving_pressure > 0 ? vt / driving_pressure : 0;
  const rsbi = vt > 0 ? rr / (vt / 1000) : 0;
  const resistive_gradient = ppeak - pplat;

  return { vt_per_kg, driving_pressure, compliance, rsbi, resistive_gradient };
}

/**
 * Determine lactate status
 */
export function getLactateStatus(lactate: number): string {
  if (lactate >= 4) return "Choc / Hypoperfusion";
  if (lactate >= 2) return "Hyperlactatémie";
  return "Normal";
}

/**
 * Calculate all results from patient data
 */
export function calculateAll(patient: PatientData): CalculationResults {
  // 1. PBW
  const pbw = calculatePBW(patient.height, patient.gender);

  // 2. Anion Gap
  const { uncorrected: ag_uncorrected, corrected: ag_corrected } = 
    calculateAnionGap(patient.na, patient.cl, patient.hco3, patient.alb);

  // 3. Delta Ratio
  const delta_ratio = calculateDeltaRatio(ag_corrected, patient.hco3);

  // 4. Acid-Base Status
  const { status, primary, winter_msg } = 
    determineAcidBaseStatus(patient.ph, patient.paco2, patient.hco3);

  // 5. Oxygenation
  const { pf_ratio, ards_grade } = calculateOxygenation(patient.pao2, patient.fio2);
  const cao2 = calculateCaO2(patient.hb, patient.sao2, patient.pao2);
  const { aa_gradient, expected_aa } = 
    calculateAaGradient(patient.fio2, patient.paco2, patient.pao2, patient.age);

  // 6. Mechanics
  const { vt_per_kg, driving_pressure, compliance, rsbi, resistive_gradient } = 
    calculateMechanics(patient.vt, pbw, patient.pplat, patient.peep, patient.ppeak, patient.rr);

  // 7. Lactate
  const lactate_status = getLactateStatus(patient.lactate);

  return {
    pbw,
    ag_uncorrected,
    ag_corrected,
    delta_ratio,
    status,
    primary,
    winter_msg,
    pf_ratio,
    ards_grade,
    cao2,
    aa_gradient,
    expected_aa,
    vt_per_kg,
    lactate_status,
    driving_pressure,
    compliance,
    rsbi,
    resistive_gradient
  };
}

// === EDUCATIONAL DEFINITIONS ===
export const DEFINITIONS = {
  patient: {
    title: "Patient & Poids Idéal (PBW)",
    content: `Le réglage du respirateur ne doit jamais se faire sur le poids réel du patient, mais sur son Poids Idéal Théorique (Predicted Body Weight - PBW).

La taille des poumons dépend de la hauteur de la cage thoracique (taille du patient), pas de sa masse graisseuse.

Formule (ARDSNet):
• Homme: 50 + 0.91 × (Taille cm - 152.4)
• Femme: 45.5 + 0.91 × (Taille cm - 152.4)`
  },
  gds: {
    title: "Gazométrie Artérielle",
    content: `• pH : Reflet de l'acidité globale (N: 7.38-7.42)
• PaCO2 : Reflet de la Ventilation. Si élevée = Hypoventilation
• PaO2 : Reflet de l'Oxygénation (pression dissoute)
• HCO3 : Tampon métabolique géré par le rein`
  },
  iono: {
    title: "Ionogramme & Albumine",
    content: `Essentiel pour calculer le Trou Anionique et classer les acidoses métaboliques.

Attention à l'Albumine : L'albumine est un acide faible. En cas d'hypoalbuminémie (fréquent en réa), le trou anionique est faussement abaissé. L'app calcule automatiquement le Trou Anionique Corrigé.`
  },
  respi: {
    title: "Paramètres Respirateur",
    content: `• Vt (Volume Courant) : Quantité d'air insufflée. Cible : 6 ml/kg PBW
• PEEP (PEP) : Pression maintenue à l'expiration pour garder les alvéoles ouvertes
• P.Plateau : Pression alvéolaire en fin d'inspi. Doit rester < 30 cmH2O
• P.Crête : Pression max dans les tuyaux. Si Crête >> Plateau = Obstruction`
  },
  transport: {
    title: "Contenu Artériel en O2 (CaO2)",
    content: `La PaO2 et la Saturation ne suffisent pas ! Le vrai "carburant" des organes est la quantité totale d'oxygène transportée.

CaO2 = (1.34 × Hb × SaO2) + (0.003 × PaO2)

Un patient avec 100% de SaO2 mais 5g d'hémoglobine est en hypoxie tissulaire grave (CaO2 bas).`
  },
  meca: {
    title: "Mécanique Ventilatoire",
    content: `• Compliance : Souplesse du poumon. Si basse (<40) = "Poumon dur" (SDRA, OAP, Fibrose)
• Driving Pressure (Pression Motrice) : P.Plat - PEEP. Meilleur prédicteur de mortalité SDRA. Doit être < 15 cmH2O
• Gradient Résistif : P.Crête - P.Plat. Si élevé (>5) = Problème voies aériennes (BPCO, Asthme, Sonde bouchée)`
  },
  metabo: {
    title: "Analyse Métabolique (Stewart)",
    content: `Trou Anionique (AG) : Si > 12-16 (selon correction), signe la présence d'acides indosés (Lactates, Cétones, Toxiques, Insuffisance Rénale).

Delta Ratio : Permet de voir si une acidose est "pure" ou mixte (associée à une perte de bicarbonates ou une alcalose métabolique).`
  }
};
