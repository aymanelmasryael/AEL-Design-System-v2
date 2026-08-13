const fs = require('fs');
const path = require('path');

const ROOT = path.join(__dirname, '..', '..');
const errors = [];

const specDir = path.join(ROOT, '05-Specifications');
const implDir = path.join(ROOT, '06-Implementation', 'tokens');

const implTokens = {};
for (const f of fs.readdirSync(implDir)) {
  if (!f.endsWith('.json')) continue;
  const d = JSON.parse(fs.readFileSync(path.join(implDir, f), 'utf8'));
  for (const id of Object.keys(d.tokens)) {
    implTokens[id] = f;
  }
}

for (const file of fs.readdirSync(specDir)) {
  if (!file.endsWith('.md')) continue;
  const content = fs.readFileSync(path.join(specDir, file), 'utf8');

  const tokenRefs = content.match(/TK-[\w-]+/g) || [];
  for (const ref of tokenRefs) {
    if (!implTokens[ref]) {
      errors.push(`${file}: references token '${ref}' which does not exist in Implementation`);
    }
  }

  const stdRefs = content.match(/S-[\w-]+/g) || [];
  for (const ref of stdRefs) {
    const stdFile = ref.replace(/\s.*/, '') + '.md';
    if (!fs.existsSync(path.join(ROOT, '04-Standards', stdFile))) {
      if (['S-Color', 'S-Typography', 'S-Spacing', 'S-Grid', 'S-Button', 'S-Component', 'S-Icon', 'S-Illustration', 'S-Image'].some(s => ref.startsWith(s))) {
        errors.push(`${file}: references Standard '${ref}' which may not exist`);
      }
    }
  }

  const downwardRefs = content.match(/07-Registry|token-registry\.json|06-Implementation\/platforms/g) || [];
  for (const dr of downwardRefs) {
    errors.push(`${file}: downward reference to '${dr}' — Specifications must not reference Registry or platform artifacts`);
  }

  const ssotRefs = content.match(/06-Implementation\/tokens\//g) || [];
  if (ssotRefs.length > 0 && !content.includes('PROP-2026-001') && !content.includes('DD06')) {
    errors.push(`${file}: references 06-Implementation/tokens/ without citing PROP-2026-001 or DD06`);
  }
}

for (const file of fs.readdirSync(path.join(ROOT, '04-Standards'))) {
  if (!file.endsWith('.md')) continue;
  const content = fs.readFileSync(path.join(ROOT, '04-Standards', file), 'utf8');
  const downwardRefs = content.match(/07-Registry|token-registry\.json|06-Implementation\/platforms|06-Implementation\/Components/g) || [];
  const tokenIds = content.match(/TK-[\w-]+/g) || [];
  for (const dr of downwardRefs) {
    if (!content.includes('PROP-2026-001') && !content.includes('Artifact') && !content.includes('generated')) {
      errors.push(`${file}: downward reference to '${dr}' — Standards must not reference Registry or platform artifacts`);
    }
  }
  const tokensRef = content.match(/06-Implementation\/tokens\//g) || [];
  if (tokensRef.length > 0 && !content.includes('PROP-2026-001') && !content.includes('SSOT')) {
    errors.push(`${file}: references 06-Implementation/tokens/ without SSOT governance context`);
  }
}

if (errors.length > 0) {
  throw new Error(`Dependency validation failed:\n  - ${errors.join('\n  - ')}`);
}
