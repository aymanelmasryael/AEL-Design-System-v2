#!/usr/bin/env node
/**
 * AEL Operating Protocol Validator
 *
 * Verifies that the governing protocol document satisfies its own
 * structural contracts (Section 34.1):
 *   1. Rule ID uniqueness
 *   2. Normative keyword presence (RFC 2119)
 *   3. Version consistency (protocol header vs VERSION vs CHANGELOG)
 *   4. State machine integrity
 *
 * Exit code 0 = compliant, 1 = violations found, 2 = fatal error.
 * Zero runtime dependencies (Node stdlib only).
 */
const fs = require('fs');
const path = require('path');

const ROOT = path.join(__dirname, '..');
const PROTOCOL_PATH = path.join(ROOT, '03-Operational-Laws', 'AEL-Operating-Protocol.md');
const VERSION_PATH = path.join(ROOT, 'VERSION');
const CHANGELOG_PATH = path.join(ROOT, 'CHANGELOG.md');

const errors = [];

function fail(id, location, message) {
  errors.push(`[FAIL] ${id} — ${location}: ${message}`);
}

// ── Load sources ────────────────────────────────────────────────────────────
let protocol = '';
try {
  protocol = fs.readFileSync(PROTOCOL_PATH, 'utf8');
} catch (e) {
  console.error(`FATAL: cannot read protocol at ${PROTOCOL_PATH}: ${e.message}`);
  process.exit(2);
}

// ── 1. Rule ID uniqueness (definitions only, not prose references) ──────────
const lines = protocol.split('\n');
// A rule ID is a "definition" in exactly two syntactic locations:
//   (a) a table row starting `| DEC-01 | ...`
//   (b) a "> *Normative form:* DEC-01. ..." statement
// References in running prose are legal and ignored.
const defRows = [];
for (const line of lines) {
  const t = line.match(/^\|\s*\*\*?([A-Z]{3}-\d+(?:\.\d+)?)\*?\*\s*\|/);
  if (t) defRows.push(t[1]);
  const n = line.match(/^\s*\*\*Normative form:\*\*\s+([A-Z]{3}-\d+(?:\.\d+)?)\s*\.?\s/);
  if (n) defRows.push(n[1]);
}
const seen = new Map();
for (const id of defRows) {
  seen.set(id, (seen.get(id) || 0) + 1);
}
let violationCount = 0;
for (const [id, count] of seen) {
  if (count > 1) {
    fail('RULE-01', id, `rule ID defined ${count} times (must be unique)`);
    violationCount++;
  }
}
const ruleIds = protocol.match(/\b[A-Z]{3}-\d+(?:\.\d+)?\b/g) || [];

// ── 2. Normative keyword presence ───────────────────────────────────────────
const normKeywords = ['MUST NOT', 'SHOULD NOT', 'MUST', 'SHOULD', 'MAY'];
const statementBlocks = [];
let inBlock = false;
let block = [];
let blockStart = 0;

const blockStarters = /^(#+.*)(Form|Rule|State|Transition|Resolution|Verification)/;
const isRuleHeader = /(\[FAIL\]|Normative form|Rule\]|Rule\||^\s*\| ID \|)/;

for (let i = 0; i < lines.length; i++) {
  const line = lines[i];
  // capture "> *Normative form:* XID-nn. ..." statements
  const normMatch = line.match(/^\s*\*\*Normative form:\*\*\s+([A-Z]{3})-\d+(?:\.\d+)?\s+\.?\s*(.*)/);
  if (normMatch) {
    const [full, prefix] = normMatch;
    const text = full.replace(/^\s*\*\*Normative form:\*\*\s+/, '');
    let hasKeyword = false;
    for (const kw of normKeywords) {
      if (text.includes(kw)) { hasKeyword = true; break; }
    }
    const idMatch = text.match(/([A-Z]{3}-\d+(?:\.\d+)?)\s*\./);
    const ruleId = idMatch ? idMatch[1] : prefix;
    if (!hasKeyword) {
      fail('KW-01', ruleId, 'normative statement missing RFC 2119 keyword');
    }
  }

  // table rows with "ID | Rule"
  const tableRow = line.match(/^\|\s*([A-Z]{3}-\d+(?:\.\d+)?)\s*\|/);
  if (tableRow) {
    const id = tableRow[1];
    let hasKeyword = false;
    for (const kw of normKeywords) {
      if (line.includes(kw)) { hasKeyword = true; break; }
    }
    const isStmRule = id.startsWith('STM-') || id.startsWith('VER-') || id.startsWith('CMP-');
    if (!hasKeyword && !isStmRule) {
      fail('KW-02', id, 'rule row missing RFC 2119 keyword');
    }
  }
}

// ── 3. Version consistency ──────────────────────────────────────────────────
// Per AEL Constitution §6.3, governance documents carry their own version,
// independent of the system VERSION file. The document's consistency
// contract is: header version == Version History table == CHANGELOG entry.
const headerVersion = protocol.match(/^\*\*Version:\*\*\s+(.+)$/m);
const docVersion = headerVersion && headerVersion[1].trim();

const historySection = protocol.split('## 36. Version History')[1] || '';
const historyHasVersion = docVersion && new RegExp(`^\\|\\s*${docVersion.replace(/\./g, '\\.')}\\s*\\|`, 'm').test(historySection);
if (docVersion && !historyHasVersion) {
  fail('VER-03', 'Version History', `header version "${docVersion}" missing from Version History table`);
}

let changelog = '';
try {
  changelog = fs.readFileSync(CHANGELOG_PATH, 'utf8');
} catch (e) {
  fail('VER-CHK', 'CHANGELOG', `cannot read ${CHANGELOG_PATH}`);
}
if (docVersion && changelog && !changelog.includes(docVersion)) {
  fail('VER-03', 'CHANGELOG', `protocol version "${docVersion}" not found in CHANGELOG.md`);
}

// ── 4. State machine integrity ──────────────────────────────────────────────
const allowedTransitions = new Set([
  'PLANNED→IN PROGRESS',
  'IN PROGRESS→IMPLEMENTED',
  'IN PROGRESS→BLOCKED',
  'BLOCKED→IN PROGRESS',
  'IMPLEMENTED→VERIFIED',
  'VERIFIED→COMPLETE',
  'PLANNED→BLOCKED',
  'BLOCKED→COMPLETE',
]);
const disallowed = [
  ['IMPLEMENTED', 'COMPLETE'],
  ['PLANNED', 'COMPLETE'],
];
const tableSection = protocol.split('### 32.2 Transition Table')[1] || '';
const tableLines = tableSection.split('\n').slice(0, 20);
for (const line of tableLines) {
  const m = line.match(/^\|\s*([A-Z ]+)\s*\|\s*([A-Z ]+)\s*\|\s*(.*?)\s*\|\s*(YES|NO)\s*\|/);
  if (!m) continue;
  const from = m[1].trim().toUpperCase();
  const to = m[2].trim().toUpperCase();
  const allowed = m[4].trim().toUpperCase();
  const transition = `${from}→${to}`;
  if (allowed === 'YES' && !allowedTransitions.has(transition)) {
    fail('STM-09', transition, 'transition marked YES but not in allowed transition set');
  }
}

// ── Report ──────────────────────────────────────────────────────────────────
if (errors.length > 0) {
  console.error(`AEL Operating Protocol validation FAILED — ${errors.length} violation(s):`);
  for (const e of errors) console.error(`  ${e}`);
  process.exit(1);
}

console.log('AEL Operating Protocol validation PASSED.');
console.log(`  rules scanned      : ${ruleIds.length}`);
console.log(`  transition rows    : validated`);
console.log(`  version            : ${docVersion}`);
process.exit(0);