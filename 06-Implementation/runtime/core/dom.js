/* AEL Runtime — DOM Utilities */

export function $(selector, parent = document) {
  return parent.querySelector(selector);
}

export function $$(selector, parent = document) {
  return [...parent.querySelectorAll(selector)];
}

export function create(tag, attrs = {}, children = []) {
  const el = document.createElement(tag);
  for (const [k, v] of Object.entries(attrs)) {
    if (k.startsWith('on')) el.addEventListener(k.slice(2).toLowerCase(), v);
    else if (k === 'className') el.className = v;
    else if (k === 'html') el.innerHTML = v;
    else el.setAttribute(k, v);
  }
  for (const child of children) {
    el.appendChild(typeof child === 'string' ? document.createTextNode(child) : child);
  }
  return el;
}

export function getFocusable(el) {
  return $$('button, [href], input, select, textarea, [tabindex]:not([tabindex="-1"])', el)
    .filter(e => !e.disabled && !e.hidden && e.offsetParent !== null);
}

export function trapFocus(el) {
  const focusable = getFocusable(el);
  const first = focusable[0];
  const last = focusable[focusable.length - 1];
  if (!first) return;

  function handler(e) {
    if (e.key !== 'Tab') return;
    if (e.shiftKey && document.activeElement === first) { e.preventDefault(); last.focus(); }
    else if (!e.shiftKey && document.activeElement === last) { e.preventDefault(); first.focus(); }
  }

  el.addEventListener('keydown', handler);
  first.focus();
  return () => el.removeEventListener('keydown', handler);
}
