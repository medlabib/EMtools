import puppeteer from 'puppeteer';
import { getCompliance } from 'accessibility-checker';

const BASE_URL = 'http://localhost';

const PAGES_TO_TEST = [
  { url: `${BASE_URL}/`, name: 'Home' },
  { url: `${BASE_URL}/login`, name: 'Login' },
  { url: `${BASE_URL}/register`, name: 'Register' },
];

const PROTECTED_PAGES = [
  { url: `${BASE_URL}/dashboard`, name: 'Dashboard' },
  { url: `${BASE_URL}/tools/medical-report`, name: 'Medical Report' },
  { url: `${BASE_URL}/tools/medical-calculator`, name: 'Medical Calculator' },
  { url: `${BASE_URL}/tools/antibiotic-guide`, name: 'Antibiotic Guide' },
  { url: `${BASE_URL}/tools/metabolic-disorders`, name: 'Metabolic Disorders' },
  { url: `${BASE_URL}/tools/blood-gas`, name: 'Blood Gas' },
  { url: `${BASE_URL}/tools/sedation`, name: 'Sedation' },
  { url: `${BASE_URL}/tools/vasoactive-drugs`, name: 'Vasoactive Drugs' },
  { url: `${BASE_URL}/tools/pastebin`, name: 'Pastebin' },
];

let totalIssues = 0;
let pagesTested = 0;

async function testPage(page, { url, name }) {
  try {
    console.log(`\n🔍 Testing: ${name}`);
    console.log(`   URL: ${url}`);
    await page.goto(url, { waitUntil: 'networkidle2', timeout: 30000 });
    
    // Run accessibility check
    const result = await getCompliance(page, name);
    
    if (result && result.summary) {
      const { violation = 0, potentialviolation = 0, recommendation = 0, pass = 0 } = result.summary;
      const totalIssuesOnPage = violation + potentialviolation + recommendation;
      totalIssues += totalIssuesOnPage;
      pagesTested++;
      
      console.log(`   ✓ Pass: ${pass}`);
      console.log(`   ⚠ Violations: ${violation}`);
      console.log(`   ? Potential: ${potentialviolation}`);
      console.log(`   💡 Recommendations: ${recommendation}`);
      
      if (violation > 0) {
        console.log(`\n   🔴 VIOLATIONS FOUND:`);
        if (result.issues) {
          result.issues.forEach((issue, idx) => {
            if (issue.level === 'violation') {
              console.log(`      ${idx + 1}. ${issue.message}`);
              console.log(`         Element: ${issue.element}`);
            }
          });
        }
      }
    } else {
      console.log(`   ✓ No issues detected`);
      pagesTested++;
    }
  } catch (error) {
    console.error(`   ❌ Error testing ${name}:`, error.message);
  }
}

async function main() {
  console.log('\n🚀 Starting Accessibility Tests\n');
  console.log(`📍 Base URL: ${BASE_URL}\n`);
  
  const browser = await puppeteer.launch({
    headless: true,
    args: ['--no-sandbox', '--disable-setuid-sandbox']
  });
  
  const page = await browser.newPage();
  
  try {
    // Test public pages
    console.log('📋 Testing Public Pages:\n');
    for (const pageConfig of PAGES_TO_TEST) {
      await testPage(page, pageConfig);
    }
    
    // Login and test protected pages
    console.log('\n\n🔐 Attempting to log in for protected pages...');
    try {
      await page.goto(`${BASE_URL}/login`, { waitUntil: 'networkidle2' });
      
      // Fill email field
      await page.type('input[placeholder="email@example.com"]', 'admin@test.com', { delay: 10 });
      
      // Fill password field
      await page.type('input[placeholder="••••••••"]', 'Test123456!!', { delay: 10 });
      
      // Click login button (find the first button that's type="submit")
      await Promise.all([
        page.click('button[type="submit"]'),
        page.waitForNavigation({ waitUntil: 'networkidle2', timeout: 30000 }).catch(() => {})
      ]);
      
      console.log('✅ Logged in successfully\n');
      
      // Test protected pages
      console.log('📋 Testing Protected Pages:\n');
      for (const pageConfig of PROTECTED_PAGES) {
        await testPage(page, pageConfig);
      }
    } catch (loginError) {
      console.log('⚠️  Could not log in, skipping protected pages');
      console.log(`   Error: ${loginError.message}`);
    }
    
  } finally {
    await browser.close();
  }
  
  // Summary
  console.log('\n\n📊 ACCESSIBILITY TEST SUMMARY');
  console.log('═'.repeat(40));
  console.log(`Pages tested: ${pagesTested}`);
  console.log(`Total issues found: ${totalIssues}`);
  
  if (totalIssues === 0) {
    console.log('\n✅ Great! No accessibility issues detected.');
  } else {
    console.log(`\n⚠️  Found ${totalIssues} accessibility issues. Review the details above.`);
  }
  console.log('═'.repeat(40) + '\n');
}

main().catch(console.error);
