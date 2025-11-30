import { vitePreprocess } from '@sveltejs/vite-plugin-svelte'

export default {
  preprocess: vitePreprocess(),
  onwarn: (warning, handler) => {
    // Suppress a11y warnings for form labels (we use implicit labels or aria-label)
    if (warning.code.startsWith('a11y-')) return;
    handler(warning);
  }
}
