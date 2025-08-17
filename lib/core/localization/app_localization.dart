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

  String get preferences {
    return Intl.message("Preferences", name: 'preferences');
  }

  String get darkTheme {
    return Intl.message("Dark theme?", name: 'darkTheme');
  }

  String get settings {
    return Intl.message("Settings", name: 'settings');
  }

  String get emptyCartTitle {
    return Intl.message("Oh no, it's empty in here!", name: 'emptyCartTitle');
  }

  String get emptyCartText {
    return Intl.message(
      "Let's fill it up with something special",
      name: 'emptyCartText',
    );
  }

  String get startShopping {
    return Intl.message('Start Shopping', name: 'startShopping');
  }

  String get checkoutNow {
    return Intl.message('Checkout now', name: 'checkoutNow');
  }

  String get paymentSummary {
    return Intl.message('Payment Summary', name: 'paymentSummary');
  }

  String get subTotal {
    return Intl.message('Subtotal', name: 'subTotal');
  }

  String get items {
    return Intl.message('Items', name: 'items');
  }

  String get deliveryFee {
    return Intl.message('Delivery Fee', name: 'deliveryFee');
  }

  String get cartTotal {
    return Intl.message('Cart Total', name: 'cartTotal');
  }

  String get totalItems {
    return Intl.message('Total items', name: 'totalItems');
  }

  String get clearCart {
    return Intl.message('Clear Cart', name: 'clearCart');
  }

  String get clearYourCart {
    return Intl.message('Clear your cart?', name: 'clearYourCart');
  }

  String get clearYourCartText {
    return Intl.message(
      'All items in your cart will be removed. This action cannot be undone.',
      name: 'clearYourCartText',
    );
  }

  String get cancel {
    return Intl.message('Cancel', name: 'cancel');
  }

  String get confirm {
    return Intl.message('Cancel', name: 'confirm');
  }

  String get shoppingCart {
    return Intl.message('Your Cart', name: 'shoppingCart');
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
