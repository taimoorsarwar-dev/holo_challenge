import 'package:flutter/material.dart';

enum SupportedLang { english, arabic }

class AppLang {
  static AppLang fromString(String language) {
    if (language == SupportedLang.english.toString()) {
      return AppLang(SupportedLang.english);
    } else if (language == SupportedLang.arabic.toString()) {
      return AppLang(SupportedLang.arabic);
    }
    return AppLang(SupportedLang.english);
  }

  SupportedLang _supportedLang;

  @override
  String toString() {
    return _supportedLang.toString();
  }

  get displayName {
    switch (_supportedLang) {
      case SupportedLang.arabic:
        return 'Arabic';

      case SupportedLang.english:
        return 'English';
    }
  }

  get locale {
    return Locale(languageCode);
  }

  void setLocale(SupportedLang lang) {
    _supportedLang = lang;
  }

  void toggleLocale() {
    if (_supportedLang == SupportedLang.english) {
      _supportedLang = SupportedLang.arabic;
    } else if (_supportedLang == SupportedLang.arabic) {
      _supportedLang = SupportedLang.english;
    }
  }

  get languageCode {
    if (_supportedLang == SupportedLang.english) {
      return 'en';
    } else if (_supportedLang == SupportedLang.arabic) {
      return 'ar';
    }
    return 'en';
  }

  get isLanguageDirectionLtr {
    switch (_supportedLang) {
      case SupportedLang.arabic:
        return false;

      default:
        return true;
    }
  }

  AppLang(this._supportedLang);
}
