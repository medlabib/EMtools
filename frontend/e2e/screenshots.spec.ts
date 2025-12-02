import { test, expect } from '@playwright/test';

const pages = [
  { name: 'Home', path: '/' },
  { name: 'Login', path: '/login' },
  { name: 'Register', path: '/register' },
  { name: 'Tools', path: '/tools' },
  { name: 'BloodGas', path: '/tools/bloodgas' },
  { name: 'VasoactiveDrugs', path: '/tools/vasoactive' },
  { name: 'Sedation', path: '/tools/sedation' },
  { name: 'MetabolicDisorders', path: '/tools/metabolic' },
  { name: 'MedicalCalculator', path: '/tools/calculator' },
  { name: 'AntibioticGuide', path: '/tools/antibiotic' },
  { name: 'MedicalReport', path: '/tools/report' },
  { name: 'Pastebin', path: '/tools/pastebin' },
];

// Screenshot each page at different viewports
for (const page of pages) {
  test(`Screenshot ${page.name} page`, async ({ page: browserPage }) => {
    await browserPage.goto(page.path);
    
    // Wait for page to fully load
    await browserPage.waitForLoadState('networkidle');
    
    // Wait a bit more for any animations
    await browserPage.waitForTimeout(500);
    
    // Take full page screenshot
    await browserPage.screenshot({
      path: `screenshots/${page.name.toLowerCase()}.png`,
      fullPage: true,
    });
  });
}

// Test tool functionality with interactions
test('BloodGas - Fill form and capture results', async ({ page }) => {
  await page.goto('/tools/bloodgas');
  await page.waitForLoadState('networkidle');
  
  // Fill in some values
  await page.fill('input[name="ph"]', '7.35');
  await page.fill('input[name="paco2"]', '40');
  await page.fill('input[name="hco3"]', '24');
  await page.fill('input[name="pao2"]', '95');
  await page.fill('input[name="lactate"]', '1.5');
  
  await page.waitForTimeout(500);
  await page.screenshot({ path: 'screenshots/bloodgas-filled.png', fullPage: true });
});

test('VasoactiveDrugs - Select drug and capture', async ({ page }) => {
  await page.goto('/tools/vasoactive');
  await page.waitForLoadState('networkidle');
  
  // Click first drug card if visible
  const drugCard = page.locator('.card').first();
  if (await drugCard.isVisible()) {
    await drugCard.click();
    await page.waitForTimeout(500);
    await page.screenshot({ path: 'screenshots/vasoactive-selected.png', fullPage: true });
  }
});

test('Sedation - Navigate tabs', async ({ page }) => {
  await page.goto('/tools/sedation');
  await page.waitForLoadState('networkidle');
  
  // Screenshot main view
  await page.screenshot({ path: 'screenshots/sedation-main.png', fullPage: true });
  
  // Click on different tabs if present
  const tabs = page.locator('.tabs .tab, [role="tab"], button:has-text("RASS"), button:has-text("Richmond")');
  const tabCount = await tabs.count();
  
  for (let i = 0; i < Math.min(tabCount, 3); i++) {
    await tabs.nth(i).click();
    await page.waitForTimeout(300);
    await page.screenshot({ path: `screenshots/sedation-tab-${i}.png`, fullPage: true });
  }
});

test('MetabolicDisorders - Navigate electrolytes', async ({ page }) => {
  await page.goto('/tools/metabolic');
  await page.waitForLoadState('networkidle');
  
  await page.screenshot({ path: 'screenshots/metabolic-main.png', fullPage: true });
  
  // Click on different electrolyte tabs
  const tabButtons = page.locator('.tab-btn, [role="tab"], button');
  const count = await tabButtons.count();
  
  for (let i = 0; i < Math.min(count, 5); i++) {
    const btn = tabButtons.nth(i);
    const text = await btn.textContent();
    if (text && (text.includes('K') || text.includes('Na') || text.includes('Ca') || text.includes('Mg') || text.includes('Phos'))) {
      await btn.click();
      await page.waitForTimeout(300);
      await page.screenshot({ path: `screenshots/metabolic-${text.trim().toLowerCase().replace(/[^a-z]/g, '')}.png`, fullPage: true });
    }
  }
});

test('MedicalCalculator - Test calculators', async ({ page }) => {
  await page.goto('/tools/calculator');
  await page.waitForLoadState('networkidle');
  
  await page.screenshot({ path: 'screenshots/calculator-main.png', fullPage: true });
});

test('AntibioticGuide - Browse antibiotics', async ({ page }) => {
  await page.goto('/tools/antibiotic');
  await page.waitForLoadState('networkidle');
  
  await page.screenshot({ path: 'screenshots/antibiotic-main.png', fullPage: true });
  
  // Click on first antibiotic card
  const card = page.locator('.card, button').first();
  if (await card.isVisible()) {
    await card.click();
    await page.waitForTimeout(500);
    await page.screenshot({ path: 'screenshots/antibiotic-selected.png', fullPage: true });
  }
});

test('MedicalReport - Form states', async ({ page }) => {
  await page.goto('/tools/report');
  await page.waitForLoadState('networkidle');
  
  await page.screenshot({ path: 'screenshots/report-empty.png', fullPage: true });
  
  // Fill some fields
  await page.fill('input[type="text"]', 'Test Patient');
  await page.waitForTimeout(300);
  await page.screenshot({ path: 'screenshots/report-partial.png', fullPage: true });
});

test('Pastebin - Create paste interface', async ({ page }) => {
  await page.goto('/tools/pastebin');
  await page.waitForLoadState('networkidle');
  
  await page.screenshot({ path: 'screenshots/pastebin-main.png', fullPage: true });
});
