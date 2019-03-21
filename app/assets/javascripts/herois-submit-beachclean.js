function backButton() {
  $('#js-show-beachclean').on('click', function (event) {
    event.preventDefault();

    window.location = window.location.pathname.replace('/summary', '');
  });
}
