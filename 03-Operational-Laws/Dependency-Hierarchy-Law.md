# Dependency Hierarchy Law

**Version:** 0.1
**Status:** Draft
**Owner:** AEL Digital Studio
**Governed By:** AEL Constitution v0.1
**Classification:** Operational Law — Level 2

---

## 1. Purpose

This law defines the dependency structure of the AEL Design System. It establishes which entities may depend on which others, the direction of authority, and the rules for resolving conflicts when dependencies overlap or contradict.

Every entity, document, and artifact in the system must conform to this dependency structure. A violation of this law is a violation of the Constitution.

---

## 2. Scope

### 2.1 In Scope

- All entity types defined in the AEL Ontology.
- All governance documents (Constitution, Operational Laws, Standards).
- All Specifications, Components, Tokens, Assets, Templates, and Artifacts.
- Relationships between entities within and across levels.

### 2.2 Out of Scope

- External code dependencies (npm packages, library imports).
- File-system symlinks or git submodules.
- Build-time or runtime dependency graphs of implementation code.
- Human team structures or reporting lines.

---

## 3. Definitions

| Term | Definition |
|---|---|
| Dependency | A directional relationship where one entity requires another to be defined, validated, or interpreted |
| Authority Flow | The direction in which governance constraints propagate |
| Upstream | An entity that governs, constrains, or defines another entity (higher authority) |
| Downstream | An entity that is governed, constrained, or defined by another entity (lower authority) |
| Direct Dependency | A dependency on an entity within the same or adjacent level |
| Transitive Dependency | A dependency on an entity two or more levels away, inherited through an intermediate entity |
| Circular Dependency | A dependency cycle where A depends on B and B depends on A, directly or transitively |
| Level | A tier in the governance hierarchy: Constitution, Operational Laws, Standards, Specifications, Implementation |

---

## 4. Rules

### 4.1 Authority Flow

The system recognizes a single, linear authority hierarchy:

```
AEL Meta-Architecture
  → AEL Ontology
    → Constitution
      → Operational Laws
        → Standards
          → Specifications
            → Implementation
```

| # | Rule | Verification |
|---|---|---|
| AF01 | Authority flows top-down only | No downstream document may override an upstream document |
| AF02 | Every entity must trace to exactly one parent in the level above | Orphan entities are not permitted |
| AF03 | No entity may skip a level when establishing authority | Direct governance only |

### 4.2 Dependency Direction

| # | Rule | Verification |
|---|---|---|
| DD01 | Dependencies must point upward (downstream → upstream) | A Specification may reference a Standard; a Standard must not reference a Specification |
| DD02 | An entity may depend on any entity at the same level | A Standard may reference another Standard |
| DD03 | An entity may depend on any entity at any higher level | A Component may reference a Token and a Standard |
| DD04 | An entity may NOT depend on an entity at a lower level | Absolute prohibition |
| DD05 | Cross-level dependencies must be declared explicitly | Implicit dependencies are not permitted |

### 4.3 Level-Specific Rules

| Level | May Depend On | Must NOT Depend On |
|---|---|---|
| Constitution | Meta-Architecture, Ontology | Operational Laws, Standards, Specifications, Implementation |
| Operational Laws | Meta-Architecture, Ontology, Constitution | Standards, Specifications, Implementation |
| Standards | Meta-Architecture, Ontology, Constitution, Operational Laws | Specifications, Implementation |
| Specifications | Meta-Architecture, Ontology, Constitution, Operational Laws, Standards | Implementation |
| Implementation | All higher levels | Nothing at same level or below |

### 4.4 Circular Dependency

| # | Rule | Verification |
|---|---|---|
| CD01 | Circular dependencies are prohibited at all levels | A → B → A is not permitted |
| CD02 | A circular dependency spanning more than two levels is prohibited | A → B → C → A is not permitted |
| CD03 | If a circular dependency is detected, the entity with lower authority must be removed or restructured | The higher-authority entity is preserved |

### 4.5 Orphan Rule

| # | Rule | Verification |
|---|---|---|
| OR01 | Every entity must have at least one incoming reference from a higher-level entity | Every Component must be described by a Specification |
| OR02 | Every entity must have at least one valid upstream authority path to the Constitution | Traceable chain required |
| OR03 | An entity with no incoming references for two consecutive versions is flagged for deprecation | Automated audit |

### 4.6 Transitive Dependency

| # | Rule | Verification |
|---|---|---|
| TD01 | A downstream entity inherits all constraints from its upstream chain | A Component implicitly conforms to all Standards in its authority path |
| TD02 | Transitive constraints may not be overridden at the downstream level | A Component may not exempt itself from a Standard |
| TD03 | Transitive dependencies must be documented in the entity metadata | Explicit declaration required |

---

## 5. Examples

### 5.1 Valid Dependency Chain

```
Constitution
  ↓ governs
Operational Laws
  ↓ constrains
Standards (S-Foundations)
  ↓ governs
Specifications (SP-ColorToken)
  ↓ describes
Component (CMP-button)
  ↓ uses
Token (TK-color-primary)
```

Every entity in this chain depends only on entities above it. No circularity. No orphans.

### 5.2 Invalid Dependency (Downward)

```
Specification: SP-button
  ↓ depends on (INVALID)
Implementation: button.css
```

A Specification must not depend on an Implementation. The direction must be reversed: Implementation depends on Specification.

### 5.3 Invalid Dependency (Circular)

```
Standard: S-Components
  ↓ governs
Specification: SP-button
  ↑ governs (INVALID — circular)
```

A Standard governs a Specification. The Specification may not govern the Standard.

### 5.4 Valid Same-Level Dependency

```
Standard: S-Foundations
  ← references
Standard: S-Components
```

Two Standards at the same level may reference each other.

---

## 6. Exceptions

| # | Condition | Approval |
|---|---|---|
| X01 | External platform requirement forces a downward reference | AEL Digital Studio + documented in EXCEPTIONS.md |
| X02 | Bidirectional reference required for circular data model | AEL Digital Studio + Architectural Review |
| X03 | Temporary dependency during migration between versions | Limited to one version cycle |

All exceptions must be recorded in `EXCEPTIONS.md` within the affected directory, with the rule violated, the reason, the approval date, and the expiry version.

---

## 7. Compliance

### 7.1 Verification

Compliance shall be verified through:

- **Manual review** during document approval.
- **Dependency graph analysis** using a registry scanner (to be implemented).
- **Pre-commit hooks** that reject violations (to be implemented).

### 7.2 Violations

| Severity | Definition | Action |
|---|---|---|
| Critical | Circular dependency detected | Must be resolved before merge |
| Major | Downward dependency (Level N → Level N-1) | Must be resolved before release |
| Minor | Missing upstream authority path | Should be resolved; logged for audit |

### 7.3 Grace Period

Existing entities that violate this law at the time of adoption have 90 days to be restructured. During this period they must be documented with a migration plan.

---

## 8. Versioning

This law follows semantic versioning as defined in the Constitution (Section 6).

| Version | Date | Change |
|---|---|---|
| 0.1 | 2026-07-30 | Initial draft |

---

*End of Dependency Hierarchy Law v0.1.*