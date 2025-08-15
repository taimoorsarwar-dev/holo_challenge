import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

import 'l10n/messages_all.dart';

class AppLocalizations {
  static final _localization = AppLocalizations();

  static Future<AppLocalizations> load(Locale locale) {
    final String name =
        locale.languageCode.isEmpty ? locale.languageCode : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);

    return initializeMessages(localeName).then((bool _) {
      Intl.defaultLocale = localeName;
      return AppLocalizations();
    });
  }

  static AppLocalizations getLocalization() {
    return _localization;
  }

  String get addToCart {
    return Intl.message('Add To Cart', name: 'addToCart');
  }

  String get dark {
    return Intl.message('Dark', name: 'dark');
  }

  String get light {
    return Intl.message('Light', name: 'light');
  }

  String get noInternetConnection {
    return Intl.message(
      'No internet connection. Please check your network and try again.',
      name: 'noInternetConnection',
    );
  }

  String get serverTakingLongRespond {
    return Intl.message(
      'The server is taking too long to respond. Please try again later.',
      name: 'serverTakingLongRespond',
    );
  }

  String get somethingWentWrong {
    return Intl.message(
      'Something went wrong! Please try after sometime.',
      name: 'somethingWentWrong',
    );
  }
}

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  final Locale overriddenLocale;

  const AppLocalizationsDelegate(this.overriddenLocale);

  @override
  bool isSupported(Locale locale) {
    return ['ar', 'en'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) {
    return AppLocalizations.load(locale);
  }

  @override
  bool shouldReload(AppLocalizationsDelegate old) {
    return false;
  }
}
