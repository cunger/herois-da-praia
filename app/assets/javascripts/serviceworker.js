const CACHE_VERSION = 'v20181020';
const CACHE_NAME = CACHE_VERSION + '-offline';

const offlineResources = [
  // Paths
  '/',
  '/info',
  '/beachcleans/new',
  '/activities',
  // Pages
  '/beachclean_show.html',
  '/offline.html',
  // Fonts
  '/fonts/Montserrat-Regular.otf',
  '/fonts/Montserrat-Italic.otf',
  '/fonts/Montserrat-Bold.otf',
  // Images
  '/images/lto_logo.png',
  '/images/analytics_icon.png',
  '/images/beachclean_icon.png',
  '/images/info_icon.png',
  '/images/unsubmitted_icon.png',
  '/images/whalewatch_icon.png'
  // CSS + JS: see Fetch below
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
    .catch(console.log);
}

// Activation

self.addEventListener('activate', function (event) {
  log('Activating...');

  event.waitUntil(removeOldCaches());
});

function removeOldCaches() {
  return caches
    .keys()
    .then((keys) => {
      return Promise.all(
        keys.filter((key) => !key.startsWith(CACHE_VERSION))
            .map((key) => caches.delete(key))
      )
      .then(() => log('Removed old caches.'))
      .catch(console.log);
    });
}

// Fetch

self.addEventListener('fetch', function (event) {
  console.log(event.request);

  // If the request is a CSS or JS file that was not yet cached,
  // cache the response before returning it.
  if (event.request.url.endsWith('.js') || event.request.url.endsWith('.css')) {
    return cache
      .match(request)
      .then((response) => { return response; })
      .catch(() => {
        fetch(request)
        .then((response) => {
          cache.put(request, response);
          return response;
        })
        .catch(console.log);
      });
  }

  // If the request is to show a beachclean, return cached HTML.
  var showBeachcleanPattern = /.*\/beachcleans\/[\w\-]+\/?$/;
  if (event.request.url.match(showBeachcleanPattern)) {
    return cache
      .match('/beachclean_show.html')
      .then((response) => response.text())
      .then((text) => event.respondWith(
        new Response(text, {
          headers: {'Content-Type': 'text/html'}
        })
      ))
      .catch(console.log);
  }

  event.respondWith(cacheOrNetworkOrOffline(event.request));
});

// 1. Check cache. Since not all requests are cached, this will fail for
//    requests that do require a network (e.g. for submitting a log).
// 2. Check network.
// 3. If there is no network connection, show offline fallback that asks
//    the user to try again when online.

function cacheOrNetworkOrOffline(request) {
  return caches
    .match(request)
    .then((response) => {
      log(`${request.method} ${request.url} ${response ? '(cached)' : '(not cached)'}`);
      return response || fetch(request).then((response) => { return response; })
                                       .catch(() => { return offlineResponse() });
    });
}

function offlineResponse() {
  return cache
    .match('/offline.html')
    .then((response) => { return response; })
    .catch(console.log);
}

// Utils

function log(text) {
  console.log('[' + CACHE_NAME + '] ' + text);
}
