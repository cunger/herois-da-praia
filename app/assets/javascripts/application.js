// This is a manifest file that'll be compiled into application.js,
// which will include all the files listed below.
//
//= require jquery
//= require rails-ujs
//= require turbolinks
//= require pouchdb-7.0.0.min.js
//= require pouchdb.find.min.js
//= require herois-shared
//= require herois-new-beachclean
//= require herois-show-beachclean
//= require herois-submit-beachclean
//= require herois-unsubmitted-logs
//= require herois-thanks
//= require herois-dispatcher

if (navigator.serviceWorker) {
  navigator.serviceWorker.register('/serviceworker.js', { scope: './' })
    .then(function (result) {
      console.log('Service worker registered.');
    })
    .catch(console.error);
}
