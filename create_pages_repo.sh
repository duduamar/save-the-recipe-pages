#!/bin/bash
# One-time helper: creates a public GitHub repo for the static privacy/
# support pages (Pages requires public on the free plan) and enables
# GitHub Pages on it directly via the API — no manual Settings step needed.
#
# Requires: git, and the GitHub CLI (`gh`) authenticated once via
# `gh auth login`. Install both with: brew install git gh
set -euo pipefail

REPO_NAME="save-the-recipe-pages"

cd "$(dirname "$0")"

if ! command -v gh >/dev/null 2>&1; then
  echo "GitHub CLI not found. Install it with: brew install gh"
  exit 1
fi

if ! gh auth status >/dev/null 2>&1; then
  echo "Not logged in to GitHub CLI. Run: gh auth login"
  exit 1
fi

if [ ! -d .git ]; then
  git init
  git add -A
  git commit -m "Add placeholder privacy policy and support pages"
  git branch -M main
fi

gh repo create "$REPO_NAME" --public --description "Privacy policy + support pages for the Save the Recipe app" --source=. --remote=origin --push

OWNER="$(gh api user -q .login)"

# Enable GitHub Pages, serving from the root of main.
# (Nested JSON must go through --input; gh api's flat -f flag can't express
# a nested "source" object.)
printf '{"source":{"branch":"main","path":"/"}}' | \
  gh api --method POST "repos/$OWNER/$REPO_NAME/pages" --input - >/dev/null 2>&1 || \
  echo "Note: Pages may already be enabled, or needs a minute to allow API access — check Settings > Pages on github.com if the URLs below don't load yet."

echo ""
echo "Done. Repo: https://github.com/$OWNER/$REPO_NAME"
echo "Pages (may take a minute to go live):"
echo "  https://$OWNER.github.io/$REPO_NAME/"
echo "  https://$OWNER.github.io/$REPO_NAME/support.html"
