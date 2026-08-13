const fs = require('fs');
const path = require('path');

const ROOT = path.join(__dirname, '..', '..');
const tokens = JSON.parse(process.env.AEL_TOKENS);
const errors = [];

const implValues = {};
for (const tok of Object.values(tokens)) {
  const v = JSON.stringify(tok.value);
  if (!implValues[v]) implValues[v] = [];
  implValues[v].push(tok.id);
}

const hexPattern = /#[0-9A-Fa-f]{3,8}\b/g;
const pxPattern = /\b\d+px\b/g;

function isReferenceLine(line, dirname) {
  if (dirname === '05-Specifications') {
    if (line.includes('TK-')) return true;
    if (line.includes('Token Value') || line.includes('from SSOT')) return true;
    if (line.includes('Size Scale') || line.includes('| Size | Token |')) return true;
  }
  return false;
}

for (const dir of ['04-Standards', '05-Specifications']) {
  const dirPath = path.join(ROOT, dir);
  if (!fs.existsSync(dirPath)) continue;

  for (const file of fs.readdirSync(dirPath)) {
    if (!file.endsWith('.md')) continue;
    const content = fs.readFileSync(path.join(dirPath, file), 'utf8');
    const lines = content.split('\n');

    for (let i = 0; i < lines.length; i++) {
      const line = lines[i];

      let match;
      hexPattern.lastIndex = 0;
      while ((match = hexPattern.exec(line)) !== null) {
        if (!isReferenceLine(line, dir)) {
          errors.push(`${dir}/${file}:${i + 1}: hex '${match[0]}' in '${line.trim().substring(0, 80)}'`);
        }
      }

      pxPattern.lastIndex = 0;
      while ((match = pxPattern.exec(line)) !== null) {
        if (!isReferenceLine(line, dir)) {
          errors.push(`${dir}/${file}:${i + 1}: px '${match[0]}' in '${line.trim().substring(0, 80)}'`);
        }
      }
    }
  }
}

const regPath = path.join(ROOT, '07-Registry', 'token-registry.json');
if (fs.existsSync(regPath)) {
  const reg = JSON.parse(fs.readFileSync(regPath, 'utf8'));

  if (!reg.generated) {
    errors.push('Registry: missing "generated" flag');
  }

  let regCount = 0;
  for (const cat of Object.values(reg.tokens)) {
    regCount += cat.length;
  }

  const implCount = Object.keys(tokens).length;
  if (regCount !== implCount) {
    errors.push(`Registry count mismatch: Registry=${regCount}, Implementation=${implCount}`);
  }
}

if (errors.length > 0) {
  throw new Error(`SSOT validation failed:\n  - ${errors.join('\n  - ')}`);
}
