function startLoggingButton() {
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
