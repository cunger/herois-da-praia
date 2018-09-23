
var allUpdatesAreSaved = true;
var counter = {};
var counterElement;
var category;

/**
 * Saving item counts stored in `counter` to the database.
 */
function saveItems(uuid) {
  Object.getOwnPropertyNames(counter).forEach(function (category) {
    var quantity = counter[category];
    if (quantity == 0) return;

    var item = {
      model: 'item',
      beachclean_uuid: uuid,
      category: category
    };

    database.find({ selector: item })
    .then(function (result) {
      if (result && result.docs.length > 0) {
        item = result.docs[0];
        item['quantity'] = quantity;
        database.put(item);
      } else {
        item['quantity'] = quantity;
        database.post(item);
      }
    });
  });

  allUpdatesAreSaved = true;
  // TODO inactivate Save button
}

/**
 * Init counts from the database: Store them in `counter` and
 * update the numbers in the corresponding `counterElement`s.
 */
function initCounts() {
  var uuid = window.location.pathname.split('/')[2];

  database.find({
    selector: {
      model: 'item',
      beachclean_uuid: uuid
    }
  })
  .then(function (result) {
    result.docs.forEach(function (item) {
      var category = item['category'];
      var quantity = item['quantity'];
      counter[category] = quantity;
      counterElement = $('.count[data-item-category="' + category + '"]');
      counterElement.text(quantity);
    });
  });
}

/**
 * To each item, attach a handler that increases the quantity of that item
 * in the `counter` when it or its plus element is clicked, and decreases
 * its quantity if its minus link is clicked.
 */
function attachHandlersForCountingItems() {
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

    allUpdatesAreSaved = false;
    // TODO activate Save button
  });
}

/**
 * Attach a handler to the "Save" button that saves the item counts
 * stored in `counter` to the database.
 */
function saveButton() {
  $('#js-save-beachclean').on('click', function (event) {
    event.preventDefault();

    var uuid = window.location.pathname.split('/')[2];

    if (!allUpdatesAreSaved) saveItems(uuid);
  });
}

/**
 * Attach a handler to the "Submit" button that sends the item counts
 * stored in `counter` to the server as an Ajax request, and then
 * redirects to the corresponding './submit' page.
 */
function submitButton() {
  $('#js-submit-beachclean').on('click', function (event) {
    event.preventDefault();

    var uuid = window.location.pathname.split('/')[2];

    if (!allUpdatesAreSaved) saveItems(uuid);

    // Retrieve info about the beach clean.
    var beachclean;
    database.get(uuid)
    .then(function (result) {
      beachclean = result;
    });

    // Retrieve all items belonging to that beach clean.
    var items = [];
    database.find({ selector: {
      model: 'item',
      beachclean_uuid: uuid
    }})
    .then(function (result) {
      items.add(result);
    });

    // Submit both to the server.
    $.ajax(window.location.pathname, {
      method: 'PATCH',
      data: { 'beachclean': beachclean,
              'items': items },
      success: function (result) {
        document.location.href = window.location.pathname + '/submit';
      },
      error: function (response) {
        console.log(response);
      }
    });
    // TODO If Ajax request fails because of network,
    //      tell the user to try again once s/he is online.
  });
}

// Deleting log.
function deleteButton() {
  $('#js-delete-beachclean').on('click', function (event) {
    event.preventDefault();

    var uuid = window.location.pathname.split('/')[2];

    console.log('Deleting beach clean...');

    // TODO Delete beachclean from PouchDB.

    database.get(uuid)
    .then(function (beachclean) {
      $.ajax(window.location.pathname, {
        method: 'DELETE',
        success: function (result) {
          document.location.href = '/';
        }
      });
    })
    .catch(function (error) {
      console.log(error); // TODO
    });
  });
}
