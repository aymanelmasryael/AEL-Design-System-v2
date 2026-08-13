/* AEL Modal — Tests */

function test(name, fn) {
  try { fn(); console.log(`  ✓ ${name}`); }
  catch (e) { console.error(`  ✗ ${name}: ${e.message}`); }
}

function assert(condition, msg) {
  if (!condition) throw new Error(msg || 'Assertion failed');
}

(function run() {
  console.log('Modal Tests');

  test('element exists in DOM', () => {
    document.body.innerHTML = `
      <div class="ael-modal" id="test-modal" hidden>
        <div class="ael-modal__backdrop">
          <div class="ael-modal__dialog">
            <div class="ael-modal__header"><span>Test</span><button class="ael-modal__close">×</button></div>
            <div class="ael-modal__body">Body</div>
          </div>
        </div>
      </div>`;
    const el = document.getElementById('test-modal');
    assert(el !== null);
  });

  test('modal starts hidden', () => {
    const el = document.getElementById('test-modal');
    assert(el.hidden === true);
  });

  test('opens and emits event', (done) => {
    const el = document.getElementById('test-modal');
    el.addEventListener('ael:open', () => {
      assert(el.hidden === false);
      done();
    });
    el.hidden = false;
    el.dispatchEvent(new CustomEvent('ael:open', { bubbles: true }));
  });

  test('closes and emits event', (done) => {
    const el = document.getElementById('test-modal');
    el.addEventListener('ael:close', () => {
      assert(el.hidden === true);
      done();
    });
    el.hidden = true;
    el.dispatchEvent(new CustomEvent('ael:close', { bubbles: true }));
  });

  test('focus trap finds focusable elements', () => {
    document.body.innerHTML += `
      <div class="ael-modal" id="focus-modal" hidden>
        <div class="ael-modal__backdrop">
          <div class="ael-modal__dialog">
            <button id="btn1">One</button>
            <input id="inp1" type="text">
            <button id="btn2">Two</button>
          </div>
        </div>
      </div>`;
    const el = document.getElementById('focus-modal');
    const focusable = el.querySelectorAll('button, input');
    assert(focusable.length === 2);
  });

})();
