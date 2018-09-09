function isViewFor(controller, action) {
  return !!$('body' +
    '[data-controller="' + controller + '"]' +
    '[data-action="' + action + '"]'
  ).length;
}

$(document).on('turbolinks:load', function (event) {
  if (!isViewFor('items', 'index')) { return; }

  // Counting items

  var counter = {};
  var counterElement;
  var category;

  $('a.item').on('click', function (event) {
    event.preventDefault();

    category = event.currentTarget.dataset.itemCategory;
    counterElement = $('.count[data-item-category="' + category + '"]');
    counter[category] = parseInt(counterElement.text());

    if ($(event.target).hasClass('count')) { return; }
    if ($(event.target).hasClass('minus')) {
      if (counter[category] > 0) { counter[category] -= 1; }
    } else {
      counter[category] += 1;
    }

    counterElement.text(counter[category]);
  });

  // Submitting items

  $('.submit-log').on('click', function (event) {
    event.preventDefault();

    $.ajax(window.location.pathname, {
      method: 'PATCH',
      data: { 'items': counter }
    });
  });

  // Deleting log

  $('.delete-log').on('click', function (event) {
    event.preventDefault();

    $.ajax(window.location.pathname, {
      method: 'DELETE'
    });
  });
});
