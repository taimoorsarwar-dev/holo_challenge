import 'dart:ui';

import 'package:holo_challenge/core/config/currency_model.dart';
import 'package:holo_challenge/core/config/supported_lang.dart';
import 'package:holo_challenge/core/theme/theme_palette.dart';
import 'package:holo_challenge/modules/base/base_bloc.dart';
import 'package:holo_challenge/modules/user/user_preferences_model.dart';
import 'package:holo_challenge/modules/user/user_preferences_repository.dart';
import 'package:rxdart/rxdart.dart';

class UserPreferencesBloc extends BlocBase {
  UserPreferencesModel _userPreferences = UserPreferencesModel();
  get userPreferences => _userPreferences;

  final ReplaySubject<UserPreferencesModel> _userPrefStreamController =
      ReplaySubject<UserPreferencesModel>(maxSize: 1);
  Stream<UserPreferencesModel> get userPrefStream =>
      _userPrefStreamController.stream;

  int _rebuildCount = 0;

  @override
  void dispose() {
    super.dispose();
    _userPrefStreamController.close();
  }

  UserPreferencesBloc() {
    UserPreferencesRepository.getUserPreferences().then((pref) {
      if (pref != null) {
        _userPreferences = pref;
      }
      setSelectedTheme(_userPreferences.selectedTheme);
      setSelectedLanguage(_userPreferences.appLang);
      setPreferences();
    });
  }

  UserPreferencesBloc.initWithLang(AppLang appLang) {
    UserPreferencesRepository.getUserPreferences().then((pref) {
      if (pref != null) {
        _userPreferences = pref;
      }
      setSelectedTheme(_userPreferences.selectedTheme);
      _userPreferences.setLanguage(appLang);
      setPreferences();
    });
  }

  void setSelectedCurrency(CurrencyModel currency) {
    _userPreferences.setCurrency(currency);
  }

  void setSelectedLanguage(AppLang appLang) {
    _userPreferences.setLanguage(appLang);
  }

  void setSelectedTheme(CustomTheme customTheme) {
    _userPreferences.setSelectedTheme(customTheme);
  }

  void incrementRebuildCount() {
    _rebuildCount = _rebuildCount + 1;
  }

  void setPreferences() {
    incrementRebuildCount();
    _userPreferences.setId(_rebuildCount);
    _userPreferences.setSelectedTheme(userPreferences.selectedTheme);
    _userPreferences.setLanguage(userPreferences.appLang);
    _userPreferences.setCurrency(userPreferences.currency);

    UserPreferencesRepository.saveUserPreferences(_userPreferences);
    if (_userPrefStreamController.isClosed == false) {
      _userPrefStreamController.sink.add(_userPreferences);
    }
  }

  CustomTheme getSelectedTheme() {
    return _userPreferences.selectedTheme;
  }

  Locale getCurrentLocale() {
    return _userPreferences.appLang.locale;
  }

  AppLang getSelectedLanguage() {
    return _userPreferences.appLang;
  }

  CurrencyModel getSelectedCurrency() {
    return _userPreferences.currency;
  }

  bool getLanguageDirection() {
    return _userPreferences.isLanguageDirectionLtr;
  }
}
