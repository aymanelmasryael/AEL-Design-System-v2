/* AEL Compiler — Concept Registry
 * Loads concept-map.json, provides CSS class → concept lookup.
 * Pure data layer. No parsing or tree manipulation.
 */

const fs = require('fs');
const path = require('path');

const MAP_PATH = path.join(__dirname, '..', '..', '06-Implementation', 'assets', 'metadata', 'concept-map.json');

let registry = null;

function load() {
  if (!registry) {
    registry = JSON.parse(fs.readFileSync(MAP_PATH, 'utf8')).concepts;
  }
  return registry;
}

function classify(classAttr) {
  const map = load();
  if (!classAttr) return null;
  const classes = classAttr.split(' ');
  for (const cls of classes) {
    if (map[cls]) return { ...map[cls], props: { ...map[cls].props } };
  }
  return null;
}

module.exports = { load, classify };
