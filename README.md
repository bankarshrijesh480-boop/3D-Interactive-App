# Yourbself - Premium Edition

## ✨ Ultra-Premium Flutter Application

Yourbself Premium Edition is a production-ready, cross-platform Flutter application for iOS, Android, and Web featuring:

- 🔐 **Firebase Authentication** - Secure user authentication
- 🎨 **Glassmorphic UI Design** - Stunning frosted glass aesthetic
- ✨ **Interactive 3D Particle Engine** - Mesmerizing physics-based particle effects
- 🎯 **Real-time Hand Tracking** - Dynamic particle warping based on cursor/hand movement
- 📊 **Advanced Metrics Dashboard** - Real-time FPS, pointer coordinates, and system stats
- 🌈 **Dual Color Themes** - Neon Cyberpunk & Arctic Aurora modes
- 🎮 **Interactive Controls** - Real-time particle physics adjustment
- ⚡ **High-Performance Rendering** - Optimized canvas painting and physics calculations

---

## 📋 Project Structure

```
yourbself/
├── lib/
│   ├── main.dart                 # Application entry point
│   ├── firebase_options.dart     # Firebase configuration
│   ├── models/
│   │   └── particle_3d.dart      # 3D particle physics engine
│   ├── screens/
│   │   ├── auth_gate.dart        # Authentication state management
│   │   ├── auth_screen.dart      # Premium login/signup UI
│   │   └── dashboard_screen.dart # Main dashboard with metrics
│   ├── painters/
│   │   └── particle_engine_canvas.dart  # Custom canvas painting
│   └── widgets/
│       └── glassmorphic_input.dart      # Reusable input widget
├── pubspec.yaml                  # Project dependencies
├── EULA.md                       # End User License Agreement
├── PRIVACY_POLICY.md             # Privacy Policy
├── LICENSE_THIRD_PARTY.md        # Third-party licenses
└── README.md                     # This file
```

---

## 🚀 Getting Started

### Prerequisites

- **Flutter SDK**: >= 3.0.0
- **Dart SDK**: >= 3.0.0
- **Git**: For version control
- **IDE**: Android Studio, VS Code, or IntelliJ IDEA

### Installation

1. **Clone the repository**:
   ```bash
   git clone https://github.com/bankarshrijesh480-boop/yourbself.git
   cd yourbself
   ```

2. **Install dependencies**:
   ```bash
   flutter pub get
   ```

3. **Configure Firebase**:
   - Visit [Firebase Console](https://console.firebase.google.com/)
   - Create a new project or use existing
   - Enable Firebase Authentication (Email/Password)
   - Download configuration files:
     - `google-services.json` for Android → `android/app/`
     - `GoogleService-Info.plist` for iOS → `ios/Runner/`
   - Update `lib/firebase_options.dart` with your project credentials

4. **Run the application**:
   ```bash
   # iOS
   flutter run -d ios

   # Android
   flutter run -d android

   # Web
   flutter run -d chrome
   ```

---

## 🎨 Key Features

### 1. Authentication System

**Features**:
- Email/Password registration and login
- Real-time Firebase authentication
- Automatic session management
- Elegant error handling
- Input validation (email format, password strength)

**Files**:
- `lib/screens/auth_gate.dart` - Stream-based auth state
- `lib/screens/auth_screen.dart` - Premium auth UI
- `lib/widgets/glassmorphic_input.dart` - Custom input fields

### 2. Glassmorphic Design

**Design Elements**:
- Frosted glass effect using `BackdropFilter`
- Semi-transparent gradients
- Neon glow accents (Cyan #00F2FE, Purple #4FACFE)
- Smooth animations and transitions
- Premium typography (Inter, Orbitron)

**Implementation**:
- `dart:ui.ImageFilter.blur()` for blur effects
- Layered gradient containers
- Custom color schemes with opacity management

### 3. 3D Particle Engine

**Physics Simulation**:
- 250+ interactive particles in 3D space
- Inverse-square attraction/repulsion forces
- Velocity damping for realistic motion
- Z-depth sorting for proper rendering
- Real-time screen projection with perspective division

**Particle Properties**:
```dart
class Particle3D {
  double x, y, z;              // 3D position
  double vx, vy, vz;           // Velocity vectors
  double mass;                 // Particle mass
  double baseRadius;           // Visual radius
  double opacity;              // Transparency
  List<Offset> trailHistory;   // Movement trail
}
```

**Physics Formula**:
```
force = (G * mass1 * mass2) / (distance² + smoothing_dampener)
velocity = (velocity + force) * dampingFactor
position = position + velocity
```

**File**: `lib/models/particle_3d.dart`

### 4. Interactive Dashboard

**Metrics Displayed**:
- **FPS Counter**: Real-time frame rate
- **Pointer Coordinates**: X, Y tracking
- **Particle Intensity**: Active particle count
- **System Status**: Connection/performance indicator
- **Uptime Counter**: Session duration

**Controls**:
- Attraction Force Slider (0.1 - 2.0)
- Particle Mass Scale Slider (0.1 - 3.0)
- Color Mode Toggle (Neon/Aurora)
- Logout Button

**File**: `lib/screens/dashboard_screen.dart`

### 5. Custom Canvas Rendering

**Rendering Pipeline**:
1. Sort particles by Z-depth (painter's algorithm)
2. Calculate screen projection using perspective division
3. Draw particle trails (historical coordinates)
4. Render glowing particles with multiple layers:
   - Outer glow (low opacity, large blur)
   - Middle ring (medium opacity, medium blur)
   - Core (high opacity, minimal blur)

**File**: `lib/painters/particle_engine_canvas.dart`

---

## 🔧 Configuration

### Firebase Setup

Update `lib/firebase_options.dart` with your credentials:

```dart
static const FirebaseOptions web = FirebaseOptions(
  apiKey: 'YOUR_API_KEY',
  appId: 'YOUR_APP_ID',
  messagingSenderId: 'YOUR_SENDER_ID',
  projectId: 'YOUR_PROJECT_ID',
  authDomain: 'YOUR_AUTH_DOMAIN',
  // ...
);
```

### Customization

**Particle Count** (in `lib/screens/dashboard_screen.dart`):
```dart
particleEngine = ParticleEngine(
  particleCount: 250,  // Adjust for performance
  width: 800,
  height: 600,
);
```

**Color Schemes**:
```dart
// Neon Cyberpunk
trailColor: const Color(0xFF00F2FE),      // Cyan
particleColor: const Color(0xFF4FACFE),   // Blue

// Arctic Aurora
trailColor: const Color(0xFF00D4FF),      // Light Blue
particleColor: const Color(0xFF0099CC),   // Deep Blue
```

**Physics Parameters** (in `lib/models/particle_3d.dart`):
```dart
const double focalLength = 600.0;           // Camera focal length
const double cameraDistance = 800.0;        // Camera Z-distance
const double smoothingDampener = 50.0;      // Force smoothing
const double gravitationalConstant = 100000.0;  // G constant
```

---

## 📱 Platform-Specific Setup

### iOS Configuration

1. Open `ios/Runner.xcworkspace` in Xcode
2. Set minimum deployment target to iOS 12.0+
3. Add Firebase pod dependencies via CocoaPods
4. Configure signing and certificates

### Android Configuration

1. Open `android/app/build.gradle`
2. Set minimum SDK to 21+
3. Ensure `google-services.json` is in `android/app/`
4. Configure Gradle and build tools

### Web Configuration

1. Firebase Web SDK is automatically included
2. No additional native setup required
3. Build for web:
   ```bash
   flutter build web --release
   ```

---

## 🎮 Usage

### Authentication Flow

1. **Open App** → AuthScreen
2. **Toggle Login/Sign Up** using form tabs
3. **Enter Email** (validated)
4. **Enter Password** (minimum 8 chars, special chars for signup)
5. **Submit** → Firebase authentication
6. **Success** → Dashboard with particle engine

### Interaction

1. **Move Mouse/Pointer** → Particles attract/repel
2. **Adjust Sliders** → Change physics in real-time
3. **Toggle Color Mode** → Switch visual themes
4. **View Metrics** → Monitor performance
5. **Logout** → Return to auth screen

---

## 📊 Performance

### Optimization Tips

1. **Particle Count**: Reduce if FPS drops below 60
2. **Blur Effects**: Use on minimal surfaces on lower-end devices
3. **Update Frequency**: Monitor `AnimationController` tick rate
4. **Trail History**: Limit to 12 points per particle

### Benchmarks (Target)

- **FPS**: 60+ on iOS 12+, Android 7+, Chrome
- **Memory**: <150MB on mobile
- **Battery**: <10mA drain (video playback rate)
- **Network**: <5KB/s for analytics

---

## 🔐 Security

### Data Protection

- ✅ Firebase Auth with encrypted passwords
- ✅ TLS/SSL encryption for data in transit
- ✅ Secure token management
- ✅ No sensitive data stored locally
- ✅ GDPR & CCPA compliant

### Best Practices

1. **Never commit Firebase keys** (use environment variables)
2. **Enable Firebase Security Rules** in console
3. **Keep dependencies updated** (run `flutter pub upgrade`)
4. **Use code obfuscation** for production builds

---

## 📄 Legal

- **EULA.md** - End User License Agreement
- **PRIVACY_POLICY.md** - Complete privacy policy
- **LICENSE_THIRD_PARTY.md** - Open source licenses

---

## 🤝 Contributing

Contributions are welcome! Please:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit changes (`git commit -m 'Add amazing feature'`)
4. Push to branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

---

## 📚 Documentation

- [Flutter Documentation](https://flutter.dev/docs)
- [Firebase Flutter Documentation](https://firebase.flutter.dev)
- [Dart Language Reference](https://dart.dev/guides)
- [Material Design 3](https://m3.material.io)

---

## 🐛 Troubleshooting

### Build Issues

```bash
# Clean build
flutter clean
flutter pub get
flutter pub upgrade

# iOS specific
cd ios
pod install --repo-update
cd ..

# Android specific
flutter clean
cd android
./gradlew clean
cd ..
flutter pub get
```

### Firebase Connection Issues

1. Verify Firebase configuration files are in correct locations
2. Check Firebase project credentials in `firebase_options.dart`
3. Enable Firebase Auth in Firebase console
4. Check internet connectivity
5. Review Firebase security rules

### Performance Issues

1. Reduce particle count
2. Disable trails if not needed
3. Lower blur sigma values
4. Profile with DevTools:
   ```bash
   flutter pub global activate devtools
   devtools
   ```

---

## 📞 Support

**Issues & Bug Reports**: [GitHub Issues](https://github.com/bankarshrijesh480-boop/yourbself/issues)

**Email**: support@yourbself.com

**Documentation**: https://github.com/bankarshrijesh480-boop/yourbself/wiki

---

## 📄 License

This project is provided under the terms of the EULA.md. See the file for complete terms.

**Third-party components** are licensed under their respective licenses. See LICENSE_THIRD_PARTY.md.

---

## 🎉 Credits

**Created by**: Yourbself Inc.

**Built with**:
- Flutter & Dart
- Firebase
- Google ML Kit
- Material Design 3

**Special Thanks** to the Flutter and Firebase communities for exceptional documentation and support.

---

## 📈 Roadmap

- [ ] Hand gesture recognition (MediaPipe)
- [ ] Voice commands
- [ ] Custom particle presets
- [ ] Social sharing
- [ ] Cloud save/sync
- [ ] Multiplayer interactions
- [ ] Augmented Reality (AR) mode
- [ ] Advanced analytics dashboard

---

**© 2026 Yourbself Inc. All rights reserved.**

**Version**: 1.0.0

**Last Updated**: September 3, 2026
