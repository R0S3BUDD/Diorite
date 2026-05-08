# Diorite!

## Character Manager

English | [Español](es/README.es.md)

---

Diorite is an application that allows users to create, edit, and manage characters. Data is stored locally, and the app is designed with writers and roleplayers in mind.

### Features

* Character creation
* Multiline text support
* Add images directly from the device
* Local storage, available offline

### Technologies

* #### Dart & Flutter

  * We use Flutter with Dart because of its multiplatform philosophy. At the moment, the app is primarily designed for Android devices, but thanks to this decision it can be easily ported to other systems in the future.

### Status

First stable release: 1.2.6

The project is under active development and currently awaiting community feedback. At the moment, only one person is working on it.

### Requirements

* Flutter SDK
* Dart SDK
* Android SDK
* Git

### Installation

```bash
git clone ...
cd diorite
flutter pub get
flutter run
```

### Building

To generate Android builds, it is also necessary to install the Android SDK and configure the command-line tools.

The first step is downloading the [Android Command-line Tools](https://developer.android.com/tools) and adding them to your `PATH`.

After that, install the required components with:

```bash
sdkmanager --install \
  "platform-tools" \
  "platforms;android-35" \
  "build-tools;35.0.0"
```

Accept the Google licenses:

```bash
flutter doctor --android-licenses
```

Verify that Flutter correctly detects the environment:

```bash
flutter doctor
```

The Android section should appear with a [✓]

#### Build APK

```bash
flutter build apk
```

The generated file will be located at:

```bash
build/app/outputs/flutter-apk/app-release.apk
```
