# Naming Convention Law

**Version:** 0.1
**Status:** Draft
**Owner:** AEL Digital Studio
**Governed By:** AEL Constitution v0.1
**Classification:** Operational Law — Level 2

---

## 1. Purpose

This law establishes a single, consistent naming system for all entities, files, tokens, and identifiers within the AEL Design System. Consistent naming ensures that any artifact can be located, referenced, and validated without ambiguity.

---

## 2. Scope

### 2.1 In Scope

- All entity identifiers defined in the AEL Ontology.
- All file and directory names within the repository.
- All design tokens and their variants.
- All component names, asset names, and template names.

### 2.2 Out of Scope

- Human-readable display labels (e.g., UI text, headings).
- External platform identifiers (e.g., Canva design IDs, Figma node IDs).
- Commit messages, branch names, or git metadata.
- Natural language content within documentation.

---

## 3. Definitions

| Term | Definition |
|---|---|
| Identifier | A machine-readable string that uniquely identifies an entity |
| Segment | A single lowercase alphanumeric component of an identifier, separated by a delimiter |
| Delimiter | The character used to separate segments within an identifier |
| Prefix | The initial segment that identifies the entity category |
| Slug | A URL-safe, human-readable identifier derived from the entity name |
| Namespace | A logical grouping prefix that prevents collisions between categories |

---

## 4. Rules

### 4.1 General Rules

These rules apply to all entity identifiers (tokens, components, assets, templates, specifications). File names follow separate rules in Section 4.4.

| # | Rule | Format |
|---|---|---|
| R01 | All entity identifiers must use **lowercase** only | `button` not `Button` |
| R02 | All entity identifiers must use **kebab-case** between segments | `primary-button` not `primaryButton` |
| R03 | All identifiers must use a **single hyphen** between segments | `color-primary` not `color--primary` |
| R04 | Identifiers must not contain spaces | `header-nav` not `header nav` |
| R05 | Identifiers must not contain underscores | Not permitted |
| R06 | Identifiers must begin with a letter, not a digit | `3d-card` not permitted |
| R07 | Identifiers must be globally unique within their category | No duplicates |
| R08 | Identifiers must not exceed 64 characters in length | Max 64 |
| R09 | Reserved characters must not appear in any segment | `./\#%&+` |

### 4.2 Entity ID Rules

Each entity type from the Ontology uses a fixed prefix.

| Entity | Prefix | Pattern | Example |
|---|---|---|---|
| Document | — | `{level-code}-{number}` | `C-01`, `L-03` |
| Standard | `S-` | `S-{domain}` | `S-foundations` |
| Specification | `SP-` | `SP-{entity-name}` | `SP-color-token` |
| Component | `CMP-` | `CMP-{component-name}` | `CMP-header` |
| Token | `TK-` | `TK-{category}-{property}-{variant}` | `TK-color-primary` |
| Asset | `AS-` | `AS-{type}-{name}` | `AS-logo-primary` |
| Template | `TPL-` | `TPL-{platform}-{purpose}` | `TPL-linkedin-post` |
| Artifact | — | `{path}/{file-name}.{format}` | `tokens/colors.json` |

### 4.3 Token Naming Rules

Token identifiers must follow a strict three-segment structure.

**Pattern: `TK-{category}-{property}-{variant}`**

| Segment | Allowed Values |
|---|---|
| category | `color`, `typography`, `spacing`, `radius`, `shadow`, `motion`, `border` |
| property | A single noun describing the property (e.g., `primary`, `background`, `body`, `md`, `sm`) |
| variant | Optional: `hover`, `active`, `disabled`, `dark`, `light` |

**Rules:**
- The variant segment is optional. When omitted, the token represents the base/default value.
- A token must not contain more than four segments.
- A token must contain at least two segments.

**Valid examples:**
- `TK-color-primary`
- `TK-color-primary-hover`
- `TK-spacing-md`
- `TK-typography-body`
- `TK-radius-lg`

**Invalid examples:**
- `TK-primary` (missing category)
- `TK-color-primary-hover-dark-active` (too many segments)
- `tk-Color-Primary` (wrong case)

### 4.4 File Naming Rules

All files in the repository must follow these conventions.

| # | Rule | Example |
|---|---|---|
| F01 | Use **PascalCase** for governance documents | `Naming-Convention-Law.md` |
| F02 | Use **kebab-case** for implementation files | `colors.json`, `primary-button.svg` |
| F03 | README files must be named exactly `README.md` | `README.md` |
| F04 | Directory names must use kebab-case | `03-Operational-Laws` |
| F05 | Prefix governance files with their level number | `00-Meta-Architecture/` |

### 4.5 Component Naming Rules

Component identifiers must follow the pattern `CMP-{domain}-{name}`.

| # | Rule | Example |
|---|---|---|
| C01 | Component names must be nouns | `CMP-header`, `CMP-footer` |
| C02 | Compound names use single hyphen | `CMP-statistic-card` |
| C03 | Variant suffixes use double hyphen | `CMP-button--primary` |
| C04 | State suffixes use colon notation | `CMP-button:hover` |
| C05 | Component names must not duplicate | Globally unique |

### 4.6 Asset Naming Rules

Asset identifiers must follow the pattern `AS-{type}-{name}`.

| # | Rule | Example |
|---|---|---|
| A01 | Asset type must be one of: `logo`, `icon`, `illustration`, `pattern`, `background`, `shape` | `AS-logo-primary` |
| A02 | Asset sub-variants append after a double hyphen | `AS-logo-primary--dark` |
| A03 | Icons use their Lucide name prefixed with `icon` | `AS-icon-arrow-right` |

---

## 5. Examples

### 5.1 Valid Identifiers

```
Document:           C-01, L-03, S-foundations
Specification:      SP-button, SP-color-token
Component:          CMP-header, CMP-statistic-card, CMP-button--primary
Token:              TK-color-primary, TK-spacing-lg, TK-typography-body
Asset:              AS-logo-primary, AS-icon-arrow-right, AS-pattern-dots
Template:           TPL-linkedin-post, TPL-presentation-deck
Implementation:     tokens/colors.json, components/button/button.svg
```

### 5.2 Files in Repository

```
AEL-Design-System/
├── 00-Meta-Architecture/
│   ├── README.md
│   └── AEL-Meta-Architecture.md
├── 01-Ontology/
│   └── AEL-Ontology.md
├── 02-Constitution/
│   └── AEL-Constitution.md
├── 03-Operational-Laws/
│   └── Naming-Convention-Law.md
└── 06-Implementation/
    └── tokens/
        └── colors.json
```

---

## 6. Exceptions

Exceptions to this law are permitted only under the following conditions:

| # | Condition | Approval |
|---|---|---|
| X01 | External platform requirement (e.g., Canva forces uppercase) | AEL Digital Studio |
| X02 | Legacy identifier that cannot be migrated | AEL Digital Studio |
| X03 | Industry-standard term that violates a rule (e.g., `3d`) | AEL Digital Studio |

All exceptions must be recorded in a file named `EXCEPTIONS.md` within the applicable directory, listing the identifier, the rule violated, the reason, and the approval date.

---

## 7. Compliance

### 7.1 Verification

Compliance with this law shall be verified through:

- **Manual review** during document approval.
- **Automated validation** via a naming convention checker (to be implemented).
- **Pre-commit hooks** that reject non-compliant names (to be implemented).

### 7.2 Violations

| Severity | Definition | Action |
|---|---|---|
| Critical | Duplicate identifier | Must be resolved before merge |
| Major | Invalid prefix or pattern | Must be resolved before release |
| Minor | Case or formatting violation | Should be resolved; logged for review |

### 7.3 Grace Period

Existing artifacts that do not conform to this law at the time of adoption are granted a 90-day grace period to be renamed. During this period they are marked as `legacy`.

---

## 8. Versioning

This law follows semantic versioning as defined in the Constitution (Section 6).

| Version | Date | Change |
|---|---|---|
| 0.1 | 2026-07-30 | Initial draft |

---

*End of Naming Convention Law v0.1.*