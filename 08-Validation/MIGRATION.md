# AEL Migration Guide

## v0.2 Migration

The v0.2 architecture refactoring (PROP-2026-001) established:

- **SSOT:** All concrete values in `06-Implementation/tokens/`
- **Registry:** Generated, never hand-authored
- **Standards:** Rules only, no values
- **Specifications:** Token ID references, no values

## Token Migration

Hardcoded values → Token references:

```
#0074FF → var(--ael-color-primary)
16px    → var(--ael-typography-size-body)
8px     → var(--ael-spacing-sm)
```

## Component Migration

All 37 components follow SP-Component v1.2 framework. No legacy components exist — v0.2 is the baseline.
