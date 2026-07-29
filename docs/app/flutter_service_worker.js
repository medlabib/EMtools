'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"assets/AssetManifest.bin": "16d26eb519f4e9e3ea9a403f56480427",
"assets/AssetManifest.bin.json": "88c715dcec5c7b4a4156f7da76617f6d",
"assets/AssetManifest.json": "0d8be223df64f684a30d1c7caf8e5489",
"assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"assets/fonts/MaterialIcons-Regular.otf": "10a0ea4f0dd4511e9910bf2d828283fa",
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
"flutter_bootstrap.js": "a69386a3bd8a52a4a96dc53cf71e7d97",
"icons/Icon-192.png": "76884370fc686e725ae2fde2e7659503",
"icons/Icon-512.png": "b8dda9968de7f79c3e2c8ba730f1741e",
"icons/Icon-maskable-192.png": "76884370fc686e725ae2fde2e7659503",
"icons/Icon-maskable-512.png": "b8dda9968de7f79c3e2c8ba730f1741e",
"index.html": "64f4949d32dfb9963a2f23fb6adc4b5c",
"/": "64f4949d32dfb9963a2f23fb6adc4b5c",
"main.dart.js": "c3fef0e911344e626e485be47c2dfca5",
"main.dart.js_1.part.js": "0c297d504513875a36ed3731887708bf",
"main.dart.js_10.part.js": "da459f67837c341cbc829df114191f6a",
"main.dart.js_100.part.js": "b07960865400aa7a459ccedff9f501ab",
"main.dart.js_101.part.js": "743009351c98f53decee650d6f999b67",
"main.dart.js_102.part.js": "4314620bb0e1f40c4cf784781fcc7dc3",
"main.dart.js_103.part.js": "69fd15a84e8cc9c485c0f40402b809fa",
"main.dart.js_104.part.js": "f3d6758c09273c99020888353fa45b08",
"main.dart.js_105.part.js": "a23dc7bacd570ec7e7a45db50a2e7673",
"main.dart.js_106.part.js": "7cf4a2c9816bd0b219e48d9f6208d85e",
"main.dart.js_107.part.js": "ff1910b1876e23e655d224dc7be0c3ef",
"main.dart.js_108.part.js": "373ea54d2d1de5d5d0fbf8ffb5cdbe13",
"main.dart.js_109.part.js": "2f04a82b681ed72de1f7d5e516581f15",
"main.dart.js_11.part.js": "cbc2cb05099414f5b24b44f2f7d21236",
"main.dart.js_110.part.js": "691b55ed0e89efb1760c61013f148c06",
"main.dart.js_111.part.js": "366d06af93f85cdc6ccafd551e6195d9",
"main.dart.js_112.part.js": "5598c2d1639f1a02c87f82bbd85bf5b0",
"main.dart.js_113.part.js": "03c61f96f3a7f8b0e4d901afa67204be",
"main.dart.js_12.part.js": "aecdbc3ea7a8c0e38252ddf1b4cd4f9d",
"main.dart.js_13.part.js": "f284703caa475289c27f114b8748aced",
"main.dart.js_14.part.js": "4246e695cae80ca1c8bd83788a3cf7de",
"main.dart.js_15.part.js": "5a3cf81f76a2d9b5bab1ca46ce126ba5",
"main.dart.js_16.part.js": "1bc7b029afcee1146cc9a89c38c2e545",
"main.dart.js_17.part.js": "d95001d40b3194eff439b7a962c0d808",
"main.dart.js_18.part.js": "3b7898817bb9875f19b05837b03212c0",
"main.dart.js_19.part.js": "a13bf715989219ddf60fc9b1e1fef686",
"main.dart.js_2.part.js": "135c54c1a33de082ecdfa022e160a678",
"main.dart.js_20.part.js": "8f2ba39376a73c9bd0d4625a38b2cbc2",
"main.dart.js_21.part.js": "cfe1abac9463c9442882822ffb0ca27d",
"main.dart.js_22.part.js": "fa69410a30c392877d38d406412692d0",
"main.dart.js_23.part.js": "99a43c0a4986c7ba24ae5c40c52118ae",
"main.dart.js_24.part.js": "ac02aba4c475d3694b01049e81f1346a",
"main.dart.js_25.part.js": "99760e3ca1f09a54f7fb9412dfce7b1b",
"main.dart.js_26.part.js": "181b221ea210354d6461c8c1da07667b",
"main.dart.js_27.part.js": "08fbeb2195cf7bfa4f36cc3a0a13be45",
"main.dart.js_28.part.js": "fba2f3a270bf493f4d301883d4368ebc",
"main.dart.js_29.part.js": "dad09b1bb9130553895811f76c6bae78",
"main.dart.js_3.part.js": "ef41cf79312138a47e63969514aa2ea3",
"main.dart.js_30.part.js": "532d4ab73a6f5d485659b4885d5ef12f",
"main.dart.js_31.part.js": "4727f6eaf2d5933d88401201e338faa6",
"main.dart.js_33.part.js": "ab281cda96f7f35769d4daa295cd8006",
"main.dart.js_34.part.js": "7c745e3dd63343d39bcf12e04a22932b",
"main.dart.js_35.part.js": "cb098c87476e73a23af820fb97442d0d",
"main.dart.js_36.part.js": "5451d839da54400353a2dbb7368f14a8",
"main.dart.js_37.part.js": "ee8c60da080beea590c7fbcda641806c",
"main.dart.js_38.part.js": "5419f27fab46d9bbb1d544dd181a1773",
"main.dart.js_39.part.js": "0dfce376f2c82b1963f0b5f0550a0dd2",
"main.dart.js_40.part.js": "a1c643de0da1fdd1725aaca7852dee5a",
"main.dart.js_41.part.js": "d22e9817afccfcabce5bae3e013a1155",
"main.dart.js_42.part.js": "bdb7bfb67c5d2eb49e565894688bf599",
"main.dart.js_43.part.js": "b0cd9cc2889a2cb268c4f08b9cf403f4",
"main.dart.js_44.part.js": "efd0ae4d6b0bf953a2059c818df1e56b",
"main.dart.js_45.part.js": "e1f696f497c1f9d41b75c5a7fb52a120",
"main.dart.js_46.part.js": "97714f8881dc4dcb5a722e5e4f6d02e3",
"main.dart.js_47.part.js": "b46e53a2a30c70afbd6cae9fd99df995",
"main.dart.js_48.part.js": "aa640f17548420a3bfd3b6ef86a677ee",
"main.dart.js_49.part.js": "b95c183cc5fb5c8a485eb2cdf2373529",
"main.dart.js_50.part.js": "63a8dd95033b230cd775ddb0c5ffa8ed",
"main.dart.js_51.part.js": "2996df7393acd5444411777efd0c525d",
"main.dart.js_52.part.js": "239d7ed7a549dddf7c00ec99704689a4",
"main.dart.js_53.part.js": "170829e8c682355177c00856c922beb9",
"main.dart.js_54.part.js": "eb53ee96d2143ac4101132c44d2c4d0b",
"main.dart.js_56.part.js": "5b26cbd4e9f4b21096ccc64c665dcca0",
"main.dart.js_57.part.js": "3d8b627833ba762aa91af732016f764c",
"main.dart.js_58.part.js": "7083ef828231952c1456892d921f1b6d",
"main.dart.js_59.part.js": "c7ae777968f170bd3cbe4851ce406910",
"main.dart.js_6.part.js": "034265a3966a755e742f966a953b9434",
"main.dart.js_60.part.js": "3e8bd2761b6ff78f35c6fadc9379ff29",
"main.dart.js_61.part.js": "00e687548bba468c15c9f49fb18ab6fd",
"main.dart.js_62.part.js": "5d92408af8cf9ace674bb5d5d80aaa15",
"main.dart.js_63.part.js": "8ac062946354c12c02efe648f3221e34",
"main.dart.js_64.part.js": "ec6ade9435004b355a117d99f3dce752",
"main.dart.js_65.part.js": "4e160d608c0306250e646ab66fa6737e",
"main.dart.js_66.part.js": "2255e58020a6ecbac6f53ce933fe0225",
"main.dart.js_67.part.js": "400154a65347ee4532862a52bb77daa7",
"main.dart.js_68.part.js": "4f26cce75033eec7445562381e1c5335",
"main.dart.js_69.part.js": "865bd5cd2ab1e748eb647a066e28f92d",
"main.dart.js_70.part.js": "6acd6aa76242f1be118a3640d4603d71",
"main.dart.js_73.part.js": "853ce1ab4d98e8b4b7815c6c7d88730a",
"main.dart.js_74.part.js": "b9ad3495f2d559521fde0c24b0c7aa01",
"main.dart.js_75.part.js": "2f99c901e414bc3046dc75034169fce1",
"main.dart.js_76.part.js": "d3802d140d81b169c813288cf31ecb45",
"main.dart.js_77.part.js": "1c9c126985529f678844affb46fcd741",
"main.dart.js_78.part.js": "8f6ef184616b7556d2e3b84ed43606cf",
"main.dart.js_79.part.js": "2153c704e34ca0d669f28b7fd02ed982",
"main.dart.js_8.part.js": "28ea2442babec664420af93517219721",
"main.dart.js_80.part.js": "d4e93338d7b71f91d91c32e2a50f3749",
"main.dart.js_81.part.js": "c8de9fefea1d2071ddbe3c2f592757d8",
"main.dart.js_82.part.js": "0d707a35b92ce9468a028fbd6f47bf8a",
"main.dart.js_83.part.js": "ae4fe30d45509f1eb63467e58d81bc87",
"main.dart.js_84.part.js": "9ab1f0526abb6d6b8b39fb323f159984",
"main.dart.js_85.part.js": "a58a207f59983739f6f3fcebae3b1f0f",
"main.dart.js_86.part.js": "83d7d667372cad2f18397663ad8f630d",
"main.dart.js_87.part.js": "0492fa71b8786752bbf48708ae92b5d7",
"main.dart.js_88.part.js": "d14262c70585add398ba8f924fa2a4e7",
"main.dart.js_89.part.js": "6ad5b21fe73a5e48212069af07577603",
"main.dart.js_9.part.js": "573a389d274a7de19ee7fa4839d00393",
"main.dart.js_90.part.js": "edc3363f066f04b19204df8e41b5a225",
"main.dart.js_91.part.js": "8336b4f29d020b67dbca89c981492b0f",
"main.dart.js_92.part.js": "1683e839b6b7fe36689d4bb23fadacf6",
"main.dart.js_93.part.js": "6ee81ca67ccaa89480a81b819848f321",
"main.dart.js_94.part.js": "f885957f469264448779ee25fcae4c0f",
"main.dart.js_95.part.js": "ddc8ef69159aa32203c9924284224dcb",
"main.dart.js_96.part.js": "640b907fb4af989a9f975a567d9159bc",
"main.dart.js_97.part.js": "9cf3c910727aeceed75238b2ed7e221f",
"main.dart.js_98.part.js": "6c336b548be1ce51d782bf98f498c7d7",
"main.dart.js_99.part.js": "939deb9564ccad76c69d2efb8769ee03",
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
