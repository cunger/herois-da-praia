// Use PouchDB as client-side database for storing all logs locally
// before submitting them to the app.

var database = new PouchDB('herois-da-praia');

$(document).on('turbolinks:load', function (event) {

  if (isViewFor('beachcleans', 'new')) {
    // Click on the 'Start Logging' button will create a new beach clean
    // and store it in the client-side database.
    $('#js-create-beachclean').on('click', function (event) {
      event.preventDefault();

      var beachclean = {
        _id: randomId(),
        model: 'beachclean',
        date: $('#beachclean_date').val(),
        place_id: $('#beachclean_place_id').val(),
        submitted: false
      }

      database.put(beachclean)
      .then(function (response) {
        document.location.href = '/beachcleans/' + beachclean._id;
      })
      .catch(function (error) {
        console.log(error); // TODO
      });
    });
  }

  if (isViewFor('beachcleans', 'show')) {
    var uuid = window.location.pathname.split('/')[2];

    // TODO Get counts from PouchDB.

    var allUpdatesAreSaved = true;
    var counter = {};
    var counterElement;
    var category;

    var saveItemsOf = function (uuid) {
      console.log('Saving items of ' + uuid);

      database.get(uuid)
      .then(function (beachclean) {
        var item;
        for (category in counter) {
          if (counter[category] == 0) continue;

          item = {
            model: 'item',
            beachclean_uuid: beachclean._id,
            category: category,
          };

          database.find({ selector: item })
          .then(function (result) {
            item['quantity'] = counter[category];
            if (result.docs.length == 0) {
              database.post(item);
            } else {
              item._id = result.docs[0]._id;
              database.put(item);
            }
          })
          .catch(function (error) { console.log(error); });
        }

        allUpdatesAreSaved = true;
      })
      .catch(function (error) {
        console.log(error); // TODO
      });
    };

    // Counting collected items.

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
    });

    // Saving items locally.

    $('#js-save-beachclean').on('click', function (event) {
      event.preventDefault();

      saveItemsOf(uuid);
    });

    // Submitting a beach clean with the collected items.

    $('#js-submit-beachclean').on('click', function (event) {
      event.preventDefault();

      console.log('Submitting beach clean...');

      if (!allUpdatesAreSaved) saveItemsOf(uuid);

      var beachclean;
      var items = [];

      database.get(uuid)
      .then(function (result) {
        beachclean = result;
      });

      database.find({
        selector: { model: 'item', beachclean_uuid: uuid }
      })
      .then(function (result) {
        items.add(result);
      });

      $.ajax(window.location.pathname, {
        method: 'PATCH',
        data: { 'beachclean': beachclean,
                'items': items },
        success: function (result) {
          document.location.href = window.location.pathname + '/submit';
        }
      });
      // TODO If Ajax request fails because of network,
      //      tell the user to try again once s/he is online.
    });

    // Deleting log.

    $('#js-delete-beachclean').on('click', function (event) {
      event.preventDefault();

      console.log('Deleting beach clean...');

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

  if (isViewFor('beachcleans', 'thanks')) {
    var uuid = window.location.pathname.split('/')[2];

    database.get(uuid)
    .then(function (beachclean) {
      beachclean['submitted'] = true;
      database.put(beachclean);
    });
  }
});
