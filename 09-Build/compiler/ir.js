/* AEL Compiler — Pipeline Orchestrator
 * Chains: Parser → Semantic → IR
 * Thin orchestration. Each stage is a pure function from its own module.
 */

const { parse } = require('./parser');
const { build: buildSemantic } = require('./semantic-builder');
const { collectMeta } = require('./semantic-builder');
const { build: buildIR } = require('./ir-builder');

function compile(html, manifest, target = 'react') {
  const syntaxTree = parse(html);
  if (!syntaxTree) return null;

  const semanticTree = buildSemantic(syntaxTree);
  if (!semanticTree) return null;

  const meta = collectMeta(semanticTree);
  const ir = buildIR(semanticTree, meta, manifest, target);

  return ir;
}

module.exports = { compile };
