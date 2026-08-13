#!/usr/bin/env node

const fs = require('fs');
const path = require('path');

const ROOT = path.join(__dirname, '..');
const TOKENS_DIR = path.join(ROOT, '06-Implementation', 'tokens');
const PLATFORMS_DIR = path.join(ROOT, '06-Implementation', 'platforms');
const GENERATORS_DIR = path.join(__dirname, 'generators');
const VALIDATORS_DIR = path.join(__dirname, 'validators');

const GENERATORS = [
  { name: 'CSS Variables', script: 'css-generator.js', output: 'css/variables.css' },
  { name: 'SCSS Variables', script: 'scss-generator.js', output: 'scss/_tokens.scss' },
  { name: 'Swift Tokens', script: 'swift-generator.js', output: 'swift/AELTokens.swift' },
  { name: 'Android XML', script: 'android-generator.js', output: 'android/ael_tokens.xml' },
  { name: 'Figma Tokens', script: 'figma-generator.js', output: 'figma/figma-tokens.json' },
  { name: 'W3C Design Tokens', script: 'w3c-generator.js', output: 'w3c/design-tokens.json' },
  { name: 'JSON API', script: 'json-generator.js', output: 'json/tokens.json' },
  { name: 'Token Registry', script: 'registry-generator.js', output: null },
  { name: 'Asset Registry', script: 'asset-registry-generator.js', output: null },
  { name: 'Component Registry', script: 'component-registry-generator.js', output: null },
  { name: 'React Components', script: 'react-generator.js', output: null },
  { name: 'Vue Components', script: 'vue-generator.js', output: null }
];

const VALIDATORS = [
  { name: 'Token Naming', script: 'token-validator.js' },
  { name: 'SSOT Integrity', script: 'ssot-validator.js' },
  { name: 'Dependency Hierarchy', script: 'dependency-validator.js' }
];

function loadTokens() {
  const tokens = {};
  const files = fs.readdirSync(TOKENS_DIR).filter(f => f.endsWith('.json'));
  for (const file of files) {
    const data = JSON.parse(fs.readFileSync(path.join(TOKENS_DIR, file), 'utf8'));
    const category = data.category;
    const domain = data.domain || null;
    for (const [id, tok] of Object.entries(data.tokens)) {
      tokens[id] = {
        id,
        category,
        domain,
        value: tok.value,
        type: tok.type,
        role: tok.role,
        tier: data.tier
      };
    }
  }
  return tokens;
}

function runValidator(name, script) {
  const scriptPath = path.join(VALIDATORS_DIR, script);
  if (!fs.existsSync(scriptPath)) {
    console.log(`  ⚠ ${name}: script not found, skipping`);
    return true;
  }
  try {
    require(scriptPath);
    console.log(`  ✓ ${name}: PASS`);
    return true;
  } catch (e) {
    console.error(`  ✗ ${name}: FAIL — ${e.message}`);
    return false;
  }
}

function runGenerator(name, script, outputFile) {
  const scriptPath = path.join(GENERATORS_DIR, script);
  if (!fs.existsSync(scriptPath)) {
    console.log(`  ⚠ ${name}: generator not found, skipping`);
    return true;
  }
  try {
    const generate = require(scriptPath);
    const output = generate();
    if (outputFile) {
      const dest = path.join(PLATFORMS_DIR, outputFile);
      fs.mkdirSync(path.dirname(dest), { recursive: true });
      const content = typeof output === 'string' ? output : JSON.stringify(output, null, 2);
      fs.writeFileSync(dest, content + '\n');
      console.log(`  ✓ ${name}: ${outputFile}`);
    } else {
      console.log(`  ✓ ${name}: generated`);
    }
    return true;
  } catch (e) {
    console.error(`  ✗ ${name}: FAIL — ${e.message}`);
    return false;
  }
}

console.log(`\n═══════════════════════════════════════`);
console.log(`  AEL BUILD SYSTEM v0.2`);
console.log(`  Source: 06-Implementation/tokens/`);
console.log(`  Target: 06-Implementation/platforms/`);
console.log(`═══════════════════════════════════════\n`);

const tokens = loadTokens();
console.log(`Loaded: ${Object.keys(tokens).length} tokens from ${TOKENS_DIR}\n`);

process.env.AEL_TOKENS = JSON.stringify(tokens);

console.log('── VALIDATION ──');
let allValid = true;
for (const v of VALIDATORS) {
  if (!runValidator(v.name, v.script)) allValid = false;
}

if (!allValid) {
  console.error('\n⛔ Build aborted: validation failed.\n');
  process.exit(1);
}

console.log('\n── GENERATION ──');
let allGenerated = true;
for (const g of GENERATORS) {
  if (!runGenerator(g.name, g.script, g.output)) allGenerated = false;
}

if (!allGenerated) {
  console.error('\n⛔ Build failed: generation errors.\n');
  process.exit(1);
}

console.log(`\n═══════════════════════════════════════`);
console.log(`  BUILD COMPLETE`);
console.log(`  Platforms: ${GENERATORS.filter(g => g.output).length}`);
console.log(`  Output: ${PLATFORMS_DIR}/`);
console.log(`═══════════════════════════════════════\n`);
