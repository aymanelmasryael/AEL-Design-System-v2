# S-Color — Color Standard

**Version:** 0.2
**Status:** Draft
**Owner:** AEL Digital Studio
**Governed By:** AEL Constitution v0.2 · Operational Laws v0.2
**Classification:** Standard — Level 3

---

## 1. Purpose

This standard defines the color system for the AEL Design System. It establishes the color categories, their roles, and the rules that govern color usage across all platforms.

All color tokens, specifications, and implementations within the AEL ecosystem must conform to this standard.

This standard governs rules and categories only. It does not carry concrete color values. All concrete values are defined in `06-Implementation/tokens/` (editorial-colors.json, product-colors.json, semantic-colors.json) — the Single Source of Truth per PROP-2026-001.

---

## 2. Scope

### 2.1 In Scope

- Editorial color system (brand identity).
- Product color system (UI and interactive elements).
- Neutral palette (grays for text, surfaces, borders).
- Color roles and semantic mapping.
- Accessibility requirements for color contrast.

### 2.2 Out of Scope

- Concrete hex values (these live in Implementation).
- CSS variable names or platform-specific format.
- JSON or token registry structure.
- Gradient or pattern definitions.
- Print color profiles (CMYK, Pantone) — future version.

---

## 3. Color Systems

### 3.1 Editorial System

The editorial system governs all published content — articles, reports, white papers, and editorial layouts.

| Role | Token | Usage |
|---|---|---|
| Brand Primary | `TK-color-brand-primary` | Logo, headlines, accents, brand identity |
| Black | `TK-color-black` | Primary text, high-contrast elements |
| White | `TK-color-white` | Backgrounds, reverse text, negative space |

### 3.2 Editorial Gray Scale

The gray scale shall contain a minimum of 10 stops (50 through 900).

| Role | Token | Usage |
|---|---|---|
| Gray 50 | `TK-color-gray-50` | Subtle background, card surfaces |
| Gray 100 | `TK-color-gray-100` | Section backgrounds, hover states |
| Gray 200 | `TK-color-gray-200` | Borders, dividers, disabled states |
| Gray 300 | `TK-color-gray-300` | Placeholder backgrounds, subtle separators |
| Gray 400 | `TK-color-gray-400` | Placeholder text, secondary icons |
| Gray 500 | `TK-color-gray-500` | Disabled text, inactive controls |
| Gray 600 | `TK-color-gray-600` | Secondary text, captions |
| Gray 700 | `TK-color-gray-700` | Medium-emphasis body text |
| Gray 800 | `TK-color-gray-800` | Body text, high-emphasis content |
| Gray 900 | `TK-color-gray-900` | Highest emphasis text, dark surfaces |

### 3.3 Product System

The product system governs UI components, digital interfaces, and interactive experiences.

| Role | Token | Usage |
|---|---|---|
| Primary | `TK-color-primary` | CTAs, links, active states |
| Primary Hover | `TK-color-primary-hover` | Primary interactive hover state |
| Primary Active | `TK-color-primary-active` | Primary interactive pressed state |
| Secondary | `TK-color-secondary` | Secondary actions, badges, tags |
| Success | `TK-color-success` | Confirmations, positive states |
| Warning | `TK-color-warning` | Alerts, cautionary states |
| Error | `TK-color-error` | Errors, destructive actions |
| Info | `TK-color-info` | Informational states, help text |
| Surface | `TK-color-surface` | Card backgrounds, containers |
| Background | `TK-color-background` | Page backgrounds |
| Border | `TK-color-border` | Dividers, outlines, default borders |
| Border Focus | `TK-color-border-focus` | Focus ring, active border |

### 3.4 Semantic Tokens

| Role | Token | Usage |
|---|---|---|
| Text Primary | `TK-color-text-primary` | Primary text on light backgrounds |
| Text Secondary | `TK-color-text-secondary` | Secondary text, captions, descriptions |
| Text Disabled | `TK-color-text-disabled` | Disabled text on any background |
| Text Inverse | `TK-color-text-inverse` | Text on dark or primary backgrounds |
| Background Secondary | `TK-color-background-secondary` | Secondary background, section surfaces |
| Surface Secondary | `TK-color-surface-secondary` | Elevated surface, modal backgrounds |

---

## 4. Rules

### 4.1 Usage Rules

| # | Rule |
|---|---|
| C01 | Brand Primary must be the dominant color in all editorial applications |
| C02 | Product colors must not be used in editorial layouts unless explicitly specified |
| C03 | Black must not be used as a background color on digital surfaces |
| C04 | Surface and Background colors must maintain minimum contrast with all foreground colors |
| C05 | Error color must not be used for non-destructive actions |

### 4.2 Accessibility Rules

| # | Rule | Requirement |
|---|---|---|
| A01 | All text colors must meet WCAG 2.1 AA contrast ratio (4.5:1) for normal text | Verified per color pair |
| A02 | All text colors must meet WCAG 2.1 AA contrast ratio (3:1) for large text | Verified per color pair |
| A03 | All UI component colors must meet WCAG 2.1 AA contrast ratio (3:1) | Verified per component |
| A04 | Error and Success colors must not be the sole indicator of state | Must include icon or text |

### 4.3 Prohibited Usage

| # | Rule |
|---|---|
| P01 | Never use a color outside its defined role |
| P02 | Never use Editorial Black as a replacement for Brand Primary |
| P03 | Never apply opacity to colors to create variants — use the defined gray scale |
| P04 | Never mix Editorial and Product color systems in the same component |

---

## 5. Color Relationships

### 5.1 Editorial Hierarchy

```
TK-color-brand-primary — dominant
  ↓
TK-color-black — text
  ↓
TK-color-gray-600 → TK-color-gray-800 — body copy
  ↓
TK-color-gray-50 → TK-color-gray-200 — surfaces and borders
TK-color-white — background
```

### 5.2 Product State Mapping

| State | Token | Default Value Reference |
|---|---|---|
| Default | `TK-color-primary` | — |
| Hover | `TK-color-primary-hover` | — |
| Active | `TK-color-primary-active` | — |
| Disabled | `TK-color-gray-200` + `TK-color-gray-500` | Foreground + Background |
| Error | `TK-color-error` | — |
| Success | `TK-color-success` | — |
| Warning | `TK-color-warning` | — |

---

## 6. Related Specifications

- SP-Color-Palette

---

## 7. Compliance

### 7.1 Verification

- Contrast ratios must be verified against WCAG 2.1 AA at the Implementation level.
- Color role usage must be verified during component review.
- No automated verification for editorial layouts (manual review).

### 7.2 Violations

| Severity | Definition | Action |
|---|---|---|
| Critical | WCAG AA contrast failure | Must be resolved before release |
| Major | Color used outside defined role | Must be corrected before merge |
| Minor | Editorial/Product system mixing | Should be corrected; logged for review |

---

## 8. Versioning

This standard follows semantic versioning as defined in the Constitution (Section 6).

| Version | Date | Change |
|---|---|---|
| 0.1 | 2026-07-30 | Initial draft |
| 0.2 | 2026-07-31 | Removed concrete hex values (migrated to Implementation SSOT per PROP-2026-001). Replaced with token ID references. Completed gray scale (added 300, 500, 700, 900). Added semantic token table. | 

---

*End of S-Color v0.2.*
