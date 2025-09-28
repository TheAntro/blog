## Accessibility Audit Report

Date: 2025-09-28
Project: Astro + Storyblok site

### Summary
- Base semantics are solid (`<html lang="en">`, landmark usage with `<main>`, headings in content).
- No images found in codebase; rich text is injected from Storyblok and may include images/links at runtime. These should be validated in the CMS.
- Global focus/hover styles mostly present via `.post-card:focus`; native links rely on browser defaults.
- ESLint lacks a11y rules; adding automated checks will prevent regressions.

### Findings

1) Language and structure
- `<html lang="en">` present in `src/layouts/BaseLayout.astro`.
- Landmarks: `<main>` used in `src/storyblok/Page.astro`. Consider adding a site-wide `<header>` role association and a skip link.

2) Navigation
- `src/components/Header.astro` uses `<nav>` and a plain list of links. No visible focus styles beyond browser defaults; hover has a bottom border.
  - Risk: Low contrast focus indicator if theme/background interacts badly. Suggest explicit focus styles.

3) Links presented as cards
- `src/components/PostItem.astro` wraps a block card in an `<a>` (valid pattern). It has `:focus` shadow, which helps.
  - Suggestion: Ensure the entire card remains accessible via keyboard (already true). Add `:focus-visible` for better UX.

4) Headings and content
- `src/storyblok/Article.astro` uses `<h1>` for title and `renderRichText` for content. Ensure the rich text renderer outputs semantic tags.
  - Risk: CMS content may include heading level jumps or missing alt on images.

5) External links security attributes
- No `target="_blank"` occurrences in codebase. If CMS content includes external links with `target="_blank"`, ensure `rel="noopener noreferrer"` is added by the renderer.

6) Images
- No `<img>` tags in codebase. CMS-provided content might include images.
  - Requirement: All content images must include meaningful `alt`. Decorative images should use empty `alt=""` and avoid redundant titles.

7) Buttons and interactive elements
- No custom buttons or non-interactive elements with `onClick` found.
  - Keep it that way: use native elements (`<button>`, `<a>`) and set `type="button|submit|reset"` on buttons.

8) Color contrast
- Theme colors are dark background with accent yellow and green. Likely okay, but not validated numerically.
  - Action: Run Axe or Lighthouse to verify contrast on live pages, especially link and small text.

9) Focus management
- No skip link present. Pages with repeated header would benefit from a "Skip to content" link.

### Recommended Edits

1) Add a skip link and focus-visible styles

Files: `src/layouts/BaseLayout.astro`, `src/styles/global.css`

Suggested changes:

In layout body, add a skip link before the header container and an id on `<main>`:

```astro
<body>
  <a class="skip-link" href="#main-content">Skip to content</a>
  <div class="header-container">
    <Header />
  </div>
  <div class="header-divider"></div>
  <main id="main-content" class="page-container">
    <slot />
  </main>
</body>
```

In global styles, add focus-visible and skip-link styles:

```css
:where(a, button, [role="button"], input, textarea, select):focus-visible {
  outline: 2px solid var(--accent);
  outline-offset: 2px;
}

.skip-link {
  position: absolute;
  left: -9999px;
  top: auto;
  width: 1px;
  height: 1px;
  overflow: hidden;
}

.skip-link:focus-visible {
  position: static;
  width: auto;
  height: auto;
  padding: 0.5rem 0.75rem;
  background: var(--bg-color-light);
  color: var(--white);
  border: 2px solid var(--accent);
  border-radius: 0.375rem;
}
```

2) Improve nav link focus clarity

File: `src/components/Header.astro`

Add a `:focus-visible` style mirroring hover and avoiding layout shift:

```css
  a {
    text-decoration: none;
    color: inherit;
    transition: all var(--state-transition);
  }
  a:hover,
  a:focus-visible {
    box-shadow: inset 0 -2px currentColor;
  }
```

3) Ensure Storyblok rich-text renders a11y-friendly markup

- Verify renderer configuration to ensure:
  - Images receive `alt` text from CMS; empty alt allowed for decorative.
  - External links with `target="_blank"` include `rel="noopener noreferrer"`.
  - Headings maintain logical order (avoid skipping from h1 to h4).

If customization is needed, consider a custom renderer or post-processing of `renderRichText` output.

### Tooling and Automation

1) Add ESLint a11y rules for Astro/JSX
- Install: `eslint-plugin-jsx-a11y` and enable for `.astro` and `.ts` where applicable.
- Also consider `eslint-plugin-astro` a11y presets when available.

2) Runtime/page checks
- Integrate Axe for local checks. Example dev-only snippet or run Lighthouse/Axe in CI against built pages.

### Next Steps
- Implement the recommended edits.
- Add ESLint a11y plugin and CI checks.
- Run Axe or Lighthouse on key pages (home, articles list, article detail) and fix any remaining issues, especially color contrast.

