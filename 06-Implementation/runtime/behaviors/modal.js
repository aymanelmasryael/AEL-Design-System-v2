/* AEL Runtime — Modal Behavior */

import { Component } from '../core/component.js';

export class Modal extends Component {
  constructor(element) {
    super(element);
    const backdrop = this.find('.ael-modal__backdrop');
    const closeBtn = this.find('.ael-modal__close');
    const triggerAttr = element.getAttribute('data-ael-modal');
    if (triggerAttr) {
      document.querySelectorAll(`[data-ael-trigger="${triggerAttr}"]`).forEach(t => {
        t.addEventListener('click', () => this.open());
      });
    }
    if (closeBtn) closeBtn.addEventListener('click', () => this.close());
    if (backdrop) backdrop.addEventListener('click', (e) => {
      if (e.target === backdrop) this.close();
    });
  }

  open() { this.show(); this.trapFocus(); }
  close() { this.hide(); this.releaseFocus(); }
}
