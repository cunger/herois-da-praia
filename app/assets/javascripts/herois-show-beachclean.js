
var allUpdatesAreSaved = true;
var counter = {};

/**
 * Saving item counts stored in `counter` to the database.
 */
function promiseToSaveItems(uuid) {
  if (allUpdatesAreSaved) return Promise.resolve(true);

  return Promise.all(
    Object.getOwnPropertyNames(counter).map(function (category) {
      var quantity = counter[category];
      if (quantity == 0) return;

      var item = {
        model: 'item',
        beachclean_uuid: uuid,
        category: category
      };

      return database
        .find({ selector: item })
        .then(function (result) {
          if (result && result.docs.length > 0) {
            item = result.docs[0];
            item['quantity'] = quantity;
            return database.put(item);
          } else {
            item['quantity'] = quantity;
            return database.post(item);
          }
        });
    })
  ).then(function () {
    allUpdatesAreSaved = true;
  })
  .catch(console.log);
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
      var counterElement = $('.count[data-item-category="' + category + '"]');

      counter[category] = quantity;
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

    var category = event.currentTarget.dataset.itemCategory;
    var counterElement = $('.count[data-item-category="' + category + '"]');

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

    promiseToSaveItems(uuid)
    .catch(console.log);
  });
}

/**
 * Function for submitting beachclean data to the server.
 * Sends the locally stored beachclean and its corresponding items
 * as an Ajax request, and then redirects to the corresponding './submit' page.
 */
function submit(beachclean, items) {
  $.ajax(window.location.pathname + '/submit', {
    method: 'POST',
    data: {
      'beachclean': beachclean,
      'items': items
    },
    success: function (response) {
      console.log(response);
      // document.location.href = window.location.pathname + '/submit';
    },
    error: function (response) {
      console.log(response);
      // TODO Probably you're offline? Try again when online.
    }
  });
}

/**
 * Attach a handler to the "Submit" button that sends the item counts
 * stored in `counter` to the server
 */
function submitButton() {
  $('#js-submit-beachclean').on('click', function (event) {
    event.preventDefault();

    var uuid = window.location.pathname.split('/')[2];

    promiseToSaveItems(uuid)
    .then(function () {
      return database.get(uuid);
    })
    .then(function (beachclean) {
      database.find({
        selector: {
          model: 'item',
          beachclean_uuid: uuid
        }
      })
      .then(function (items) {
        submit(beachclean, items.docs);
      })
      .catch(console.log);
    })
    .catch(console.log);
  });
}

/**
 * Attach a handler to the "Delete" button that deletes the log
 * in the local database.
 */
function deleteButton() {
  $('#js-delete-beachclean').on('click', function (event) {
    event.preventDefault();

    var uuid = window.location.pathname.split('/')[2];

    database.get(uuid)
    .then(function (beachclean) {
      return database.remove(beachclean);
    })
    .then(function () {
      document.location.href = '/';
    })
    .catch(console.log);
  });
}
