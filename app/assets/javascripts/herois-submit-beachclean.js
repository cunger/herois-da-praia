/**
 * Attach a handler to the "Back" button that takes you back to the
 * beachclean data.
 */
function backButton() {
  $('#js-show-beachclean').on('click', function (event) {
    event.preventDefault();

    window.location = window.location.pathname.replace('/summary', '');
  });
}

/**
 * Function for submitting user data to the server.
 */
function submitUser(beachclean_uuid, user_uuid, name, email, group) {
  $.ajax(window.location.pathname.replace('summary', 'sign'), {
    method: 'POST',
    data: {
      'beachclean_uuid': beachclean_uuid,
      'user_uuid': user_uuid,
      'user_name': name,
      'user_email': email,
      'user_group': group
    },
    success: function (response) {
      return response;
    },
    error: function (response) {
      console.log(response);
      // TODO redirect to offline page
    }
  });
}

/**
 * Attach a handler to the "Submit" button. First checks whether user filled
 * in the form, then submits the data to the server.
 */
function submitButton() {
  $('#js-submit-beachclean').on('click', function (event) {
    event.preventDefault();

    var user_name  = document.forms['signature']['name'].value;
    var user_email = document.forms['signature']['email'].value;

    var user_group = '';
    var radios = document.getElementsByName('group');
    var i;
    for (i = 0; i < radios.length; i++) {
      if (radios[i].checked) {
        user_group = radios[i].value;
        break;
      }
    }

    if (user_name === '' && user_email === '') {
      alert("Without your name and email as signature, we will not be able to use your data in our research. Therefore we highly appreciate if you fill in these information. We promise to not share them with anyone else.");
      return;
    }

    if (user_name === '') {
      alert("We'd love to know your name.");
      return;
    }

    if (user_email === '') {
      alert("Please provide an email address.");
      return;
    }

    var uuid = window.location.pathname.split('/')[2];

    if (!database) initDatabase();

    currentUser()
    .then(function (user) {
      submitUser(uuid, user._id, user_name, user_email, user_group);
    })
    .catch(console.log);
  });
}
