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

/**
 * Local, client-side database for storing all logged data
 * until it is submitted to the server.
 */
var database;

function initDatabase() {
  database = new PouchDB('herois-da-praia');
  console.log('Initiated in-browser database.')
}

/**
 * Local, client-side cache for storing all page content
 * needed for offline view.
 */
var CACHE_VERSION = 'v20190101';
var CACHE_NAME = CACHE_VERSION + '-offline';

/**
 * Get the current user id from the database. If this is the first encounter,
 * create a new user and store it in the database.
 */
function currentUser() {
  return database
  .find({ selector: { model: 'user' } })
  .then(function (results) {
    if (results.docs.length > 0) {
      return results.docs[0];
    } else {
      var user = { model: 'user', _id: randomId() };
      database.put(user);
      return user;
    }
  })
  .catch(console.log);
}
