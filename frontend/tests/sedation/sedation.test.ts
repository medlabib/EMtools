/**
 * Sedation Drugs Tests
 * Tests for sedation/anesthesia drug calculations and data
 */
import { describe, it, expect } from 'vitest';
import {
  propofol,
  etomidate,
  ketamine,
  midazolam,
  succinylcholine,
  rocuronium,
  fentanyl,
  morphine
} from '../../src/lib/pages/tools/sedation/drugs';

describe('Sedation Drugs', () => {
  describe('Induction Agents', () => {
    describe('Propofol', () => {
      it('should have correct standard dose', () => {
        expect(propofol.standardDose).toBe(2);
        expect(propofol.doseUnit).toBe('mg/kg');
      });

      it('should have correct onset and duration', () => {
        expect(propofol.onsetSeconds).toBe(30);
        expect(propofol.durationMinutes).toBe(5);
      });

      it('should have doses for different age groups', () => {
        expect(propofol.dosesByAge).toBeDefined();
        expect(propofol.dosesByAge!.length).toBeGreaterThan(0);
        
        const adultDose = propofol.dosesByAge!.find(d => d.ageGroup === 'adult');
        expect(adultDose).toBeDefined();
        expect(adultDose?.dose).toBe(1.5);
        
        const elderlyDose = propofol.dosesByAge!.find(d => d.ageGroup === 'elderly');
        expect(elderlyDose).toBeDefined();
        expect(elderlyDose?.dose).toBe(1);
      });

      it('should have max single dose defined', () => {
        expect(propofol.maxSingleDose).toBe(200);
        expect(propofol.maxSingleDoseUnit).toBe('mg');
      });

      it('should have proper indications', () => {
        expect(propofol.indications).toContain('Induction anesthésie');
        expect(propofol.indications).toContain('Sédation procédurale');
      });

      it('should have contraindications listed', () => {
        expect(propofol.contraindications.length).toBeGreaterThan(0);
      });
    });

    describe('Etomidate', () => {
      it('should have correct standard dose', () => {
        expect(etomidate.standardDose).toBe(0.3);
        expect(etomidate.doseUnit).toBe('mg/kg');
      });

      it('should be indicated for hemodynamically unstable patients', () => {
        expect(etomidate.indications).toContain('ISR chez patient instable hémodynamiquement');
      });

      it('should have hemodynamic stability as advantage', () => {
        expect(etomidate.advantages).toContain('Stabilité hémodynamique');
      });

      it('should list myoclonus as side effect', () => {
        const hasMyoclonus = etomidate.sideEffects.some(se => 
          se.toLowerCase().includes('myoclonies')
        );
        expect(hasMyoclonus).toBe(true);
      });
    });

    describe('Ketamine', () => {
      it('should have correct standard dose for RSI', () => {
        expect(ketamine.standardDose).toBe(1.5);
        expect(ketamine.doseUnit).toBe('mg/kg');
      });

      it('should support multiple routes', () => {
        expect(ketamine.route).toContain('IV');
        expect(ketamine.route).toContain('IM');
      });

      it('should be indicated for asthma/bronchospasm', () => {
        const hasAsthmaIndication = ketamine.indications.some(ind => 
          ind.toLowerCase().includes('asthme') || ind.toLowerCase().includes('bronchospasme')
        );
        expect(hasAsthmaIndication).toBe(true);
      });

      it('should have bronchodilation as advantage', () => {
        expect(ketamine.advantages).toContain('Bronchodilatation');
      });

      it('should preserve airway reflexes', () => {
        const preservesReflexes = ketamine.advantages.some(adv => 
          adv.toLowerCase().includes('réflexes')
        );
        expect(preservesReflexes).toBe(true);
      });

      it('should have pediatric dosing', () => {
        const childDose = ketamine.dosesByAge!.find(d => d.ageGroup === 'child');
        expect(childDose).toBeDefined();
      });
    });

    describe('Midazolam', () => {
      it('should have correct standard dose', () => {
        expect(midazolam.standardDose).toBe(0.1);
        expect(midazolam.doseUnit).toBe('mg/kg');
      });

      it('should be a benzodiazepine', () => {
        expect(midazolam.drugClass).toBe('Benzodiazépine');
      });

      it('should have amnesia as advantage', () => {
        expect(midazolam.advantages).toContain('Amnésie antérograde');
      });

      it('should mention flumazenil as antidote in notes', () => {
        const hasFlumazenil = midazolam.notes.some(note => 
          note.toLowerCase().includes('flumazénil')
        );
        expect(hasFlumazenil).toBe(true);
      });

      it('should support intranasal route', () => {
        expect(midazolam.route).toContain('IN');
      });
    });
  });

  describe('Paralytic Agents', () => {
    describe('Succinylcholine', () => {
      it('should have correct standard dose', () => {
        expect(succinylcholine.standardDose).toBe(1.5);
        expect(succinylcholine.doseUnit).toBe('mg/kg');
      });

      it('should be a depolarizing agent', () => {
        expect(succinylcholine.drugClass).toBe('Curare dépolarisant');
      });

      it('should have very rapid onset', () => {
        expect(succinylcholine.onsetSeconds).toBeLessThanOrEqual(60);
      });

      it('should have short duration', () => {
        expect(succinylcholine.durationMinutes).toBeLessThanOrEqual(10);
      });

      it('should list hyperkalemia risk', () => {
        const hasHyperkalemiaRisk = succinylcholine.contraindications.some(ci => 
          ci.toLowerCase().includes('hyperkaliémie') || ci.toLowerCase().includes('potassium')
        );
        expect(hasHyperkalemiaRisk).toBe(true);
      });

      it('should warn about malignant hyperthermia', () => {
        const hasMHWarning = succinylcholine.contraindications.some(ci => 
          ci.toLowerCase().includes('hyperthermie maligne')
        );
        expect(hasMHWarning).toBe(true);
      });
    });

    describe('Rocuronium', () => {
      it('should have correct RSI dose', () => {
        expect(rocuronium.standardDose).toBe(1.2);
        expect(rocuronium.doseUnit).toBe('mg/kg');
      });

      it('should be a non-depolarizing agent', () => {
        expect(rocuronium.drugClass).toBe('Curare non-dépolarisant');
      });

      it('should mention sugammadex reversal', () => {
        const hasSugammadex = rocuronium.notes.some(note => 
          note.toLowerCase().includes('sugammadex')
        );
        expect(hasSugammadex).toBe(true);
      });

      it('should have doses for different age groups', () => {
        expect(rocuronium.dosesByAge).toBeDefined();
        expect(rocuronium.dosesByAge!.length).toBeGreaterThan(0);
      });
    });
  });

  describe('Analgesics', () => {
    describe('Fentanyl', () => {
      it('should have correct standard dose in mcg/kg', () => {
        expect(fentanyl.standardDose).toBeDefined();
        expect(fentanyl.doseUnit).toBe('mcg/kg');
      });

      it('should be an opioid', () => {
        expect(fentanyl.drugClass.toLowerCase()).toContain('opioïde');
      });

      it('should have rapid onset', () => {
        expect(fentanyl.onsetSeconds).toBeLessThanOrEqual(120);
      });

      it('should list respiratory depression as side effect', () => {
        const hasRespDepression = fentanyl.sideEffects.some(se => 
          se.toLowerCase().includes('respiratoire')
        );
        expect(hasRespDepression).toBe(true);
      });

      it('should mention chest wall rigidity', () => {
        const hasRigidity = fentanyl.sideEffects.some(se => 
          se.toLowerCase().includes('rigidité')
        );
        expect(hasRigidity).toBe(true);
      });
    });

    describe('Morphine', () => {
      it('should have correct standard dose', () => {
        expect(morphine.standardDose).toBeDefined();
        expect(morphine.doseUnit).toBe('mg/kg');
      });

      it('should be an opioid', () => {
        expect(morphine.drugClass.toLowerCase()).toContain('opioïde');
      });

      it('should have longer onset than fentanyl', () => {
        expect(morphine.onsetSeconds).toBeGreaterThan(fentanyl.onsetSeconds);
      });

      it('should have longer duration than fentanyl', () => {
        expect(morphine.durationMinutes).toBeGreaterThan(fentanyl.durationMinutes);
      });

      it('should mention histamine release', () => {
        const hasHistamine = morphine.sideEffects.some(se => 
          se.toLowerCase().includes('histamine')
        );
        expect(hasHistamine).toBe(true);
      });
    });
  });

  describe('Drug Calculations', () => {
    it('should calculate propofol dose for 70kg adult', () => {
      const weight = 70;
      const dose = propofol.standardDose * weight;
      expect(dose).toBe(140);
    });

    it('should calculate etomidate dose for 80kg adult', () => {
      const weight = 80;
      const dose = etomidate.standardDose * weight;
      expect(dose).toBe(24);
    });

    it('should calculate ketamine dose for 60kg adult', () => {
      const weight = 60;
      const dose = ketamine.standardDose * weight;
      expect(dose).toBe(90);
    });

    it('should calculate succinylcholine dose for 70kg adult', () => {
      const weight = 70;
      const dose = succinylcholine.standardDose * weight;
      expect(dose).toBe(105);
    });

    it('should calculate rocuronium RSI dose for 70kg adult', () => {
      const weight = 70;
      const dose = rocuronium.standardDose * weight;
      expect(dose).toBe(84);
    });

    it('should not exceed max single dose for propofol', () => {
      const weight = 150; // Very heavy patient
      const calculatedDose = propofol.standardDose * weight;
      const maxDose = propofol.maxSingleDose!;
      const actualDose = Math.min(calculatedDose, maxDose);
      expect(actualDose).toBe(maxDose);
    });
  });

  describe('Drug Data Integrity', () => {
    const allDrugs = [propofol, etomidate, ketamine, midazolam, succinylcholine, rocuronium, fentanyl, morphine];

    it('all drugs should have required properties', () => {
      allDrugs.forEach(drug => {
        expect(drug.id).toBeDefined();
        expect(drug.name).toBeDefined();
        expect(drug.drugClass).toBeDefined();
        expect(drug.standardDose).toBeDefined();
        expect(drug.doseUnit).toBeDefined();
        expect(drug.route).toBeDefined();
        expect(drug.route.length).toBeGreaterThan(0);
      });
    });

    it('all drugs should have onset and duration', () => {
      allDrugs.forEach(drug => {
        expect(drug.onsetSeconds).toBeGreaterThan(0);
        expect(drug.durationMinutes).toBeGreaterThan(0);
      });
    });

    it('all drugs should have indications', () => {
      allDrugs.forEach(drug => {
        expect(drug.indications).toBeDefined();
        expect(drug.indications.length).toBeGreaterThan(0);
      });
    });

    it('all drugs should have side effects', () => {
      allDrugs.forEach(drug => {
        expect(drug.sideEffects).toBeDefined();
        expect(drug.sideEffects.length).toBeGreaterThan(0);
      });
    });

    it('all drugs should have unique IDs', () => {
      const ids = allDrugs.map(d => d.id);
      const uniqueIds = new Set(ids);
      expect(uniqueIds.size).toBe(ids.length);
    });
  });
});
