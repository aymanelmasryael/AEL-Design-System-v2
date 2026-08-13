#!/bin/bash
#
# AEL Color Picker — macOS .app bundle build
#
# Compiles the SPM package in release mode and assembles a double-clickable
# AELColorPicker.app with a proper bundle identifier (needed for the TCC
# Screen Recording permission to attach to the app rather than the shell).
#
# Usage:
#   ./scripts/build-app.sh
#
# Output:
#   ./dist/AELColorPicker.app
#
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT"

BIN=".build/release/AELColorPicker"
APP="dist/AELColorPicker.app"
BUNDLE_ID="com.aelstudio.AELColorPicker"
VERSION="1.0.0"

echo "── Building release binary (swift build -c release) ──"
swift build -c release

echo "── Assembling ${APP} ──"
rm -rf "$APP"
mkdir -p "$APP/Contents/MacOS"
mkdir -p "$APP/Contents/Resources"

cp "$BIN" "$APP/Contents/MacOS/AELColorPicker"

# Minimal, generated Info.plist. LSUIElement=false keeps a Dock icon so the
# main window is easy to bring back; the status-bar item is always present.
cat > "$APP/Contents/Info.plist" <<PLIST
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
  <key>CFBundleName</key>
  <string>AELColorPicker</string>
  <key>CFBundleDisplayName</key>
  <string>AEL Color Picker</string>
  <key>CFBundleIdentifier</key>
  <string>${BUNDLE_ID}</string>
  <key>CFBundleExecutable</key>
  <string>AELColorPicker</string>
  <key>CFBundlePackageType</key>
  <string>APPL</string>
  <key>CFBundleVersion</key>
  <string>${VERSION}</string>
  <key>CFBundleShortVersionString</key>
  <string>${VERSION}</string>
  <key>LSMinimumSystemVersion</key>
  <string>13.0</string>
  <key>NSHighResolutionCapable</key>
  <true/>
  <key>LSApplicationCategoryType</key>
  <string>public.app-category.graphics-design</string>
  <key>NSHumanReadableCopyright</key>
  <string>Copyright © 2026 Ayman Elmasry. All rights reserved.</string>
</dict>
</plist>
PLIST

# Default to the AEL logo as the app icon when available.
if [ -f ../../../../ael-logo.svg ]; then
  echo "── Generating app icon from AEL logo ──"
  # SVG -> PNG needs a converter. Try sips/qlmanage-free paths; if none exist,
  # ship without a custom icon (the app still works).
  if command -v magick >/dev/null 2>&1; then
    magick ../../../../ael-logo.svg -resize 1024x1024 -background none dist/icon.png
  elif command -v rsvg-convert >/dev/null 2>&1; then
    rsvg-convert -w 1024 -h 1024 ../../../../ael-logo.svg -o dist/icon.png
  fi
  if [ -f dist/icon.png ]; then
    mkdir -p dist/AppIcon.iconset
    for s in 16 32 64 128 256 512 1024; do
      magick dist/icon.png -resize "${s}x${s}" "dist/AppIcon.iconset/icon_${s}x${s}.png" 2>/dev/null || true
    done
    iconutil -c icns dist/AppIcon.iconset -o dist/AppIcon.icns 2>/dev/null || true
    if [ -f dist/AppIcon.icns ]; then
      cp dist/AppIcon.icns "$APP/Contents/Resources/AppIcon.icns"
      /usr/libexec/PlistBuddy -c "Add :CFBundleIconFile string AppIcon" "$APP/Contents/Info.plist"
    fi
  fi
fi

codesign --force --deep -s - "$APP" 2>/dev/null || true

echo ""
echo "✅ Built: $APP"
echo ""
echo "First launch: grant Screen Recording in"
echo "System Settings → Privacy & Security → Screen Recording, then press ⌘⇧P."
