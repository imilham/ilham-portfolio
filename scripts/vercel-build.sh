#!/usr/bin/env bash
set -e

echo "🚀 [1/4] Checking Dart SDK environment on Vercel..."
if ! command -v dart &> /dev/null || [[ "$(dart --version 2>&1)" != *"3.13.7"* ]]; then
  echo "Downloading official Dart SDK 3.13.7 (Linux x64)..."
  curl -fsSL "https://storage.googleapis.com/dart-archive/channels/stable/release/3.13.7/sdk/dartsdk-linux-x64-release.zip" -o /tmp/dart-sdk.zip
  rm -rf /tmp/dart-sdk
  unzip -q -o /tmp/dart-sdk.zip -d /tmp
  export PATH="/tmp/dart-sdk/bin:$PATH"
fi

dart --version

echo "🚀 [2/4] Activating jaspr_cli..."
export PUB_CACHE="${PUB_CACHE:-$HOME/.pub-cache}"
export PATH="$PUB_CACHE/bin:$PATH"

if ! command -v jaspr &> /dev/null; then
  dart pub global activate jaspr_cli
fi

echo "🚀 [3/4] Preparing Tailwind CSS..."
cd portfolio_jaspr
npm install
npm run build:css

echo "🚀 [4/4] Building Jaspr Static Site Generation (SSG)..."
jaspr build -p 9020 --sitemap-domain=https://imilham.com

echo "✅ Build completed successfully! Static output ready in portfolio_jaspr/build/jaspr"
