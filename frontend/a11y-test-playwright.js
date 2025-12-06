import { chromium } from 'playwright';
import fs from 'fs';

const PAGES_TO_TEST = [
  { url: 'http://localhost:5173/', name: 'Home', requiresAuth: false },
  { url: 'http://localhost:5173/login', name: 'Login', requiresAuth: false },
  { url: 'http://localhost:5173/register', name: 'Register', requiresAuth: false },
];

const PROTECTED_PAGES = [
  { url: 'http://localhost:5173/dashboard', name: 'Dashboard' },
  { url: 'http://localhost:5173/tools/medical-report', name: 'Medical Report' },
  { url: 'http://localhost:5173/tools/medical-calculator', name: 'Medical Calculator' },
  { url: 'http://localhost:5173/tools/antibiotic-guide', name: 'Antibiotic Guide' },
  { url: 'http://localhost:5173/tools/metabolic-disorders', name: 'Metabolic Disorders' },
  { url: 'http://localhost:5173/tools/blood-gas', name: 'Blood Gas' },
  { url: 'http://localhost:5173/tools/sedation', name: 'Sedation' },
  { url: 'http://localhost:5173/tools/vasoactive-drugs', name: 'Vasoactive Drugs' },
  { url: 'http://localhost:5173/tools/pastebin', name: 'Pastebin' },
];

const results = [];

async function testPage(page, pageConfig) {
  try {
    console.log(`🔍 Testing: ${pageConfig.name}`);
    await page.goto(pageConfig.url, { waitUntil: 'networkidle' });
    
    // Collect accessibility metrics
    const metrics = await page.evaluate(() => {
      const issues = [];
      
      // Check for images without alt text
      document.querySelectorAll('img').forEach((img) => {
        if (!img.alt || img.alt.trim() === '') {
          issues.push({
            type: 'missing-alt',
            element: 'img',
            text: `Image missing alt text: ${img.src.substring(0, 50)}`,
            severity: 'warning',
          });
        }
      });

      // Check for buttons without text/aria-label
      document.querySelectorAll('button').forEach((btn) => {
        const hasText = btn.textContent.trim().length > 0;
        const hasAria = btn.getAttribute('aria-label');
        if (!hasText && !hasAria) {
          issues.push({
            type: 'button-no-text',
            element: 'button',
            text: 'Button missing accessible text',
            severity: 'error',
          });
        }
      });

      // Check for form inputs without labels
      document.querySelectorAll('input, select, textarea').forEach((input) => {
        const inputId = input.getAttribute('id');
        const hasLabel = inputId && document.querySelector(`label[for="${inputId}"]`);
        const hasAria = input.getAttribute('aria-label');
        const hasPlaceholder = input.getAttribute('placeholder');
        
        if (!hasLabel && !hasAria && !hasPlaceholder) {
          issues.push({
            type: 'form-no-label',
            element: input.tagName,
            text: 'Form input missing associated label',
            severity: 'error',
          });
        }
      });

      // Check for proper heading structure
      const headings = Array.from(document.querySelectorAll('h1, h2, h3, h4, h5, h6')).map(h => h.tagName);
      let headingIssue = false;
      for (let i = 1; i < headings.length; i++) {
        const curr = parseInt(headings[i][1]);
        const prev = parseInt(headings[i-1][1]);
        if (curr - prev > 1) {
          headingIssue = true;
          issues.push({
            type: 'heading-skip',
            element: 'headings',
            text: `Heading hierarchy skipped from H${prev} to H${curr}`,
            severity: 'warning',
          });
          break;
        }
      }

      // Check for links with no text
      document.querySelectorAll('a').forEach((link) => {
        const hasText = link.textContent.trim().length > 0;
        const hasAria = link.getAttribute('aria-label');
        if (!hasText && !hasAria) {
          issues.push({
            type: 'link-no-text',
            element: 'a',
            text: 'Link missing accessible text',
            severity: 'error',
          });
        }
      });

      return {
        title: document.title,
        lang: document.documentElement.lang || 'not set',
        headings: document.querySelectorAll('h1, h2, h3, h4, h5, h6').length,
        h1: document.querySelectorAll('h1').length,
        buttons: document.querySelectorAll('button').length,
        inputs: document.querySelectorAll('input, select, textarea').length,
        links: document.querySelectorAll('a').length,
        images: document.querySelectorAll('img').length,
        issues,
      };
    });

    console.log(`   ├─ Title: ${metrics.title}`);
    console.log(`   ├─ Language: ${metrics.lang}`);
    console.log(`   ├─ Headings: ${metrics.headings} (H1: ${metrics.h1})`);
    console.log(`   ├─ Buttons: ${metrics.buttons}`);
    console.log(`   ├─ Inputs: ${metrics.inputs}`);
    console.log(`   ├─ Links: ${metrics.links}`);
    console.log(`   └─ Images: ${metrics.images}`);

    if (metrics.issues.length > 0) {
      console.log(`   ⚠️  Found ${metrics.issues.length} accessibility issues:`);
      metrics.issues.slice(0, 3).forEach((issue) => {
        const emoji = issue.severity === 'error' ? '❌' : '⚠️ ';
        console.log(`       ${emoji} [${issue.type}] ${issue.text}`);
      });
      if (metrics.issues.length > 3) {
        console.log(`       ... and ${metrics.issues.length - 3} more`);
      }
    } else {
      console.log(`   ✅ No detected accessibility issues`);
    }

    results.push({
      page: pageConfig.name,
      url: pageConfig.url,
      ...metrics,
    });

    console.log('');
  } catch (error) {
    console.error(`   ❌ Error testing ${pageConfig.name}: ${error.message}\n`);
    results.push({
      page: pageConfig.name,
      url: pageConfig.url,
      error: error.message,
    });
  }
}

async function runTests() {
  const browser = await chromium.launch();
  const context = await browser.createBrowserContext();
  const page = await context.newPage();

  try {
    console.log('🚀 Starting Accessibility Tests\n');
    console.log('📋 Testing Public Pages:\n');

    for (const pageConfig of PAGES_TO_TEST) {
      await testPage(page, pageConfig);
    }

    console.log('\n🔐 Logging in to test protected pages...');
    await page.goto('http://localhost:5173/login', { waitUntil: 'networkidle' });
    await page.fill('input[placeholder="email@example.com"]', 'admin@test.com');
    await page.fill('input[placeholder="••••••••"]', 'Test123456!!');
    await page.click('button:has-text("Login")');
    await page.waitForNavigation();
    console.log('✅ Logged in\n');

    console.log('📋 Testing Protected Pages:\n');
    for (const pageConfig of PROTECTED_PAGES) {
      await testPage(page, pageConfig);
    }

    // Save results to file
    fs.writeFileSync('a11y-results.json', JSON.stringify(results, null, 2));
    console.log('📊 Results saved to a11y-results.json');

  } finally {
    await browser.close();
  }
}

(async () => {
  await runTests();
  console.log('\n✨ Accessibility tests complete!');
  process.exit(0);
})();
