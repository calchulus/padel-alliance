import { defineConfig } from 'vite';

// GitHub Pages project sites live at /<repository>/; custom domains and
// username.github.io repositories live at /.
export default defineConfig({
  base: process.env.VITE_BASE_PATH || '/',
});
