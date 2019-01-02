
function deleteAllDataButton() {
  $('#js-delete-data').on('click', function (event) {
    event.preventDefault();

    if (database) {
      database
        .destroy()
        .catch(console.log);
    }

    if ('caches' in window) {
      caches
        .delete(CACHE_NAME)
        .catch(console.log)
    }

    $('#js-delete-data').prop('disabled', true);
    $('#js-delete-data').text('Deleted all browser data');
  });
}
