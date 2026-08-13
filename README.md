# AEL Design System Platform

**Enterprise-grade, vendor-neutral, cross-platform Design System.**

| | |
|---|---|
| **Version** | 0.2 |
| **Status** | Architecture & Reference Implementation — Stable |
| **Production Readiness** | 87% |
| **Components** | 37 (HTML + CSS + JS) |
| **Tokens** | 143 |
| **Platforms** | 11 targets (1 complete, 10 scaffolded) |

## Identity

| | |
|---|---|
| **Project** | AEL Design System Platform |
| **Owner** | Ayman Elmasry |
| **Organization** | AEL Digital Studio™ |
| **Official Logo** | `ael-logo.svg` |
| **Brand** | See [BRAND.md](./BRAND.md) |
| **License** | See [LICENSE](./LICENSE) |

---

## Quick Links

| Document | Purpose |
|----------|---------|
| [BRAND.md](./BRAND.md) | Official brand identity, logo, and usage rules |
| [ARCHITECTURE.md](./ARCHITECTURE.md) | How the system is architected |
| [PROJECT_STATUS.md](./PROJECT_STATUS.md) | Where the project stands today |
| [CHANGELOG.md](./CHANGELOG.md) | Release notes and roadmap |
| [REFERENCE_IMPLEMENTATION.md](./REFERENCE_IMPLEMENTATION.md) | Contract between reference and platform libraries |
| [CONTRIBUTING.md](./CONTRIBUTING.md) | How to contribute components, tokens, and platforms |
| [00-Meta-Architecture/ROADMAP.md](./00-Meta-Architecture/ROADMAP.md) | Static execution plan |
| [00-Meta-Architecture/PROGRESS.md](./00-Meta-Architecture/PROGRESS.md) | Dynamic progress tracker |

## Build

```bash
node 09-Build/build.js
```

Validates all layers, regenerates registries, exports tokens to 7 platform formats.

## Architecture

```
Governance → Infrastructure → Foundations → Components → Composition → Distribution → Knowledge
```

All concrete values are Single Source of Truth in `06-Implementation/tokens/`. Standards define rules only. Specifications declare token bindings only. Registry is generated — never hand-authored.

## License

See [LICENSE](./LICENSE).

---

*AEL Design System Platform v0.2*  
*Copyright © 2026 Ayman Elmasry. All rights reserved.*  
*Owner: Ayman Elmasry · Organization: AEL Digital Studio™ · Official Logo: `ael-logo.svg`*
