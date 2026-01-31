#!/usr/bin/env bash
set -euo pipefail

# create-github-release.sh
# Create a GitHub release with all template zip files
# Usage: create-github-release.sh <version>

if [[ $# -ne 1 ]]; then
  echo "Usage: $0 <version>" >&2
  exit 1
fi

VERSION="$1"

# Remove 'v' prefix from version for release title
VERSION_NO_V=${VERSION#v}

gh release create "$VERSION" \
  .genreleases/quynhluu-template-copilot-sh-"$VERSION".zip \
  .genreleases/quynhluu-template-copilot-ps-"$VERSION".zip \
  .genreleases/quynhluu-template-claude-sh-"$VERSION".zip \
  .genreleases/quynhluu-template-claude-ps-"$VERSION".zip \
  .genreleases/quynhluu-template-gemini-sh-"$VERSION".zip \
  .genreleases/quynhluu-template-gemini-ps-"$VERSION".zip \
  .genreleases/quynhluu-template-cursor-agent-sh-"$VERSION".zip \
  .genreleases/quynhluu-template-cursor-agent-ps-"$VERSION".zip \
  .genreleases/quynhluu-template-opencode-sh-"$VERSION".zip \
  .genreleases/quynhluu-template-opencode-ps-"$VERSION".zip \
  .genreleases/quynhluu-template-qwen-sh-"$VERSION".zip \
  .genreleases/quynhluu-template-qwen-ps-"$VERSION".zip \
  .genreleases/quynhluu-template-windsurf-sh-"$VERSION".zip \
  .genreleases/quynhluu-template-windsurf-ps-"$VERSION".zip \
  .genreleases/quynhluu-template-codex-sh-"$VERSION".zip \
  .genreleases/quynhluu-template-codex-ps-"$VERSION".zip \
  .genreleases/quynhluu-template-kilocode-sh-"$VERSION".zip \
  .genreleases/quynhluu-template-kilocode-ps-"$VERSION".zip \
  .genreleases/quynhluu-template-auggie-sh-"$VERSION".zip \
  .genreleases/quynhluu-template-auggie-ps-"$VERSION".zip \
  .genreleases/quynhluu-template-roo-sh-"$VERSION".zip \
  .genreleases/quynhluu-template-roo-ps-"$VERSION".zip \
  .genreleases/quynhluu-template-codebuddy-sh-"$VERSION".zip \
  .genreleases/quynhluu-template-codebuddy-ps-"$VERSION".zip \
  .genreleases/quynhluu-template-amp-sh-"$VERSION".zip \
  .genreleases/quynhluu-template-amp-ps-"$VERSION".zip \
  .genreleases/quynhluu-template-shai-sh-"$VERSION".zip \
  .genreleases/quynhluu-template-shai-ps-"$VERSION".zip \
  .genreleases/quynhluu-template-q-sh-"$VERSION".zip \
  .genreleases/quynhluu-template-q-ps-"$VERSION".zip \
  .genreleases/quynhluu-template-bob-sh-"$VERSION".zip \
  .genreleases/quynhluu-template-bob-ps-"$VERSION".zip \
  .genreleases/quynhluu-template-jules-sh-"$VERSION".zip \
  .genreleases/quynhluu-template-jules-ps-"$VERSION".zip \
  .genreleases/quynhluu-template-qoder-sh-"$VERSION".zip \
  .genreleases/quynhluu-template-qoder-ps-"$VERSION".zip \
  .genreleases/quynhluu-template-antigravity-sh-"$VERSION".zip \
  .genreleases/quynhluu-template-antigravity-ps-"$VERSION".zip \
  --title "Quynhluu - $VERSION_NO_V" \
  --notes-file release_notes.md
