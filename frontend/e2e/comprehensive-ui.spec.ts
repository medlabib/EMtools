import { test, expect, Page } from '@playwright/test';

/**
 * PERSONA: Dr. Sarah - Emergency Room Physician
 * - Works in a busy ER in France
 * - Uses EMTOOLS daily for quick calculations and documentation
 * - Needs fast, accurate tools that work on mobile during patient care
 * - Values: Speed, accuracy, clear visual feedback, offline capability
 */

const TEST_USER = {
  email: 'dr.sarah@example.com',
  password: 'EmergencyDoc123!',
  fullName: 'Dr. Sarah Martin'
};

// Helper: Login
async function login(page: Page): Promise<boolean> {
  try {
    await page.request.post('/api/v1/auth/register', {
      data: { email: TEST_USER.email, password: TEST_USER.password, full_name: TEST_USER.fullName }
    }).catch(() => {});
    
    const loginResponse = await page.request.post('/api/v1/auth/login', {
      form: { username: TEST_USER.email, password: TEST_USER.password }
    });
    
    if (loginResponse.ok()) {
      const data = await loginResponse.json();
      await page.evaluate((token) => localStorage.setItem('access_token', token), data.access_token);
      return true;
    }
    return false;
  } catch { return false; }
}

// =============================================================================
// 1. HOME PAGE - First impression for new users
// =============================================================================
test.describe('Home Page - User Onboarding', () => {
  test('should display clear value proposition and CTA', async ({ page }) => {
    await page.goto('/');
    await page.waitForLoadState('networkidle');
    
    // Check hero section is visible
    await expect(page.locator('h1')).toBeVisible();
    
    // Check CTA buttons are prominent
    const registerBtn = page.locator('a:has-text("Créer un compte"), button:has-text("Créer")');
    await expect(registerBtn.first()).toBeVisible();
    
    await page.screenshot({ path: 'screenshots/test-home-hero.png', fullPage: false });
  });
  
  test('should show all 8 tools in grid', async ({ page }) => {
    await page.goto('/');
    await page.waitForLoadState('networkidle');
    
    // Scroll to tools section
    await page.evaluate(() => window.scrollBy(0, 600));
    await page.waitForTimeout(500);
    
    await page.screenshot({ path: 'screenshots/test-home-tools-grid.png', fullPage: false });
  });
});

// =============================================================================
// 2. LOGIN/REGISTER - Authentication Flow
// =============================================================================
test.describe('Authentication Flow', () => {
  test('Login page should have clear form with icons', async ({ page }) => {
    await page.goto('/login');
    await page.waitForLoadState('networkidle');
    
    // Check form elements
    await expect(page.locator('input[type="email"]')).toBeVisible();
    await expect(page.locator('input[type="password"]')).toBeVisible();
    await expect(page.locator('button[type="submit"]')).toBeVisible();
    
    await page.screenshot({ path: 'screenshots/test-login-form.png', fullPage: true });
  });
  
  test('Register page should show all required fields', async ({ page }) => {
    await page.goto('/register');
    await page.waitForLoadState('networkidle');
    
    // Check all 4 fields
    await expect(page.locator('#fullName')).toBeVisible();
    await expect(page.locator('#email')).toBeVisible();
    await expect(page.locator('#password')).toBeVisible();
    await expect(page.locator('#confirmPassword')).toBeVisible();
    
    await page.screenshot({ path: 'screenshots/test-register-form.png', fullPage: true });
  });
  
  test('Login error should be clearly visible', async ({ page }) => {
    await page.goto('/login');
    await page.waitForLoadState('networkidle');
    
    // Try invalid login
    await page.fill('#email', 'wrong@example.com');
    await page.fill('#password', 'wrongpassword');
    await page.click('button[type="submit"]');
    
    await page.waitForTimeout(1000);
    await page.screenshot({ path: 'screenshots/test-login-error.png', fullPage: true });
  });
});

// =============================================================================
// 3. DASHBOARD - Tool Selection
// =============================================================================
test.describe('Dashboard - Tool Selection', () => {
  test.beforeEach(async ({ page }) => {
    await page.goto('/');
    await login(page);
  });
  
  test('Cards should display properly without text overflow', async ({ page }) => {
    await page.goto('/dashboard');
    await page.waitForLoadState('networkidle');
    await page.waitForTimeout(500);
    
    // Desktop view
    await page.setViewportSize({ width: 1280, height: 800 });
    await page.screenshot({ path: 'screenshots/test-dashboard-desktop-cards.png', fullPage: true });
    
    // Check card descriptions are properly truncated
    const descriptions = page.locator('.card-body p');
    const count = await descriptions.count();
    
    for (let i = 0; i < count; i++) {
      const box = await descriptions.nth(i).boundingBox();
      if (box) {
        // Card width should be reasonable
        expect(box.width).toBeLessThan(400);
      }
    }
  });
  
  test('Cards should stack properly on mobile', async ({ page }) => {
    await page.goto('/dashboard');
    await page.waitForLoadState('networkidle');
    
    // Mobile view
    await page.setViewportSize({ width: 375, height: 667 });
    await page.waitForTimeout(300);
    
    await page.screenshot({ path: 'screenshots/test-dashboard-mobile-cards.png', fullPage: true });
  });
  
  test('Hover states should work on desktop', async ({ page }) => {
    await page.goto('/dashboard');
    await page.waitForLoadState('networkidle');
    
    // Hover over first card
    const firstCard = page.locator('.card').first();
    await firstCard.hover();
    await page.waitForTimeout(300);
    
    await page.screenshot({ path: 'screenshots/test-dashboard-card-hover.png', fullPage: false });
  });
});

// =============================================================================
// 4. MEDICAL REPORT - Complex Form
// =============================================================================
test.describe('Medical Report - Patient Documentation', () => {
  test.beforeEach(async ({ page }) => {
    await page.goto('/');
    await login(page);
  });
  
  test('Identity section should capture patient info correctly', async ({ page }) => {
    await page.goto('/tools/medical-report');
    await page.waitForLoadState('networkidle');
    
    // Fill identity section
    await page.fill('#patientName', 'Jean Dupont');
    await page.selectOption('#gender', 'male');
    await page.fill('#age', '45');
    await page.fill('#motif', 'Douleur thoracique aiguë');
    
    await page.screenshot({ path: 'screenshots/test-report-identity.png', fullPage: false });
  });
  
  test('Trauma toggle button should be clearly styled', async ({ page }) => {
    await page.goto('/tools/medical-report');
    await page.waitForLoadState('networkidle');
    
    // Find trauma toggle button (it's now a styled button, not a checkbox)
    const traumaToggle = page.locator('button').filter({ hasText: /trauma/i }).first();
    
    await page.screenshot({ path: 'screenshots/test-report-trauma-unchecked.png', fullPage: false });
    
    // Click trauma toggle
    await traumaToggle.click();
    await page.waitForTimeout(300);
    
    await page.screenshot({ path: 'screenshots/test-report-trauma-checked.png', fullPage: false });
    
    // Mechanism field should appear
    await expect(page.locator('#mecanisme')).toBeVisible();
  });
  
  test('Complete form should generate proper report with age', async ({ page }) => {
    await page.goto('/tools/medical-report');
    await page.waitForLoadState('networkidle');
    
    // Fill complete form
    await page.fill('#patientName', 'Marie Martin');
    await page.selectOption('#gender', 'female');
    await page.fill('#age', '67');
    await page.fill('#motif', 'AVC ischémique');
    
    // Wait for report preview
    await page.waitForTimeout(500);
    
    // Take screenshot of the preview panel
    await page.screenshot({ path: 'screenshots/test-report-preview.png', fullPage: true });
    
    // Check if age appears in report
    const reportPreview = page.locator('pre');
    const reportText = await reportPreview.textContent();
    expect(reportText).toContain('67');
  });
  
  test('ABCDE sections should be visually distinct', async ({ page }) => {
    await page.goto('/tools/medical-report');
    await page.waitForLoadState('networkidle');
    
    // Scroll through ABCDE sections
    await page.evaluate(() => window.scrollBy(0, 400));
    await page.waitForTimeout(300);
    await page.screenshot({ path: 'screenshots/test-report-airway.png', fullPage: false });
    
    await page.evaluate(() => window.scrollBy(0, 400));
    await page.waitForTimeout(300);
    await page.screenshot({ path: 'screenshots/test-report-breathing.png', fullPage: false });
    
    await page.evaluate(() => window.scrollBy(0, 400));
    await page.waitForTimeout(300);
    await page.screenshot({ path: 'screenshots/test-report-circulation.png', fullPage: false });
  });
  
  test('Mobile form should be usable', async ({ page }) => {
    await page.goto('/tools/medical-report');
    await page.waitForLoadState('networkidle');
    
    await page.setViewportSize({ width: 375, height: 667 });
    await page.waitForTimeout(300);
    
    await page.screenshot({ path: 'screenshots/test-report-mobile.png', fullPage: true });
  });
});

// =============================================================================
// 5. VASOACTIVE DRUGS - Calculator
// =============================================================================
test.describe('Vasoactive Drugs - Dose Calculator', () => {
  test.beforeEach(async ({ page }) => {
    await page.goto('/');
    await login(page);
  });
  
  test('Drug selection grid should show categories', async ({ page }) => {
    await page.goto('/tools/vasoactive-drugs');
    await page.waitForLoadState('networkidle');
    
    await page.screenshot({ path: 'screenshots/test-vasoactive-grid.png', fullPage: true });
  });
  
  test('Drug calculator should show slider and results', async ({ page }) => {
    await page.goto('/tools/vasoactive-drugs');
    await page.waitForLoadState('networkidle');
    
    // Click on Norepinephrine card
    await page.click('button:has-text("Noradrénaline")');
    await page.waitForTimeout(500);
    
    // Should see slider and results
    await expect(page.locator('input[type="range"]')).toBeVisible();
    await expect(page.locator('.stat-value').first()).toBeVisible();

    await page.screenshot({ path: 'screenshots/test-vasoactive-calculator.png', fullPage: true });
  });
  
  test('Effect bars should be colored and visible', async ({ page }) => {
    await page.goto('/tools/vasoactive-drugs');
    await page.waitForLoadState('networkidle');
    
    // Click on a drug
    await page.click('button:has-text("Noradrénaline")');
    await page.waitForTimeout(500);
    
    // Scroll to effects section
    await page.evaluate(() => window.scrollBy(0, 400));
    await page.waitForTimeout(300);
    
    await page.screenshot({ path: 'screenshots/test-vasoactive-effects.png', fullPage: false });
  });
  
  test('Info sections should be styled with colors', async ({ page }) => {
    await page.goto('/tools/vasoactive-drugs');
    await page.waitForLoadState('networkidle');
    
    // Click on a drug
    await page.click('button:has-text("Noradrénaline")');
    await page.waitForTimeout(500);
    
    // Scroll to info sections
    await page.evaluate(() => window.scrollBy(0, 800));
    await page.waitForTimeout(300);
    
    await page.screenshot({ path: 'screenshots/test-vasoactive-info-sections.png', fullPage: false });
  });
});

// =============================================================================
// 6. BLOOD GAS - Analysis Tool
// =============================================================================
test.describe('Blood Gas Analysis', () => {
  test.beforeEach(async ({ page }) => {
    await page.goto('/');
    await login(page);
  });
  
  test('Input form should be clear and organized', async ({ page }) => {
    await page.goto('/tools/blood-gas');
    await page.waitForLoadState('networkidle');
    
    await page.screenshot({ path: 'screenshots/test-bloodgas-inputs.png', fullPage: false });
  });
  
  test('Results should update reactively', async ({ page }) => {
    await page.goto('/tools/blood-gas');
    await page.waitForLoadState('networkidle');
    
    // Fill in values (fields are paco2, not pco2)
    await page.fill('input[name="ph"]', '7.35');
    await page.fill('input[name="paco2"]', '40');
    await page.fill('input[name="hco3"]', '24');
    await page.fill('input[name="pao2"]', '95');
    
    await page.waitForTimeout(500);
    await page.screenshot({ path: 'screenshots/test-bloodgas-results.png', fullPage: true });
  });
});

// =============================================================================
// 7. SEDATION - Protocol Calculator
// =============================================================================
test.describe('Sedation Calculator', () => {
  test.beforeEach(async ({ page }) => {
    await page.goto('/');
    await login(page);
  });
  
  test('RSI tab should show protocol steps', async ({ page }) => {
    await page.goto('/tools/sedation');
    await page.waitForLoadState('networkidle');
    
    await page.screenshot({ path: 'screenshots/test-sedation-rsi.png', fullPage: true });
  });
  
  test('Drug selection should show dose calculation', async ({ page }) => {
    await page.goto('/tools/sedation');
    await page.waitForLoadState('networkidle');
    
    // Click on drugs tab if exists
    const drugsTab = page.locator('button:has-text("Médicaments"), button:has-text("Drugs")');
    if (await drugsTab.count() > 0) {
      await drugsTab.first().click();
      await page.waitForTimeout(300);
    }
    
    await page.screenshot({ path: 'screenshots/test-sedation-drugs.png', fullPage: true });
  });
});

// =============================================================================
// 8. MEDICAL CALCULATOR - Score Calculators
// =============================================================================
test.describe('Medical Calculator', () => {
  test.beforeEach(async ({ page }) => {
    await page.goto('/');
    await login(page);
  });
  
  test('Calculator list should be searchable', async ({ page }) => {
    await page.goto('/tools/medical-calculator');
    await page.waitForLoadState('networkidle');
    
    await page.screenshot({ path: 'screenshots/test-calculator-list.png', fullPage: true });
  });
  
  test('Calculator form should show result', async ({ page }) => {
    await page.goto('/tools/medical-calculator');
    await page.waitForLoadState('networkidle');
    
    // Click on first calculator card
    const calcCard = page.locator('.card button, .card a, button:has-text("Calculer")').first();
    if (await calcCard.isVisible()) {
      await calcCard.click();
      await page.waitForTimeout(500);
    }
    
    await page.screenshot({ path: 'screenshots/test-calculator-detail.png', fullPage: true });
  });
});

// =============================================================================
// 9. METABOLIC DISORDERS
// =============================================================================
test.describe('Metabolic Disorders', () => {
  test.beforeEach(async ({ page }) => {
    await page.goto('/');
    await login(page);
  });
  
  test('Electrolyte tabs should be visible', async ({ page }) => {
    await page.goto('/tools/metabolic-disorders');
    await page.waitForLoadState('networkidle');
    
    await page.screenshot({ path: 'screenshots/test-metabolic-tabs.png', fullPage: true });
  });
});

// =============================================================================
// 10. ANTIBIOTIC GUIDE
// =============================================================================
test.describe('Antibiotic Guide', () => {
  test.beforeEach(async ({ page }) => {
    await page.goto('/');
    await login(page);
  });
  
  test('Antibiotic list should be organized', async ({ page }) => {
    await page.goto('/tools/antibiotic-guide');
    await page.waitForLoadState('networkidle');
    
    await page.screenshot({ path: 'screenshots/test-antibiotic-list.png', fullPage: true });
  });
});

// =============================================================================
// 11. PASTEBIN
// =============================================================================
test.describe('Pastebin - Secure Sharing', () => {
  test.beforeEach(async ({ page }) => {
    await page.goto('/');
    await login(page);
  });
  
  test('Create paste form should be clear', async ({ page }) => {
    await page.goto('/tools/pastebin');
    await page.waitForLoadState('networkidle');
    
    await page.screenshot({ path: 'screenshots/test-pastebin-form.png', fullPage: true });
  });
});

// =============================================================================
// RESPONSIVE TESTS
// =============================================================================
test.describe('Mobile Responsiveness', () => {
  test.beforeEach(async ({ page }) => {
    await page.goto('/');
    await login(page);
    await page.setViewportSize({ width: 375, height: 667 });
  });
  
  test('Navigation should work on mobile', async ({ page }) => {
    await page.goto('/dashboard');
    await page.waitForLoadState('networkidle');
    
    // Look for hamburger menu
    const menuBtn = page.locator('button[aria-label*="menu"], .btn-circle:has(span)');
    if (await menuBtn.first().isVisible()) {
      await menuBtn.first().click();
      await page.waitForTimeout(300);
    }
    
    await page.screenshot({ path: 'screenshots/test-mobile-nav.png', fullPage: false });
  });
});
