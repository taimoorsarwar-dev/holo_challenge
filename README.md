# holo_challenge

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

- To Update splash screen run
  dart run flutter_native_splash:create

  in case if you are not able to find a path
  flutter pub run flutter_native_splash:create --path=/Users/taimoorsarwar/StudioProjects/holo_challenge/pubspec.yaml

- Localization
  If want to clear all localization generated files
  rm lib/core/localization/l10n/intl_messages.arb
  rm lib/core/localization/l10n/messages_*

  generate new files
  flutter pub run intl_translation:extract_to_arb --output-dir=lib/core/localization/l10n lib/core/localization/app_localization.dart                                
  flutter pub run intl_translation:generate_from_arb --output-dir=lib/core/localization/l10n --no-use-deferred-loading lib/core/localization/app_localization.dart lib/core/localization/l10n/intl_*.arb
