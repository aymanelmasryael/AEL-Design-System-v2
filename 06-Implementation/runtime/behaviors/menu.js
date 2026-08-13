/* AEL Runtime — Menu Behavior */

import { Component } from '../core/component.js';

export class Menu extends Component {
  constructor(element) {
    super(element);
    const triggerId = element.getAttribute('data-ael-menu-trigger');
    const trigger = triggerId ? document.getElementById(triggerId) : element.previousElementSibling;
    if (trigger) {
      trigger.addEventListener('click', (e) => { e.stopPropagation(); this.toggle(); });
    }
    document.addEventListener('click', (e) => {
      if (!element.contains(e.target) && e.target !== trigger) this.close();
    });
  }

  open() { this.show(); this.trapFocus(); }
  close() { this.hide(); this.releaseFocus(); }
}
