'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "assets/AssetManifest.json": "b270b772206ac4c75d47e62b3795a3d2",
"assets/assets/images/ghosts/blue/baixo.png": "36a451b8808155e062d55ee0f66ddf21",
"assets/assets/images/ghosts/blue/cima.png": "bb514ad39974157572faf82f2afd65dc",
"assets/assets/images/ghosts/blue/direita.png": "fbc6ced648db308e072f8960f2dbe4bc",
"assets/assets/images/ghosts/blue/esquerda.png": "b99ae684709c28fad6e47dd02ef9f68b",
"assets/assets/images/ghosts/green/baixo.png": "a3c778cab58f5ceb70fc49946aafaa90",
"assets/assets/images/ghosts/green/cima.png": "a8ac5afee25991abe48ff82f8a3b85b2",
"assets/assets/images/ghosts/green/direita.png": "495a47def923db48f2243ae2d972f255",
"assets/assets/images/ghosts/green/esquerda.png": "80ed7501b5653b84d8f745d057d3975f",
"assets/assets/images/ghosts/orange/baixo.png": "2e624751a16b1949b40c3f10cfd8fca1",
"assets/assets/images/ghosts/orange/cima.png": "bb43ed05e3a7c560790c2792c5fcd679",
"assets/assets/images/ghosts/orange/direita.png": "3e114e9b4f76811c272b6855f563249e",
"assets/assets/images/ghosts/orange/esquerda.png": "d70e5a28b274b42fe7546ff3411291b1",
"assets/assets/images/ghosts/pink/baixo.png": "b94a68f8bc8e4bfd88f52b2688329bc0",
"assets/assets/images/ghosts/pink/cima.png": "568aa9758155ab5a32d7e8e4ae42b7a4",
"assets/assets/images/ghosts/pink/direita.png": "b7aa06297bc1cc6a98a92f8b28b6b31e",
"assets/assets/images/ghosts/pink/esquerda.png": "106df99063aec56d5c61de2f35f38d7f",
"assets/assets/images/ghosts/red/baixo.png": "9bf64dd9f1cb8172a2a5f1df33e06159",
"assets/assets/images/ghosts/red/cima.png": "3c019e017562d0617a4b03593248a776",
"assets/assets/images/ghosts/red/direita.png": "0e752addfdd3adee579e76f4d7f34879",
"assets/assets/images/ghosts/red/esquerda.png": "674919409308b15b243e0632cc7816e5",
"assets/assets/images/itens/coin.png": "227c5c640b36f1d48a9fbf13c35a1fbc",
"assets/assets/images/map/mapa.json": "f5e1d7d0a7b311dc1b11df26fcdc0dc1",
"assets/assets/images/map/tileset.json": "008dc5d87596ec1d696cdabe49e484a2",
"assets/assets/images/map/tileset.png": "9a95657fef952db879dbfbbfe9a36559",
"assets/assets/images/player/LifeIndicator.png": "176d97262df2204483517b5a8fd8c4cc",
"assets/assets/images/player/PacDown.png": "9c22bfff1e5c2c84cae7323ed78defe2",
"assets/assets/images/player/PacLeft.png": "49ed452548e87c0e6081a0f6a8b7b614",
"assets/assets/images/player/PacRight.png": "4364d2e920cccd29e1373789b8811433",
"assets/assets/images/player/PacUp.png": "c05270a8188a35d301478ea7dfd212e9",
"assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"assets/fonts/MaterialIcons-Regular.otf": "95db9098c58fd6db106f1116bae85a0b",
"assets/NOTICES": "a651df6775deb087f06a646ed855c28f",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "6d342eb68f170c97609e9da345464e5e",
"assets/shaders/ink_sparkle.frag": "8d2312025d3b7a9a9401157a82ce4578",
"canvaskit/canvaskit.js": "2bc454a691c631b07a9307ac4ca47797",
"canvaskit/canvaskit.wasm": "bf50631470eb967688cca13ee181af62",
"canvaskit/profiling/canvaskit.js": "38164e5a72bdad0faa4ce740c9b8e564",
"canvaskit/profiling/canvaskit.wasm": "95a45378b69e77af5ed2bc72b2209b94",
"favicon.png": "7881f8ff85e3ad47fe88980f2b87d464",
"flutter.js": "f85e6fb278b0fd20c349186fb46ae36d",
"icons/Icon-192.png": "7ce81843b8054e220595b516984ac859",
"icons/Icon-512.png": "ab4fed2aad8f94f4d98996358f4e4c51",
"icons/Icon-maskable-192.png": "7ce81843b8054e220595b516984ac859",
"icons/Icon-maskable-512.png": "ab4fed2aad8f94f4d98996358f4e4c51",
"index.html": "41dd3442306aa5942def46488db8b0f9",
"/": "41dd3442306aa5942def46488db8b0f9",
"main.dart.js": "e86e5852ff83142b60033f437a8548f9",
"manifest.json": "d71a3e86e7efe46a41cf51dd28f56f08",
"version.json": "765d559b498189c6f4f8f7cf3571babf"
};

// The application shell files that are downloaded before a service worker can
// start.
const CORE = [
  "main.dart.js",
"index.html",
"assets/AssetManifest.json",
"assets/FontManifest.json"];
// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});

// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});

// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});

self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});

// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}

// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
