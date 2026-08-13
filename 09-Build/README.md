# 09 — Build & Distribution Infrastructure

**Purpose:** The build engine that transforms SSOT Implementation tokens into platform-specific outputs. All generators consume exclusively from `06-Implementation/tokens/`. Nothing is hand-authored in output directories.

**Architecture:**

```
06-Implementation/tokens/ (SSOT)
        │
        ▼
    Validation (3 checks)
        │
        ▼
    Registry Generation
        │
        ▼
    Platform Exports (7 targets)
```

**Structure:**

| Directory | Purpose |
|-----------|---------|
| `build.js` | Build coordinator — orchestrates validation, generation, and export |
| `generators/` | Platform-specific token generators — one script per target |
| `validators/` | Pre-build validation — naming, SSOT, dependency checks |

**Generators:**

| Generator | Output | Format |
|-----------|--------|--------|
| `css-generator.js` | `platforms/css/variables.css` | CSS Custom Properties |
| `scss-generator.js` | `platforms/scss/_tokens.scss` | SCSS Variables |
| `swift-generator.js` | `platforms/swift/AELTokens.swift` | Swift Enum |
| `android-generator.js` | `platforms/android/ael_tokens.xml` | Android XML Resources |
| `figma-generator.js` | `platforms/figma/figma-tokens.json` | Figma Token Format |
| `w3c-generator.js` | `platforms/w3c/design-tokens.json` | W3C Design Tokens Format |
| `json-generator.js` | `platforms/json/tokens.json` | Flat JSON API |
| `registry-generator.js` | `../../07-Registry/token-registry.json` | AEL Registry (generated) |

**Validators:**

| Validator | Checks |
|-----------|--------|
| `token-validator.js` | Naming convention compliance, category validity, segment count, casing |
| `ssot-validator.js` | Zero hex/px in Standards and Specifications, registry consistency |
| `dependency-validator.js` | Token ID references resolve, no downward references from Standards/Specs |

**Usage:**

```bash
node 09-Build/build.js
```

**Build fails if:**

- Any validation fails
- Any generator throws

**Belongs here:** Build scripts, generators, validators. Nothing else.

**Does NOT belong here:** Governance documents, tokens, platform output files, registry.
