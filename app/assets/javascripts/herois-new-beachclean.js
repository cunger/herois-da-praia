function currentLocation() {
  if ($('#location_').is(':checked')) {
    return new Promise(function (fulfill, reject) {
      navigator.geolocation.getCurrentPosition(
        function (position) { fulfill(position.coords); },
        function (error) { reject(error); }
      );
    });
  } else {
    return Promise.resolve(null);
  }
}

function startLoggingButton() {
  // Click on the 'Start Logging' button will create a new beach clean
  // and store it in the client-side database.
  $('#js-create-beachclean').on('click', function (event) {
    event.preventDefault();

    var date = $('#beachclean_date').val();
    var place_id = $('#beachclean_place_id').val();
    var place_name = $('#place_name').val();

    currentLocation()
    .then(function (location) {
      currentUser()
      .then(function (user) {
        return {
          _id: randomId(),
          model: 'beachclean',
          date: date,
          place_id: place_id,
          place_name: place_name,
          place_latitude: location ? location.latitude : '',
          place_longitude: location ? location.longitude : '',
          user_uuid: user._id,
          submitted: false
        };
      })
      .then(function (beachclean) {
        database.put(beachclean)
        .then(function () {
          window.location = window.location.pathname.replace('/new', '/' + beachclean._id);
        })
        .catch(console.log)
      })
      .catch(console.log);
    })
    .catch(console.log);
  });
}

function handlerForPlaceOptions() {
  $('#beachclean_place_id').on('change', function (event) {
    var options = event.target.options;
    var option;
    var i;
    for (i = 0; i < options.length; i++) {
      option = options[i];
      if (option.text === 'Other' && option.selected) {
        $('#other-place').removeClass('hidden');
      }
      if (option.text !== 'Other' && option.selected) {
        $('#other-place').addClass('hidden');
      }
    }
  });
}
