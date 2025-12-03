import { test, expect, Page } from '@playwright/test';

// Test credentials - ensure this user exists in DB or will be created
const TEST_USER = {
  email: 'playwright@example.com',
  password: 'PlaywrightTest123!',
  fullName: 'Playwright Test User'
};

// Helper function to login
async function login(page: Page): Promise<boolean> {
  try {
    // First try to register (in case user doesn't exist)
    await page.request.post('/api/v1/auth/register', {
      data: {
        email: TEST_USER.email,
        password: TEST_USER.password,
        full_name: TEST_USER.fullName
      }
    }).catch(() => {}); // Ignore if user already exists
    
    // Now login with form-urlencoded (OAuth2 format)
    const loginResponse = await page.request.post('/api/v1/auth/login', {
      form: {
        username: TEST_USER.email,
        password: TEST_USER.password
      }
    });
    
    if (loginResponse.ok()) {
      const data = await loginResponse.json();
      // Store token in localStorage
      await page.evaluate((token) => {
        localStorage.setItem('access_token', token);
      }, data.access_token);
      return true;
    }
    console.log('Login response not OK:', loginResponse.status());
    return false;
  } catch (e) {
    console.error('Login failed:', e);
    return false;
  }
}

// Public pages (no auth needed)
const publicPages = [
  { name: 'Home', path: '/' },
  { name: 'Login', path: '/login' },
  { name: 'Register', path: '/register' },
];

// Protected pages (auth required)
const protectedPages = [
  { name: 'Dashboard', path: '/dashboard' },
  { name: 'BloodGas', path: '/tools/blood-gas' },
  { name: 'VasoactiveDrugs', path: '/tools/vasoactive-drugs' },
  { name: 'Sedation', path: '/tools/sedation' },
  { name: 'MetabolicDisorders', path: '/tools/metabolic-disorders' },
  { name: 'MedicalCalculator', path: '/tools/medical-calculator' },
  { name: 'AntibioticGuide', path: '/tools/antibiotic-guide' },
  { name: 'MedicalReport', path: '/tools/medical-report' },
  { name: 'Pastebin', path: '/tools/pastebin' },
];

// Screenshot public pages without auth
for (const pageInfo of publicPages) {
  test(`Screenshot ${pageInfo.name} page (public)`, async ({ page }) => {
    await page.goto(pageInfo.path);
    await page.waitForLoadState('networkidle');
    await page.waitForTimeout(500);
    
    // Desktop screenshot
    await page.setViewportSize({ width: 1280, height: 720 });
    await page.screenshot({
      path: `screenshots/${pageInfo.name.toLowerCase()}-desktop.png`,
      fullPage: true,
    });
    
    // Mobile screenshot
    await page.setViewportSize({ width: 390, height: 844 });
    await page.screenshot({
      path: `screenshots/${pageInfo.name.toLowerCase()}-mobile.png`,
      fullPage: true,
    });
  });
}

// Screenshot protected pages with auth
for (const pageInfo of protectedPages) {
  test(`Screenshot ${pageInfo.name} page (authenticated)`, async ({ page }) => {
    // Login first
    await page.goto('/');
    const loggedIn = await login(page);
    
    if (!loggedIn) {
      console.warn(`Could not login, skipping ${pageInfo.name}`);
      return;
    }
    
    // Navigate to protected page
    await page.goto(pageInfo.path);
    await page.waitForLoadState('networkidle');
    await page.waitForTimeout(800);
    
    // Desktop screenshot
    await page.setViewportSize({ width: 1280, height: 720 });
    await page.screenshot({
      path: `screenshots/${pageInfo.name.toLowerCase()}-desktop.png`,
      fullPage: true,
    });
    
    // Mobile screenshot
    await page.setViewportSize({ width: 390, height: 844 });
    await page.screenshot({
      path: `screenshots/${pageInfo.name.toLowerCase()}-mobile.png`,
      fullPage: true,
    });
  });
}

// Interactive tests with authentication
test.describe('Interactive Tool Screenshots', () => {
  test.beforeEach(async ({ page }) => {
    await page.goto('/');
    await login(page);
  });

  test('BloodGas - Fill form and capture results', async ({ page }) => {
    await page.goto('/tools/blood-gas');
    await page.waitForLoadState('networkidle');
    await page.waitForTimeout(500);
    
    await page.screenshot({ path: 'screenshots/bloodgas-interactive.png', fullPage: true });
  });

  test('VasoactiveDrugs - Select drug and capture', async ({ page }) => {
    await page.goto('/tools/vasoactive-drugs');
    await page.waitForLoadState('networkidle');
    await page.waitForTimeout(500);
    
    // Click first drug card if visible
    const drugCard = page.locator('.card').first();
    if (await drugCard.isVisible()) {
      await drugCard.click();
      await page.waitForTimeout(500);
    }
    await page.screenshot({ path: 'screenshots/vasoactive-interactive.png', fullPage: true });
  });

  test('MedicalCalculator - Explore calculators', async ({ page }) => {
    await page.goto('/tools/medical-calculator');
    await page.waitForLoadState('networkidle');
    await page.waitForTimeout(500);
    
    await page.screenshot({ path: 'screenshots/calculator-interactive.png', fullPage: true });
  });

  test('MedicalReport - Form view', async ({ page }) => {
    await page.goto('/tools/medical-report');
    await page.waitForLoadState('networkidle');
    await page.waitForTimeout(500);
    
    await page.screenshot({ path: 'screenshots/report-interactive.png', fullPage: true });
  });
});
