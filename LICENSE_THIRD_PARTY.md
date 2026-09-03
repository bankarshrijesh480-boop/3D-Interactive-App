# Third-Party Licenses

**3D INTERACTIVE APP - Premium Edition**
**Third-Party Open Source Licenses and Acknowledgments**

---

## 1. Flutter Framework

**License**: BSD 3-Clause License

```
Copyright 2014 The Flutter Authors. All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:

1. Redistributions of source code must retain the above copyright notice,
   this list of conditions and the following disclaimer.

2. Redistributions in binary form must reproduce the above copyright notice,
   this list of conditions and the following disclaimer in the documentation
   and/or other materials provided with the distribution.

3. Neither the name of the copyright holder nor the names of its
   contributors may be used to endorse or promote products derived from
   this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
POSSIBILITY OF SUCH DAMAGE.
```

**Repository**: https://github.com/flutter/flutter
**Website**: https://flutter.dev

---

## 2. Firebase (Firebase Core & Firebase Auth)

**License**: Google Terms of Service

Firebase is provided under the Google Terms of Service:
https://firebase.google.com/terms

**Key Services Used**:
- Firebase Core (firebase_core)
- Firebase Authentication (firebase_auth)
- Firebase Realtime Database
- Google Analytics for Firebase

**Data Processing**: As per Google's Privacy Policy
https://policies.google.com/privacy

**Repository**: https://github.com/firebase/firebase-ios-sdk (iOS)
**Repository**: https://github.com/firebase/firebase-android-sdk (Android)
**Website**: https://firebase.google.com

---

## 3. Google Fonts

**License**: Open Font License (OFL 1.1)

```
Copyright 2010-2023 Google LLC

This Font Software is licensed under the SIL Open Font License, Version 1.1.
This license is copied below, and is also available with a FAQ at
http://scripts.sil.org/OFL

OPEN FONT LICENSE Version 1.1 - 26 February 2007
```

**Fonts Used**:
- Inter: Google's system font family
- Orbitron: Geometric sans-serif display font

**Repository**: https://github.com/google/fonts
**Website**: https://fonts.google.com

---

## 4. Google ML Kit (MediaPipe)

**License**: Apache License 2.0

```
Copyright 2023 Google LLC

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
```

**Components Used**:
- google_mlkit_pose_detection: Pose detection via MediaPipe

**Repository**: https://github.com/google/mediapipe
**Website**: https://mediapipe.dev

---

## 5. Camera Plugin

**License**: BSD 3-Clause License

**Repository**: https://github.com/flutter/plugins
**Package**: camera

```
Copyright 2013 The Flutter Authors. All rights reserved.

[Full BSD 3-Clause License text as in Flutter Framework section above]
```

---

## 6. Provider (State Management)

**License**: MIT License

```
Copyright 2019-2023 Remi Rousselet

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```

**Repository**: https://github.com/rrousselGit/provider
**Website**: https://pub.dev/packages/provider

---

## 7. Dart & Dart SDK

**License**: BSD 3-Clause License

**Repository**: https://github.com/dart-lang/sdk
**Website**: https://dart.dev

---

## 8. intl (Internationalization)

**License**: BSD 3-Clause License

**Repository**: https://github.com/google/app-resource-bundle
**Package**: intl

---

## 9. uuid (UUID Generation)

**License**: MIT License

**Repository**: https://github.com/google/uuid.dart
**Package**: uuid

---

## 10. flutter_lints (Code Quality)

**License**: BSD 3-Clause License

**Repository**: https://github.com/flutter/packages
**Package**: flutter_lints

---

## 11. Gradle Build System (Android)

**License**: Apache License 2.0

**Website**: https://gradle.org

---

## 12. CocoaPods (iOS Dependency Manager)

**License**: MIT License

**Website**: https://cocoapods.org

---

## Summary of License Types

| License Type | Count | Packages |
|---|---|---|
| BSD 3-Clause | 4 | Flutter, Camera, Dart SDK, flutter_lints |
| Apache License 2.0 | 2 | Google ML Kit, Gradle |
| MIT License | 3 | Provider, uuid, CocoaPods |
| OFL 1.1 | 1 | Google Fonts |
| Google Terms of Service | 1 | Firebase |

---

## How to View Full License Text

**In the Flutter Project**:
```bash
# View all dependency licenses
flutter pub get
flutter pub global activate license_finder
license_finder --csv

# Or check pubspec.lock file
cat pubspec.lock
```

**Online**:
- Individual package licenses available on https://pub.dev
- Links provided above for each dependency

---

## Important Notes

1. **No Warranty**: All third-party software is provided "AS IS" without warranty.

2. **Compliance**: We ensure all dependencies comply with their respective licenses and our usage adheres to their terms.

3. **Updates**: As dependencies are updated, their licenses may change. Check the license file in pubspec.lock for current information.

4. **Open Source Contribution**: We acknowledge and respect the contributions of all open-source developers and communities.

5. **Contact**: For questions about third-party licenses, contact: legal@3dinteractiveapp.com

---

**© 2026 3D Interactive App Inc.**

**Generated**: September 3, 2026

**Last Updated**: September 3, 2026