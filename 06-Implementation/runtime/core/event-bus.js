/* AEL Runtime — Event Bus */

const listeners = new Map();

export function on(name, fn) {
  if (!listeners.has(name)) listeners.set(name, []);
  listeners.get(name).push(fn);
}

export function off(name, fn) {
  if (!listeners.has(name)) return;
  const fns = listeners.get(name);
  const i = fns.indexOf(fn);
  if (i > -1) fns.splice(i, 1);
}

export function emit(name, detail = {}) {
  if (!listeners.has(name)) return;
  listeners.get(name).forEach(fn => fn(detail));
}
