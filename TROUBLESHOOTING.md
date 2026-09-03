# Troubleshooting Guide for Yourbself Premium Edition

## Common Issues & Solutions

### 1. Build & Installation Issues

#### Problem: `Pod install` fails on iOS
```bash
# Solution:
cd ios
rm Podfile.lock
pod install --repo-update
cd ..
```

#### Problem: Gradle build fails on Android
```bash
# Solution:
flutter clean
cd android
./gradlew clean
cd ..
flutter pub get
flutter run
```

#### Problem: Pub get fails
```bash
# Solution:
flutter pub cache repair
flutter pub get
```

#### Problem: Flutter version mismatch
```bash
# Check Flutter version:
flutter --version

# Update Flutter:
flutter upgrade

# Check dependency conflicts:
flutter pub outdated
```

### 2. Firebase Connection Issues

#### Problem: Firebase initialization fails
```
Error: "[core/unknown] Unknown error occurred"
```

**Solutions**:
1. Verify Firebase config files are in correct locations:
   - Android: `android/app/google-services.json`
   - iOS: `ios/Runner/GoogleService-Info.plist`
   - Web: Configured in `firebase_options.dart`

2. Check Firebase credentials in `firebase_options.dart`
3. Verify Firebase project is active in console
4. Check internet connectivity
5. Try running with verbose logging:
   ```bash
   flutter run -v
   ```

#### Problem: Authentication fails
```
Error: "user-not-found" or "wrong-password"
```

**Solutions**:
1. Verify email is registered in Firebase console
2. Check password requirements (minimum 8 characters)
3. Enable Email/Password authentication in Firebase console
4. Clear app cache and try again

#### Problem: Network timeout
```
Error: "network-request-failed"
```

**Solutions**:
1. Check internet connectivity
2. Check Firebase service status: https://status.firebase.google.com
3. Increase timeout in code if necessary
4. Try using a different network

### 3. Performance Issues

#### Problem: Low FPS (below 60)

**Solutions**:
1. Reduce particle count in `dashboard_screen.dart`:
   ```dart
   particleCount: 150,  // Reduce from 250
   ```

2. Disable trails:
   ```dart
   showTrails: false,  // In ParticleEngineCanvas
   ```

3. Reduce blur effects:
   ```dart
   filter: ui.ImageFilter.blur(sigmaX: 8, sigmaY: 8),  // Reduce from 12
   ```

4. Profile with DevTools:
   ```bash
   flutter pub global activate devtools
   devtools
   ```

#### Problem: High memory usage

**Solutions**:
1. Reduce particle count
2. Limit trail history (default: 12, reduce to 8)
3. Dispose controllers properly in `dispose()` method
4. Check for memory leaks with DevTools Memory tab

#### Problem: Battery drains quickly

**Solutions**:
1. Reduce particle update frequency
2. Disable particle trails if not needed
3. Reduce animation frame rate
4. Use less intensive blur effects

### 4. Authentication Screen Issues

#### Problem: Input fields not responding

**Solutions**:
1. Check FocusNode is properly managed
2. Verify TextEditingController is initialized
3. Check for exception in build logs:
   ```bash
   flutter run -v
   ```

#### Problem: Password toggle not working

**Solutions**:
1. Verify `_obscurePassword` state is being updated
2. Check `GlassmorphicInput` widget implementation
3. Review `onSuffixTap` callback binding

#### Problem: Form validation not working

**Solutions**:
1. Verify regex patterns in validation methods
2. Check error message display condition
3. Test with valid/invalid inputs manually

### 5. Particle Engine Issues

#### Problem: Particles not moving

**Solutions**:
1. Verify `_updateController` is running
2. Check particle physics calculations
3. Verify mouse position is being updated
4. Check for zero-distance division errors

#### Problem: Particles behaving erratically

**Solutions**:
1. Adjust damping factor (default: 0.95)
2. Increase smoothing dampener value
3. Reduce attraction force
4. Check boundary wrapping logic

#### Problem: Trails disappearing

**Solutions**:
1. Check trail history max length
2. Verify `addToTrail()` is being called
3. Check trail rendering in canvas painter
4. Increase trail history size if needed

### 6. UI/Design Issues

#### Problem: Glassmorphic effect not visible

**Solutions**:
1. Verify `BackdropFilter` is wrapping content
2. Check blur sigma values (should be > 0)
3. Ensure parent has opaque background
4. Check device supports blur effects (some older devices may not)

#### Problem: Text not visible on glassmorphic background

**Solutions**:
1. Increase text opacity
2. Use darker/lighter color for better contrast
3. Add text shadow or background
4. Reduce blur intensity behind text

#### Problem: Gradient colors not displaying correctly

**Solutions**:
1. Verify `LinearGradient` begin/end values
2. Check color hex codes are valid
3. Ensure `BoxDecoration` includes gradient
4. Check container size (gradient needs space to display)

### 7. Gesture & Input Issues

#### Problem: Mouse hover not tracking particles

**Solutions**:
1. Verify `MouseRegion.onHover` callback is firing
2. Check `localPosition` is being used correctly
3. Verify canvas size matches actual size
4. Debug with print statements in callback

#### Problem: Touch input not working (Android/iOS)

**Solutions**:
1. Use `GestureDetector` instead of `MouseRegion` for touch
2. Implement `onPanUpdate` for touch tracking
3. Check gesture recognizer priorities
4. Test on physical device (emulator may have issues)

### 8. Network & Connectivity Issues

#### Problem: App crashes when network is lost

**Solutions**:
1. Implement error handling for network failures
2. Add connectivity check before Firebase calls
3. Gracefully degrade functionality offline
4. Show user-friendly error messages

#### Problem: Slow data sync

**Solutions**:
1. Check internet speed/quality
2. Enable Firebase offline persistence
3. Optimize database queries
4. Batch operations when possible

### 9. Platform-Specific Issues

#### iOS Issues

**Problem**: CocoaPods conflicts
```bash
flutter clean
cd ios
rm -rf Pods Podfile.lock
pod install --repo-update
cd ..
```

**Problem**: Xcode build errors
```bash
flutter clean
flutter pub get
flutter run -d ios
```

#### Android Issues

**Problem**: Gradle sync fails
```bash
flutter clean
cd android
./gradlew clean
cd ..
flutter pub get
```

**Problem**: APK too large
- Enable proguard in build.gradle
- Remove unused dependencies
- Use app bundle instead of APK

#### Web Issues

**Problem**: Web app loads slowly
- Use `flutter build web --release --web-renderer=html`
- Enable caching headers
- Minify assets

**Problem**: Browser compatibility issues
- Test in multiple browsers
- Use compatible packages
- Check Flutter web limitations

### 10. Development & Debugging

#### Problem: Hot reload not working

**Solutions**:
1. Save file to trigger reload
2. Use `r` key if not automatic
3. Try hot restart with `R`
4. Restart IDE if issues persist

#### Problem: Debugging breakpoints not working

**Solutions**:
1. Run in debug mode: `flutter run`
2. Connect debugger before setting breakpoints
3. Check breakpoint is on executable line
4. Use `print()` or logging as fallback

#### Problem: IDE errors/warnings don't match runtime

**Solutions**:
1. Run `flutter clean`
2. Close and reopen IDE
3. Run `flutter analyze`
4. Invalidate IDE cache

### 11. Getting Help

If you can't find a solution:

1. **Check Logs**: Enable verbose mode
   ```bash
   flutter run -v
   ```

2. **Search Issues**: GitHub Issues page
   https://github.com/bankarshrijesh480-boop/yourbself/issues

3. **Community Resources**:
   - Flutter Slack: https://flutter.dev/docs/resources/community
   - Stack Overflow: Tag `flutter`
   - Reddit: r/FlutterDev

4. **Contact Support**:
   - Email: support@yourbself.com
   - GitHub Issues: Create new issue with details

### 12. Debug Checklist

Before reporting an issue:
- [ ] Updated Flutter: `flutter upgrade`
- [ ] Updated packages: `flutter pub upgrade`
- [ ] Ran clean build: `flutter clean && flutter pub get`
- [ ] Tested on physical device (if applicable)
- [ ] Checked Firebase console for errors
- [ ] Ran with verbose logging: `flutter run -v`
- [ ] Reproduced issue consistently
- [ ] Searched existing issues
- [ ] Included error logs and stack traces

---

**Last Updated**: September 3, 2026
