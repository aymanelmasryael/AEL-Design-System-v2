/* AEL Compiler — Parser
 * Canonical HTML → Syntax AST.
 */

function parse(html) {
  let i = 0, len = html.length;
  const tokens = [];

  while (i < len) {
    if (html[i] === '<' && html[i+1] === '!' && html[i+2] === '-' && html[i+3] === '-') {
      i += 4;
      const commentStart = i;
      while (i < len && !(html[i] === '-' && html[i+1] === '-' && html[i+2] === '>')) i++;
      const comment = html.substring(commentStart, i).trim();
      i += 3;
      const slot = comment.match(/^\s*Slot:\s*(\S+)/);
      if (slot) tokens.push({ type: 'slot', name: slot[1] });
      continue;
    }

    if (html[i] === '<' && html[i+1] === '/') {
      i += 2;
      while (i < len && html[i] !== '>') i++;
      i++;
      tokens.push({ type: 'close' });
      continue;
    }

    if (html[i] === '<') {
      i++;
      let tag = '', attrStr = '';
      while (i < len && html[i] !== '>' && html[i] !== ' ' && html[i] !== '/') tag += html[i++];
      if (html[i] === ' ') {
        attrStr += ' ';
        i++;
        let inQuote = false, quoteChar = '';
        while (i < len && html[i] !== '>') {
          if ((html[i] === '"' || html[i] === "'") && (!inQuote || html[i] === quoteChar)) {
            inQuote = !inQuote; if (inQuote) quoteChar = html[i];
          }
          attrStr += html[i++];
        }
      }
      const selfClose = html[i-1] === '/';
      if (html[i] === '>') i++;

      const attrs = {};
      const classMatch = attrStr.match(/class\s*=\s*"([^"]*)"/);
      if (classMatch) attrs.class = classMatch[1];
      const roleMatch = attrStr.match(/role\s*=\s*"([^"]*)"/);
      if (roleMatch) attrs.role = roleMatch[1];
      for (const m of (attrStr.match(/aria-[^=]+="[^"]*"/g) || [])) {
        const eq = m.indexOf('=');
        attrs[m.slice(0, eq).trim()] = m.slice(eq + 2, -1);
      }
      if (attrStr.includes('hidden')) attrs.hidden = true;

      tokens.push({ type: 'open', tag, attrs, selfClose });
      continue;
    }

    let text = '';
    while (i < len && html[i] !== '<') text += html[i++];
    const trimmed = text.trim();
    if (trimmed) tokens.push({ type: 'text', value: trimmed });

    while (i < len && html[i] === '\n') i++;
  }

  const root = { tag: 'root', children: [] };
  const stack = [root];
  for (const tok of tokens) {
    const cur = stack[stack.length - 1];
    if (tok.type === 'open') {
      const n = { tag: tok.tag, attrs: tok.attrs, children: [], selfClose: tok.selfClose };
      cur.children.push(n);
      if (!tok.selfClose) stack.push(n);
    } else if (tok.type === 'close') {
      if (stack.length > 1) stack.pop();
    } else if (tok.type === 'text') {
      cur.children.push({ tag: 'text', value: tok.value });
    } else if (tok.type === 'slot') {
      cur.children.push({ tag: 'slot', name: tok.name });
    }
  }

  return root.children[0] || null;
}

module.exports = { parse };
