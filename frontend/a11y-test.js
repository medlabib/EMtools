import puppeteer from 'puppeteer';
import { getCompliance } from 'accessibility-checker';

const PAGES_TO_TEST = [
  { url: 'http://localhost/', name: 'Home' },
  { url: 'http://localhost/login', name: 'Login' },
  { url: 'http://localhost/register', name: 'Register' },
];

const PROTECTED_PAGES = [
  { url: 'http://localhost/dashboard', name: 'Dashboard' },
  { url: 'http://localhost/tools/medical-report', name: 'Medical Report' },
  { url: 'http://localhost/tools/medical-calculator', name: 'Medical Calculator' },
  { url: 'http://localhost/tools/antibiotic-guide', name: 'Antibiotic Guide' },
  { url: 'http://localhost/tools/metabolic-disorders', name: 'Metabolic Disorders' },
  { url: 'http://localhost/tools/blood-gas', name: 'Blood Gas' },
  { url: 'http://localhost/tools/sedation', name: 'Sedation' },
  { url: 'http://localhost/tools/vasoactive-drugs', name: 'Vasoactive Drugs' },
  { url: 'http://localhost/tools/pastebin', name: 'Pastebin' },
];

async function loginAndTest() {
  const browser = await puppeteer.launch();
  const page = await browser.newPage();

  try {
    // Login first
    console.log('🔐 Logging in...');
    await page.goto('http://localhost/login');
    await page.fill('input[placeholder="email@example.com"]', 'admin@test.com');
    await page.fill('input[placeholder="••••••••"]', 'Test123456!!');
    await page.click('button:has-text("Login")');
    await page.waitForNavigation();
    console.log('✅ Logged in successfully\n');

    // Test protected pages
    console.log('📋 Testing Protected Pages:\n');
    for (const pageConfig of PROTECTED_PAGES) {
      await testPage(page, pageConfig);
    }
  } finally {
    await browser.close();
  }
}

async function testPublicPages() {
  const browser = await puppeteer.launch();
  const page = await browser.newPage();

  try {
    console.log('📋 Testing Public Pages:\n');
    for (const pageConfig of PAGES_TO_TEST) {
      await testPage(page, pageConfig);
    }
  } finally {
    await browser.close();
  }
}

async function testPage(page, pageConfig) {
  try {
    console.log(`🔍 Testing: ${pageConfig.name}`);
    await page.goto(pageConfig.url, { waitUntil: 'networkidle2' });
    
    // Get accessibility results
    const results = await page.evaluate(() => {
      return {
        title: document.title,
        headings: document.querySelectorAll('h1, h2, h3, h4, h5, h6').length,
        buttons: document.querySelectorAll('button').length,
        inputs: document.querySelectorAll('input, select, textarea').length,
        links: document.querySelectorAll('a').length,
        images: document.querySelectorAll('img').length,
      };
    });

    console.log(`   ├─ Headings: ${results.headings}`);
    console.log(`   ├─ Buttons: ${results.buttons}`);
    console.log(`   ├─ Form inputs: ${results.inputs}`);
    console.log(`   ├─ Links: ${results.links}`);
    console.log(`   └─ Images: ${results.images}`);

    // Run accessibility checker
    const report = await getCompliance(page, 'WCAG_2_1_Level_AA');
    
    if (report.issues && report.issues.length > 0) {
      console.log(`   ⚠️  Found ${report.issues.length} accessibility issues:`);
      report.issues.slice(0, 3).forEach((issue) => {
        console.log(`       • ${issue.ruleId}: ${issue.message}`);
      });
      if (report.issues.length > 3) {
        console.log(`       ... and ${report.issues.length - 3} more`);
      }
    } else {
      console.log(`   ✅ No major accessibility issues found`);
    }
    console.log('');
  } catch (error) {
    console.error(`   ❌ Error testing ${pageConfig.name}: ${error.message}\n`);
  }
}

(async () => {
  console.log('🚀 Starting Accessibility Tests\n');
  await testPublicPages();
  await loginAndTest();
  console.log('✨ Tests complete!');
})();
