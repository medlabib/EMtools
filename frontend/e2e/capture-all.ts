import { chromium } from '@playwright/test';

const pages = [
  { name: 'home', path: '/' },
  { name: 'login', path: '/login' },
  { name: 'register', path: '/register' },
  { name: 'tools', path: '/tools' },
  { name: 'bloodgas', path: '/tools/bloodgas' },
  { name: 'vasoactive', path: '/tools/vasoactive' },
  { name: 'sedation', path: '/tools/sedation' },
  { name: 'metabolic', path: '/tools/metabolic' },
  { name: 'calculator', path: '/tools/calculator' },
  { name: 'antibiotic', path: '/tools/antibiotic' },
  { name: 'report', path: '/tools/report' },
  { name: 'pastebin', path: '/tools/pastebin' },
];

async function captureScreenshots() {
  const browser = await chromium.launch();
  
  // Desktop viewport
  const desktopContext = await browser.newContext({
    viewport: { width: 1280, height: 720 },
  });
  const desktopPage = await desktopContext.newPage();
  
  console.log('📸 Capturing Desktop Screenshots...');
  for (const p of pages) {
    await desktopPage.goto(`http://localhost:80${p.path}`);
    await desktopPage.waitForLoadState('networkidle');
    await desktopPage.waitForTimeout(500);
    await desktopPage.screenshot({ 
      path: `screenshots/desktop-${p.name}.png`, 
      fullPage: true 
    });
    console.log(`  ✓ ${p.name}`);
  }
  await desktopContext.close();
  
  // Mobile viewport
  const mobileContext = await browser.newContext({
    viewport: { width: 390, height: 844 },
    isMobile: true,
    hasTouch: true,
  });
  const mobilePage = await mobileContext.newPage();
  
  console.log('\n📱 Capturing Mobile Screenshots...');
  for (const p of pages) {
    await mobilePage.goto(`http://localhost:80${p.path}`);
    await mobilePage.waitForLoadState('networkidle');
    await mobilePage.waitForTimeout(500);
    await mobilePage.screenshot({ 
      path: `screenshots/mobile-${p.name}.png`, 
      fullPage: true 
    });
    console.log(`  ✓ ${p.name}`);
  }
  await mobileContext.close();
  
  await browser.close();
  console.log('\n✅ All screenshots captured!');
}

captureScreenshots().catch(console.error);
