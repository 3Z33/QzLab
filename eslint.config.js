// eslint.config.js
import js from '@eslint/js';
import vue from 'eslint-plugin-vue';
import prettier from 'eslint-config-prettier';

export default [
  // Bases recommandées
  js.configs.recommended,
  ...vue.configs['flat/recommended'], // ou 'flat/vue3-recommended' si tu veux plus strict
  prettier,

  // Configuration globale + globals (appliquée à tout)
  {
    files: ["**/*.{js,ts,vue}"],
    languageOptions: {
      ecmaVersion: 'latest',
      sourceType: 'module',
      globals: {
        console: 'readonly',
        window: 'readonly',
        document: 'readonly',
        process: 'readonly',     // utile pour le backend Node
        // fetch: 'readonly',    // décommente si besoin
         setTimeout: 'readonly',
      },
    },
    rules: {
      'no-unused-vars': 'warn',
      'no-console': 'off',           // globalement off (tu peux override après si besoin)
      'vue/multi-word-component-names': 'off',
    },
  },

  // Overrides spécifiques backend (seulement ce qui change)
  {
    files: ["server/**/*.{js,ts}", "api/**/*.{js,ts}", "backend/**/*.{js,ts}"],
    rules: {
      'no-await-in-loop': 'warn',
      // 'no-console': 'off'  ← déjà off globalement, donc inutile ici
    },
  },
];