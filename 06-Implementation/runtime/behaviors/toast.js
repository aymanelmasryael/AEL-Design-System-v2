/* AEL Runtime — Toast Behavior */

import { Component } from '../core/component.js';

export class Toast extends Component {
  constructor(element) {
    super(element);
    this._duration = parseInt(element.getAttribute('data-ael-duration')) || 3000;
  }

  show() {
    super.show();
    if (this.el.hasAttribute('data-ael-auto')) {
      clearTimeout(this._timer);
      this._timer = setTimeout(() => this.dismiss(), this._duration);
    }
  }

  dismiss() {
    this.hide();
    this.emit('toast:dismiss');
    setTimeout(() => this.el.remove(), 300);
  }
}
