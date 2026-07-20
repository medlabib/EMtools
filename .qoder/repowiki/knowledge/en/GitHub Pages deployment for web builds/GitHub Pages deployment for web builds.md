---
kind: external_dependency
name: GitHub Pages deployment for web builds
slug: github-pages
category: external_dependency
category_hints:
    - vendor_identity
scope:
    - '**'
---

### GitHub Pages
- Role: Static hosting for the Flutter web build, deployed at `https://medlabib.github.io/EMtools/app/`.
- Durable usage model: Web artifacts are built in CI and published to the repository's Pages site; no runtime API calls from the app itself.
- Verify exact action versions and base-href path against the current workflow file.