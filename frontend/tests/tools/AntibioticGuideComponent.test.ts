import { render, screen, fireEvent } from '@testing-library/svelte';
import { describe, it, expect, vi } from 'vitest';
import AntibioticGuide from '../../src/lib/pages/tools/AntibioticGuide.svelte';

// Mock the antibiotics module
vi.mock('../../src/lib/pages/tools/antibiotics/drugs', () => {
  const mockAntibiotic = {
    id: 'amoxicillin',
    name: 'Amoxicillin',
    genericName: 'Amoxicillin',
    class: 'penicillin',
    spectrum: 'broad',
    route: ['PO', 'IV'],
    indications: ['Otitis', 'Pneumonia'],
    contraindications: ['Allergy'],
    sideEffects: ['Rash'],
    interactions: [],
    renalAdjustment: [],
    standardDose: { adult: '1g', frequency: '8h' },
    availableInTunisia: true
  };

  return {
    antibiotics: [mockAntibiotic],
    getAntibioticById: vi.fn().mockReturnValue(mockAntibiotic),
    searchAntibiotics: vi.fn().mockReturnValue([mockAntibiotic])
  };
});

vi.mock('../../src/lib/pages/tools/antibiotics/types', () => ({
  classLabels: { penicillin: 'Pénicillines' },
  spectrumLabels: { broad: 'Large spectre' },
  qtProlongingDrugs: [],
  nephrotoxicDrugs: []
}));

describe('AntibioticGuide Component', () => {
  it('renders the header and tabs', () => {
    render(AntibioticGuide);
    expect(screen.getByText('💊 Guide Antibiotiques')).toBeTruthy();
    // Tabs now have emojis in separate spans, so look for text content
    expect(screen.getByText(/Recherche/)).toBeTruthy();
    expect(screen.getByText(/Classes/)).toBeTruthy();
  });

  it('renders antibiotic cards in search tab', () => {
    render(AntibioticGuide);
    // Amoxicillin appears in h3 and span
    expect(screen.getAllByText('Amoxicillin').length).toBeGreaterThan(0);
    expect(screen.getAllByText('Pénicillines').length).toBeGreaterThan(0);
  });

  it('navigates to antibiotic detail on click', async () => {
    render(AntibioticGuide);
    // Click the card which contains the text
    const card = screen.getAllByText('Amoxicillin')[0].closest('button');
    if (card) {
      await fireEvent.click(card);
    }
    
    // Check if detail view is shown
    expect(screen.getByText('📋 Posologie')).toBeTruthy();
    expect(screen.getByText('✅ Indications')).toBeTruthy();
  });

  it('switches tabs', async () => {
    render(AntibioticGuide);
    // Find tab by partial text match since emoji is in separate span
    const renalTab = screen.getByText(/Rénal/);
    await fireEvent.click(renalTab);
    
    expect(screen.getByText('DFG estimé (mL/min)')).toBeTruthy();
  });
});
