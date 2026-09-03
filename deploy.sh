#!/bin/bash
# Yourbself Premium Edition - Deployment Script

set -e

echo "🚀 Yourbself Premium Edition - Deployment Script"
echo "================================================"
echo ""

# Function to display usage
usage() {
    echo "Usage: $0 [platform] [mode]"
    echo "  platform: ios, android, web, all"
    echo "  mode: debug, release (default: release)"
    echo ""
    echo "Examples:"
    echo "  $0 ios release"
    echo "  $0 android debug"
    echo "  $0 web"
    echo "  $0 all release"
    exit 1
}

# Check arguments
if [ $# -eq 0 ]; then
    usage
fi

PLATFORM=$1
MODE=${2:-release}

# Validate mode
if [ "$MODE" != "debug" ] && [ "$MODE" != "release" ]; then
    echo "❌ Invalid mode: $MODE"
    usage
fi

echo "Platform: $PLATFORM"
echo "Mode: $MODE"
echo ""

# Common setup
echo "📥 Getting dependencies..."
flutter pub get
echo ""

# iOS Build
build_ios() {
    echo "📱 Building for iOS ($MODE)..."
    if [ "$MODE" = "debug" ]; then
        flutter run -d ios
    else
        flutter build ios --release
        echo "✅ iOS build complete at: build/ios/iphoneos/Runner.app"
    fi
    echo ""
}

# Android Build
build_android() {
    echo "📱 Building for Android ($MODE)..."
    if [ "$MODE" = "debug" ]; then
        flutter run -d android
    else
        flutter build apk --release
        flutter build appbundle --release
        echo "✅ APK build complete at: build/app/outputs/flutter-apk/app-release.apk"
        echo "✅ AAB build complete at: build/app/outputs/bundle/release/app-release.aab"
    fi
    echo ""
}

# Web Build
build_web() {
    echo "🌐 Building for Web ($MODE)..."
    if [ "$MODE" = "debug" ]; then
        flutter run -d chrome
    else
        flutter build web --release
        echo "✅ Web build complete at: build/web/"
    fi
    echo ""
}

# Route to correct build
case "$PLATFORM" in
    ios)
        build_ios
        ;;
    android)
        build_android
        ;;
    web)
        build_web
        ;;
    all)
        build_ios
        build_android
        build_web
        ;;
    *)
        echo "❌ Invalid platform: $PLATFORM"
        usage
        ;;
esac

echo "🎉 Deployment complete!"
