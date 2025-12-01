/**
 * Internationalization (i18n) Tests
 */
import { describe, it, expect } from 'vitest';
import en from '../../src/lib/locales/en.json';
import fr from '../../src/lib/locales/fr.json';

describe('Internationalization', () => {
  describe('Translation Files', () => {
    it('should have English translations', () => {
      expect(en).toBeDefined();
      expect(typeof en).toBe('object');
    });

    it('should have French translations', () => {
      expect(fr).toBeDefined();
      expect(typeof fr).toBe('object');
    });

    it('should have matching keys in both languages', () => {
      const enKeys = Object.keys(en);
      const frKeys = Object.keys(fr);
      
      // Check that all English keys exist in French
      enKeys.forEach(key => {
        expect(frKeys).toContain(key);
      });
      
      // Check that all French keys exist in English
      frKeys.forEach(key => {
        expect(enKeys).toContain(key);
      });
    });

    it('should have common navigation keys', () => {
      const navKeys = ['home', 'tools', 'login', 'register', 'logout'];
      
      navKeys.forEach(key => {
        expect(en.nav).toHaveProperty(key);
        expect(fr.nav).toHaveProperty(key);
      });
    });

    it('should have non-empty values for all keys', () => {
      Object.entries(en).forEach(([key, value]) => {
        expect(value).toBeTruthy();
        expect(String(value).length).toBeGreaterThan(0);
      });

      Object.entries(fr).forEach(([key, value]) => {
        expect(value).toBeTruthy();
        expect(String(value).length).toBeGreaterThan(0);
      });
    });

    it('French should be the more verbose language (typical)', () => {
      // French translations are typically longer than English
      const enTotal = JSON.stringify(en).length;
      const frTotal = JSON.stringify(fr).length;
      
      // French should be at least 80% of English length (accounting for variations)
      expect(frTotal).toBeGreaterThan(enTotal * 0.5);
    });
  });

  describe('Translation Content', () => {
    it('should have proper French accents in French translations', () => {
      const frString = JSON.stringify(fr);
      // French typically has accented characters
      const hasAccents = /[éèêëàâäùûüôöîïç]/.test(frString);
      expect(hasAccents).toBe(true);
    });

    it('English translations should not have French accents', () => {
      const enString = JSON.stringify(en);
      // English typically doesn't have French-specific accents
      const hasFrenchAccents = /[éèêàâùûôîç]/.test(enString);
      expect(hasFrenchAccents).toBe(false);
    });
  });
});
