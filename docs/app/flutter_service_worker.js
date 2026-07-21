'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"assets/AssetManifest.bin": "16d26eb519f4e9e3ea9a403f56480427",
"assets/AssetManifest.bin.json": "88c715dcec5c7b4a4156f7da76617f6d",
"assets/AssetManifest.json": "0d8be223df64f684a30d1c7caf8e5489",
"assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"assets/fonts/MaterialIcons-Regular.otf": "5b5e282126e2bb84d54c9da2f922fe96",
"assets/NOTICES": "03d94b9083815f41c307f6570c98ce17",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "33b7d9392238c04c131b6ce224e13711",
"assets/packages/wakelock_plus/assets/no_sleep.js": "7748a45cd593f33280669b29c2c8919a",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"canvaskit/canvaskit.js": "140ccb7d34d0a55065fbd422b843add6",
"canvaskit/canvaskit.js.symbols": "58832fbed59e00d2190aa295c4d70360",
"canvaskit/canvaskit.wasm": "07b9f5853202304d3b0749d9306573cc",
"canvaskit/chromium/canvaskit.js": "5e27aae346eee469027c80af0751d53d",
"canvaskit/chromium/canvaskit.js.symbols": "193deaca1a1424049326d4a91ad1d88d",
"canvaskit/chromium/canvaskit.wasm": "24c77e750a7fa6d474198905249ff506",
"canvaskit/skwasm.js": "1ef3ea3a0fec4569e5d531da25f34095",
"canvaskit/skwasm.js.symbols": "0088242d10d7e7d6d2649d1fe1bda7c1",
"canvaskit/skwasm.wasm": "264db41426307cfc7fa44b95a7772109",
"canvaskit/skwasm_heavy.js": "413f5b2b2d9345f37de148e2544f584f",
"canvaskit/skwasm_heavy.js.symbols": "3c01ec03b5de6d62c34e17014d1decd3",
"canvaskit/skwasm_heavy.wasm": "8034ad26ba2485dab2fd49bdd786837b",
"favicon.png": "4c0f62791afe79bb8fae532b2f3a5934",
"flutter.js": "888483df48293866f9f41d3d9274a779",
"flutter_bootstrap.js": "b90b1426ca34548f26b8f61447a9b938",
"icons/Icon-192.png": "76884370fc686e725ae2fde2e7659503",
"icons/Icon-512.png": "b8dda9968de7f79c3e2c8ba730f1741e",
"icons/Icon-maskable-192.png": "76884370fc686e725ae2fde2e7659503",
"icons/Icon-maskable-512.png": "b8dda9968de7f79c3e2c8ba730f1741e",
"index.html": "64f4949d32dfb9963a2f23fb6adc4b5c",
"/": "64f4949d32dfb9963a2f23fb6adc4b5c",
"main.dart.js": "8ad684e8fd293c81737dabc2aacccd26",
"main.dart.js_1.part.js": "67ee67819df18ffcdf2ca686075c8397",
"main.dart.js_10.part.js": "47462da4aa723b13f4ab94093fbede74",
"main.dart.js_100.part.js": "62bdb4edf44a2ceb5d66daaa2161ecc0",
"main.dart.js_101.part.js": "743009351c98f53decee650d6f999b67",
"main.dart.js_102.part.js": "84d7502218a95a5d2a5811564a71eda7",
"main.dart.js_104.part.js": "f3d6758c09273c99020888353fa45b08",
"main.dart.js_105.part.js": "dc8630bdf3758fecfd523117d1c5bab3",
"main.dart.js_107.part.js": "3898504c7accebfe099c42708d98245f",
"main.dart.js_108.part.js": "391bdc48a01cd545eae5eda2c05bbeab",
"main.dart.js_109.part.js": "21522fa88422c195ca14f4efbe35fd65",
"main.dart.js_11.part.js": "896514a61043a91533137e4aad40b614",
"main.dart.js_110.part.js": "0e374d2d94adb5cce7720db24ab8a104",
"main.dart.js_111.part.js": "9e751523ac83c128dc29c3ae7950e056",
"main.dart.js_112.part.js": "5598c2d1639f1a02c87f82bbd85bf5b0",
"main.dart.js_113.part.js": "03c61f96f3a7f8b0e4d901afa67204be",
"main.dart.js_12.part.js": "753b6c0aa56333cf3d20e90b03a8cc79",
"main.dart.js_13.part.js": "e854cb1c90902cdcbb9415851ba096f3",
"main.dart.js_14.part.js": "61fa9ec7340f3a4767126cb67a561a3a",
"main.dart.js_15.part.js": "6685cd481cf0c606feb8e7d4334811fa",
"main.dart.js_17.part.js": "ac40c6bb3afb05534bd4260d50a2b95a",
"main.dart.js_18.part.js": "23764ba76a314340dc8d4ec98f04e011",
"main.dart.js_19.part.js": "811b89bc3380bbc72dbf7d26788b9819",
"main.dart.js_2.part.js": "a966266392cf88a6b9bf1ed1822c901e",
"main.dart.js_20.part.js": "983e98b21a75ae3e0602e6e5424a0442",
"main.dart.js_21.part.js": "cfe1abac9463c9442882822ffb0ca27d",
"main.dart.js_23.part.js": "67171e5218c976b5e799d15da0a1fb90",
"main.dart.js_24.part.js": "27ed34494f2d8e2779dd2e5558df49dd",
"main.dart.js_25.part.js": "ba5aef23ce7039911b946a496f676205",
"main.dart.js_26.part.js": "061386485866c618856c881cea6531e7",
"main.dart.js_27.part.js": "aa926a94a825a3d967bd5409b410825d",
"main.dart.js_28.part.js": "da8c4e8f98ed3874c3abcf578d1f8b7f",
"main.dart.js_29.part.js": "cf43338a248bbbd3d82e2047bfc3ea50",
"main.dart.js_3.part.js": "d6a518348b2f8acff93424773b051a93",
"main.dart.js_30.part.js": "6f0e41be8d526364173d7073e3d7e6cf",
"main.dart.js_31.part.js": "4727f6eaf2d5933d88401201e338faa6",
"main.dart.js_34.part.js": "e33a4bf046441f4a678a498043ed6719",
"main.dart.js_35.part.js": "a3fd4284e7032e668e2a2025fe7429ec",
"main.dart.js_36.part.js": "6f23f831231ff0dd147136be199511be",
"main.dart.js_38.part.js": "914f0b926a39ae28ce29b0dac6bb3dee",
"main.dart.js_39.part.js": "e638d2854dbd92430aee3379a947bb13",
"main.dart.js_40.part.js": "ce62049a4612341820c80b4e4e4c91be",
"main.dart.js_41.part.js": "67e4b4c7825b302c1d81527669935fb6",
"main.dart.js_42.part.js": "bdb7bfb67c5d2eb49e565894688bf599",
"main.dart.js_43.part.js": "06bf277e9997aeb8081472336a61e6f9",
"main.dart.js_44.part.js": "46101178399abc486efc2745f2aa5209",
"main.dart.js_45.part.js": "b0a5f71333742fdc1ccb00e641f40f61",
"main.dart.js_46.part.js": "1faee2285f190ea80d7fc8d66104dadb",
"main.dart.js_47.part.js": "e399c55b2845f7e68603e52bc325c1a9",
"main.dart.js_48.part.js": "917ec49417d32c2bde03c9ab18b03cd8",
"main.dart.js_49.part.js": "97714f8881dc4dcb5a722e5e4f6d02e3",
"main.dart.js_50.part.js": "0c61c9d25b99e4385fafcc98419603b6",
"main.dart.js_51.part.js": "aa640f17548420a3bfd3b6ef86a677ee",
"main.dart.js_52.part.js": "239d7ed7a549dddf7c00ec99704689a4",
"main.dart.js_53.part.js": "4dceeda1529621167bc1fa243a4dcc32",
"main.dart.js_54.part.js": "0f534c35cbbf2d3bede0d5791374bc46",
"main.dart.js_56.part.js": "a8467db125e48584a8455756e832defb",
"main.dart.js_57.part.js": "a0b70b2fcdd783be54ab11361f3d5cdc",
"main.dart.js_59.part.js": "643edd81e0bf4433435a7cb7fbed6c1d",
"main.dart.js_6.part.js": "96a84d952fd75fcc592be940273a54d5",
"main.dart.js_60.part.js": "793e580d84b5b955f6f4046213cc55d8",
"main.dart.js_61.part.js": "57be25f8ba32376b415e180ed63feb06",
"main.dart.js_62.part.js": "e389106994a49b2c74c1f8dea8e0959a",
"main.dart.js_63.part.js": "fc74a71ff3a2b108b4d637763d9f82f9",
"main.dart.js_64.part.js": "871d371dae9b10b0f21deacbb8e58e68",
"main.dart.js_65.part.js": "56adc9f4cc14030930a7cc736abb8f57",
"main.dart.js_66.part.js": "3c99600e50610578d2e0f5a9885546b7",
"main.dart.js_67.part.js": "1805b3a0520ad29e36926a8f0b9bc723",
"main.dart.js_68.part.js": "4f26cce75033eec7445562381e1c5335",
"main.dart.js_69.part.js": "865bd5cd2ab1e748eb647a066e28f92d",
"main.dart.js_70.part.js": "6acd6aa76242f1be118a3640d4603d71",
"main.dart.js_76.part.js": "453ad0e91fc9288cae32f380e055667b",
"main.dart.js_77.part.js": "e6d493c4581df3a1293af5fdba9d16fa",
"main.dart.js_78.part.js": "eaf37bbaeae5d12134f77780cf082da4",
"main.dart.js_79.part.js": "2153c704e34ca0d669f28b7fd02ed982",
"main.dart.js_8.part.js": "55cac6269372ed380f55af08b9941a0a",
"main.dart.js_80.part.js": "3335716bfa546dce802c7c6d5e5eda1d",
"main.dart.js_82.part.js": "51ca73651a5ce38b829c765049c70a04",
"main.dart.js_83.part.js": "2a050e0db0ea87e69a8940de18a3caa3",
"main.dart.js_84.part.js": "5833e0416d5e4c3f052d714d7db6944d",
"main.dart.js_85.part.js": "5be75528316314a02f96b8e22fe5bfb6",
"main.dart.js_86.part.js": "83d7d667372cad2f18397663ad8f630d",
"main.dart.js_87.part.js": "0492fa71b8786752bbf48708ae92b5d7",
"main.dart.js_9.part.js": "edb81f2f8a8cacf2075cf283340a5a7a",
"main.dart.js_90.part.js": "4dd083737d6834a084109e7957a3b435",
"main.dart.js_91.part.js": "8336b4f29d020b67dbca89c981492b0f",
"main.dart.js_92.part.js": "0032c6643ff6f47323d0158d08f6f988",
"main.dart.js_94.part.js": "352822e69a8c733c780024aa0c995759",
"main.dart.js_95.part.js": "ddc8ef69159aa32203c9924284224dcb",
"main.dart.js_96.part.js": "af57e8472985857cd1380d1aa8c21226",
"main.dart.js_98.part.js": "392fbb93703c6a01b9b5e58bb4075023",
"main.dart.js_99.part.js": "036a956c84b8ab11b7712611295db57a",
"manifest.json": "06493d97047c5a23823d238cc48aadc9",
"version.json": "0b43019e9d3e0ce31e051dabcc844c90"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
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
        // Claim client to enable caching on first launch
        self.clients.claim();
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
      // Claim client to enable caching on first launch
      self.clients.claim();
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
