const astro = require('eslint-plugin-astro')
const tseslint = require('@typescript-eslint/eslint-plugin')
const tsParser = require('@typescript-eslint/parser')
const astroParser = require('astro-eslint-parser')

module.exports = [
  { ignores: ['dist/**', 'node_modules/**'] },

  // Astro recommended flat config
  ...astro.configs['flat/recommended'],

  // Ensure .astro supports TS in script blocks
  {
    files: ['**/*.astro'],
    languageOptions: {
      parser: astroParser,
      parserOptions: {
        parser: tsParser,
        extraFileExtensions: ['.astro']
      }
    }
  },

  // TS files
  {
    files: ['**/*.ts'],
    languageOptions: { parser: tsParser },
    plugins: { '@typescript-eslint': tseslint },
    rules: {
      // add TS rules if needed
    }
  }
]
