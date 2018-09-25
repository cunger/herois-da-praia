function startLoggingButton() {
  // Click on the 'Start Logging' button will create a new beach clean
  // and store it in the client-side database.
  $('#js-create-beachclean').on('click', function (event) {
    event.preventDefault();

    currentUser()
    .then(function (user) {
      return {
        _id: randomId(),
        model: 'beachclean',
        date: $('#beachclean_date').val(),
        place_id: $('#beachclean_place_id').val(),
        user_uuid: user._id,
        submitted: false
      };
    })
    .then(function (beachclean) {
      database.put(beachclean)
      .then(function () {
        document.location.href = '/beachcleans/' + beachclean._id;
      })
      .catch(console.log);
    })
    .catch(console.log);
  });
}
