function isViewFor(controller, action) {
  return !!document.querySelector('body' +
    '[data-controller="' + controller + '"]' +
    '[data-action="' + action + '"]');
}

document.addEventListener('turbolinks:load', function (event) {
  if (!isViewFor('items', 'index')) { return; }

  var counter = {};

  var elements = document.querySelectorAll('a.item');
  var element;
  var counterElement;
  var position;
  var i;
  for (i = 0; i < elements.length; i++) {
    elements[i].addEventListener('click', function (event) {
      event.preventDefault();

      position = event.currentTarget.dataset.position;
      counterElement = document.querySelector('.count[data-position="' + position + '"]');
      counter[position] = parseInt(counterElement.innerHTML);

      if (event.target.className.indexOf('count') >= 0) { return; }
      if (event.target.className.indexOf('minus') >= 0) {
        if (counter[position] > 0) { counter[position] -= 1; }
      } else {
        counter[position] += 1;
      }

      counterElement.innerHTML = counter[position];
    });
  }
});
