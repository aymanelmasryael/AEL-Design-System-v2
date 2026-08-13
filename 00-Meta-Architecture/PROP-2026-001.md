# Architecture Refactoring Proposal v0.3

**Document ID:** PROP-2026-001
**Version:** 0.3 (Adopted)
**Status:** Approved
**Owner:** AEL Digital Studio
**Governed By:** AEL Constitution v0.1 §5.2 (Amendment Process)
**Classification:** Architectural Decision Record
**Adopted:** 2026-07-31

---

## 1. Purpose

This proposal resolves four architectural tensions discovered in the Phase 3 Design Token implementation audit (2026-07-31):

| Tension | Description |
|---------|-------------|
| **T1 — SSOT Conflict** | Two documents (`SP-Color-Palette.md`, `token-registry.json`) both claim to be the "canonical source of truth" for the same values. |
| **T2 — Value Duplication** | 86 concrete values (colors, spacing, typography) are duplicated across Standards, Specifications, and Registry. |
| **T3 — Registry Role Ambiguity** | The Registry is declared SSOT but cannot legally be referenced by higher levels (Dependency Hierarchy Law §4.3 DD04). |
| **T4 — Naming Law Restrictiveness** | Naming Convention Law §4.3 allows only 7 token categories. `opacity`, `elevation`, `breakpoint`, and others required by component specifications are excluded. |

This document defines the architectural decisions that, once adopted, drive amendments to the Constitution, Operational Laws, and existing documents.

---

## 2. Adopted Architecture

### 2.1 Hierarchy

```
AEL Meta-Architecture
  → AEL Ontology
    → Constitution
      → Operational Laws
        → Standards (rules, categories, constraints ONLY — no concrete values)
          → Specifications (structure, token ID references, requirements — no concrete values)
            → Implementation (SSOT — all concrete values live here)
              → Registry (Generated catalog — produced from Implementation, never hand-authored)

Validation (Cross-cutting, all levels)
```

### 2.2 The SSOT

**The Implementation Token files** in `06-Implementation/tokens/` are the Single Source of Truth.

| File | Content |
|------|---------|
| `colors.json` | All color tokens with hex values |
| `spacing.json` | All spacing tokens with px values |
| `typography.json` | All typography tokens (fonts, sizes, weights, line heights, letter spacing) |
| `radius.json` | All border radius tokens |
| `shadow.json` | All shadow tokens (box-shadow values) |
| `border.json` | All border width tokens |
| `motion.json` | All motion tokens (durations, easings) |
| `opacity.json` | All opacity tokens (interaction states) |
| `elevation.json` | All elevation tokens (z-axis depth) |
| `breakpoint.json` | All responsive breakpoint tokens |
| `z-index.json` | All z-index tokens (stacking order) |
| `blur.json` | All blur tokens (backdrop, filter) |
| `size.json` | All size tokens (component dimensions) |
| `icon.json` | All icon-specific tokens (size, stroke) |
| `grid.json` | All grid tokens (columns, max-width, container) |

Every value is defined in exactly one file. No value appears in any Standard, Specification, or Registry.

### 2.3 SSOT Definition

**Single Source of Truth** is a principle with three properties:

| Property | Definition |
|----------|-----------|
| **Origin** | Every value originates from exactly one file. |
| **Authority** | No other file may independently define the same value. |
| **Propagation** | All other files derive their values from the SSOT through references or generation. |

---

## 3. Layer Roles

### 3.1 Standards (Level 3)

**Role:** Define WHAT must exist. Govern categories, constraints, and usage rules.

**Contains:** Domain scope, category definitions, usage rules and constraints, accessibility requirements, compliance criteria.

**Must NOT contain:** Concrete hex, px, em, or numeric values. Token IDs. Platform-specific implementation details.

**Example — S-Color §3 after refactoring:**

```
## 3. Color Categories

The color system shall define the following categories:

| Category | Purpose |
|----------|---------|
| Brand Primary | Logo, headlines, accents |
| Gray Scale | Text, surfaces, borders — minimum 10 stops |
| Semantic Colors | Primary, Secondary, Success, Warning, Error, Info |
| Text Colors | Text-primary, text-secondary, text-disabled, text-inverse |
| Surface Colors | Surface, background, background-secondary |
```

### 3.2 Specifications (Level 4)

**Role:** Technical blueprint. Describe structure, reference token IDs, define relationships.

**Contains:** Entity purpose and structure, token ID references (e.g., "Uses: `TK-color-primary`"), variant definitions, state definitions, platform mapping.

**Must NOT contain:** Concrete values (hex, px, em). Token value definitions. Implementation code.

### 3.3 Implementation (Level 5)

**Role:** SSOT. Houses concrete token values in platform-neutral JSON.

**Contains:** One JSON file per token category. Complete token definitions (id, value, type, role). All values necessary for platform consumers.

**Must NOT contain:** Governance rules. Platform-specific output formats. Redundant value definitions.

### 3.4 Registry (Level 6 — Generated)

**Role:** Generated catalog. Machine-produced index from Implementation tokens.

**Contains:** Compiled index of all tokens from all category files. Cross-reference mappings (token → standard → specification). Compliance metadata.

**Must NOT contain:** Original token definitions. Hand-authored values.

**Generation flow:**

```
Implementation Tokens (*.json)
        │
        ▼
    Build Script (generate-registry.js)
        │
        ▼
Registry (token-registry.json)
```

---

## 4. Token Categories — Tiered Model

### 4.1 Tier Structure

| Tier | Purpose | Stability | Categories |
|------|---------|-----------|------------|
| **Core** | Required by all tokens. Present in every design system. | Stable | `color`, `typography`, `spacing`, `radius`, `shadow`, `border`, `motion`, `opacity` |
| **Layout** | Required by layout systems. Present in most platforms. | Stable | `breakpoint`, `grid`, `zindex`, `elevation` |
| **Optional** | Context-dependent. Present based on project scope. | May expand | `blur`, `size`, `icon` |

### 4.2 Tier Rules

| # | Rule |
|---|------|
| T01 | All Core categories must be present in every platform implementation. |
| T02 | Layout categories must be present if the platform supports responsive or z-axis layout. |
| T03 | Optional categories may be added or removed without requiring an amendment to the Naming Convention Law. The law defines the allowed set; project scope decides which Optional categories are implemented. |
| T04 | Adding a new category to Core or Layout tiers requires an amendment to the Naming Convention Law. |
| T05 | Adding a new category to Optional tier does not require a law amendment. |

### 4.3 Category Definitions

#### Core

| Category | Token Pattern | Example | Description |
|----------|-------------|---------|-------------|
| `color` | `TK-color-{role}-{variant}` | `TK-color-primary-hover` | Color values (hex, rgb) for all surfaces and elements |
| `typography` | `TK-typography-{property}-{variant}` | `TK-typography-size-body` | Font families, sizes, weights, line heights, letter spacing |
| `spacing` | `TK-spacing-{size}` | `TK-spacing-md` | Spacing scale based on 8px grid |
| `radius` | `TK-radius-{size}` | `TK-radius-md` | Border radius values |
| `shadow` | `TK-shadow-{size}` | `TK-shadow-md` | Box shadow / elevation shadow values |
| `border` | `TK-border-width-{size}` | `TK-border-width-sm` | Border width values |
| `motion` | `TK-motion-{property}-{variant}` | `TK-motion-duration-normal` | Animation durations and easing curves |
| `opacity` | `TK-opacity-{state}` | `TK-opacity-disabled` | Opacity values for interaction states |

#### Layout

| Category | Token Pattern | Example | Description |
|----------|-------------|---------|-------------|
| `breakpoint` | `TK-breakpoint-{device}` | `TK-breakpoint-tablet` | Responsive viewport width thresholds |
| `grid` | `TK-grid-{property}` | `TK-grid-columns` | Grid system constants (columns, max-width, container) |
| `zindex` | `TK-zindex-{layer}` | `TK-zindex-modal` | Stacking order values |
| `elevation` | `TK-elevation-{level}` | `TK-elevation-surface` | Semantic z-axis depth levels |

#### Optional

| Category | Token Pattern | Example | Description |
|----------|-------------|---------|-------------|
| `blur` | `TK-blur-{strength}` | `TK-blur-md` | Backdrop and filter blur values |
| `size` | `TK-size-{component}-{variant}` | `TK-size-avatar-lg` | Width/height dimensions for components |
| `icon` | `TK-icon-{property}` | `TK-icon-size-default` | Icon-specific tokens (default size, stroke width) |

---

## 5. Token Lifecycle

Every token in the AEL Design System shall progress through a defined lifecycle. No token may exist in the system without passing through each stage.

### 5.1 Lifecycle Stages

| # | Stage | Input | Output | Owner | Gate |
|---|-------|-------|--------|-------|------|
| 1 | **Proposal** | Need identified by component spec, standard, or platform requirement | Token proposal record (ID, category, rationale, proposed value) | Any contributor | — |
| 2 | **Review** | Token proposal record | Reviewed proposal with feedback | Standard Owner for the category (e.g., S-Color owner for color tokens) | Must align with governing Standard. Must not duplicate existing token. |
| 3 | **Approval** | Reviewed proposal | Approved token specification | Standard Owner or AEL Digital Studio (for new categories) | Token ID must conform to Naming Convention Law. Value must pass accessibility checks if applicable. |
| 4 | **Implementation** | Approved token specification | Token entry in `06-Implementation/tokens/{category}.json` | Implementation agent | Token value becomes SSOT. No other file may define this value. |
| 5 | **Validation** | Token entry in Implementation | Validation report | Automated pre-commit hook | Naming check, value type check, SSOT uniqueness check, cross-reference integrity. |
| 6 | **Registry Generation** | All Implementation token files | Updated `07-Registry/token-registry.json` | Build script (`scripts/generate-registry.js`) | Automated. Must produce identical output for identical input. Human must not edit output. |
| 7 | **Release** | Validated token in all layers | Token available for platform consumption | Release manager | CHANGELOG updated. System VERSION incremented per semantic versioning. |

### 5.2 Lifecycle Diagram

```
PROPOSAL  →  REVIEW  →  APPROVAL  →  IMPLEMENTATION  →  VALIDATION  →  REGISTRY GENERATION  →  RELEASE
    │           │           │              │                 │               │                    │
    ▼           ▼           ▼              ▼                 ▼               ▼                    ▼
 Proposal   Feedback   Approval       colors.json      Pre-commit     token-registry        CHANGELOG
  Record                                       │        hook passes        .json              VERSION
                                               │            │
                                               ▼            ▼
                                          SSOT entry   Validation
                                        (single truth)   Report
```

### 5.3 Lifecycle Rules

| # | Rule |
|---|------|
| LC01 | A token must not skip any stage. |
| LC02 | A token at Implementation is the SSOT. Any value change must originate from Implementation and propagate downward to Registry. |
| LC03 | A token at Registry must exactly match Implementation. Divergence is a build failure. |
| LC04 | A token at Release has an immutable value for that version. Changes require a new lifecycle cycle starting at Proposal. |
| LC05 | Deprecated tokens remain in Implementation for one full version cycle before removal. Registry reflects deprecation status. |

### 5.4 Deprecation Path

| Stage | Action |
|-------|--------|
| Token marked deprecated | `"status": "deprecated"` in Implementation token file |
| Replacement token exists | `"replacedBy": "TK-{new-token}"` in Implementation |
| Grace period | One full version cycle (e.g., deprecated in v0.3 → removed in v0.5) |
| Removal | Token entry removed from Implementation. Registry regenerated without it. |

---

## 6. Dependency Rules Update

### 6.1 Amended Level-Specific Rules

| Level | May Depend On | Must NOT Depend On |
|-------|--------------|-------------------|
| Standards | Meta-Architecture, Ontology, Constitution, Operational Laws | Specifications, Implementation, Registry |
| Specifications | All above + **Implementation token IDs** (namespace reference, not file dependency) | Implementation value files, Registry |
| Implementation | All governance levels above | Registry |
| Registry | **Implementation (generated from)** | Nothing — Registry must not be hand-authored |

### 6.2 Specification → Token ID Rule

Specifications may reference Implementation token IDs (e.g., `TK-color-primary`) without creating a downward dependency. A token ID is a namespace identifier, not a file dependency. The token value is defined in Implementation; the token ID is a stable reference that both documents share.

---

## 7. Validation Mechanism

### 7.1 Pre-commit Hook

A pre-commit validation hook enforces the SSOT principle:

```
For every value V (hex, px, em, numeric):
  1. Search all Standards for V → FAIL if found (standards must not carry values)
  2. Search all Specifications for V → FAIL if found (specs reference token IDs, not values)
  3. Search Implementation for V → PASS if exactly one file defines it
  4. If Registry contains V not in Implementation → FAIL (registry must not be hand-authored)
```

### 7.2 Token ID Uniqueness

```
For every token ID T in system:
  Search all Implementation files for T → PASS if found exactly once
  FAIL if found 0 times (orphan reference) or >1 times (duplicate definition)
```

---

## 8. Migration Path

| Step | Action | Status |
|------|--------|--------|
| 1 | Adopt this proposal | ✓ Approved |
| 2 | Amend Naming Convention Law §4.3 — tiered categories | Pending |
| 3 | Amend Dependency Hierarchy Law §4.3 — token ID references | Pending |
| 4 | Amend AEL Constitution §5.1 — hierarchy diagram | Pending |
| 5 | Remove concrete values from Standards (S-Color, S-Spacing) | Pending |
| 6 | Replace concrete values in Specifications with token ID references (SP-Color-Palette, SP-Typography, SP-Spacing, SP-Grid) | Pending |
| 7 | Fix S-Color.md incomplete gray scale (add 300, 500, 700, 900) | Pending |
| 8 | Fix broken SP-Interactive reference in S-Color.md | Pending |
| 9 | Update SP-Typography with full font stacks | Pending |
| 10 | Create Implementation token files (`colors.json`, etc.) as SSOT | Pending |
| 11 | Create `scripts/generate-registry.js` build script | Pending |
| 12 | Regenerate token-registry.json from script | Pending |
| 13 | Add pre-commit validation hook | Pending |
| 14 | Verify zero value duplication across all layers | Pending |
| 15 | Update CHANGELOG.md with v0.2 architecture refactoring | Pending |

---

## 9. Document Amendments Required

| Document | Section | Change |
|----------|---------|--------|
| AEL Constitution | §5.1 | Add "Implementation (SSOT) → Registry (Generated)" to document hierarchy |
| Dependency Hierarchy Law | §4.3 | Allow Specifications to reference Implementation token IDs |
| Naming Convention Law | §4.3 | Replace flat 7-category list with tiered 15-category model (Core/Layout/Optional) |
| Override & Exception Policy | None | No change needed |

---

## 10. Comparison: Before vs After

| Property | Before (v0.1) | After (v0.2) |
|----------|---------------|-----------------|
| SSOT Location | Contested (SP-Color-Palette vs token-registry.json) | `06-Implementation/tokens/*.json` |
| Value Duplication | 86 values in 2-3 locations each | Zero duplication |
| Standards Carry Values | Yes (S-Color, S-Spacing) | No — rules only |
| Specifications Carry Values | Yes (hex, px, em) | No — token ID references only |
| Registry Authority | Declared SSOT but legally unenforceable | Generated catalog, no authority claim |
| Registry Edit Method | Hand-authored JSON | Generated by build script |
| Token Categories | 7 (flat) | 15 (Core 8 + Layout 4 + Optional 3) |
| Token Lifecycle | Undefined | 7-stage formal process |
| Validation | Manual only | Automated pre-commit hook |

---

## 11. Rejected Alternatives

### 11.1 B1 — "Registry as SSOT, Standards reference Registry"

**Rejected.** Inverts the governance hierarchy. A supporting system (Registry, Level 5) would govern Level 3 and 4 documents. A generated catalog cannot govern the rules that describe it.

### 11.2 B2 — "Standards as SSOT"

**Rejected.** Standards define rules and constraints. Embedding concrete values in governance documents creates maintenance risk. Governance cadence and value cadence differ. Coupling them is architecturally unsound.

---

## 12. Appendix — Registry Generation Architecture

```
┌─────────────────────────────────────┐
│ 06-Implementation/tokens/           │
│                                     │
│ colors.json ─────────┐              │
│ spacing.json ────────┤              │
│ typography.json ─────┤              │
│ radius.json ─────────┤              │
│ shadow.json ─────────┤              │
│ border.json ─────────┤              │
│ motion.json ─────────┤   generate-  │
│ opacity.json ────────┼── registry   │
│ elevation.json ──────┤   .js        │
│ breakpoint.json ─────┤              │
│ z-index.json ────────┤              │
│ blur.json ───────────┤              │
│ size.json ───────────┤              │
│ icon.json ───────────┤              │
│ grid.json ───────────┘              │
│                                     │
└─────────────────┬───────────────────┘
                  │
                  ▼
┌─────────────────────────────────────┐
│ 07-Registry/token-registry.json    │
│ (Generated Catalog — DO NOT EDIT)  │
│                                     │
│ Compiled index of all tokens        │
│ Cross-reference mappings            │
│ Compliance metadata                 │
└─────────────────────────────────────┘
```

---

*End of Architecture Refactoring Proposal v0.3 (Adopted 2026-07-31).*
