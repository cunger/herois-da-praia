/**
 * Local, client-side database for storing all logged data
 * until it is submitted to the server.
 */
var database = new PouchDB('herois-da-praia');

/**
 * Get the current user from the database. If it's the first encounter,
 * create a new user and store the info in the database.
 */
function currentUser() {
  // TODO
}

/**
 * Random ID generator, adopted from Slavik Meltser (http://slavik.meltser.info/?p=142).
 * Not ideal for real UUIDs, as it uses Math.random();
 * see e.g. https://github.com/jchook/uuid-random for stronger uniqueness.
 * Since we just need uniqueness across the application, this is sufficient.
 */
function randomId() {
  function _p8(includeDash) {
    var p = (Math.random().toString(16) + '000000000').substr(2, 8);
    return includeDash ? '-' + p.substr(0, 4) + '-' + p.substr(4, 4) : p;
  }
  return _p8() + _p8(true) + _p8(true) + _p8();
}
