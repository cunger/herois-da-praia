/**
 * Attach a handler to the "Send data" button that sends the item counts
 * stored in `counter` to the server.
 */
function sendButton() {
  $('#js-send-beachclean').on('click', function (event) {
    event.preventDefault();

    var uuid = window.location.pathname.split('/')[2];

    database.get(uuid)
    .then(function (beachclean) {
      beachclean['submitted'] = true;
      return database.put(beachclean);
    })
    .then(window.location = window.location.pathname.replace('/summary', '/sign'))
    .catch(console.log);
  });
}

function backButton() {
  $('#js-show-beachclean').on('click', function (event) {
    event.preventDefault();

    window.location = window.location.pathname.replace('/summary', '');
  });
}
