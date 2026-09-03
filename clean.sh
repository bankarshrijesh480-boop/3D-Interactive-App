#!/bin/bash
# Yourbself Premium Edition Clean Script

set -e

echo "🧹 Yourbself Premium Edition - Clean Script"
echo "========================================="
echo ""

echo "Removing build artifacts..."
rm -rf build/
rm -rf .dart_tool/
rm -rf .packages
rm -rf pubspec.lock

echo "Cleaning iOS build..."
rm -rf ios/Pods
rm -rf ios/Podfile.lock
rm -rf ios/Flutter/Flutter.framework
rm -rf ios/Flutter/Flutter.podspec

echo "Cleaning Android build..."
rm -rf android/.gradle
rm -rf android/app/build

echo "Cleaning generated files..."
find . -name '*.g.dart' -delete
find . -name '*.pb.dart' -delete
find . -name 'generated_plugin_registrant.dart' -delete

echo "Removing cache..."
flutter clean

echo ""
echo "✅ Clean complete!"
echo ""
echo "Run 'flutter pub get' to reinstall dependencies"
