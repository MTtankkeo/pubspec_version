# Introduction
A Dart CLI to manage and update the version in pubspec.yaml, primarily used to automate version increments and management in CI/CD workflows.

## Usage

### Get the version
Retrieve the version from pubspec.yaml.

```bash
dart run pubspec_version get
```

Retrieve only the version name (before the dash):

```bash
dart run pubspec_version get --only-version-name
```

Retrieve only the build number (after the dash):

```bash
dart run pubspec_version get --only-build-number
```

### Set the version
Update the version in pubspec.yaml.

```bash
dart run pubspec_version set 1.0.0-42
```
