/* AEL Runtime — Accessibility Utilities */

export function setAria(el, attrs) {
  for (const [k, v] of Object.entries(attrs)) {
    if (v === null || v === false) el.removeAttribute(`aria-${k}`);
    else el.setAttribute(`aria-${k}`, String(v));
  }
}

export function announce(message, priority = 'polite') {
  let region = document.getElementById('ael-live-region');
  if (!region) {
    region = document.createElement('div');
    region.id = 'ael-live-region';
    region.setAttribute('aria-live', priority);
    region.setAttribute('aria-atomic', 'true');
    region.className = 'ael-sr-only';
    region.style.cssText = 'position:absolute;width:1px;height:1px;overflow:hidden;clip:rect(0,0,0,0);white-space:nowrap';
    document.body.appendChild(region);
  }
  region.textContent = '';
  requestAnimationFrame(() => { region.textContent = message; });
}

export function focusElement(el) {
  if (!el) return;
  el.setAttribute('tabindex', '-1');
  el.focus({ preventScroll: false });
}
