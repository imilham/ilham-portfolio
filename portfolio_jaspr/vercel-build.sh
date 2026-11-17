#!/usr/bin/env bash
set -e

echo "🚀 [1/3] Checking Dart SDK environment on Vercel..."
if ! command -v dart &> /dev/null; then
  echo "Downloading official Dart SDK (Linux x64)..."
  curl -fsSL "https://storage.googleapis.com/dart-archive/channels/stable/release/latest/sdk/dartsdk-linux-x64-release.zip" -o /tmp/dart-sdk.zip
  unzip -q -o /tmp/dart-sdk.zip -d /tmp
  export PATH="/tmp/dart-sdk/bin:$PATH"
fi

dart --version

echo "🚀 [2/3] Activating jaspr_cli..."
export PUB_CACHE="${PUB_CACHE:-$HOME/.pub-cache}"
export PATH="$PUB_CACHE/bin:$PATH"

if ! command -v jaspr &> /dev/null; then
  dart pub global activate jaspr_cli
fi

echo "🚀 [3/3] Building Tailwind CSS & Jaspr SSG..."
npm install
npm run build:css

jaspr build --sitemap-domain=https://imilham.com

echo "✅ Build completed successfully! Output ready in build/jaspr"
