# Override & Exception Policy

**Version:** 0.1
**Status:** Draft
**Owner:** AEL Digital Studio
**Governed By:** AEL Constitution v0.1
**Classification:** Operational Law — Level 2

---

## 1. Purpose

This policy defines the conditions under which a rule, standard, or specification within the AEL Design System may be overridden or exempted. It ensures that exceptions are documented, approved, time-bound, and auditable — preventing ad-hoc deviations from becoming permanent inconsistencies.

Without this policy, every exception is a liability. With it, exceptions become traceable architectural decisions.

---

## 2. Scope

### 2.1 In Scope

- Any governance rule defined in the Constitution or Operational Laws.
- Any requirement defined in a Standard.
- Any parameter defined in a Specification.
- Any entity that cannot conform to an applicable rule.

### 2.2 Out of Scope

- Implementation bugs or errors (these are defects, not exceptions).
- Temporary work-in-progress during active development (these are drafts).
- Changes to the Meta-Architecture or Ontology (these require constitutional amendment, not exception).
- Platform-specific constraints already declared in the relevant Standard.

---

## 3. Definitions

| Term | Definition |
|---|---|
| Override | A permanent replacement of a rule for a specific entity or context |
| Exception | A time-limited exemption from a rule for a specific entity or context |
| Waiver | A one-time permission to proceed without meeting a rule, granted before the fact |
| Deviation | Any instance where an entity does not conform to an applicable rule |
| Expiry | The version or date at which an exception automatically becomes invalid |
| Migration Path | The plan for bringing a non-conforming entity into compliance |

---

## 4. Rules

### 4.1 General Principles

| # | Rule | Verification |
|---|---|---|
| GP01 | All deviations must be documented. An undocumented deviation is a violation | Every exception must have a record |
| GP02 | Exceptions must have an expiry. An exception without an expiry is permanent debt | Every exception must include a version or date |
| GP03 | Override is permitted only at the level where the rule is defined | A Standard may not override a Constitutional rule |
| GP04 | An exception never propagates. It applies only to the entity for which it was granted | One entity, one exception |
| GP05 | Exceptions must be reviewed at every major version. Unreviewed exceptions expire automatically | Mandatory review cycle |

### 4.2 Exception Types

| # | Type | Duration | Approval | Example |
|---|---|---|---|---|
| ET01 | Technical Constraint | Permanent or until constraint is removed | AEL Digital Studio | Platform API limitation |
| ET02 | Temporal Grace Period | Maximum 2 versions | Operational Law Owner | Migration of legacy naming |
| ET03 | Contextual Variance | Until context changes | Standard Owner | Brand variant for partner co-branding |
| ET04 | Experimental | 1 version max | AEL Digital Studio | Testing a new pattern before full standardization |

### 4.3 Documentation Requirements

Every exception must be recorded in a machine-readable format with the following fields:

| # | Field | Required | Description |
|---|---|---|---|
| DR01 | `exception-id` | Yes | Unique identifier: `EX-{year}-{number}` |
| DR02 | `created` | Yes | ISO 8601 date |
| DR03 | `expires` | Yes | Version or date of automatic expiry |
| DR04 | `type` | Yes | One of: `technical`, `grace-period`, `contextual`, `experimental` |
| DR05 | `entity` | Yes | The entity ID being exempted |
| DR06 | `rule` | Yes | The rule ID being overridden |
| DR07 | `rationale` | Yes | Why the exception is necessary |
| DR08 | `approved-by` | Yes | Approver name or role |
| DR09 | `migration-path` | Conditional | Required for `grace-period` and `experimental` types |
| DR10 | `replaces` | Conditional | If this exception supersedes a previous one |

### 4.4 Approval Authority

| # | Rule | Verification |
|---|---|---|
| AA01 | Exceptions to a Standard require approval from the Standard Owner | Approval must be documented |
| AA02 | Exceptions to an Operational Law require approval from AEL Digital Studio | Approval must be documented |
| AA03 | Exceptions to the Constitution are not permitted | Absolute prohibition |
| AA04 | Override of a rule at Level N requires approval at Level N-1 | Escalation required |

### 4.5 Expiry and Renewal

| # | Rule | Verification |
|---|---|---|
| ER01 | Every exception expires automatically at the specified version or date | System-enforced |
| ER02 | An expired exception may be renewed once. After that, it must be resolved or escalated | Max one renewal |
| ER03 | Renewal requires re-approval at the same level as the original | Re-approval required |
| ER04 | If an exception expires without renewal or resolution, the entity is non-compliant | Violation flagged |

### 4.6 Prohibited Exceptions

The following may never be granted an exception:

| # | Prohibited | Reason |
|---|---|---|
| P01 | Override of a Meta-Architecture rule | Destroys the modeling foundation |
| P02 | Override of the Canonical Representation rule | Creates duplicate definitions |
| P03 | Override of the Dependency Authority Flow | Breaks the governance hierarchy |
| P04 | Exception that applies to all entities in a category | Would effectively repeal the rule |

---

## 5. Examples

### 5.1 Valid Exception Record

```json
{
  "exception-id": "EX-2026-001",
  "created": "2026-07-30",
  "expires": "v0.4",
  "type": "grace-period",
  "entity": "AS-logo-primary--legacy",
  "rule": "AN-01 (Naming Convention Law)",
  "rationale": "Logo file cannot be renamed until Q3 brand refresh completes",
  "approved-by": "AEL Digital Studio",
  "migration-path": "Rename to AS-logo-primary on or before v0.4 release"
}
```

### 5.2 Invalid Exception (Constitutional Override)

```
Attempt: Override Constitution Section 4.3 (Documentation First)
Reason: "We need to ship without documentation"
Result: DENIED — Constitutional rules may not be overridden
```

### 5.3 Invalid Exception (Category-Wide)

```
Attempt: Exempt all Components from using Tokens
Reason: "It's faster to hardcode values"
Result: DENIED — Category-wide exception effectively repeals the rule
```

### 5.4 Valid Exception (Technical Constraint)

```
A third-party platform forces uppercase icon names.
Exception applies to AS-icon-* assets only.
Approved as Technical Constraint, permanent until platform changes.
```

---

## 6. Compliance

### 6.1 Exception Registry

All active exceptions must be recorded in a single machine-readable file:

```
07-Registry/exception-registry.json
```

This file is the single source of truth for all deviations. Any exception not recorded in this file does not exist.

### 6.2 Verification

Compliance shall be verified through:

- **Registry audit** — A scan of all active exceptions at every release.
- **Expiry check** — Automated verification that no exception has passed its expiry.
- **Renewal limit check** — No exception renewed more than once.
- **Category scope check** — No exception applies to an entire entity category.

### 6.3 Violations

| Severity | Definition | Action |
|---|---|---|
| Critical | Override of a prohibited rule (Section 4.6) | Must be reverted before merge |
| Major | Expired exception without renewal | Must be resolved or renewed before release |
| Minor | Missing or incomplete exception documentation | Must be corrected; logged for audit |

---

## 7. Versioning

This policy follows semantic versioning as defined in the Constitution (Section 6).

| Version | Date | Change |
|---|---|---|
| 0.1 | 2026-07-30 | Initial draft |

---

*End of Override & Exception Policy v0.1.*