## Accessibility Audit Report

Date: 2025-09-28
Project: Astro + Storyblok site

### Summary

- Base semantics are solid (`<html lang="en">`, landmark usage with `<main>`, headings in content).
- Implemented skip link and `id` on main for keyboard users.
- Added global `:focus-visible` outlines and skip-link reveal styles.
- Improved nav link focus styles; card links now use `:focus-visible`.
- No images found in codebase; rich text is injected from Storyblok and may include images/links at runtime. These should be validated in the CMS.
- ESLint lacks a11y rules; adding automated checks will prevent regressions.

### Findings

1. Language and structure

- `<html lang="en">` present in `src/layouts/BaseLayout.astro`.
- Landmarks: `<main>` used in `src/storyblok/Page.astro`. Consider adding a site-wide `<header>` role association and a skip link.

2. Navigation

- `src/components/Header.astro` uses `<nav>` and a plain list of links. Now has explicit `:focus-visible` indicator (inset underline) matching hover.
  - Benefit: Clear, consistent focus state without layout shift.

3. Links presented as cards

- `src/components/PostItem.astro` wraps a block card in an `<a>` (valid pattern). Card now uses `:focus-visible` for keyboard-only focus styling.

4. Headings and content

- `src/storyblok/Article.astro` uses `<h1>` for title and `renderRichText` for content. Ensure the rich text renderer outputs semantic tags.
  - Risk: CMS content may include heading level jumps or missing alt on images.

5. External links security attributes

- No `target="_blank"` occurrences in codebase. If CMS content includes external links with `target="_blank"`, ensure `rel="noopener noreferrer"` is added by the renderer.

6. Images

- No `<img>` tags in codebase. CMS-provided content might include images.
  - Requirement: All content images must include meaningful `alt`. Decorative images should use empty `alt=""` and avoid redundant titles.

7. Buttons and interactive elements

- No custom buttons or non-interactive elements with `onClick` found.
  - Keep it that way: use native elements (`<button>`, `<a>`) and set `type="button|submit|reset"` on buttons.

8. Color contrast

- Theme colors are dark background with accent yellow and green. Likely okay, but not validated numerically.
  - Action: Run Axe or Lighthouse to verify contrast on live pages, especially link and small text.

9. Focus management

- Skip link added in `src/layouts/BaseLayout.astro` and revealed on focus-visible. `<main>` has `id="main-content"`.

### Implemented Edits

1. Skip link and focus-visible styles

- Files: `src/layouts/BaseLayout.astro`, `src/styles/global.css`
- Result: Keyboard users can skip header; clear outlines for interactive elements.

2. Nav link focus clarity

- File: `src/components/Header.astro`
- Result: `:focus-visible` uses inset underline matching hover.

3. Ensure Storyblok rich-text renders a11y-friendly markup

- Verify renderer configuration to ensure:
  - Images receive `alt` text from CMS; empty alt allowed for decorative.
  - External links with `target="_blank"` include `rel="noopener noreferrer"`.
  - Headings maintain logical order (avoid skipping from h1 to h4).

If customization is needed, consider a custom renderer or post-processing of `renderRichText` output.

### Tooling and Automation

1. Add ESLint a11y rules for Astro/JSX

- Install: `eslint-plugin-jsx-a11y` and enable for `.astro` and `.ts` where applicable.
- Also consider `eslint-plugin-astro` a11y presets when available.

2. Runtime/page checks

- Integrate Axe for local checks. Example dev-only snippet or run Lighthouse/Axe in CI against built pages.

### Next Steps

- Add ESLint a11y plugin and CI checks.
- Run Axe or Lighthouse on key pages (home, articles list, article detail) and fix any remaining issues, especially color contrast.
