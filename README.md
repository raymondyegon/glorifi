# glorifi

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials, samples, guidance on
mobile development, and a full API reference.

## Storybook

We have a Storybook that has a couple of main purposes. First, it will serve as developer
documentation for our custom widgets/components that can be shared among different pages/screens.
Second, it can be used as a sandbox environment to construct static pages. This can be useful when
needing to transfer a designer mockup to code, but the back end data is not ready yet.

### Running storybook locally

`flutter run --dart-define=storybook=true`

## Configuration

To configure `lib/src/environment/environment.dart` to use the production, dev, or mock endpoints:

```
flutter run --dart-define=ENVIRONMENT=PROD # use PROD, DEV, or MOCK
```
