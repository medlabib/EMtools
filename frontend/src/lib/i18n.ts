import { register, init, getLocaleFromNavigator, locale } from 'svelte-i18n';

register('en', () => import('./locales/en.json'));
register('fr', () => import('./locales/fr.json'));

// Get saved locale from localStorage or use navigator locale
function getInitialLocale(): string {
  if (typeof window !== 'undefined') {
    const savedLocale = localStorage.getItem('locale');
    if (savedLocale && ['en', 'fr'].includes(savedLocale)) {
      return savedLocale;
    }
  }
  const navigatorLocale = getLocaleFromNavigator();
  // Extract base language (e.g., 'fr-FR' -> 'fr')
  if (navigatorLocale) {
    const baseLang = navigatorLocale.split('-')[0];
    if (['en', 'fr'].includes(baseLang)) {
      return baseLang;
    }
  }
  return 'en';
}

init({
  fallbackLocale: 'en',
  initialLocale: getInitialLocale(),
});

// Subscribe to locale changes and persist to localStorage
if (typeof window !== 'undefined') {
  locale.subscribe((value) => {
    if (value) {
      localStorage.setItem('locale', value);
      // Update HTML lang attribute for accessibility
      document.documentElement.lang = value;
    }
  });
}
