const { getAllASTs } = require('../compiler/loader');
const { renderVue } = require('../compiler/vue-renderer');
const fs = require('fs');
const path = require('path');

const OUT = path.join(__dirname, '..', '..', '06-Implementation', 'platforms', 'vue', 'src');

module.exports = function() {
  const asts = getAllASTs();
  let count = 0;
  for (const ast of asts) {
    if (!ast.ir) continue;
    const output = renderVue(ast.ir);
    const outPath = path.join(OUT, `${ast.dirName}.vue`);
    fs.writeFileSync(outPath, output);
    count++;
  }
  return count;
};
