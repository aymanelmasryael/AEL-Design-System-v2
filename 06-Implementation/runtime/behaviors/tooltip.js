/* AEL Runtime — Tooltip Behavior */

import { Component } from '../core/component.js';

export class Tooltip extends Component {
  constructor(element) {
    super(element);
    const targetId = element.getAttribute('data-ael-tooltip');
    const target = targetId ? document.getElementById(targetId) : element.parentElement;
    if (target) {
      target.addEventListener('mouseenter', () => this.show());
      target.addEventListener('mouseleave', () => this.hide());
      target.addEventListener('focus', () => this.show());
      target.addEventListener('blur', () => this.hide());
    }
  }
}
