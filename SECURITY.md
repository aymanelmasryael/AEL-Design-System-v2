# Security Policy

## Reporting a Vulnerability

If you discover a security vulnerability in the AEL Design System, please report it privately to:

**Email:** security@ael.design

Do not open a public issue. We will respond within 72 hours.

## Scope

- Build pipeline vulnerabilities
- Token injection in generated outputs
- Dependency vulnerabilities in runtime JavaScript
- Cross-site scripting vectors in component templates

## Out of Scope

- Issues in unmodified third-party dependencies
- Social engineering attacks
- Physical security

## Supported Versions

| Version | Supported |
|---------|-----------|
| 0.2.x | Yes |
| < 0.2 | No |

## Disclosure Policy

- Acknowledgment within 72 hours
- Fix within 30 days (critical: 7 days)
- Public disclosure after fix is released
- Credit given to reporter unless anonymity requested

## Dependencies

The Reference Implementation has zero runtime dependencies. The build system uses only Node.js standard library (`fs`, `path`).
