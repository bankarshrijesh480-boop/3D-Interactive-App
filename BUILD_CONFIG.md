# Platform-specific build configuration for Yourbself Premium Edition

## Flutter Version
* Minimum Flutter SDK: 3.0.0
* Minimum Dart SDK: 3.0.0

## Android Configuration
* Minimum SDK: 21 (Android 5.0)
* Target SDK: 34 (Android 14)
* Gradle Version: 8.0+

## iOS Configuration
* Minimum deployment target: 12.0
* Maximum deployment target: Latest (iOS 17+)
* Xcode: 14.0 or later

## Web Configuration
* No additional requirements
* Supported browsers: Chrome, Firefox, Safari, Edge (latest versions)

## Build Commands

### Development
```bash
flutter run
```

### Release iOS
```bash
flutter build ios --release
```

### Release Android
```bash
flutter build apk --release
flutter build appbundle --release
```

### Release Web
```bash
flutter build web --release
```

## Firebase Configuration
* Ensure google-services.json is in android/app/
* Ensure GoogleService-Info.plist is in ios/Runner/
* Update firebase_options.dart with your project credentials

## Performance Targets
* Target FPS: 60+ on all platforms
* Memory footprint: <150MB on mobile
* Battery impact: Minimal (<5% per hour)
* Network usage: <100KB per session
