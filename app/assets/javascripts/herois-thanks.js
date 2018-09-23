function markBeachcleanAsSubmitted() {
  var uuid = window.location.pathname.split('/')[2];

  database.get(uuid)
  .then(function (beachclean) {
    beachclean['submitted'] = true;
    database.put(beachclean);
  });
}
