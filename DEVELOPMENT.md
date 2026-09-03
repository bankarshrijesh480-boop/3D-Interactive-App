# Development Guidelines for Yourbself Premium Edition

## Code Organization

### Directory Structure
```
lib/
├── main.dart              # Application entry point
├── firebase_options.dart  # Firebase configuration
├── models/                # Data models and business logic
├── screens/               # Full-screen widgets
├── widgets/               # Reusable UI components
├── painters/              # Custom paint classes
├── services/              # Services (auth, storage, etc.)
├── utils/                 # Utility functions and helpers
└── constants/             # Constants and configuration
```

## Naming Conventions

### Files
- Snake case for file names: `particle_engine.dart`, `auth_screen.dart`
- Separate files for each class/widget

### Classes & Widgets
- Pascal case: `ParticleEngine`, `AuthScreen`, `GlassmorphicInput`
- Stateful widgets end with `Screen` or use descriptive names
- Custom painters end with `Painter` or `Canvas`

### Methods & Variables
- Camel case: `updateParticles()`, `mousePosition`
- Private methods/variables prefix with `_`: `_handleAuthentication()`
- Boolean variables prefix with `is` or `has`: `isLoading`, `hasData`

### Constants
- Upper camel case: `ParticleCount = 250`
- Magic numbers should be named constants

## Code Quality Standards

### Formatting
- Use `dart format` with 100-character line limit
- Run before every commit

### Analysis
- Run `dart analyze` and fix all warnings
- Follow linting rules in `analysis_options.yaml`
- Use `flutter analyze` for Flutter-specific issues

### Comments
- Use `///` for public API documentation
- Use `//` for inline comments
- Avoid obvious comments
- Keep comments updated with code changes

### Error Handling
- Always handle `FirebaseAuthException` with meaningful messages
- Log errors for debugging without exposing to users
- Provide user-friendly error messages

## Performance Best Practices

### Flutter/Dart
- Use `const` constructors where possible
- Cache computed values when appropriate
- Avoid rebuilds with proper `setState` usage
- Use `ValueListenableBuilder` for simple state changes
- Profile with DevTools before and after changes

### Custom Painting
- Minimize `CustomPaint` size (use smaller subtrees)
- Avoid heavy computations in `paint()` method
- Use `shouldRepaint()` efficiently
- Batch drawing operations

### Particle Engine
- Limit particle count based on device capability
- Use efficient physics calculations
- Cache projection matrices where applicable
- Profile FPS impact with different particle counts

### Firebase
- Implement caching for frequently accessed data
- Batch operations when possible
- Use security rules to minimize data transfer
- Monitor quota usage

## Testing

### Unit Tests
- Test business logic (particle physics, auth validation)
- Aim for 80%+ code coverage
- Location: `test/` directory

### Widget Tests
- Test UI components and state changes
- Test navigation flows
- Location: `test/` directory

### Integration Tests
- Test end-to-end user flows
- Test Firebase integration
- Location: `integration_test/` directory

### Running Tests
```bash
flutter test                    # All unit/widget tests
flutter test integration_test/  # Integration tests
flutter test --coverage         # Coverage report
```

## Git Workflow

### Commit Messages
- Format: `type(scope): description`
- Types: feat, fix, docs, style, refactor, perf, test, chore
- Example: `feat(particle-engine): add trail rendering`

### Branch Naming
- Feature: `feature/particle-physics`
- Fix: `fix/auth-validation`
- Docs: `docs/readme-update`

### Pull Requests
- Descriptive title and description
- Link related issues
- Request reviews from team members
- Ensure CI/CD checks pass

## Security

### Code Review Checklist
- No hardcoded credentials
- No sensitive data logged
- Proper input validation
- Secure error handling
- OWASP compliance

### Dependencies
- Keep all packages updated
- Review dependency licenses
- Check for known vulnerabilities
- Run `flutter pub outdated` regularly

## Documentation

### Code Documentation
- Document public APIs with `///`
- Include parameter descriptions
- Include return value descriptions
- Include usage examples for complex functions

### README
- Keep installation instructions current
- Update feature list when adding features
- Document breaking changes
- Include troubleshooting section

### Changelog
- Update CHANGELOG.md for each release
- Document features, fixes, and breaking changes
- Use semantic versioning

## Debugging

### Tools
- Flutter DevTools: `flutter pub global activate devtools && devtools`
- Dart Analyzer: Built-in to IDE
- Android Studio: Native debugging
- Xcode: iOS debugging
- Chrome DevTools: Web debugging

### Common Issues
- See TROUBLESHOOTING.md for common solutions
- Check GitHub Issues for known problems
- Enable verbose logging: `flutter run -v`

## Release Process

### Version Management
- Update version in `pubspec.yaml`: `version: X.Y.Z+BUILD`
- Update version in `README.md`
- Create git tag: `git tag vX.Y.Z`

### Pre-Release Checklist
- Run all tests
- Run code analysis
- Update CHANGELOG.md
- Review all public APIs
- Update documentation
- Test on real devices

### Build & Release
```bash
# iOS
flutter build ios --release
# Upload to App Store via Xcode

# Android
flutter build appbundle --release
# Upload to Play Store

# Web
flutter build web --release
# Deploy to hosting service
```

## Resources

- [Flutter Documentation](https://flutter.dev/docs)
- [Dart Style Guide](https://dart.dev/guides/language/effective-dart/style)
- [Firebase Best Practices](https://firebase.google.com/docs/guides/best-practices)
- [Material Design 3](https://m3.material.io)
- [GitHub Flow](https://guides.github.com/introduction/flow/)
