/* AEL Compiler — Component Loader
 * File I/O layer. Loads canonical HTML + manifest, runs compiler pipeline.
 */

const fs = require('fs');
const path = require('path');
const { compile } = require('./ir');

const COMPONENTS_DIR = path.join(__dirname, '..', '..', '06-Implementation', 'Components');

function getComponentAST(name, target = 'react') {
  const dirName = name.split('-').map(w => w.charAt(0).toUpperCase() + w.slice(1)).join('');
  const htmlPath = path.join(COMPONENTS_DIR, dirName, `${name}.html`);
  if (!fs.existsSync(htmlPath)) return null;

  const html = fs.readFileSync(htmlPath, 'utf8');
  const manifestPath = path.join(COMPONENTS_DIR, dirName, `${name}.manifest.json`);
  const manifest = fs.existsSync(manifestPath)
    ? JSON.parse(fs.readFileSync(manifestPath, 'utf8'))
    : { id: `CMP-${name}`, name };

  const ir = compile(html, manifest, target);
  if (!ir) return null;

  return { ir, name, dirName };
}

function getAllASTs(target = 'react') {
  if (!fs.existsSync(COMPONENTS_DIR)) return [];
  const results = [];
  for (const entry of fs.readdirSync(COMPONENTS_DIR, { withFileTypes: true })) {
    if (!entry.isDirectory() || entry.name.startsWith('.')) continue;
    const ast = getComponentAST(entry.name.toLowerCase(), target);
    if (ast) results.push(ast);
  }
  return results;
}

module.exports = { getComponentAST, getAllASTs, COMPONENTS_DIR };
