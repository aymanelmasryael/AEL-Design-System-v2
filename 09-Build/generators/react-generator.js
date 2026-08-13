/* AEL Compiler — React Generator
 * Thin orchestrator: Parser → IR → React Renderer
 */

const { getAllASTs } = require('../compiler/loader');
const { renderReact } = require('../compiler/react-renderer');
const fs = require('fs');
const path = require('path');

const OUT = path.join(__dirname, '..', '..', '06-Implementation', 'platforms', 'react', 'src');

module.exports = function() {
  const asts = getAllASTs();
  let count = 0;
  for (const ast of asts) {
    if (!ast.ir) continue;
    const output = renderReact(ast.ir);
    const outPath = path.join(OUT, `${ast.dirName}.jsx`);
    fs.writeFileSync(outPath, output);
    count++;
  }
  return count;
};
