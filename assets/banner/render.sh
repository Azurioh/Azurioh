#!/usr/bin/env bash
# Renders banner.html to banner-light.png and banner-dark.png (2800x700) with headless Chrome.
set -euo pipefail

dir="$(cd "$(dirname "$0")" && pwd)"
chrome="/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"

for theme in light dark; do
  "$chrome" --headless=new --disable-gpu --hide-scrollbars \
    --force-device-scale-factor=2 --window-size=1400,350 \
    --virtual-time-budget=8000 \
    --screenshot="$dir/banner-$theme.png" \
    "file://$dir/banner.html?theme=$theme"
done

if command -v oxipng >/dev/null 2>&1; then
  oxipng -o 4 --strip safe "$dir/banner-light.png" "$dir/banner-dark.png"
fi
