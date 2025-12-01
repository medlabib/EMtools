import { render, screen, fireEvent } from '@testing-library/svelte';
import { describe, it, expect, vi } from 'vitest';
import MedicalCalculator from '../../src/lib/pages/tools/MedicalCalculator.svelte';

// Mock the calculators module to avoid dependency on actual data
vi.mock('../../src/lib/pages/tools/calculators', () => {
  const mockCalculator = {
    id: 'test-calc',
    name: 'Test Calculator',
    shortName: 'Test',
    description: 'A test calculator',
    category: 'trauma',
    fields: [
      { id: 'field1', type: 'number', label: 'Field 1', min: 0, max: 10 },
      { id: 'field2', type: 'checkbox', label: 'Field 2' }
    ],
    calculate: vi.fn().mockReturnValue(5),
    interpretations: [
      { range: [0, 10], label: 'Normal', description: 'Normal range', color: 'green' }
    ]
  };

  return {
    allCalculators: [mockCalculator],
    calculatorsByCategory: { trauma: [mockCalculator] },
    categoryLabels: { trauma: 'Traumatologie' },
    getCalculatorById: vi.fn().mockReturnValue(mockCalculator),
    searchCalculators: vi.fn().mockReturnValue([mockCalculator])
  };
});

describe('MedicalCalculator Component', () => {
  it('renders the header and search box', () => {
    render(MedicalCalculator);
    expect(screen.getByText('Calculateurs Médicaux')).toBeTruthy();
    expect(screen.getByPlaceholderText('Rechercher un score...')).toBeTruthy();
  });

  it('renders calculator cards', () => {
    render(MedicalCalculator);
    expect(screen.getByRole('heading', { name: 'Test Calculator' })).toBeTruthy();
    // "Traumatologie" appears in filter button and card badge
    const elements = screen.getAllByText('Traumatologie');
    expect(elements.length).toBeGreaterThan(0);
  });

  it('navigates to calculator detail on click', async () => {
    render(MedicalCalculator);
    const card = screen.getByText('Test Calculator');
    await fireEvent.click(card);
    
    // Check if detail view is shown
    expect(screen.getByText('A test calculator')).toBeTruthy();
    expect(screen.getByText('Calculer')).toBeTruthy();
  });

  it('performs calculation', async () => {
    render(MedicalCalculator);
    const card = screen.getByText('Test Calculator');
    await fireEvent.click(card);

    const calculateBtn = screen.getByText('Calculer');
    await fireEvent.click(calculateBtn);

    // Check result
    expect(screen.getByText('Score')).toBeTruthy();
    expect(screen.getByText('5')).toBeTruthy();
    expect(screen.getByText('Normal')).toBeTruthy();
  });
});
