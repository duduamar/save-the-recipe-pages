Save the Recipe — Pages
=======================

Static privacy policy and support pages for the "Save the Recipe" iOS app, in their own public repo.

Why a separate repo
--------------------
GitHub Pages on the free plan only serves from **public** repos. The app's source lives in the private `save-the-recipe` repo; this repo holds nothing but the two placeholder HTML pages below, so nothing about the app itself is exposed.

Contents
--------
- `index.html` — placeholder privacy policy
- `support.html` — placeholder support page

Both still need real content written in before App Store submission — see the `[TODO]` markers inside each file.

Setup
-----
Requires `git` and the GitHub CLI (`gh`, authenticated via `gh auth login`).
```
chmod +x create_pages_repo.sh
./create_pages_repo.sh
```
This creates a public repo named `save-the-recipe-pages`, pushes these files, and enables GitHub Pages on it automatically. It prints the live URLs when done — use those in App Store Connect's privacy policy and support URL fields.
