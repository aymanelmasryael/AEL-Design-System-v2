# S-Color — Color Standard

**Version:** 0.1
**Status:** Draft
**Owner:** AEL Digital Studio
**Governed By:** AEL Constitution v0.1 · Operational Laws v0.1
**Classification:** Standard — Level 3

---

## 1. Purpose

This standard defines the color system for the AEL Design System. It establishes the color categories, their roles, and the rules that govern color usage across all platforms.

All color tokens, specifications, and implementations within the AEL ecosystem must conform to this standard.

---

## 2. Scope

### 2.1 In Scope

- Editorial color system (brand identity).
- Product color system (UI and interactive elements).
- Neutral palette (grays for text, surfaces, borders).
- Color roles and semantic mapping.
- Accessibility requirements for color contrast.

### 2.2 Out of Scope

- CSS variable names or platform-specific format.
- JSON or token registry structure.
- Gradient or pattern definitions.
- Print color profiles (CMYK, Pantone) — future version.

---

## 3. Color Systems

### 3.1 Editorial System

The editorial system governs all published content — articles, reports, white papers, and editorial layouts.

| Role | Hex | Usage |
|---|---|---|
| Brand Primary | `#0074FF` | Logo, headlines, accents, brand identity |
| Black | `#000000` | Primary text, high-contrast elements |
| White | `#FFFFFF` | Backgrounds, reverse text, negative space |

### 3.2 Editorial Gray Scale

| Role | Hex | Usage |
|---|---|---|
| Gray 50 | `#F9F9F9` | Subtle background, card surfaces |
| Gray 100 | `#F2F2F7` | Section backgrounds, hover states |
| Gray 200 | `#E5E5EA` | Borders, dividers, disabled states |
| Gray 400 | `#C7C7CC` | Placeholder text, secondary icons |
| Gray 600 | `#8E8E93` | Secondary text, captions |
| Gray 800 | `#48484A` | Body text, high-emphasis content |

### 3.3 Product System

The product system governs UI components, digital interfaces, and interactive experiences.

| Role | Hex | Usage |
|---|---|---|
| Primary | `#0074FF` | CTAs, links, active states |
| Secondary | `#5856D6` | Secondary actions, badges, tags |
| Success | `#34C759` | Confirmations, positive states |
| Warning | `#FF9500` | Alerts, cautionary states |
| Error | `#FF3B30` | Errors, destructive actions |
| Surface | `#F9F9F9` | Card backgrounds, containers |
| Background | `#FFFFFF` | Page backgrounds |
| Border | `#E5E5EA` | Dividers, outlines |

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
Brand Primary (#0074FF) — dominant
  ↓
Black (#000000) — text
  ↓
Gray Scale #600–#800 — body copy
  ↓
Gray Scale #50–#200 — surfaces and borders
White (#FFFFFF) — background
```

### 5.2 Product Semantic Mapping

| State | Color | Counterpart |
|---|---|---|
| Default | Primary | — |
| Hover | Primary (darkened) | Specified in SP-Interactive |
| Active | Primary (darkened further) | Specified in SP-Interactive |
| Disabled | Gray 200 + Gray 400 | — |
| Error | Error (#FF3B30) | — |
| Success | Success (#34C759) | — |
| Warning | Warning (#FF9500) | — |

---

## 6. Compliance

### 6.1 Verification

- Contrast ratios must be verified against WCAG 2.1 AA at the Specification level.
- Color role usage must be verified during component review.
- No automated verification for editorial layouts (manual review).

### 6.2 Violations

| Severity | Definition | Action |
|---|---|---|
| Critical | WCAG AA contrast failure | Must be resolved before release |
| Major | Color used outside defined role | Must be corrected before merge |
| Minor | Editorial/Product system mixing | Should be corrected; logged for review |

---

## 7. Versioning

This standard follows semantic versioning as defined in the Constitution (Section 6).

| Version | Date | Change |
|---|---|---|
| 0.1 | 2026-07-30 | Initial draft |

---

*End of S-Color v0.1.*