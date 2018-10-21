const CACHE_VERSION = 'v20181020';
const CACHE_NAME = CACHE_VERSION + '-offline';

const offlineResources = [
  // Paths
  '/',
  '/info',
  '/beachcleans/new',
  '/activities',
  // Pages
  // TODO beachcleans/:uuid/ page
  '/offline.html',
  // CSS + JS
  asset_path('application.css'),
  asset_path('application.js'),
  asset_path('serviceworker.js'),
  // Fonts
  asset_path('Montserrat-Regular.otf'),
  asset_path('Montserrat-Italic.otf'),
  asset_path('Montserrat-Bold.otf'),
  // Images
  asset_path('lto_logo.png'),
  asset_path('analytics_icon.png'),
  asset_path('beachclean_icon.png'),
  asset_path('info_icon.png'),
  asset_path('unsubmitted_icon.png'),
  asset_path('whalewatch_icon.png')
];

// Installation

self.addEventListener('install', function (event) {
  log('Installing...');

  event.waitUntil(cacheOfflineResources());
});

function cacheOfflineResources() {
  return caches
    .open(CACHE_NAME)
    .then((cache) => cache.addAll(offlineResources))
    .then(() => log('Finished caching offline resources.'))
    .error(console.log);
}

// Activation

self.addEventListener('activate', function (event) {
  log('Activating...');

  event.waitUntil(removeOldCaches());
}

function removeOldCaches() {
  return caches
    .keys()
    .then((keys) => {
      return Promise.all(
        keys.filter((key) => !key.startsWith(CACHE_VERSION))
            .map((key) => caches.delete(key))
      )
      .then(() => log('Removed old caches.'))
      .error(console.log);
    });
}

// Fetch

self.addEventListener('fetch', function (event) {
  // TODO check for /beachcleans/:uuid request,
  //      and respond with cached web page if there is no network

  event.respondWith(cacheOrNetworkOrOffline());
}

// 1. Check cache. Since not all requests are cached, this will fail for
//    requests that do require a network (e.g. for submitting a log).
// 2. Check network.
// 3. If there is no network connection, show offline fallback that asks
//    the user to try again when online.
function cacheOrNetworkOrOffline() {
  return caches
    .match(request)
    .then((response) => {
      log(`${request.method} ${request.url} ${response ? '(cached)' : '(not cached)'}`);
      return response ||
        tryNetwork(request)
          .catch(() => { return offlineResponse(request) });
    });
}

function tryNetwork(request) {
  // TODO
}

function offlineResponse(request) {
  // TODO
}

// Utils

function log(text) {
  console.log('[' + CACHE_NAME + '] ' + text);
}
